From: Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
Date: Tue, 2 Oct 2018 15:16:51 -0700
Message-ID: <CAD=FV=XU45z=kvO48Cwhi2NxuOBermbnEdxov5kZtt-VdMB4GA@mail.gmail.com>
References: <20180927203523.60856-1-dianders@chromium.org> <20181002080554.GC19677@amd>
 <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com>
 <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com> <CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dilip Kota <dkota@codeaurora.org>, Dmitry Torokhov <dtor@chromium.org>, Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Oct 2, 2018 at 2:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 2, 2018 at 11:01 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Oct 2, 2018 at 1:29 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> [cut]
>
> > > I guess so.
> > >
> > > Doing that in all cases is kind of risky IMO, because we haven't taken
> > > the return values of the ->resume* callbacks into account so far
> > > (except for printing the information that is), so there may be
> > > non-lethal cases when that happens and the $subject patch would make
> > > them not work any more.
> >
> > I think you're arguing that the best option is to leave the code / API
> > exactly as-is because someone could be relying on the existing
> > behavior?  That is certainly the least likely to introduce any new
> > bugs.  ;-P
> >
> > ...would you accept a patch adding a comment codifying the existing
> > behavior (AKA suspend will be called again even if resume failed) as
> > the officially documented behavior?
>
> It is documented already IIRC, but yes.

Ah ha!  I'm guessing this is the documentation you're talking about in pm.h?

 * All of the above callbacks, except for @complete(), return error codes.
 * However, the error codes returned by @resume(), @thaw(), @restore(),
 * @resume_noirq(), @thaw_noirq(), and @restore_noirq(), do not cause the PM
 * core to abort the resume transition during which they are returned.  The
 * error codes returned in those cases are only printed to the system logs for
 * debugging purposes.  Still, it is recommended that drivers only return error
 * codes from their resume methods in case of an unrecoverable failure (i.e.
 * when the device being handled refuses to resume and becomes unusable) to
 * allow the PM core to be modified in the future, so that it can avoid
 * attempting to handle devices that failed to resume and their children.

To me the above reads as "the behavior of the kernel right now isn't
quite right, but we'll fix it in the future".  It also don't
explicitly state that the next "suspend" will still be called.  That's
implicit in the "all we do is print a message" but the "we'll fix it
in the future" makes me feel like that might change.

...if there's some other documentation you're thinking of then I'm
happy to keep looking.


> > ...or if the official word is that if your resume fails you're totally
> > unrecoverable then I can start simplifying the error handling in
> > resume.  AKA instead of:
> >
> >   hypothetical_resume(...) {
> >     ret = clk_enable(...);
> >     if (ret)
> >       return ret;
> >     ret = regulator_enable(...);
> >     if (ret)
> >       clk_disable(...);
> >     return ret;
> >
> > ...I can just change it to:
> >
> >   hypothetical_resume(...) {
> >     ret = clk_enable(...);
> >     if (ret)
> >       return ret;
> >     return regulator_enable(...);
> >
> > ...the above would leave no way to recover the system because if
> > hypothetical_resume() returned an error we'd have no idea if the clock
> > was left enabled or not.  ...but if we're unrecoverable anyway why not
> > save the code?
>
> This really depends on the particular case.
>
> If you deal with clocks directly, then you pretty much know whether or
> not things are recoverable after a failing device resume, but if AML
> tells you that it failed (say), you don't really know what happened.
> In many cases the device that failed to resume will not work correctly
> in the working state, but attempting to suspend it again may be fine.
> It may recover after the next suspend-resume cycle even sometimes.  So
> IMO drivers can do "smart" things if they really want to and know
> enough, but there really is too much variation to handle it in the
> core in a uniform way.

Got it.  Right that every driver will be different and we can't
possibly magically "fix the world" and universally recover from all
errors.  ...and putting too much smarts in the drivers doesn't make a
lot of sense since really we're in a mostly unrecoverable place
anyway.

In any case, if I don't hear anything else I'll assume that the
officially documented suggestion is to assume that suspend() will
still be called after a failed resume() (AKA today's behavior) and I
should code drivers to that standard until I hear otherwise.

Thanks for your time.

-Doug
