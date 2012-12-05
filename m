From: dirk.brandewie@gmail.com
Subject: =?UTF-8?q?=5BPATCH=20RFC=200/1=5D=20cpufreq/x86=3A=20Add=20P-state=20driver=20for=20sandy=20bridge=2E=20?=
Date: Wed,  5 Dec 2012 11:01:30 -0800
Message-ID: <1354734091-29870-1-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, deneen.t.dock@intel.com, arjan@linux.intel.com, Dirk Brandewie <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Dirk Brandewie <dirk.brandewie@gmail.com>

This driver provides a P state driver for Sandybridge and Ivybridge
processors.
=20
Motivation:
The goal of this driver is to improve the power efficiency of
Sandybridge/Ivybridge based systems.  As the investigation into how to
achieve this goal progressed it became apparent (to me) that some of th=
e
design assumptions of the cpufreq subsystem are no longer valid and
that a micro-architecure specific P state driver would be less complex
and potentially more effiecent.  As Intel continues to innovate in the
area of freqency/power control this will become more true IMHO.

General info:
The driver uses a PID controller to adjust the core frequency based on
the presented load. The driver exposes the tuning parameters for the
controller in the /sys/devices/system/cpu/cpufreq/snb directory.  The
controller code is being used in PI mode with the default tuning
parmeters.

Tuning parmeters:
   setpoint - load in percent on the core will attempt to maintain.=09
   sample_rate_ms - rate at which the driver will sample the load on th=
e core.=20
   deadband  - percent =C2=B1 around the setpoint the controller will
               consider zero error.
   p_gain_pct - Proportional gain in percent.=20
   i_gain_pct - Integral gain in percent.=20
   d_gain_pct - Derivative gain in percent

To use the driver as root run the following shell script:
   #!/bin/sh
   for file in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
   do=20
      echo snb > $file
   done

Limitations:

ATM this driver will only run on SandyBridge systems testing on
Ivybridge systems is not complete.
=20
Open Questions:

What is the correct way to integrate this driver into the system?  The
current implementation registers as a cpufreq frequency governor, this
was done to streamline testing using cpufreq to load/unload governors.

What tuning parameters should be exposed via sysfs (if any)?  ATM all
the PID parameters are exposed to enable tuning of the driver.


Performance information:

 --- Kernel build ---
The following is data collected for a bzImage kernel build.  The
commands used were:
	 make -j8 clean
	 sysctl -w vm.drop_caches=3D3
	 /usr/bin/time -f "%E %c" make -j8 bzImage

Time and context switches measured with /usr/bin/time -f "%E %c"

Energy measured with package energy status MSR described in section
14.7 in the Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=
=80=99s
Manual Volume 3.
       http://download.intel.com/products/processor/manual/325384.pdf

Average watts calculated with energy/time in seconds

           time		ctx sw	energy	avg watts
perf      02:24.49	116721	6660	46.09
snb       02:27.03	114940	6591	44.83
ondemand  02:26.83	190948	6683	45.51

A graph of the power usage during the kernel build for each governor
is available here:
    http://git.fenrus.org/dirk/kernel.png

 --- Power benchmark ---
I used industry standard power bench suite to compare the performance a=
nd
ondemand governors against the Sandybridge governor.

  Governor    | ssj_ops/watt
 -----------------------------
  performance |   1855
  ondemand    |   1839
  snb         |   2016
=20
A graph of the power usage for each governor is avavailable here:
    http://git.fenrus.org/dirk/power_benchmark.png

A graph showing the results of cpufreq-bench tool shipped with the
kernel Collected with
   cpufreq-bench -l 6000 -s 6000 -x 2000 -y 2000 -c 0 \
               -g {ondemand | snb} -n 40 -r 40=20
is available here:
    http://git.fenrus.org/dirk/cpufreq-bench.png

Dirk Brandewie (1):
  cpufreq/x86: Add P-state driver for sandy bridge.

 drivers/cpufreq/Kconfig.x86   |    8 +
 drivers/cpufreq/Makefile      |    1 +
 drivers/cpufreq/cpufreq_snb.c |  727 +++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 736 insertions(+), 0 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq_snb.c

--=20
1.7.7.6

