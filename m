From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
Date: Tue, 2 Oct 2018 10:28:53 +0200
Message-ID: <CAJZ5v0g13wJrUpshFoQx-FXHMs=MkQ1dStNSESiqXC3zduqJcA@mail.gmail.com>
References: <20180927203523.60856-1-dianders@chromium.org> <20181002080554.GC19677@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002080554.GC19677@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Doug Anderson <dianders@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, dkota@codeaurora.org, Dmitry Torokhov <dtor@chromium.org>, swboyd@chromium.org, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 2, 2018 at 10:05 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > In general Linux doesn't behave super great if you get an error while
> > executing a device's resume handler.  Nothing will come along later
> > and and try again to resume the device (and all devices that depend on
> > it), so pretty much you're left with a non-functioning device and
> > that's not good.
> >
> > However, even though you'll end up with a non-functioning device we
> > still don't consider resume failures to be fatal to the system.  We'll
> > keep chugging along and just hope that the device that failed to
> > resume wasn't too critical.  This establishes the precedent that we
> > should at least try our best not to fully bork the system after a
> > resume failure.
> >
> > I will argue that the best way to keep the system in the best shape is
> > to assume that if a resume callback failed that it did as close to
> > no-op as possible.  Because of this we should consider the device
> > still suspended and shouldn't try to suspend the device again next
> > time around.  Today that's not what happens.  AKA if you have a
> > device
>
> I don't think there are many guarantees when device resume fail. It
> may have done nothing, and it may have resumed the device almost
> fully.
>
> I guess the best option would be to refuse system suspend after some
> device failed like that.
>
> That leaves user possibility to debug it...

I guess so.

Doing that in all cases is kind of risky IMO, because we haven't taken
the return values of the ->resume* callbacks into account so far
(except for printing the information that is), so there may be
non-lethal cases when that happens and the $subject patch would make
them not work any more.

Thanks,
Rafael
