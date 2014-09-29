From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Re: [PATCH 4/4] simplefb: add clock handling code
Date: Mon, 29 Sep 2014 10:27:41 +0200
Message-ID: <CAMuHMdV8job81-sf88Dx6w=0GZsWD02h94picAtYw2BtSz=Kgw@mail.gmail.com>
References: <53FDB46C.5010609@redhat.com>
	<20140827125613.GF23186@ulmo>
	<53FDE0CE.5030807@redhat.com>
	<20140827141632.GB32243@ulmo>
	<53FF1D6C.6090205@redhat.com>
	<20140829070116.GC13106@ulmo>
	<20140829141244.GH15297@lukather>
	<20140829143812.GC31264@ulmo>
	<20140902092508.GR15297@lukather>
	<20140927235601.19023.31593@quantum>
	<20140929080637.GB12506@ulmo>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCQJP74GSUDRB7VPUSQQKGQELGA5I6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140929080637.GB12506@ulmo>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Thierry,

(CC linux-pm, as PM is the real reason behind disabling unused clocks)
(CC gregkh and lkml, for driver core)

On Mon, Sep 29, 2014 at 10:06 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Sat, Sep 27, 2014 at 04:56:01PM -0700, Mike Turquette wrote:
>> Quoting Maxime Ripard (2014-09-02 02:25:08)
>> > On Fri, Aug 29, 2014 at 04:38:14PM +0200, Thierry Reding wrote:
>> > > On Fri, Aug 29, 2014 at 04:12:44PM +0200, Maxime Ripard wrote:
>> > > > On Fri, Aug 29, 2014 at 09:01:17AM +0200, Thierry Reding wrote:
>> > > > > I would think the memory should still be reserved anyway to make sure
>> > > > > nothing else is writing over it. And it's in the device tree anyway
>> > > > > because the driver needs to know where to put framebuffer content. So
>> > > > > the point I was trying to make is that we can't treat the memory in the
>> > > > > same way as clocks because it needs to be explicitly managed. Whereas
>> > > > > clocks don't. The driver is simply too generic to know what to do with
>> > > > > the clocks.
>> > > >
>> > > > You agreed on the fact that the only thing we need to do with the
>> > > > clocks is claim them. Really, I don't find what's complicated there
>> > > > (or not generic).
>> > >
>> > > That's not what I agreed on. What I said is that the only thing we need
>> > > to do with the clocks is nothing. They are already in the state that
>> > > they need to be.
>> >
>> > Claim was probably a poor choice of words, but still. We have to keep
>> > the clock running, and both the solution you've been giving and this
>> > patch do so in a generic way.
>> >
>> > > > > It doesn't know what frequency they should be running at
>> > > >
>> > > > We don't care about that. Just like we don't care about which
>> > > > frequency is the memory bus running at. It will just run at whatever
>> > > > frequency is appropriate.
>> > >
>> > > Exactly. And you shouldn't have to care about them at all. Firmware has
>> > > already configured the clocks to run at the correct frequencies, and it
>> > > has made sure that they are enabled.
>> > >
>> > > > > or what they're used for
>> > > >
>> > > > And we don't care about that either. You're not interested in what
>> > > > output the framebuffer is setup to use, which is pretty much the same
>> > > > here, this is the same thing here.
>> > >
>> > > That's precisely what I've been saying. The only thing that simplefb
>> > > cares about is the memory it should be using and the format of the
>> > > pixels (and how many of them) it writes into that memory. Everything
>> > > else is assumed to have been set up.
>> > >
>> > > Including clocks.
>> >
>> > We're really discussing in circles here.
>> >
>> > Mike?
>> >
>>
>> -EHIGHLATENCYRESPONSE
>>
>> I forgot about this thread. Sorry.
>>
>> In an attempt to provide the least helpful answer possible, I will stay
>> clear of all of the stuff relating to "how simple should simplefb be"
>> and the related reserved memory discussion.
>>
>> A few times in this thread it is stated that we can't prevent unused
>> clocks from being disabled. That is only partially true.
>>
>> The clock framework DOES provide a flag to prevent UNUSED clocks from
>> being disabled at late_initcall-time by a clock "garbage collector"
>> mechanism. Maxime and others familiar with the clock framework are aware
>> of this.
>>
>> What the framework doesn't do is to allow for a magic flag in DT, in
>> platform_data or elsewhere that says, "don't let me get turned off until
>> the right driver claims me". That would be an external or alternative
>> method for preventing a clock from being disabled. We have a method for
>> preventing clocks from being disabled. It is as follows:
>>
>> struct clk *my_clk = clk_get(...);
>> clk_prepare_enable(my_clk);
>>
>> That is how it should be done. Period.
>>
>> With that said I think that Luc's approach is very sensible. I'm not
>> sure what purpose in the universe DT is supposed to serve if not for
>> _this_exact_case_. We have a nice abstracted driver, usable by many
>> people. The hardware details of how it is hooked up at the board level
>> can all be hidden behind stable DT bindings that everyone already uses.
>
> simplefb doesn't deal at all with hardware details. It simply uses what
> firmware has set up, which is the only reason why it will work for many

It doesn't deal with "hardware details for hardware components for which
no driver is available (yet)". That's why the hardware is still in a usable
state, after the firmware has set it up.

Clocks, regulators, PM domains typically have system-wide implications,
and thus need system-wide drivers (in the absence of such drivers,
things would work as-is).

Note that the driver still requests resources (ioremap the frame buffer),
so it needs to know about that tiny piece of hardware detail.

> people. What is passed in via its device tree node is the minimum amount
> of information needed to draw something into the framebuffer. Also note
> that the simplefb device tree node is not statically added to a DTS file
> but needs to be dynamically generated by firmware at runtime.

The latter indeed complicates things. But see below... [*]

> If we start extending the binding with board-level details we end up
> duplicating the device tree node for the proper video device. Also note
> that it won't stop at clocks. Other setups will require regulators to be
> listed in this device tree node as well so that they don't get disabled
> at late_initcall. And the regulator bindings don't provide a method to
> list an arbitrary number of clocks in a single property in the way that
> the clocks property works.

Then (optional) regulator support needs to be added.

> There may be also resets involved. Fortunately the reset framework is
> minimalistic enough not to care about asserting all unused resets at
> late_initcall. And other things like power domains may also need to be
> kept on.

Fortunately, unlike clocks, PM domains are first class citizens in the
device framework, as they're handled by the driver core.
So just adding a power-domains property to DTS will work, without any
driver change.

> Passing in clock information via the device tree already requires a non-
> trivial amount of code in the firmware. A similar amount of code would
> be necessary for each type of resource that needs to be kept enabled. In
> addition to the above some devices may also require resources that have
> no generic bindings. That just doesn't scale.

[*] The firmware does need to make sure the clocks, regulators, PM domains,
... are up and running for the initial video mode, too. So it already needs
to have this knowledge (unless enabled by SoC reset-state).

> The only reasonable thing for simplefb to do is not deal with any kind
> of resource at all (except perhaps area that contains the framebuffer
> memory).
>
> So how about instead of requiring resources to be explicitly claimed we
> introduce something like the below patch? The intention being to give
> "firmware device" drivers a way of signalling to the clock framework
> that they need rely on clocks set up by firmware and when they no longer
> need them. This implements essentially what Mark (CC'ing again on this
> subthread) suggested earlier in this thread. Basically, it will allow
> drivers to determine the time when unused clocks are really unused. It
> will of course only work when used correctly by drivers. For the case of
> simplefb I'd expect its .probe() implementation to call the new
> clk_ignore_unused() function and once it has handed over control of the
> display hardware to the real driver it can call clk_unignore_unused() to
> signal that all unused clocks that it cares about have now been claimed.
> This is "reference counted" and can therefore be used by more than a
> single driver if necessary. Similar functionality could be added for
> other resource subsystems as needed.

This still won't work for modules, right? Or am I missing something?
With modules you will never know in advance what will be used and what
won't be used, so you need to keep all clocks, regulators, PM domains, ...
up and running?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
