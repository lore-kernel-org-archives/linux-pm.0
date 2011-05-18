From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: xHCI and suspend/resume
Date: Wed, 18 May 2011 21:40:41 +0200
Message-ID: <201105182140.42296.rjw__8635.79791407592$1305747673$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<2DEEA3AB13739D45A22ADDB5086AEA0B015AD959@sshaexmb1.amd.com>
	<BANLkTin6=h1HfL6vuKEJR36ABgeakEiZyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTin6=h1HfL6vuKEJR36ABgeakEiZyA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dwight Schauer <dschauer@gmail.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, "Xu, Andiry" <Andiry.Xu@amd.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 18, 2011, Dwight Schauer wrote:
> On Tue, May 17, 2011 at 8:59 PM, Xu, Andiry <Andiry.Xu@amd.com> wrote:
> >> -----Original Message-----
> >> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
> >> owner@vger.kernel.org] On Behalf Of Dwight Schauer
> >> Sent: Wednesday, May 18, 2011 7:02 AM
> >> To: Rafael J. Wysocki
> >> Cc: linux-pm@lists.linux-foundation.org; Sarah Sharp; dschauer@ti.com;
> >> USB list
> >> Subject: Re: [linux-pm] xHCI and suspend/resume
> >>
> >> On Tue, May 17, 2011 at 5:56 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Wednesday, May 18, 2011, Dwight Schauer wrote:
> >> >> On Tue, May 17, 2011 at 4:54 PM, Rafael J. Wysocki <rjw@sisk.pl>
> >> wrote:
> >> >> > On Tuesday, May 17, 2011, Dwight Schauer wrote:
> >> >> >> On Tue, May 17, 2011 at 4:43 PM, Rafael J. Wysocki <rjw@sisk.pl>
> >> wrote:
> >> >> > ...
> >> >> >> >
> >> >> >> > OK, one more test, please.
> >> >> >> >
> >> >> >> > Try to do
> >> >> >> >
> >> >> >> > # echo core > /sys/power/pm_test
> >> >> >> > # echo mem > /sys/power/state
> >> >> >> >
> >> >> >> > (that should simulate suspend, but without going into the BIOS,
> >> and it
> >> >> >> > should return do the command prompt after 5-10 sec.) and check
> >> if the
> >> >> >> > USB3 controllers work after that ("echo none >
> >> /sys/power/pm_test" resets
> >> >> >> > to the normal suspend behavior).
> >> >> >> >
> >> >> >> > Thanks,
> >> >> >> > Rafael
> >> >> >>
> >> >> >> No problem.
> >> >> >>
> >> >> >> The simulated suspend works fine.
> >> >> >
> >> >> > Good.
> >> >> >
> >> >> >> Also, waking up from S3 via a PS/2 keyboard works fine.
> >> >> >
> >> >> > Hmm.  Do you mean that the USB3 controllers work after the resume
> >> if
> >> >> > the box has been woken up via the keyboard and they don't work
> >> when it
> >> >> > has been woken up via a power button?
> >> >> >
> >> >> > Rafael
> >> >>
> >> >> They work either way. I'm just not able to get the USB keyboard that
> >> >> is connected to the USB3 controller to perform the wakeup. (Which is
> >> >> what I thought I made clear from the beginning and what Alan Stern
> >> had
> >> >> reiterated for new readers further into the thread).
> >> >
> >> > Oh, I must have missed that information.  Sorry about that.
> >> >
> >> > So, the situation is that if you set up the USB3 controllers to wake
> >> up
> >> > and next you wake up the system from S3 using a USB device connected
> >> to one
> >> > of those controllers, then they appear to be in D3 after the resume
> >> and
> >> > apparently cannot be put into D0.  However, if the wakeup is done in
> >> any
> >> > different way, they work correctly after the resume, right?
> >> >
> >> > Is that the case on both the affected systems?
> >> >
> >>
> >> On both systems the USB3 controllers plugged into PCIe slots work fine
> >> after the system has been woken up from S3 suspend state.
> >>
> >> The USB3 keyboard plugged into the PCIe USB3 controller is immediately
> >> avaiable after the system has woken up. It is just that in Linux a
> >> keyboard plugged into the USB3 controller can not be used to wake the
> >> system up when it has gone into S3 suspend. With Windows 7 on our test
> >> systems our USB3 contoller (the Texas Instruments Inc. PCEe xHCI
> >> device) a USB keyboard plugged into it can wake it up from an S3
> >> suspend.
> >>
> >
> > I've verified that USB keyboard under xHCI controller can wakeup system
> > from S3, either by press the keyboard or plug it in during suspend. But
> > you need to enable wakeup in /proc/acpi/wakeup for the corresponding
> > xHC controller.
> >
> > Thanks,
> > Andiry
> 
> I was told /proc/acpi/wakeup was deprecated, and to use
> /sys/devices/pci.../power/wakeup instead.

That is correct, but /proc/acpi/wakeup still contains valid information
and is generally useful for debugging, so I'd appraciate it if you could
tell me what's in there.

> Anyways, the controllers in question are not showing up in
> /proc/acpi/wakeup. These are add on cards, not devices included on the
> motherboard.

In that case you may try to enable wakeup for the bridges they are
attached to.  Hard to say without any more information.

Thanks,
Rafael
