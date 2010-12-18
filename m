From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.37-rc5, pata_atiixp,
 DVD-ROM: kernel log flooded with "rpm_resume flags 0x4",
 "rpm_resume returns 1"
Date: Sat, 18 Dec 2010 13:11:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012181259080.3334-100000@saphir.localdomain>
References: <20101217211556.2789cb80@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101217211556.2789cb80@stein>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Dec 2010, Stefan Richter wrote:

> On Dec 11 Alan Stern wrote:
> > On Sat, 11 Dec 2010, Stefan Richter wrote:
> > 
> > > Hi,
> > > 
> > > I just booted from 2.6.36 (without PM debugging configured) into
> > > 2.6.37-rc5 (with PM debugging enabled).  There is endless log spam like
> > > this:
> > > 
> > > Dec 11 17:11:31 stein kernel: scsi host6: rpm_resume flags 0x4
> > > Dec 11 17:11:31 stein kernel: scsi host6: rpm_resume returns 1
> > > Dec 11 17:11:31 stein kernel: scsi host6: rpm_resume flags 0x4
> > > Dec 11 17:11:31 stein kernel: scsi host6: rpm_resume returns 1
> > ...
> > 
> > > Why is rpm_resume performed 6 times every two seconds?
> > 
> > This is probably because hal probes the DVD drive every two seconds
> > looking for media changes.  However that's not supposed to cause
> > rpm_resume to be called for the host unless runtime PM is allowed for
> > the DVD drive, which it isn't according to your listings below.  So
> > there's a bug somewhere.
> 
> I had 2.6.36 running since then and have now booted into 2.6.37-rc6.
> 
> Yes, it is hal indeed.  Shutting hal down avoids this logging activity.
> 
> > > host6 is pata_atiixp with an:
> > > 
> > > 00:14.1 IDE interface: ATI Technologies Inc SB700/SB800 IDE Controller
> > > (prog-if 8a [Master SecP PriP])
> > > 
> > > # grep . /sys/class/scsi_host/host6/power/*
> > > /sys/class/scsi_host/host6/power/async:enabled
> > > grep: /sys/class/scsi_host/host6/power/autosuspend_delay_ms: Input/output error
> > > /sys/class/scsi_host/host6/power/control:auto
> > > /sys/class/scsi_host/host6/power/runtime_active_kids:0
> > > /sys/class/scsi_host/host6/power/runtime_active_time:0
> > > /sys/class/scsi_host/host6/power/runtime_enabled:disabled
> > > /sys/class/scsi_host/host6/power/runtime_status:unsupported
> > > /sys/class/scsi_host/host6/power/runtime_suspended_time:0
> > > /sys/class/scsi_host/host6/power/runtime_usage:0
> > 
> > This is the wrong directory (the class device, not the device itself).  
> > You should look at /sys/class/scsi_host/host6/device/power instead.  
> > And also /sys/class/scsi_host/host6/device/target6:0:0/power.
> 
> OK, correct directory follows below.
> 
> Actually, this time I see once every two seconds a message about
> logical unit 6:0:0:0 and 6 times every two seconds a message about
> host7:
> 
> Dec 17 20:22:08 stein kernel: sd 6:0:0:0: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: sd 6:0:0:0: rpm_resume returns 1
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume returns 1
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume flags 0x4
> Dec 17 20:22:08 stein kernel: scsi host7: rpm_resume returns 1
...

> sd 6:0:0:0 is a USB card reader built into a monitor:
> Host: scsi6 Channel: 00 Id: 00 Lun: 00
>   Vendor: Generic  Model: Ultra HS-SD/MMC  Rev: 1.88
>   Type:   Direct-Access                    ANSI  SCSI revision: 00
> 
> This is from the power/ directory of the "6:0:0:0" device which is
> bound to driver sd:
> 
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/host6/target6:0:0/6:0:0:0/power/async:enabled
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/host6/target6:0:0/6:0:0:0/power/control:on
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/host6/target6:0:0/6:0:0:0/power/runtime_active_kids:0
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/host6/target6:0:0/6:0:0:0/power/runtime_active_time:1650131
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/host6/target6:0:0/6:0:0:0/power/runtime_enabled:forbidden
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/host6/target6:0:0/6:0:0:0/power/runtime_status:active
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/host6/target6:0:0/6:0:0:0/power/runtime_suspended_time:0
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.0/host6/target6:0:0/6:0:0:0/power/runtime_usage:1
> 
> host7 is the mentioned ATI SB700/SB800 IDE controller.  Here is the
> power/ directory of the scsi_host device (rather than scsi_host class
> device):
> 
> /sys/devices/pci0000:00/0000:00:14.1/host7/power/async:enabled
> /sys/devices/pci0000:00/0000:00:14.1/host7/power/control:auto
> /sys/devices/pci0000:00/0000:00:14.1/host7/power/runtime_active_kids:1
> /sys/devices/pci0000:00/0000:00:14.1/host7/power/runtime_active_time:1935478
> /sys/devices/pci0000:00/0000:00:14.1/host7/power/runtime_enabled:enabled
> /sys/devices/pci0000:00/0000:00:14.1/host7/power/runtime_status:active
> /sys/devices/pci0000:00/0000:00:14.1/host7/power/runtime_suspended_time:0
> /sys/devices/pci0000:00/0000:00:14.1/host7/power/runtime_usage:0
> 
> The parent device 0000:00:14.1 is bound to the mentioned pata_atiixp,
> if this is of any importance at all.
> 
> From the child device:
> 
> /sys/devices/pci0000:00/0000:00:14.1/host7/target7:0:0/power/async:enabled
> /sys/devices/pci0000:00/0000:00:14.1/host7/target7:0:0/power/control:auto
> /sys/devices/pci0000:00/0000:00:14.1/host7/target7:0:0/power/runtime_active_kids:1
> /sys/devices/pci0000:00/0000:00:14.1/host7/target7:0:0/power/runtime_active_time:2402125
> /sys/devices/pci0000:00/0000:00:14.1/host7/target7:0:0/power/runtime_enabled:enabled
> /sys/devices/pci0000:00/0000:00:14.1/host7/target7:0:0/power/runtime_status:active
> /sys/devices/pci0000:00/0000:00:14.1/host7/target7:0:0/power/runtime_suspended_time:0
> /sys/devices/pci0000:00/0000:00:14.1/host7/target7:0:0/power/runtime_usage:0

Okay.  These messages appear because during each probe, something is
requesting a runtime-PM resume.  In the case of sd 6:0:0:0, the resume
happens each time the device file is opened; I don't know why you're
getting a resume request for the scsi7 host (probably something strange
going on in the ATA stack).  If you really want to know, you could add a
dump_stack() to one of the debugging messages in rpm_resume().

The "flags 0x4" means the actual call is pm_runtime_get_sync().  The
"returns 1" means that the call didn't do anything to the hardware because
the device in question was already at full power.

> --------
> 
> On Dec 11 Rafael J. Wysocki wrote:
> > On Saturday, December 11, 2010, Stefan Richter wrote:
> > > Hi,
> > > 
> > > I just booted from 2.6.36 (without PM debugging configured) into
> > > 2.6.37-rc5 (with PM debugging enabled).  There is endless log spam like
> > > this:
> > 
> > I guess you have either CONFIG_PM_VERBOSE set or CONFIG_PM_DEBUG unset.
> > 
> > Which is the case?
> 
> I have both options off on 2.6.36 and older kernels.  I have both
> options on on 2.6.37-rc5/-rc6 (because I wanted to check something
> unrelated on 2.6.37).

These messages are produced by dev_dbg() calls.  The debug output is 
enabled by either CONFIG_PM_VERBOSE or CONFIG_DEBUG_DRIVER.  Since you say 
CONFIG_PM_VERBOSE is off, the other must be on -- unless maybe you have 
CONFIG_DYNAMIC_DEBUG enabled.

Alan Stern
