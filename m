From: linux-pm.20.masuefke@spamgourmet.com
Subject: Suspend2Ram - Kernel Panic on Dual Core Atom D525 right
	after resume
Date: Mon, 20 Dec 2010 11:11:47 +0100
Message-ID: <4D0F2BE3.8000207@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello,
I have a system that is unable to suspend to ram, under most but not all 
conditions.
Suspend to disk works flawlessly as well as "Power On Suspend " (ACPI 
S1) if ACPI suspend is set to "S1(POS)" in the BIOS

To me, the matter seems complicated, I have done as many tests as I can 
and I find it extremely difficult to describe my findings in a short manner.

The System in concern is a Gigabyte GA-D525TUD , with an Atom D525 
Processor (1.8GHz, Dual Core, Hyperthreading, no IntelSpeedStep/CPU 
Frequency Scaling ) and 4GB DDR3 ram installed. The mainboard is in use 
scince about one week.
Bios Versions F2 (as shipped) and F3 (just updated) behave identical, 
buggy.

Main problem "the bug":
(at a "vanilla" 24x80 virtual terminal, tty0)
# echo mem > /sys/power/state
(machine suspends, power is turned off except for standby power, all OK)
[I press the power button to wake it up again]
(Power comes up, Machine is halted, Kernel panic'd, keyboard LEDs caps 
lock + scroll lock blinking, the monitor shows the VGA Bios "Intel 
PineView ..." or a panic screen)

This is reproducible with www.kernel.org Kernels 2.6.35.10, 2.6.36.2 and 
2.6.37-rc6 , all compiled for x86_64 (amd64)
Most testing was done in the initrd for this would not wreck my 
harddrive (fsck complaining because of unclean shutdown). Therefore 
there were no programs running and also I could unload all modules with 
"rmmod" in the initrd (absolutely needed drivers are all compiled-in). 
But the results for suspending were all the same: Kernel Panic. No 
matter wether modules (mostly RAID, HD controller, iScsi ) were loaded 
or not. The outcome is the same when testing in the "really booted" 
state, in runlevel 3 as well as in runlevel 1.

I followed http://en.opensuse.org/SDB:Suspend_to_RAM and the 
documentation in <Kernel-Source>/Documentation/power to no avail.
A useable screen becomes visible after resume when Kernel cmd line 
option "acpi_sleep=s3_bios" is given. This seems ok to me.

Of course, I used <web-search-engine-of-choice-here> but found nothing 
that solved the issue.

Because of the blinking keyboard LEDs I assume a kernel panic upon 
resume and that it is not a driver that makes the trouble, nor is it my 
screeen being blank because the video would not be resumed as it is 
often the failure. This is why I bug the mainling list with this problem.

It is difficult to obtain reasonable debug output as the console didn't 
come back after the suspend at first (alleviated by adding the kernel 
command line option "no_console_suspend") and serial debug output via 
ttyS0 stays frozen after resume. Using an oscilloscope, I see signals on 
the RS232-Tx line, at about 500-520 uSec/bit (a little unter 2000 baud - 
no sensible baud rate), so there is a bug in the resume of a serial 
console (Kernel cmd line option "console=ttyS0,115200n8 console=tty0" ), 
too. This bug seems not much important to me. Should I file it 
nevertheless ? Where ? Sidenote: When the serial console fails, console 
output on the screen may be slowed to a crawl, too. There is one Picture 
with an exceptionally long resume time (263 seconds!) because of that
