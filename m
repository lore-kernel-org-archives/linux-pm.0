From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Date: Wed, 10 Oct 2018 09:14:49 +0200
Message-ID: <CAJZ5v0hWqWg0X0A9GUvppRHg4RvFqDGwKOw-8nZUWivPyJn9pA@mail.gmail.com>
References: <000301d45ecb$4f002a90$ed007fb0$@net> <003801d45f54$3d9b0c50$b8d124f0$@net>
 <CAJZ5v0h4sVoen++nF1cYvqQeY3qN0B1aP42e8A4SZwxzBV3NVA@mail.gmail.com> <003d01d4602c$905b5840$b11208c0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <003d01d4602c$905b5840$b11208c0$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 2:02 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2018.10.09 03:43 Rafael J. Wysocki wrote:
>
> ...[snip]...
>
> > While at it, could you test the appended patch
> > (on top of the previous 8) for me please?
> >
> > I think that this code can be simplified now.
> >
> > ---
> > drivers/cpuidle/governors/menu.c |    8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -371,12 +371,12 @@ static int menu_select(struct cpuidle_dr
> >               if (s->target_residency > predicted_us) {
> >                       /*
> >                        * Use a physical idle state, not busy polling, unless
> > -                      * a timer is going to trigger really really soon.
> > +                      * a timer is going to trigger soon enough.
> >                        */
> >                       if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> > -                         i == idx + 1 && latency_req > s->exit_latency &&
> > -                         data->next_timer_us > max_t(unsigned int, 20,
> > -                                                     s->target_residency)) {
> > +                         s->exit_latency <= latency_req &&
> > +                         s->target_residency <= data->next_timer_us) {
> > +                             predicted_us = s->target_residency;
> >                               idx = i;
> >                               break;
> >                       }
>
> It seems to work fine.
> I was unable to detect any difference between the 8 patch set and with
> this additional patch for any of the tests that I ran. (at least beyond
> noise and/or experimental error.)

Great, thank you!

Cheers,
Rafael
