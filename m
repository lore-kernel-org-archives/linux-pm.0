From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: xHCI and suspend/resume
Date: Wed, 18 May 2011 00:56:03 +0200
Message-ID: <201105180056.03337.rjw__23908.3100147129$1305673069$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<201105172354.22675.rjw@sisk.pl>
	<BANLkTinqLM2kvEgszcCMbu=pc-yJZsAo9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTinqLM2kvEgszcCMbu=pc-yJZsAo9w@mail.gmail.com>
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
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 18, 2011, Dwight Schauer wrote:
> On Tue, May 17, 2011 at 4:54 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, May 17, 2011, Dwight Schauer wrote:
> >> On Tue, May 17, 2011 at 4:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > ...
> >> >
> >> > OK, one more test, please.
> >> >
> >> > Try to do
> >> >
> >> > # echo core > /sys/power/pm_test
> >> > # echo mem > /sys/power/state
> >> >
> >> > (that should simulate suspend, but without going into the BIOS, and it
> >> > should return do the command prompt after 5-10 sec.) and check if the
> >> > USB3 controllers work after that ("echo none > /sys/power/pm_test" resets
> >> > to the normal suspend behavior).
> >> >
> >> > Thanks,
> >> > Rafael
> >>
> >> No problem.
> >>
> >> The simulated suspend works fine.
> >
> > Good.
> >
> >> Also, waking up from S3 via a PS/2 keyboard works fine.
> >
> > Hmm.  Do you mean that the USB3 controllers work after the resume if
> > the box has been woken up via the keyboard and they don't work when it
> > has been woken up via a power button?
> >
> > Rafael
> 
> They work either way. I'm just not able to get the USB keyboard that
> is connected to the USB3 controller to perform the wakeup. (Which is
> what I thought I made clear from the beginning and what Alan Stern had
> reiterated for new readers further into the thread).

Oh, I must have missed that information.  Sorry about that.

So, the situation is that if you set up the USB3 controllers to wake up
and next you wake up the system from S3 using a USB device connected to one
of those controllers, then they appear to be in D3 after the resume and
apparently cannot be put into D0.  However, if the wakeup is done in any
different way, they work correctly after the resume, right?

Is that the case on both the affected systems?

Rafael
