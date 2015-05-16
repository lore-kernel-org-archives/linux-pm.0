From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / clock_ops: Fix clock error check in __pm_clk_add()
Date: Sat, 16 May 2015 23:37:01 +0200
Message-ID: <CAMuHMdWySBrfoyE=5809rHPBVWURT_54yQiZF+XACpwFCCdBTg@mail.gmail.com>
References: <1431074863-19124-1-git-send-email-geert+renesas@glider.be>
	<2196912.kiJqTqq7oO@vostro.rjw.lan>
	<20150513003229.GH20725@dtor-ws>
	<9611184.kabx71SGcD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9611184.kabx71SGcD@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 14, 2015 at 12:45 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, May 12, 2015 05:32:29 PM Dmitry Torokhov wrote:
>> On Wed, May 13, 2015 at 02:22:50AM +0200, Rafael J. Wysocki wrote:
>> > On Tuesday, May 12, 2015 11:07:33 AM Dmitry Torokhov wrote:
>> > > On Tue, May 12, 2015 at 08:59:03PM +0300, Grygorii.Strashko@linaro.org wrote:
>> > > > On 05/12/2015 07:42 PM, Dmitry Torokhov wrote:
>> > > > > On Tue, May 12, 2015 at 04:55:39PM +0300, Grygorii.Strashko@linaro.org wrote:
>> > > > >> On 05/09/2015 12:05 AM, Dmitry Torokhov wrote:
>> > > > >>> On Fri, May 08, 2015 at 10:59:04PM +0200, Geert Uytterhoeven wrote:
>> > > > >>>> On Fri, May 8, 2015 at 7:19 PM, Dmitry Torokhov
>> > > > >>>> <dmitry.torokhov@gmail.com> wrote:
>> > > > >>>>> On Fri, May 08, 2015 at 10:47:43AM +0200, Geert Uytterhoeven wrote:
>> > > > >>>>>> In the final iteration of commit 245bd6f6af8a62a2 ("PM / clock_ops: Add
>> > > > >>>>>> pm_clk_add_clk()"), a refcount increment was added by Grygorii Strashko.
>> > > > >>>>>> However, the accompanying IS_ERR() check operates on the wrong clock
>> > > > >>>>>> pointer, which is always zero at this point, i.e. not an error.
>> > > > >>>>>> This may lead to a NULL pointer dereference later, when __clk_get()
>> > > > >>>>>> tries to dereference an error pointer.
>> > > > >>>>>>
>> > > > >>>>>> Check the passed clock pointer instead to fix this.
>> > > > >>>>>
>> > > > >>>>> Frankly I would remove the check altogether. Why do we only check for
>> > > > >>>>> IS_ERR and not NULL or otherwise validate the pointer? The clk is passed
>> > > > >>>>
>> > > > >>>> __clk_get() does the NULL check.
>> > > > >>>
>> > > > >>> No, not really. It _handles_ clk being NULL and returns "everything is
>> > > > >>> fine". In any case it is __clk_get's decision what to do.
>> > > > >>>
>> > > > >>> I dislike gratuitous checks of arguments passed in. Instead of relying
>> > > > >>> on APIs refusing grabage we better not pass garbage to these APIs in the
>> > > > >>> first place. So I'd change it to trust that we are given a usable
>> > > > >>> pointer and simply do:
>> > > > >>>
>> > > > >>>     if (!__clk_get(clk)) {
>> > > > >>>             kfree(ce);
>> > > > >>>             return -ENOENTl
>> > > > >>>     }
>> > > > >>
>> > > > >> Not sure this is right thing to do, because this API initially
>> > > > >> was intended to be used as below [1]:
>> > > > >>      clk = of_clk_get(dev->of_node, i));
>> > > > >>      ret = pm_clk_add_clk(dev, clk);
>> > > > >>      clk_put(clk);
>> > > > >>
>> > > > >> and of_clk_get may return ERR_PTR().
>> > > > >
>> > > > > Jeez, that sequence was not meant to be taken literally, it does miss
>> > > > > error handling completely. If you notice the majority of users of this
>> > > > > API do something like below:

What's the majority of zero users? ;-)

>> > > > >
>> > > > >       i = 0;
>> > > > >       while ((clk = of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
>> > > > >               dev_dbg(dev, "adding clock '%s' to list of PM clocks\n",
>> > > > >                       __clk_get_name(clk));
>> > > > >               error = pm_clk_add_clk(dev, clk);
>> > > > >               clk_put(clk);
>> > > > >               if (error) {
>> > > > >                       dev_err(dev, "pm_clk_add_clk failed %d\n", error);
>> > > > >                       pm_clk_destroy(dev);
>> > > > >                       return error;
>> > > > >               }
>> > > > >       }
>> > > > >
>> > > > > i.e. it already validates clk pointer before passing it on since it
>> > > > > needs to know when to stop iterating.
>> > > >
>> > > > np. It's just my opinion - if you agree that code will just crash
>> > > > in case of passing invalid @clk argument (in worst case:)
>> > > >
>> > > > int __clk_get(struct clk *clk)
>> > > > {
>> > > >         struct clk_core *core = !clk ? NULL : clk->core;
>> > > >                                                 ^^^ here
>> > >
>> > > Yes, it will crash if you pass invalid pointer here, be it
>> > > ERR_PTR-encoded value, or, for example, 0x1, or maybe (void
>> > > *)random_32(). The latter will probably not crash right away, but cause
>> > > some random damage that will manifest later.
>> >
>> > Oh well.  Shouldn't we actually do:
>> >
>> > int __clk_get(struct clk *clk)
>> > {
>> >     struct clk_core *core = IS_ERR_OR_NULL(clk) ? NULL : clk->core;
>> >
>> > and remove the check from __pm_clk_add() at the same time?
>> >
>> > Knowingly crashing on an error encoded as a pointer is kind of disgusting to me
>> > and the difference between that and a random invalid pointer is that poeple who
>> > pass error values encoded as pointers up the stack usually expect them to be
>> > handled cleanly.
>>
>> I think the operative work here is "up". Returning ERR_PTR-encoded
>> pointer is fine, checking it fine as well, blindly passing it *down*
>> into a random API is not fine and we should not try to accommodate this.
>
> You're basically saying "Passing an error-encoding pointer down to an API is
> not valid" which I agree with, but I don't agree that it's OK to crash the
> kernel when that happens.  It's never OK to crash the kernel when we can
> easily avoid that, because it may lead to user data loss.
>
> However, you seem to be arguing against fixing up things *silently* which may
> hide serious bugs.  That's a good point, so what about adding a WARN_ON_ONCE()
> aroud the IS_ERR() check in the Geert's patch?

Most (all?) clock API calls allow to pass in error pointers as returned by
clk_get(). This allows for calling clk_get() and clk_prepare_enable() in a row,
without any checking by the user (in many drivers, clocks are optional).

__clk_get() is more of an internal function, that's why it doesn't
have the check.

So Grygorii's answer "the API is to be used like this", is not that insane,
following other clock API calls.

Now, pm_clk_add_clk() returns -ENOENT if the clock is not valid.
This is a visible difference from pm_clk_add(), which (ignoring -ENOMEM) always
returns zero, whether the clock for the con_id can be found or not (i.e. whether
pm_clk_acquire() succeeds or not).

I guess we want to be consistent here:
  1. Either always return zero,
  2. Either always propagate failures.

Then, clocks can be optional, especially when considering clock domains.
Hence existing code calling pm_clk_add() from the generic_pm_domain.attach_dev()
callback may start to break when pm_clk_add() starts returning errors for
non-existent clocks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
