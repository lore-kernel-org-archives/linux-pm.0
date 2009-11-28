From: Sriram V <vshrirama@gmail.com>
Subject: Re: Question on USB re-enumeration
Date: Sat, 28 Nov 2009 12:07:49 +0530
Message-ID: <8bf247760911272237l13cb6d4pc6636a20a90c8d3a@mail.gmail.com>
References: <8bf247760911150100i15434810r7be8e1c03f78c7f7@mail.gmail.com>
	<Pine.LNX.4.44L0.0911151407380.6654-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911151407380.6654-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Alan,
  We have a USB GSM externally powered connected through a external
transceiver phy. Normal suspend-resume works.
  When we make a call to the GSM chip while in suspend. The resume
fails and it returns -19.

  This is coming from file : drivers/usb/core/driver.c - external usb
resume function.


Regards,
sriram



I am appending the log im seeing here:

Sucessful Resume:
----------------------------

<6>PM: Syncing filesystems ... done.
<7>PM: Preparing system for mem sleep
<4>Freezing user space processes ... (elapsed 0.00 seconds) done.
<4>Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
<7>PM: Entering mem sleep
<4>Suspending console(s) (use no_console_suspend to debug)
<7>hub 1-0:1.0: hub_suspend
<7>usb usb1: bus suspend
<7>ehci-omap ehci-omap.0: suspend root hub
<6>Powerdomain (core_pwrdm) didn't enter target state 1
<3>Could not enter target state in pm_suspend
<7>usb usb1: usb resume
<7>ehci-omap ehci-omap.0: resume root hub
<7>hub 1-0:1.0: hub_resume
<7>ehci-omap ehci-omap.0: GetStatus port 2 status 001803 POWER sig=3Dj CSC =
CONNECT
<7>hub 1-0:1.0: port 2: status 0501 change 0001
<7>usb 1-2: reset-resume
<7>ehci-omap ehci-omap.0: port 2 high speed
<7>ehci-omap ehci-omap.0: GetStatus port 2 status 001005 POWER sig=3Dse0
PE CONNECT
<6>usb 1-2: reset high speed USB device using ehci-omap and address 2
<7>ehci-omap ehci-omap.0: port 2 high speed
<7>ehci-omap ehci-omap.0: GetStatus port 2 status 001005 POWER sig=3Dse0
PE CONNECT
<7>PM: Finishing wakeup.
<4>Restarting tasks ... <6>
<7>hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0000
<7>hub 1-0:1.0: port 2, status 0503, change 0000, 480 Mb/s
<4>done.


Unsuccessful Resume:
----------------------------------
<6>PM: Syncing filesystems ... done.
<7>PM: Preparing system for mem sleep
<4>Freezing user space processes ... (elapsed 0.00 seconds) done.
<4>Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
<7>PM: Entering mem sleep
<4>Suspending console(s) (use no_console_suspend to debug)
<7>hub 1-0:1.0: hub_suspend
<7>usb usb1: bus suspend
<7>ehci-omap ehci-omap.0: suspend root hub
<6>Powerdomain (core_pwrdm) didn't enter target state 1
<3>Could not enter target state in pm_suspend
<<7>usb usb1: usb resume
<7>ehci-omap ehci-omap.0: resume root hub
<7>hub 1-0:1.0: hub_resume
<7>ehci-omap ehci-omap.0: GetStatus port 2 status 001803 POWER sig=3Dj CSC =
CONNECT
<7>hub 1-0:1.0: port 2: status 0501 change 0001
<7>usb 1-2: reset-resume
<7>ehci-omap ehci-omap.0: port 2 high speed
<7>ehci-omap ehci-omap.0: GetStatus port 2 status 001005 POWER sig=3Dse0
PE CONNECT
<6>usb 1-2: reset high speed USB device using ehci-omap and address 2
<7>ehci-omap ehci-omap.0: devpath 2 ep0in 3strikes
<7>ehci-omap ehci-omap.0: devpath 2 ep0in 3strikes
<7>ehci-omap ehci-omap.0: devpath 2 ep0in 3strikes
<7>ehci-omap ehci-omap.0: GetStatus port 2 status 001002 POWER sig=3Dse0 CSC
<7>hub 1-0:1.0: logical disconnect on port 2
<3>pm_op(): usb_dev_resume+0x0/0x18 returns -19
<3>PM: Device 1-2 failed to resume: error -19
<7>PM: Finishing wakeup.
<4>Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 3 chg 0004 evt 0004
<7>hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
<6>usb 1-2: USB disconnect, address 2
<7>usb 1-2: unregistering device
<7>usb 1-2: usb_disable_device nuking all URBs
<7>usb 1-2: unregistering interface 1-2:1.0
<7>usb 1-2:1.0: uevent
<7>usb 1-2: unregistering interface 1-2:1.1
<7>usb 1-2:1.1: uevent
<7>usb 1-2: unregistering interface 1-2:1.2
<7>usb 1-2:1.2: uevent
<7>usb 1-2: unregistering interface 1-2:1.3
<4>done.
<6>suspend: exit suspend, ret =3D 0
<7>usb 1-2:1.3: uevent
<7>usb 1-2: unregistering interface 1-2:1.4
<7>usb 1-2:1.4: uevent
<7>usb 1-2: uevent



On Mon, Nov 16, 2009 at 12:41 AM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> On Sun, 15 Nov 2009, Sriram V wrote:
>
>> Hi,
>>
>> I have a couple of questions of re-enumeration of usb devices on
>> suspend-resume
>>
>> I have a USB Device permanently connected to the host controller.
>>
>> Upon resume - Should i usb device get re-enumerated?
>
> If the host controller lost power was reinitialized during the suspend
> then yes. =A0Otherwise no. =A0In particular, devices should always get
> re-enumerated when resuming from hibernation. =A0But when resuming from
> suspend-to-RAM, it depends on the motherboard.
>
>> If so, does Linux choose a different address for accessing it?
>
> If the device's firmware hasn't changed then the address remains the
> same. =A0Otherwise a different address is used.
>
> Read Documentation/usb/persist.txt.
>
>> If i have a USB harddisk, I am accessing it using a device node say
>> /dev/sdb1
>> The harddisk is mounted as /dev/sdb1.
>>
>> Now, i go into suspend and then resume - If i need to re-enumerate the
>> devices
>> It could be detected as /dev/sdc1... or something.
>>
>> If that is the case i cannot access my harddisk - since im assuming
>> /dev/sdb1.
>>
>> What im seeing here is - My usb device is permanently connected to the u=
sb
>> host via an external phy.
>>
>> =A0When i suspend - i turn off the clocks and upon resume - turn on the =
clocks
>> and reset the phy.
>>
>> =A0For some time - i am able to access the device, What happens is - The
>> device gets re-enumerated to some other device node.
>>
>> I am not sure if this is a device issue or a resume function issue.
>>
>>
>> Please advice.
>
> Enable CONFIG_USB_DEBUG in your kernel and post the dmesg log showing
> what happens during suspend and resume.
>
> Alan Stern
>
>
