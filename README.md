# bench-lit

This is a fork of [js-framework-benchmark](https://github.com/krausest/js-framework-benchmark) that is designed to easily benchmark lit-html and other frameworks.

The repo comes with a Makefile that gives you simple commands to perform benchmark runs. Separate tasks are available for running in `Docker` environments, simply prefix the task with `docker` (e.g. `make bench` becomes `make dockerbench`).

## Getting started

After cloning, run the `init` task

```bash
make init
```

## Running benchmarks

Run all the benchmarks

```bash
make benchall
```

Run one specific benchmark

```bash
make bench FRAMEWORK=lit-html-0.10
```

After running benchmarks, a `results.html` will appear that contains the results. Individual test results are also available in JSON format in the `webdriver-ts/results/` folder.

## Adding a new build

1. Create a copy of an existing build

```bash
cp -r frameworks/non-keyed/lit-html-0.11 frameworks/non-keyed/lit-html-1.0
```

2. Make sure to edit the `package.json` to point to the correct version of the package you want to test.

3. Update the build for that framework using `make update`

```
make update FRAMEWORK=lit-html-1.0
```

4. Now the framework is ready to be benchmarked.

## About the benchmarks

The following operations are benchmarked for each framework:

- create rows: Duration for creating 1,000 rows after the page loaded (no warmup).
- replace all rows: Duration for replacing all 1,000 rows of the table (with 5 warmup iterations).
- partial update: Time to update the text of every 10th row for a table with 10,000 rows (with 5 warmup iterations).
- select row: Duration to highlight a row in response to a click on the row. (with 5 warmup iterations).
- swap rows: Time to swap 2 rows on a table with 1,000 rows. (with 5 warmup iterations).
- remove row: Duration to remove a row for a table with 1,000 rows. (with 5 warmup iterations).
- create many rows: Duration to create 10,000 rows (no warmup)
- append rows to large table: Duration for adding 1,000 rows on a table of 10,000 rows (no warmup).
- clear rows: Duration to clear the table filled with 10,000 rows. (no warmup)
- ready memory: Memory usage after page load.
- run memory: Memory usage after adding 1,000 rows.
- update memory: Memory usage after clicking 5 times update for a table with 1,000 rows.
- replace memory: Memory usage after clicking 5 times create 1,000 rows.
- repeated clear memory: Memory usage after creating and clearing 1,000 rows for 5 times.
- update memory: Memory usage after clicking 5 times update for a table with 1,000 rows.
- startup time: Duration for loading and parsing the javascript code and rendering the page.
- consistently interactive: The lighthouse metric TimeToConsistentlyInteractive: A pessimistic TTI - when the CPU and network are both definitely very idle. (no more CPU tasks over 50ms)
- script bootup time: The lighthouse metric ScriptBootUpTtime: The total ms required to parse/compile/evaluate all the page's scripts
- main thread work cost: The lighthouse metric MainThreadWorkCost: Total amount of time spent doing work on the main thread. includes style/layout/etc.
- total byte weight: The lighthouse metric TotalByteWeight: Network transfer cost (post-compression) of all the resources loaded into the page.

For all benchmarks the duration is measured including rendering time. You can read some details on this [article](http://www.stefankrause.net/wp/?p=218).
