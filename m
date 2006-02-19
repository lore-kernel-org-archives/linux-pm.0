From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: suspend-to-ram fails resume.
Date: Sun, 19 Feb 2006 17:58:52 +0000
Message-ID: <43F8B1DC.7060204@superbug.co.uk>
References: <43EE824B.20609@superbug.co.uk>
	<20060215233300.GB3490@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030805090502030005000401"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060215233300.GB3490@openzaurus.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------030805090502030005000401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
>> "hibernate" and restore to/from disk works fine.
>> I have been trying to resume after running a "hibernate-ram" script.
>> Just using a text console, no X.
>>
>> I attach a log with comments in it.
>> I have a Nvidia FX5200 video card.
>>
>> After resume the display is blank. ping works from a remote machine, but
>> ssh does not work.
>>
>> What can I do to help diagnose this problem?
>>     
>
> get video to work - see Doc*/power/video.txt and see
> what are last messages on console.
>   

I have sort of solved my problem.
I can exit from suspend ok now, but I have to disable the detection of 
the power button in the /etc/acpi scripts.
So, I now need some way of disabling detection of the power button while 
it is exiting from suspend.
Does anyone have any ideas how to?

James


--------------030805090502030005000401
Content-Type: text/plain;
 name="power-works.txt"
Content-Disposition: inline;
 filename="power-works.txt"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k1JHx1DZ001678

# Press the Power button to check that the power off script is disabled.

Feb 19 17:45:59 localhost logger: ACPI action power is not defined

# Run the hibernate-ram script (from gentoo)

Feb 19 17:46:24 localhost kernel: ehci_hcd 0000:00:1d.7: remove, state 1
Feb 19 17:46:24 localhost kernel: usb usb1: USB disconnect, address 1
Feb 19 17:46:24 localhost kernel: usb 1-3: USB disconnect, address 2
Feb 19 17:46:24 localhost kernel: usb 1-3.4: USB disconnect, address 3
Feb 19 17:46:24 localhost kernel: ehci_hcd 0000:00:1d.7: USB bus 1 deregi=
stered
Feb 19 17:46:24 localhost kernel: ACPI: PCI interrupt for device 0000:00:=
1d.7 disabled
Feb 19 17:46:25 localhost kernel: PM: Preparing system for mem sleep
Feb 19 17:46:25 localhost kernel: Freezing cpus ...
Feb 19 17:46:25 localhost kernel: CPU 1 is now offline
Feb 19 17:46:25 localhost kernel: CPU1 is down
Feb 19 17:47:10 localhost kernel: Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
Feb 19 17:47:10 localhost kernel: ACPI: PCI interrupt for device 0000:02:=
01.0 disabled
Feb 19 17:47:10 localhost kernel: ACPI: PCI interrupt for device 0000:00:=
1f.2 disabled
Feb 19 17:47:10 localhost kernel: PM: Entering mem sleep

# System has fallen to sleep.

# Press the Power buffer to wake it up.

Feb 19 17:47:10 localhost kernel: Intel machine check architecture suppor=
ted.
Feb 19 17:47:10 localhost kernel: Intel machine check reporting enabled o=
n CPU#0.
Feb 19 17:47:10 localhost kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (=
12) available
Feb 19 17:47:10 localhost kernel: CPU0: Thermal monitoring enabled
Feb 19 17:47:10 localhost kernel: Back to C!
Feb 19 17:47:10 localhost kernel: PM: Finishing wakeup.
Feb 19 17:47:10 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1e.0 to 64
Feb 19 17:47:10 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 19 17:47:10 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1f.2 to 64
Feb 19 17:47:10 localhost kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 19 17:47:10 localhost kernel: PCI: Setting latency timer of device 00=
00:02:01.0 to 64
Feb 19 17:47:10 localhost kernel: ACPI: PCI Interrupt 0000:03:02.0[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 19 17:47:10 localhost kernel: ACPI: PCI Interrupt 0000:03:03.0[A] -> =
GSI 19 (level, low) -> IRQ 177
Feb 19 17:47:10 localhost kernel: PCI: Enabling device 0000:03:05.2 (0000=
 -> 0002)
Feb 19 17:47:10 localhost kernel: ACPI: PCI Interrupt 0000:03:05.2[B] -> =
GSI 22 (level, low) -> IRQ 193
Feb 19 17:47:10 localhost kernel: ata1: dev 0 configured for UDMA/33
Feb 19 17:47:10 localhost kernel: ata1: dev 1 configured for UDMA/33
Feb 19 17:47:10 localhost kernel: ATA: abnormal status 0x80 on port 0x177
Feb 19 17:47:10 localhost last message repeated 2 times
Feb 19 17:47:10 localhost kernel: e1000: eth0: e1000_watchdog_task: NIC L=
ink is Up 100 Mbps Full Duplex
Feb 19 17:47:10 localhost kernel: ata2: slow completion (cmd ef)
Feb 19 17:47:10 localhost kernel: ata2: dev 0 configured for UDMA/133
Feb 19 17:47:10 localhost kernel: ata2: dev 1 configured for UDMA/133
Feb 19 17:47:10 localhost gconfd (jcd-6843): GConf server is not in use, =
shutting down.
Feb 19 17:47:10 localhost gconfd (jcd-6843): Exiting

# OOPS!!!  The pressing of the power button to exist suspend mode
# has been detected as a "power button" for OFF!!!
# But in this case it is ignored, as I disabled the script at the beginni=
ng.

Feb 19 17:47:10 localhost logger: ACPI action power is not defined
Feb 19 17:47:10 localhost kernel: Restarting tasks... done
Feb 19 17:47:10 localhost kernel: Thawing cpus ...
Feb 19 17:47:10 localhost kernel: Booting processor 1/1 eip 3000
Feb 19 17:47:10 localhost kernel: CPU 1 irqstacks, hard=3Dc047f000 soft=3D=
c0477000
Feb 19 17:47:10 localhost kernel: Initializing CPU#1
Feb 19 17:47:10 localhost kernel: Calibrating delay using timer specific =
routine.. 5613.13 BogoMIPS (lpj=3D11226265)
Feb 19 17:47:10 localhost kernel: CPU: After generic identify, caps: bfeb=
fbff 00000000 00000000 00000000 00004400 00000000 00000000
Feb 19 17:47:10 localhost kernel: CPU: After vendor identify, caps: bfebf=
bff 00000000 00000000 00000000 00004400 00000000 00000000
Feb 19 17:47:10 localhost kernel: CPU: Trace cache: 12K uops, L1 D cache:=
 8K
Feb 19 17:47:10 localhost kernel: CPU: L2 cache: 512K
Feb 19 17:47:10 localhost kernel: CPU: Physical Processor ID: 0
Feb 19 17:47:10 localhost kernel: CPU: After all inits, caps: bfebfbff 00=
000000 00000000 00000080 00004400 00000000 00000000
Feb 19 17:47:10 localhost kernel: Intel machine check architecture suppor=
ted.
Feb 19 17:47:10 localhost kernel: Intel machine check reporting enabled o=
n CPU#1.
Feb 19 17:47:10 localhost kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (=
12) available
Feb 19 17:47:10 localhost kernel: CPU1: Thermal monitoring enabled
Feb 19 17:47:10 localhost kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz=
 stepping 09
Feb 19 17:47:10 localhost kernel: APIC error on CPU1: 00(40)
Feb 19 17:47:10 localhost kernel: CPU1 is up
Feb 19 17:47:14 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> =
GSI 23 (level, low) -> IRQ 185
Feb 19 17:47:14 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1d.7 to 64
Feb 19 17:47:14 localhost kernel: ehci_hcd 0000:00:1d.7: EHCI Host Contro=
ller
Feb 19 17:47:14 localhost kernel: ehci_hcd 0000:00:1d.7: debug port 1
Feb 19 17:47:14 localhost kernel: PCI: cache line size of 128 is not supp=
orted by device 0000:00:1d.7
Feb 19 17:47:14 localhost kernel: ehci_hcd 0000:00:1d.7: new USB bus regi=
stered, assigned bus number 1
Feb 19 17:47:14 localhost kernel: ehci_hcd 0000:00:1d.7: irq 185, io mem =
0xfc100000
Feb 19 17:47:14 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started,=
 EHCI 1.00, driver 10 Dec 2004
Feb 19 17:47:14 localhost kernel: hub 1-0:1.0: USB hub found
Feb 19 17:47:14 localhost kernel: hub 1-0:1.0: 8 ports detected
Feb 19 17:47:15 localhost kernel: usb 1-3: new high speed USB device usin=
g ehci_hcd and address 2
Feb 19 17:47:15 localhost kernel: hub 1-3:1.0: USB hub found
Feb 19 17:47:15 localhost kernel: hub 1-3:1.0: 7 ports detected
Feb 19 17:47:15 localhost kernel: usb 1-3.4: new low speed USB device usi=
ng ehci_hcd and address 3
Feb 19 17:47:15 localhost kernel: input: Microsoft Microsoft IntelliMouse=
=AE Explorer as /class/input/input2
Feb 19 17:47:15 localhost kernel: input: USB HID v1.00 Mouse [Microsoft M=
icrosoft IntelliMouse=AE Explorer] on usb-0000:00:1d.7-3.4

--------------030805090502030005000401
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--------------030805090502030005000401--
