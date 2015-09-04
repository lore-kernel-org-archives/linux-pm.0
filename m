From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Fri, 4 Sep 2015 11:41:43 -0700
Message-ID: <000701d0e741$5933c580$0b9b5080$@net>
References: <001401d0e691$302127b0$90637710$@net> <3237049.urJsZkC6Rf@vostro.rjw.lan> <20150904144241.GJ29194@linux>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0008_01D0E706.ACD4ED80"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta10.telus.net ([209.171.16.83]:60508 "EHLO cmta10.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065AbbIDSls (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 14:41:48 -0400
In-Reply-To: <20150904144241.GJ29194@linux>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01D0E706.ACD4ED80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2015.09.04 07:43 Viresh Kumar wrote:
> On 04-09-15, 16:59, Rafael J. Wysocki wrote:
>> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
>>> As of, or about, Kernel 4.2RC1 if I take my highest numbered
>>> CPU offline (7 in my case), the system will not suspend.

> I wanted to give him some patch to debug it a bit more, but couldn't
> do that whole day.

> @Doug: Can you please enable DEBUG for cpufreq with this:
>
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 9fde14544ead..c09945aa7f17 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -1,3 +1,4 @@
> +subdir-ccflags-y  := -DDEBUG
> # CPUfreq core
> obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
>
>
> And give us the outputs of both successful and unsuccessful logs?

Edited /var/log/kern.log attached (might get stripped for
on-list e-mail deliveries)

> + the values of both affected_cpus and related_cpus fields for all
> CPUs.

Step 1: CPU 6 offline (sudo pm-suspend works):

root@s15:/home/doug# echo -n 0 > /sys/devices/system/cpu/cpu6/online
root@s15:/home/doug# cat /sys/devices/system/cpu/cpu*/online
1
1
1
1
1
0
1

root@s15:/sys/devices/system/cpu# cat cpu?/cpufreq/affected_cpus
0
1
2
3
4
5

7

root@s15:/sys/devices/system/cpu# cat cpu?/cpufreq/related_cpus
0
1
2
3
4
5
6
7

Step 2: CPU 7 offline (sudo pm-suspend does not work):

root@s15:/sys/devices/system/cpu# cat /sys/devices/system/cpu/cpu*/online
1
1
1
1
1
1
0
root@s15:/sys/devices/system/cpu# cat cpu?/cpufreq/affected_cpus
0
1
2
3
4
5
6

root@s15:/sys/devices/system/cpu# cat cpu?/cpufreq/related_cpus
0
1
2
3
4
5
6
7


------=_NextPart_000_0008_01D0E706.ACD4ED80
Content-Type: text/plain;
	name="log.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="log.txt"

>>>>>> Smythies 2015.09.04 Edited /var/log/kern.log file for Virseh, =
with Makefile modified.=0A=
>>>>>> Linux s15 4.2.0viresh #46 SMP Fri Sep 4 09:00:41 PDT 2015 x86_64 =
x86_64 x86_64 GNU/Linux=0A=
=0A=
>>>>>> Take CPU 6 offline.=0A=
Sep  4 09:21:02 s15 kernel: [  145.256813] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 6=0A=
Sep  4 09:21:02 s15 kernel: [  145.256819] intel_pstate: CPU 6 exiting=0A=
Sep  4 09:21:02 s15 kernel: [  145.274158] smpboot: CPU 6 is now offline=0A=
=0A=
>>>>>> Do a "sudo pm-suspend" that will work properly. Subsequently turn =
computer on again.=0A=
Sep  4 09:26:11 s15 kernel: [  454.524941] cpufreq: setting new policy =
for CPU 0: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.524948] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.524949] cpufreq: setting range=0A=
Sep  4 09:26:11 s15 kernel: [  454.526917] cpufreq: setting new policy =
for CPU 1: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.526923] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.526924] cpufreq: setting range=0A=
Sep  4 09:26:11 s15 kernel: [  454.528952] cpufreq: setting new policy =
for CPU 2: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.528958] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.528959] cpufreq: setting range=0A=
Sep  4 09:26:11 s15 kernel: [  454.530887] cpufreq: setting new policy =
for CPU 3: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.530892] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.530893] cpufreq: setting range=0A=
Sep  4 09:26:11 s15 kernel: [  454.532526] cpufreq: setting new policy =
for CPU 4: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.532531] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.532533] cpufreq: setting range=0A=
Sep  4 09:26:11 s15 kernel: [  454.534520] cpufreq: setting new policy =
for CPU 5: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.534525] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.534527] cpufreq: setting range=0A=
Sep  4 09:26:11 s15 kernel: [  454.537764] cpufreq: setting new policy =
for CPU 7: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.537766] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:11 s15 kernel: [  454.537767] cpufreq: setting range=0A=
Sep  4 09:26:28 s15 kernel: [  454.675889] PM: Syncing filesystems ... =
done.=0A=
Sep  4 09:26:28 s15 kernel: [  454.782119] PM: Preparing system for =
sleep (mem)=0A=
Sep  4 09:26:28 s15 kernel: [  454.782272] Freezing user space processes =
... (elapsed 0.001 seconds) done.=0A=
Sep  4 09:26:28 s15 kernel: [  454.783462] Freezing remaining freezable =
tasks ... (elapsed 0.001 seconds) done.=0A=
Sep  4 09:26:28 s15 kernel: [  454.784612] PM: Suspending system (mem)=0A=
Sep  4 09:26:28 s15 kernel: [  454.784628] Suspending console(s) (use =
no_console_suspend to debug)=0A=
... deleted some lines ...=0A=
Sep  4 09:26:28 s15 kernel: [  456.490899] PM: suspend of devices =
complete after 1707.250 msecs=0A=
Sep  4 09:26:28 s15 kernel: [  456.506867] PM: late suspend of devices =
complete after 15.976 msecs=0A=
Sep  4 09:26:28 s15 kernel: [  456.507316] pcieport 0000:00:01.0: System =
wakeup enabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.507328] xhci_hcd 0000:07:00.0: System =
wakeup enabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.507374] ehci-pci 0000:00:1d.0: System =
wakeup enabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.507375] r8169 0000:03:00.0: System =
wakeup enabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.507527] ehci-pci 0000:00:1a.0: System =
wakeup enabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.522894] PM: noirq suspend of devices =
complete after 16.036 msecs=0A=
Sep  4 09:26:28 s15 kernel: [  456.523192] ACPI: Preparing to enter =
system sleep state S3=0A=
Sep  4 09:26:28 s15 kernel: [  456.523380] PM: Saving platform NVS memory=0A=
Sep  4 09:26:28 s15 kernel: [  456.523389] Disabling non-boot CPUs ...=0A=
Sep  4 09:26:28 s15 kernel: [  456.523415] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 1=0A=
Sep  4 09:26:28 s15 kernel: [  456.523416] intel_pstate: CPU 1 exiting=0A=
Sep  4 09:26:28 s15 kernel: [  456.524616] smpboot: CPU 1 is now offline=0A=
Sep  4 09:26:28 s15 kernel: [  456.547041] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 2=0A=
Sep  4 09:26:28 s15 kernel: [  456.547043] intel_pstate: CPU 2 exiting=0A=
Sep  4 09:26:28 s15 kernel: [  456.547173] Broke affinity for irq 19=0A=
Sep  4 09:26:28 s15 kernel: [  456.548215] smpboot: CPU 2 is now offline=0A=
Sep  4 09:26:28 s15 kernel: [  456.567001] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 3=0A=
Sep  4 09:26:28 s15 kernel: [  456.567003] intel_pstate: CPU 3 exiting=0A=
Sep  4 09:26:28 s15 kernel: [  456.567129] Broke affinity for irq 19=0A=
Sep  4 09:26:28 s15 kernel: [  456.567163] Broke affinity for irq 33=0A=
Sep  4 09:26:28 s15 kernel: [  456.568172] smpboot: CPU 3 is now offline=0A=
Sep  4 09:26:28 s15 kernel: [  456.582960] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 4=0A=
Sep  4 09:26:28 s15 kernel: [  456.582961] intel_pstate: CPU 4 exiting=0A=
Sep  4 09:26:28 s15 kernel: [  456.583069] Broke affinity for irq 19=0A=
Sep  4 09:26:28 s15 kernel: [  456.583104] Broke affinity for irq 33=0A=
Sep  4 09:26:28 s15 kernel: [  456.584113] smpboot: CPU 4 is now offline=0A=
Sep  4 09:26:28 s15 kernel: [  456.598918] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 5=0A=
Sep  4 09:26:28 s15 kernel: [  456.598920] intel_pstate: CPU 5 exiting=0A=
Sep  4 09:26:28 s15 kernel: [  456.599016] Broke affinity for irq 19=0A=
Sep  4 09:26:28 s15 kernel: [  456.599023] Broke affinity for irq 25=0A=
Sep  4 09:26:28 s15 kernel: [  456.599049] Broke affinity for irq 33=0A=
Sep  4 09:26:28 s15 kernel: [  456.600058] smpboot: CPU 5 is now offline=0A=
Sep  4 09:26:28 s15 kernel: [  456.614896] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 7=0A=
Sep  4 09:26:28 s15 kernel: [  456.614898] intel_pstate: CPU 7 exiting=0A=
Sep  4 09:26:28 s15 kernel: [  456.614988] Broke affinity for irq 19=0A=
Sep  4 09:26:28 s15 kernel: [  456.614991] Broke affinity for irq 23=0A=
Sep  4 09:26:28 s15 kernel: [  456.614995] Broke affinity for irq 25=0A=
Sep  4 09:26:28 s15 kernel: [  456.615021] Broke affinity for irq 33=0A=
Sep  4 09:26:28 s15 kernel: [  456.616030] smpboot: CPU 7 is now offline=0A=
Sep  4 09:26:28 s15 kernel: [  456.631985] ACPI: Low-level resume =
complete=0A=
Sep  4 09:26:28 s15 kernel: [  456.632020] PM: Restoring platform NVS =
memory=0A=
Sep  4 09:26:28 s15 kernel: [  456.632338] Enabling non-boot CPUs ...=0A=
Sep  4 09:26:28 s15 kernel: [  456.632374] x86: Booting SMP =
configuration:=0A=
Sep  4 09:26:28 s15 kernel: [  456.632374] smpboot: Booting Node 0 =
Processor 1 APIC 0x2=0A=
Sep  4 09:26:28 s15 kernel: [  456.644260]  cache: parent cpu1 should =
not be sleeping=0A=
Sep  4 09:26:28 s15 kernel: [  456.644318] cpufreq: adding CPU 1=0A=
Sep  4 09:26:28 s15 kernel: [  456.644323] intel_pstate: controlling: =
cpu 1=0A=
Sep  4 09:26:28 s15 kernel: [  456.644325] cpufreq: setting new policy =
for CPU 1: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.644327] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.644327] cpufreq: setting range=0A=
Sep  4 09:26:28 s15 kernel: [  456.644328] cpufreq: initialization =
complete=0A=
Sep  4 09:26:28 s15 kernel: [  456.644364] CPU1 is up=0A=
Sep  4 09:26:28 s15 kernel: [  456.644381] smpboot: Booting Node 0 =
Processor 2 APIC 0x4=0A=
Sep  4 09:26:28 s15 kernel: [  456.652292]  cache: parent cpu2 should =
not be sleeping=0A=
Sep  4 09:26:28 s15 kernel: [  456.652348] cpufreq: adding CPU 2=0A=
Sep  4 09:26:28 s15 kernel: [  456.652352] intel_pstate: controlling: =
cpu 2=0A=
Sep  4 09:26:28 s15 kernel: [  456.652355] cpufreq: setting new policy =
for CPU 2: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.652356] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.652357] cpufreq: setting range=0A=
Sep  4 09:26:28 s15 kernel: [  456.652357] cpufreq: initialization =
complete=0A=
Sep  4 09:26:28 s15 kernel: [  456.652390] CPU2 is up=0A=
Sep  4 09:26:28 s15 kernel: [  456.652406] smpboot: Booting Node 0 =
Processor 3 APIC 0x6=0A=
Sep  4 09:26:28 s15 kernel: [  456.660308]  cache: parent cpu3 should =
not be sleeping=0A=
Sep  4 09:26:28 s15 kernel: [  456.660366] cpufreq: adding CPU 3=0A=
Sep  4 09:26:28 s15 kernel: [  456.660370] intel_pstate: controlling: =
cpu 3=0A=
Sep  4 09:26:28 s15 kernel: [  456.660373] cpufreq: setting new policy =
for CPU 3: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.660374] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.660375] cpufreq: setting range=0A=
Sep  4 09:26:28 s15 kernel: [  456.660375] cpufreq: initialization =
complete=0A=
Sep  4 09:26:28 s15 kernel: [  456.660409] CPU3 is up=0A=
Sep  4 09:26:28 s15 kernel: [  456.660426] smpboot: Booting Node 0 =
Processor 4 APIC 0x1=0A=
Sep  4 09:26:28 s15 kernel: [  456.668263]  cache: parent cpu4 should =
not be sleeping=0A=
Sep  4 09:26:28 s15 kernel: [  456.668300] cpufreq: adding CPU 4=0A=
Sep  4 09:26:28 s15 kernel: [  456.668304] intel_pstate: controlling: =
cpu 4=0A=
Sep  4 09:26:28 s15 kernel: [  456.668307] cpufreq: setting new policy =
for CPU 4: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.668308] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.668308] cpufreq: setting range=0A=
Sep  4 09:26:28 s15 kernel: [  456.668309] cpufreq: initialization =
complete=0A=
Sep  4 09:26:28 s15 kernel: [  456.668336] CPU4 is up=0A=
Sep  4 09:26:28 s15 kernel: [  456.668349] smpboot: Booting Node 0 =
Processor 5 APIC 0x3=0A=
Sep  4 09:26:28 s15 kernel: [  456.680270]  cache: parent cpu5 should =
not be sleeping=0A=
Sep  4 09:26:28 s15 kernel: [  456.680307] cpufreq: adding CPU 5=0A=
Sep  4 09:26:28 s15 kernel: [  456.680311] intel_pstate: controlling: =
cpu 5=0A=
Sep  4 09:26:28 s15 kernel: [  456.680313] cpufreq: setting new policy =
for CPU 5: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.680314] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.680314] cpufreq: setting range=0A=
Sep  4 09:26:28 s15 kernel: [  456.680315] cpufreq: initialization =
complete=0A=
Sep  4 09:26:28 s15 kernel: [  456.680341] CPU5 is up=0A=
Sep  4 09:26:28 s15 kernel: [  456.680355] smpboot: Booting Node 0 =
Processor 7 APIC 0x7=0A=
Sep  4 09:26:28 s15 kernel: [  456.688288]  cache: parent cpu7 should =
not be sleeping=0A=
Sep  4 09:26:28 s15 kernel: [  456.688326] cpufreq: adding CPU 7=0A=
Sep  4 09:26:28 s15 kernel: [  456.688330] intel_pstate: controlling: =
cpu 7=0A=
Sep  4 09:26:28 s15 kernel: [  456.688333] cpufreq: setting new policy =
for CPU 7: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.688333] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:28 s15 kernel: [  456.688334] cpufreq: setting range=0A=
Sep  4 09:26:28 s15 kernel: [  456.688334] cpufreq: initialization =
complete=0A=
Sep  4 09:26:28 s15 kernel: [  456.688360] CPU7 is up=0A=
Sep  4 09:26:28 s15 kernel: [  456.693743] ACPI: Waking up from system =
sleep state S3=0A=
Sep  4 09:26:28 s15 kernel: [  456.708292] ehci-pci 0000:00:1a.0: System =
wakeup disabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.708418] xhci_hcd 0000:07:00.0: System =
wakeup disabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.708583] ehci-pci 0000:00:1d.0: System =
wakeup disabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.708607] PM: noirq resume of devices =
complete after 14.593 msecs=0A=
Sep  4 09:26:28 s15 kernel: [  456.708929] PM: early resume of devices =
complete after 0.295 msecs=0A=
Sep  4 09:26:28 s15 kernel: [  456.709055] pcieport 0000:00:01.0: System =
wakeup disabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.709059] r8169 0000:03:00.0: System =
wakeup disabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.709106] rtc_cmos 00:02: System wakeup =
disabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.709123] usb usb1: root hub lost power =
or was reset=0A=
Sep  4 09:26:28 s15 kernel: [  456.709124] usb usb2: root hub lost power =
or was reset=0A=
Sep  4 09:26:28 s15 kernel: [  456.709537] parport_pc 00:05: activated=0A=
Sep  4 09:26:28 s15 kernel: [  456.709572] i8042 kbd 00:07: System =
wakeup disabled by ACPI=0A=
Sep  4 09:26:28 s15 kernel: [  456.710359] serial 00:08: activated=0A=
Sep  4 09:26:28 s15 kernel: [  456.713382] ACPI Error: [DSSP] Namespace =
lookup failure, AE_NOT_FOUND (20150619/psargs-359)=0A=
Sep  4 09:26:28 s15 kernel: [  456.713386] ACPI Error: Method =
parse/execution failed [\_SB_.PCI0.SAT0.CHN0.DRV0._GTF] (Node =
ffff88040ecc8438), AE_NOT_FOUND (20150619/psparse-536)=0A=
Sep  4 09:26:28 s15 kernel: [  456.713407] ACPI Error: [DSSP] Namespace =
lookup failure, AE_NOT_FOUND (20150619/psargs-359)=0A=
Sep  4 09:26:28 s15 kernel: [  456.713410] ACPI Error: Method =
parse/execution failed [\_SB_.PCI0.SAT0.CHN0.DRV1._GTF] (Node =
ffff88040ecc84b0), AE_NOT_FOUND (20150619/psparse-536)=0A=
Sep  4 09:26:28 s15 kernel: [  456.716059] ACPI Error: [DSSP] Namespace =
lookup failure, AE_NOT_FOUND (20150619/psargs-359)=0A=
Sep  4 09:26:28 s15 kernel: [  456.716068] ACPI Error: Method =
parse/execution failed [\_SB_.PCI0.SAT1.CHN0.DRV0._GTF] (Node =
ffff88040ecc87d0), AE_NOT_FOUND (20150619/psparse-536)=0A=
Sep  4 09:26:28 s15 kernel: [  456.718140] sd 0:0:0:0: [sda] Starting =
disk=0A=
Sep  4 09:26:28 s15 kernel: [  456.718142] sd 0:0:1:0: [sdb] Starting =
disk=0A=
Sep  4 09:26:28 s15 kernel: [  456.830264] r8169 0000:03:00.0 eth0: link =
down=0A=
Sep  4 09:26:28 s15 kernel: [  456.830272] br0: port 1(eth0) entered =
disabled state=0A=
Sep  4 09:26:28 s15 kernel: [  457.035873] ata5: SATA link down (SStatus =
0 SControl 300)=0A=
Sep  4 09:26:28 s15 kernel: [  457.035921] ata6: SATA link down (SStatus =
0 SControl 300)=0A=
Sep  4 09:26:28 s15 kernel: [  457.191764] ata3: SATA link up 1.5 Gbps =
(SStatus 113 SControl 330)=0A=
Sep  4 09:26:28 s15 kernel: [  457.195886] usb 1-2: reset low-speed USB =
device number 2 using xhci_hcd=0A=
Sep  4 09:26:28 s15 kernel: [  457.199927] ACPI Error: [DSSP] Namespace =
lookup failure, AE_NOT_FOUND (20150619/psargs-359)=0A=
Sep  4 09:26:28 s15 kernel: [  457.199930] ACPI Error: Method =
parse/execution failed [\_SB_.PCI0.SAT1.CHN0.DRV0._GTF] (Node =
ffff88040ecc87d0), AE_NOT_FOUND (20150619/psparse-536)=0A=
Sep  4 09:26:28 s15 kernel: [  457.215848] ata3.00: configured for =
UDMA/100=0A=
Sep  4 09:26:28 s15 kernel: [  457.473072] usb 1-2: ep 0x81 - rounding =
interval to 64 microframes, ep desc says 80 microframes=0A=
Sep  4 09:26:28 s15 kernel: [  457.476193] PM: resume of devices =
complete after 767.759 msecs=0A=
Sep  4 09:26:28 s15 kernel: [  457.476362] PM: Finishing wakeup.=0A=
Sep  4 09:26:28 s15 kernel: [  457.476363] Restarting tasks ... done.=0A=
... deleted some lines...=0A=
Sep  4 09:26:36 s15 kernel: [  464.735231] cpufreq: setting new policy =
for CPU 0: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.735235] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.735236] cpufreq: setting range=0A=
Sep  4 09:26:36 s15 kernel: [  464.735678] cpufreq: setting new policy =
for CPU 1: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.735680] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.735681] cpufreq: setting range=0A=
Sep  4 09:26:36 s15 kernel: [  464.736112] cpufreq: setting new policy =
for CPU 2: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.736114] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.736115] cpufreq: setting range=0A=
Sep  4 09:26:36 s15 kernel: [  464.736547] cpufreq: setting new policy =
for CPU 3: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.736549] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.736550] cpufreq: setting range=0A=
Sep  4 09:26:36 s15 kernel: [  464.736968] cpufreq: setting new policy =
for CPU 4: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.736971] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.736972] cpufreq: setting range=0A=
Sep  4 09:26:36 s15 kernel: [  464.737388] cpufreq: setting new policy =
for CPU 5: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.737390] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.737391] cpufreq: setting range=0A=
Sep  4 09:26:36 s15 kernel: [  464.738325] cpufreq: setting new policy =
for CPU 7: 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.738328] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:26:36 s15 kernel: [  464.738329] cpufreq: setting range=0A=
Sep  4 09:26:39 s15 kernel: [  468.184616] br0: port 1(eth0) entered =
forwarding state=0A=
=0A=
>>>>>> Now put CPU 6 back online and take CPU 7 offline.=0A=
Sep  4 09:30:52 s15 kernel: [  720.581828] smpboot: Booting Node 0 =
Processor 6 APIC 0x5=0A=
Sep  4 09:30:52 s15 kernel: [  720.602104] cpufreq: adding CPU 6=0A=
Sep  4 09:30:52 s15 kernel: [  720.602142] intel_pstate: controlling: =
cpu 6=0A=
Sep  4 09:30:52 s15 kernel: [  720.602147] cpufreq: setting new policy =
for CPU 6: 1600000 - 3800000 kHz=0A=
Sep  4 09:30:52 s15 kernel: [  720.602150] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:30:52 s15 kernel: [  720.602151] cpufreq: setting range=0A=
Sep  4 09:30:52 s15 kernel: [  720.602153] cpufreq: initialization =
complete=0A=
Sep  4 09:31:03 s15 kernel: [  732.221929] cpufreq: =
__cpufreq_remove_dev_prepare: unregistering CPU 7=0A=
Sep  4 09:31:03 s15 kernel: [  732.221932] intel_pstate: CPU 7 exiting=0A=
Sep  4 09:31:03 s15 kernel: [  732.235076] smpboot: CPU 7 is now offline=0A=
=0A=
>>>>>> about to to "sudo pm-suspend" that will fail.=0A=
Sep  4 09:32:43 s15 kernel: [  831.613558] cpufreq: setting new policy =
for CPU 0: 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.613562] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.613563] cpufreq: setting range=0A=
Sep  4 09:32:43 s15 kernel: [  831.614373] cpufreq: setting new policy =
for CPU 1: 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.614375] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.614376] cpufreq: setting range=0A=
Sep  4 09:32:43 s15 kernel: [  831.615165] cpufreq: setting new policy =
for CPU 2: 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.615166] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.615167] cpufreq: setting range=0A=
Sep  4 09:32:43 s15 kernel: [  831.615956] cpufreq: setting new policy =
for CPU 3: 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.615957] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.615958] cpufreq: setting range=0A=
Sep  4 09:32:43 s15 kernel: [  831.616740] cpufreq: setting new policy =
for CPU 4: 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.616741] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.616742] cpufreq: setting range=0A=
Sep  4 09:32:43 s15 kernel: [  831.617594] cpufreq: setting new policy =
for CPU 5: 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.617596] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.617596] cpufreq: setting range=0A=
Sep  4 09:32:43 s15 kernel: [  831.618386] cpufreq: setting new policy =
for CPU 6: 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.618387] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 09:32:43 s15 kernel: [  831.618388] cpufreq: setting range=0A=
=0A=
>>>>>> During write up, realize that the last entries above must have =
been during the "sudo pm-suspend" that fails.=0A=
>>>>>> Verify that these log entries are all that occur for the failed =
"sudo pm-suspend" by doing another:=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.787685] cpufreq: setting new policy =
for CPU 0: 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.787689] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.787690] cpufreq: setting range=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.788544] cpufreq: setting new policy =
for CPU 1: 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.788546] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.788547] cpufreq: setting range=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.789389] cpufreq: setting new policy =
for CPU 2: 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.789391] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.789391] cpufreq: setting range=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.790210] cpufreq: setting new policy =
for CPU 3: 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.790212] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.790213] cpufreq: setting range=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.790992] cpufreq: setting new policy =
for CPU 4: 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.790994] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.790994] cpufreq: setting range=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.791891] cpufreq: setting new policy =
for CPU 5: 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.791893] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.791894] cpufreq: setting range=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.792739] cpufreq: setting new policy =
for CPU 6: 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.792741] cpufreq: new min and max =
freqs are 1600000 - 3800000 kHz=0A=
Sep  4 11:15:38 s15 kernel: [ 7002.792741] cpufreq: setting range=0A=

------=_NextPart_000_0008_01D0E706.ACD4ED80--

