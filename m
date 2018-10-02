From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
Date: Tue, 2 Oct 2018 23:16:23 +0200
Message-ID: <CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com>
References: <20180927203523.60856-1-dianders@chromium.org> <20181002080554.GC19677@amd>
 <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com> <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=Xi=BmWtzHAmXe0nNU4rBaQzHZDQhqOgbdKi4+dDCrJ8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dkota@codeaurora.org, Dmitry Torokhov <dtor@chromium.org>, swboyd@chromium.org, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 2, 2018 at 11:01 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Oct 2, 2018 at 1:29 AM Rafael J. Wysocki <rafael@kernel.org> wrote:

[cut]

> > I guess so.
> >
> > Doing that in all cases is kind of risky IMO, because we haven't taken
> > the return values of the ->resume* callbacks into account so far
> > (except for printing the information that is), so there may be
> > non-lethal cases when that happens and the $subject patch would make
> > them not work any more.
>
> I think you're arguing that the best option is to leave the code / API
> exactly as-is because someone could be relying on the existing
> behavior?  That is certainly the least likely to introduce any new
> bugs.  ;-P
>
> ...would you accept a patch adding a comment codifying the existing
> behavior (AKA suspend will be called again even if resume failed) as
> the officially documented behavior?

It is documented already IIRC, but yes.

> Then we can start making new
> drivers behave correctly at least.  If nothing else I can add a
> boolean inside my driver data that says "resume failed, ignore the
> next suspend".

Or maybe "fail the next suspend" even?

> ...or if the official word is that if your resume fails you're totally
> unrecoverable then I can start simplifying the error handling in
> resume.  AKA instead of:
>
>   hypothetical_resume(...) {
>     ret = clk_enable(...);
>     if (ret)
>       return ret;
>     ret = regulator_enable(...);
>     if (ret)
>       clk_disable(...);
>     return ret;
>
> ...I can just change it to:
>
>   hypothetical_resume(...) {
>     ret = clk_enable(...);
>     if (ret)
>       return ret;
>     return regulator_enable(...);
>
> ...the above would leave no way to recover the system because if
> hypothetical_resume() returned an error we'd have no idea if the clock
> was left enabled or not.  ...but if we're unrecoverable anyway why not
> save the code?

This really depends on the particular case.

If you deal with clocks directly, then you pretty much know whether or
not things are recoverable after a failing device resume, but if AML
tells you that it failed (say), you don't really know what happened.
In many cases the device that failed to resume will not work correctly
in the working state, but attempting to suspend it again may be fine.
It may recover after the next suspend-resume cycle even sometimes.  So
IMO drivers can do "smart" things if they really want to and know
enough, but there really is too much variation to handle it in the
core in a uniform way.

Thanks,
Rafael
