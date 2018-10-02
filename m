From: Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
Date: Tue, 2 Oct 2018 14:01:35 -0700
Message-ID: <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com>
References: <20180927203523.60856-1-dianders@chromium.org> <20181002080554.GC19677@amd>
 <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dilip Kota <dkota@codeaurora.org>, Dmitry Torokhov <dtor@chromium.org>, Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Oct 2, 2018 at 1:29 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 2, 2018 at 10:05 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > In general Linux doesn't behave super great if you get an error while
> > > executing a device's resume handler.  Nothing will come along later
> > > and and try again to resume the device (and all devices that depend on
> > > it), so pretty much you're left with a non-functioning device and
> > > that's not good.
> > >
> > > However, even though you'll end up with a non-functioning device we
> > > still don't consider resume failures to be fatal to the system.  We'll
> > > keep chugging along and just hope that the device that failed to
> > > resume wasn't too critical.  This establishes the precedent that we
> > > should at least try our best not to fully bork the system after a
> > > resume failure.
> > >
> > > I will argue that the best way to keep the system in the best shape is
> > > to assume that if a resume callback failed that it did as close to
> > > no-op as possible.  Because of this we should consider the device
> > > still suspended and shouldn't try to suspend the device again next
> > > time around.  Today that's not what happens.  AKA if you have a
> > > device
> >
> > I don't think there are many guarantees when device resume fail. It
> > may have done nothing, and it may have resumed the device almost
> > fully.

With today's drivers you're probably right.  I don't think too many
drivers properly undo everything when they fail in the resume path.

...but it makes sense to have some sort of standard for how drivers
ought to behave.  IMO the most sane thing to do (and what we do in
probe--which is why EPROBE_DEFER mostly works) is that if a function
returns an error then it should try its best to undo everything it
did.  Then you can always try calling it again later.


> > I guess the best option would be to refuse system suspend after some
> > device failed like that.

Yeah, I thought about that.  I think we sometimes end up in that
situation today (without my patch) because the suspend callback
doesn't always work so great if the previous resume failed, so it's
entirely likely it'll return an error and block suspend...

 ...another thing I thought about was possibly trying to forcibly
unbind the device.  AKA: it's misbehaving so kick it out of the
system...  Of course if "resume" failed perhaps "remove" won't be so
happy...


> > That leaves user possibility to debug it...

You mean they wouldn't notice that some peripheral failed to resume
but they'd notice that their computer doesn't suspend any more?  Maybe
they'd notice, but it'd probably because they pulled their laptop out
of their bag and it was hot and had a dead batter.


> I guess so.
>
> Doing that in all cases is kind of risky IMO, because we haven't taken
> the return values of the ->resume* callbacks into account so far
> (except for printing the information that is), so there may be
> non-lethal cases when that happens and the $subject patch would make
> them not work any more.

I think you're arguing that the best option is to leave the code / API
exactly as-is because someone could be relying on the existing
behavior?  That is certainly the least likely to introduce any new
bugs.  ;-P

...would you accept a patch adding a comment codifying the existing
behavior (AKA suspend will be called again even if resume failed) as
the officially documented behavior?  Then we can start making new
drivers behave correctly at least.  If nothing else I can add a
boolean inside my driver data that says "resume failed, ignore the
next suspend".

...or if the official word is that if your resume fails you're totally
unrecoverable then I can start simplifying the error handling in
resume.  AKA instead of:

  hypothetical_resume(...) {
    ret = clk_enable(...);
    if (ret)
      return ret;
    ret = regulator_enable(...);
    if (ret)
      clk_disable(...);
    return ret;

...I can just change it to:

  hypothetical_resume(...) {
    ret = clk_enable(...);
    if (ret)
      return ret;
    return regulator_enable(...);

...the above would leave no way to recover the system because if
hypothetical_resume() returned an error we'd have no idea if the clock
was left enabled or not.  ...but if we're unrecoverable anyway why not
save the code?


-Doug
