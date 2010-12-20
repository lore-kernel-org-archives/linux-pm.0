From: linux-pm.20.masuefke@spamgourmet.com
Subject: Suspend2Ram - Kernel Panic on Dual Core Atom D525 right
 after resume part 2
Date: Mon, 20 Dec 2010 11:15:11 +0100
Message-ID: <4D0F2CAF.3060506@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

-- continued, mail seems to have been cur short on the list --

That means, I cannot produce reasonable log files because there is no
captureable output (neither file nor on the serial port) right after the
resume.
But I got some literal "screeenshots" taken with a digicam:
http://www-users.rwth-aachen.de/martin.suefke/s2ram/
The pictures were taken when I was able to, but I cannot give exact
configuration details for each picture. The configs were quite similar
though, all made with "make --oldconfig" based upon the configuration of
the 2.6.23.2 Kernel.

I ran most tests (dozens!) with the Kernel 2.6.36.2.
Tested these Kernel command line options, also in combinations:
"noapic" -> bug remains
"acpi=3Doff" -> no more "mem" option in /sys/proc/power
"test_suspend=3Dmem" -> bug appeard during the boot test

I tried setting the testing options in /sys/power/pm_test, for all three
Kernels, especially the "core" test repeated quite often.
"core" -> pass (hibernates for ca. 10 seconds, system comes up again,
system stable & useable)
"processors" -> pass
"platform" -> pass
"devices" -> pass
"freezer" -> pass

I tried the setting pm_trace=3D1 in /sys/power/pm_trace
dmesg -s 1000000 | grep -i2 'hash match' showed nothing
The hwclock was set to about December 2024, though. I tried this
repeatedly and with all three Kernels.

I tried setting /sys/power/pm_async to 0 -> bug still there (also tested
more than once)

Finally, I disabled one core (both Hyperthreads) of the machine and
voil=E0: suspend to ram works:
I guess that cpu0 and cpu3 are Hyperthreads of one core and cpu1 and
cpu2 are Hyperthreads of the other core
# cd /sys/devices/system/cpu/
# echo 0 > cpu1/online
# echo 0 > cpu2/online
# echo mem > /sys/power/state
(system suspends)
[press power button]
(system resumes, stable, working, charming)

But if one re-enables one of the just-disabled CPUs , the system crashes
*if it was in suspend to ram before*:
# echo 1 > cpu1/online
(Kernel panic)

But if one enables one thread of each core the system crashes, too:
# cd /sys/devices/system/cpu/
# echo 0 > cpu2/online
# echo 0 > cpu3/online
# echo mem > /sys/power/state
(Kernel panic)

For comparison, the CPUs 1-3 can be switched on and off at will and
without trouble if the system never had suspended to ram
# echo 0 > cpu1/online
# echo 0 > cpu2/online
# echo 0 > cpu3/online
# echo 1 > cpu1/online
# echo 1 > cpu2/online
# echo 1 > cpu3/online
(no problem, system runnning, the order of the above 6 commands and
repetitions of these do not matter)
Some printk statements may appear on the console saying that SMP
scheduling is changed for UP scheduling if only cpu0 is active and
another printk statement for the change back when >=3D2 CPUs/Hyperthreads
are enabled.

Disabling "CPU Frequency Scaling", "Intel_Idle", "Model Specific
Registers", "Microcode updating" alone or in various combinations in the
kernel yielded nothing. Except Kernel Panics

I don't know exactly which information I should provide in order to help
you help me. It is all here or it can be produced, please ask for it if
I can provide any info or running any further tests.

I am not sure if I should post tons of kernel config, log files and
pictures on the mailing list (probably not), so I will put them here:
http://www-users.rwth-aachen.de/martin.suefke/s2ram/
There is the grub.cfg file (for the kernel options) , all file contents
from /sys/power and /sys/devices/system/cpu (so one can understand the
core relationships) and the content of  /proc/cpuinfo as well as a few
of the logs I got from the serial console.
However the serial logs are of a repetitive and little meaning nature
