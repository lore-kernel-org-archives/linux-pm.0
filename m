From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Sat, 22 Jul 2006 23:59:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607222334510.10239-100000@netrider.rowland.org>
References: <200607221837.15940.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607221837.15940.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 22 Jul 2006, David Brownell wrote:

> On Wednesday 12 July 2006 9:03 am, Alan Stern wrote:
> =

> > One oddity worth mentioning somewhere is that the PM core will never as=
k a
> > driver to make a transition between two states unless one of them is ON.
> =

> That's not exactly true ... in the senses that
> =

>  (a) dev->power.power_state.event is not always updated.  Some drivers do;
>      as do sysfs update codepaths (clobbering updates from those drivers).

Right.  The decision whether to invoke the driver's method depends on the =

power_state.event value, not the device's actual state.

>  (b) suspend_device() checks the recorded event, but resume_device() does=
n't.
>      My guess is that's to defend against sysfs updates, since clearly
>      it'll never matter as part of a system suspend or resume sequence.

True again.  This behavior is consistent with what I said, since
resume_device() asks the driver to change to the ON state.  The assumption
appears to be that during a system resume sequence, a device will never be
resumed before its resume_device() call -- or if it is, the redundant
resume method call won't matter.

>  (c) dpm_runtime_{suspend,resume} check those recorded event codes, before
>      deciding to call {suspend,resume}_device().  This is in support of
>      that sysfs update glitch.

Well, not so much in support of that glitch as simply recognizing that the
device might already be in the desired target state.  Either as a result
of earlier calls to dpm_runtime_{suspend,resume} or as a result of
unilateral action by the driver... the reason doesn't matter.

>  (d) ON is really an event not a state (confusingly enough it can also
>      be a "message" holding that event).  OK, maybe that's a nit, but
>      it does reflect conceptual confusion in the current API.

Agreed.

> In short that's kind of a mess.  IMO the correct approach involves removi=
ng
> the dev->power.power_state thing entirely, along with the sysfs thing, but
> we can't do that quite yet.

Then what _can_ we do now?  Or better yet, what _should_ we aim towards
doing?  I'm perfectly happy to have those things removed, but what (if
anything) should take their place?

Some simple questions may help start the ball rolling.  During a system
resume, should all devices be powered on full, or should they be restored
to the state they were in before the suspend?  Or should there be a third
possibility -- maybe some devices always on, others the way they were?  =

And who decides?  The driver?

For that matter, to what extent does the PM core need to be involved in
runtime power management?  As far as I can see, all the core can do is
provide centralized routines that would be widely useful.  But apart from
something resembling the current sysfs interface, I can't see what those
routines might do.

Alan Stern
