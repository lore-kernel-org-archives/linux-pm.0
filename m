From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 04 Jul 2007 16:45:34 +0200
Message-ID: <E1I666o-0006wu-00@dorka.pomaz.szeredi.hu>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707041325.55779.rjw@sisk.pl>
	<E1I63Nv-0006Z9-00@dorka.pomaz.szeredi.hu>
	<200707041641.58883.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707041641.58883.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> On Wednesday, 4 July 2007 13:51, Miklos Szeredi wrote:
> > > Still, my position is this:
> > > 
> > > 1) The freezer (in the modified form, with the freezing of kernel threads
> > > limited to the ones that want to be frozen) is needed for hibernation.
> > > 
> > > 2) The freezer is generally not needed for suspend, _but_ there are drivers
> > > in the tree that rely on it being used.  Thus, at some point in time we can
> > > remove the freezer from the suspend code path, _but_ no sooner than we are
> > > sure that the majority of drivers is prepared for that.
> > 
> > And we won't know if drivers are OK until we remove the freezer,
> > catch-22.
> 
> I disagree.  We can learn that by auditing the drivers.

In theory, yes.  But it scales far worse than letting everyone
experiment/report/fix problems as they crop up.

> > So I think we need to disable the freezer at least in -mm and/or
> > optionally in -linus.
> > 
> > I applied Matthew's patch, and suspend did in fact stop working
> > (thinkpad t60), but there was nothing catastrophic.  Here's the dmesg
> > if somebody is interested:
> > 
> > Suspending console(s)
> > usb_endpoint usbdev5.3_ep83: PM: suspend 0->2, parent 5-2:1.0 already 2
> > usb_endpoint usbdev5.3_ep02: PM: suspend 0->2, parent 5-2:1.0 already 2
> > usb_endpoint usbdev5.3_ep81: PM: suspend 0->2, parent 5-2:1.0 already 2
> > hub 2-0:1.0: suspend error -16
> > suspend_device(): usb_suspend+0x0/0x1c() returns -16
> > Could not suspend device usb2: error -16
> > usb_endpoint usbdev5.3_ep81: PM: resume from 0, parent 5-2:1.0 still 2
> > usb_endpoint usbdev5.3_ep02: PM: resume from 0, parent 5-2:1.0 still 2
> > usb_endpoint usbdev5.3_ep83: PM: resume from 0, parent 5-2:1.0 still 2
> > Some devices failed to suspend
> 
> No, it's not catastrophic, but something like this will result in a
> bug report with "regression" in the subject.

If it was due to a config option marked experimental, then it's not a
regression.

It's a bug, and it needs looking at, but while the freezer is not
completely removed, it's not a serious problem.

So I agree with Ted, a config option (or maybe a runtime sysctl
tunable) to turn off the freezer for suspend should only have positive
effects.

Miklos
