From: "Xu, Andiry" <Andiry.Xu@amd.com>
Subject: Re: xHCI and suspend/resume
Date: Wed, 18 May 2011 09:59:58 +0800
Message-ID: <2DEEA3AB13739D45A22ADDB5086AEA0B015AD959__3575.39961482889$1305684092$gmane$org@sshaexmb1.amd.com>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org><201105172354.22675.rjw@sisk.pl><BANLkTinqLM2kvEgszcCMbu=pc-yJZsAo9w@mail.gmail.com><201105180056.03337.rjw@sisk.pl>
	<BANLkTi=mphkfHfd7aeZb+d1uAeAhj1=qFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Class: urn:content-classes:message
In-Reply-To: <BANLkTi=mphkfHfd7aeZb+d1uAeAhj1=qFg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dwight Schauer <dschauer@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
> owner@vger.kernel.org] On Behalf Of Dwight Schauer
> Sent: Wednesday, May 18, 2011 7:02 AM
> To: Rafael J. Wysocki
> Cc: linux-pm@lists.linux-foundation.org; Sarah Sharp; dschauer@ti.com;
> USB list
> Subject: Re: [linux-pm] xHCI and suspend/resume
> =

> On Tue, May 17, 2011 at 5:56 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, May 18, 2011, Dwight Schauer wrote:
> >> On Tue, May 17, 2011 at 4:54 PM, Rafael J. Wysocki <rjw@sisk.pl>
> wrote:
> >> > On Tuesday, May 17, 2011, Dwight Schauer wrote:
> >> >> On Tue, May 17, 2011 at 4:43 PM, Rafael J. Wysocki <rjw@sisk.pl>
> wrote:
> >> > ...
> >> >> >
> >> >> > OK, one more test, please.
> >> >> >
> >> >> > Try to do
> >> >> >
> >> >> > # echo core > /sys/power/pm_test
> >> >> > # echo mem > /sys/power/state
> >> >> >
> >> >> > (that should simulate suspend, but without going into the BIOS,
> and it
> >> >> > should return do the command prompt after 5-10 sec.) and check
> if the
> >> >> > USB3 controllers work after that ("echo none >
> /sys/power/pm_test" resets
> >> >> > to the normal suspend behavior).
> >> >> >
> >> >> > Thanks,
> >> >> > Rafael
> >> >>
> >> >> No problem.
> >> >>
> >> >> The simulated suspend works fine.
> >> >
> >> > Good.
> >> >
> >> >> Also, waking up from S3 via a PS/2 keyboard works fine.
> >> >
> >> > Hmm. =A0Do you mean that the USB3 controllers work after the resume
> if
> >> > the box has been woken up via the keyboard and they don't work
> when it
> >> > has been woken up via a power button?
> >> >
> >> > Rafael
> >>
> >> They work either way. I'm just not able to get the USB keyboard that
> >> is connected to the USB3 controller to perform the wakeup. (Which is
> >> what I thought I made clear from the beginning and what Alan Stern
> had
> >> reiterated for new readers further into the thread).
> >
> > Oh, I must have missed that information. =A0Sorry about that.
> >
> > So, the situation is that if you set up the USB3 controllers to wake
> up
> > and next you wake up the system from S3 using a USB device connected
> to one
> > of those controllers, then they appear to be in D3 after the resume
> and
> > apparently cannot be put into D0. =A0However, if the wakeup is done in
> any
> > different way, they work correctly after the resume, right?
> >
> > Is that the case on both the affected systems?
> >
> =

> On both systems the USB3 controllers plugged into PCIe slots work fine
> after the system has been woken up from S3 suspend state.
> =

> The USB3 keyboard plugged into the PCIe USB3 controller is immediately
> avaiable after the system has woken up. It is just that in Linux a
> keyboard plugged into the USB3 controller can not be used to wake the
> system up when it has gone into S3 suspend. With Windows 7 on our test
> systems our USB3 contoller (the Texas Instruments Inc. PCEe xHCI
> device) a USB keyboard plugged into it can wake it up from an S3
> suspend.
> =


I've verified that USB keyboard under xHCI controller can wakeup system
from S3, either by press the keyboard or plug it in during suspend. But
you need to enable wakeup in /proc/acpi/wakeup for the corresponding
xHC controller.

Thanks,
Andiry
