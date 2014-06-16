From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: v3.16-rc1 regression? unexpected usb_autopm_get_interface error
Date: Mon, 16 Jun 2014 13:31:26 +0200
Message-ID: <87r42p146p.fsf@nemi.mork.no>
References: <87egyp8f70.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:39809 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbaFPLed convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 07:34:33 -0400
In-Reply-To: <87egyp8f70.fsf@nemi.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of "Mon, 16
	Jun 2014 09:51:47 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-pm@vger.kernel.org

[adding the linux-pm list as I suspect this is a more generic issue
affecting usb, quoting all I previously sent to linux-usb for context]

Bj=C3=B8rn Mork <bjorn@mork.no> writes:

> I just booted v3.16-rc1 on my laptop and ended up with an error I've
> never encountered before.  Which makes me suspect that it is related =
to
> changes in v3.16.  Haven't yet spent any time trying to debug it.  Ju=
st
> posting in case it is an already known problem.
>
> I got this in the log:
>
> [  268.689677] usb usb3-port4: not suspended yet
> [  268.696603] cdc_mbim 3-4:1.0: Error autopm - -16
>
> And looking at the latter driver (which I should know ;-), I see that
> this is logged if we get an error from usb_autopm_get_interface when
> attempting to open the chardev:
>
> static int wdm_open(struct inode *inode, struct file *file)
> {
> ..
>         rv =3D usb_autopm_get_interface(desc->intf);
>         if (rv < 0) {
>                 dev_err(&desc->intf->dev, "Error autopm - %d\n", rv);
>                 goto out;
>         }
>
>
>
> But we shouldn't really hit this, and I cannot remember ever seeing i=
t
> before.  Looking at the device power state, I note that the
> runtime_status is 'error':
>
> bjorn@nemi:~$  grep . /sys/bus/usb/devices/3-4/power/*
> /sys/bus/usb/devices/3-4/power/active_duration:4284
> /sys/bus/usb/devices/3-4/power/async:enabled
> /sys/bus/usb/devices/3-4/power/autosuspend:2
> /sys/bus/usb/devices/3-4/power/autosuspend_delay_ms:2000
> /sys/bus/usb/devices/3-4/power/connected_duration:1523832
> /sys/bus/usb/devices/3-4/power/control:auto
> /sys/bus/usb/devices/3-4/power/level:auto
> /sys/bus/usb/devices/3-4/power/persist:1
> /sys/bus/usb/devices/3-4/power/runtime_active_kids:0
> /sys/bus/usb/devices/3-4/power/runtime_active_time:4040
> /sys/bus/usb/devices/3-4/power/runtime_enabled:enabled
> /sys/bus/usb/devices/3-4/power/runtime_status:error
> /sys/bus/usb/devices/3-4/power/runtime_suspended_time:1519548
> /sys/bus/usb/devices/3-4/power/runtime_usage:0
> /sys/bus/usb/devices/3-4/power/wakeup:disabled
>
>
> Known problem?  Or any suggestions where I start debugging this?
>
> FWIW, I've been using this device with all the latest and greatest
> changes to cdc_mbim for a few weeks already, so I'm pretty sure it is=
n't
> (only) those changes which trigger this.  I beleive it has to be
> something related to the usb and/or pm core.
>
> If it matters, this device is connected to an internal (mini-PCIe)
> laptop port.  The port state looks OK to me:
>
> bjorn@nemi:~$ cat /sys/bus/usb/devices/3-4/port/connect_type=20
> hardwired
> bjorn@nemi:~$ grep . /sys/bus/usb/devices/3-4/port/power/*
> /sys/bus/usb/devices/3-4/port/power/async:enabled
> grep: /sys/bus/usb/devices/3-4/port/power/autosuspend_delay_ms: Input=
/output error
> /sys/bus/usb/devices/3-4/port/power/control:auto
> /sys/bus/usb/devices/3-4/port/power/runtime_active_kids:0
> /sys/bus/usb/devices/3-4/port/power/runtime_active_time:0
> /sys/bus/usb/devices/3-4/port/power/runtime_enabled:disabled
> /sys/bus/usb/devices/3-4/port/power/runtime_status:unsupported
> /sys/bus/usb/devices/3-4/port/power/runtime_suspended_time:0
> /sys/bus/usb/devices/3-4/port/power/runtime_usage:1


Some more experimenting reveals that this isn't limited to a single
device, or to builtin devices.  I have the exact same problem with *all=
*
USB devices.  Any USB device which is runtime suspended before it is
used becomes non-functional with a permanent(?) 'error' runtime_status:

nemi:/home/bjorn# grep . /sys/bus/usb/devices/?-?/power/runtime_status
/sys/bus/usb/devices/1-1/power/runtime_status:error
/sys/bus/usb/devices/1-6/power/runtime_status:error
/sys/bus/usb/devices/3-2/power/runtime_status:error
/sys/bus/usb/devices/5-1/power/runtime_status:error
/sys/bus/usb/devices/5-4/power/runtime_status:error
/sys/bus/usb/devices/7-1/power/runtime_status:error

Suspending and resuming the system resets the state temporarily:

nemi:/home/bjorn# grep . /sys/bus/usb/devices/?-?/power/runtime_status
/sys/bus/usb/devices/1-1/power/runtime_status:suspended
/sys/bus/usb/devices/1-6/power/runtime_status:suspended
/sys/bus/usb/devices/3-2/power/runtime_status:suspended
/sys/bus/usb/devices/5-1/power/runtime_status:suspended
/sys/bus/usb/devices/5-4/power/runtime_status:active
/sys/bus/usb/devices/7-1/power/runtime_status:suspended


This doesn't really help though.  Attempting to activate these devices
by opening their respective character devices etc return them to the
same error state:

nemi:/home/bjorn# cat /dev/ttyUSB0
cat: /dev/ttyUSB0: Device or resource busy
nemi:/home/bjorn# grep . /sys/bus/usb/devices/?-?/power/runtime_status
/sys/bus/usb/devices/1-1/power/runtime_status:suspended
/sys/bus/usb/devices/1-6/power/runtime_status:suspended
/sys/bus/usb/devices/3-2/power/runtime_status:suspended
/sys/bus/usb/devices/5-1/power/runtime_status:error
/sys/bus/usb/devices/5-4/power/runtime_status:suspended
/sys/bus/usb/devices/7-1/power/runtime_status:suspended
nemi:/home/bjorn# cat /dev/ttyACM0=20
cat: /dev/ttyACM0: Input/output error
nemi:/home/bjorn# grep . /sys/bus/usb/devices/?-?/power/runtime_status
/sys/bus/usb/devices/1-1/power/runtime_status:suspended
/sys/bus/usb/devices/1-6/power/runtime_status:suspended
/sys/bus/usb/devices/3-2/power/runtime_status:suspended
/sys/bus/usb/devices/5-1/power/runtime_status:error
/sys/bus/usb/devices/5-4/power/runtime_status:error
/sys/bus/usb/devices/7-1/power/runtime_status:suspended


But if a device is opened (i.e. marked it "in use") *before* it is
runtime suspended for the first time, then this device will continue to
work.  Also after being runtime suspended.

So the problem is related to runtime suspend before first use. I
strongly suspect=20

 aae4518b3124 PM / sleep: Mechanism to avoid resuming runtime-suspended=
 devices unnecessarily

but I haven't been able to verify this yet as it doesn't revert
cleanly.  Will continue to look at it, but any help and/or hint is
appreciated.



Bj=C3=B8rn
