From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Re: [PATCH 4/4] simplefb: add clock handling code
Date: Mon, 29 Sep 2014 11:10:53 +0200
Message-ID: <CAMuHMdU0_GjbOjVE9Vnp703TnsdmkN-nxCxrigCWO7RPMzPRyw@mail.gmail.com>
References: <53FDE0CE.5030807@redhat.com>
	<20140827141632.GB32243@ulmo>
	<53FF1D6C.6090205@redhat.com>
	<20140829070116.GC13106@ulmo>
	<20140829141244.GH15297@lukather>
	<20140829143812.GC31264@ulmo>
	<20140902092508.GR15297@lukather>
	<20140927235601.19023.31593@quantum>
	<20140929080637.GB12506@ulmo>
	<CAMuHMdV8job81-sf88Dx6w=0GZsWD02h94picAtYw2BtSz=Kgw@mail.gmail.com>
	<20140929085421.GH12506@ulmo>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCQJP74GSUDRBHWEUSQQKGQE5K6SKRQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140929085421.GH12506@ulmo>
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

On Mon, Sep 29, 2014 at 10:54 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Sep 29, 2014 at 10:27:41AM +0200, Geert Uytterhoeven wrote:
>> (CC linux-pm, as PM is the real reason behind disabling unused clocks)
>> (CC gregkh and lkml, for driver core)
>>
>> On Mon, Sep 29, 2014 at 10:06 AM, Thierry Reding
>> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > If we start extending the binding with board-level details we end up
>> > duplicating the device tree node for the proper video device. Also note
>> > that it won't stop at clocks. Other setups will require regulators to be
>> > listed in this device tree node as well so that they don't get disabled
>> > at late_initcall. And the regulator bindings don't provide a method to
>> > list an arbitrary number of clocks in a single property in the way that
>> > the clocks property works.
>>
>> Then (optional) regulator support needs to be added.
>
> Can you elaborate?

I'm not so familiar with regulators, but I guess it's similar to clocks?

>> > There may be also resets involved. Fortunately the reset framework is
>> > minimalistic enough not to care about asserting all unused resets at
>> > late_initcall. And other things like power domains may also need to be
>> > kept on.
>>
>> Fortunately, unlike clocks, PM domains are first class citizens in the
>> device framework, as they're handled by the driver core.
>> So just adding a power-domains property to DTS will work, without any
>> driver change.
>
> Well, the device driver would also need to call into the PM runtime
> framework to enable all the first class citizen magic. But even if it
> were to do that, you'd still need to add all the domains to the DTB.

Powering up domains can be done solely by the device-specific PM
domain code, without PM runtime. If simplefb is tied to the PM domain
and doesn't do any PM runtime, the domain will stay powered on
(only unused PM domains are powered down via late_initcall).

> Note that I'm saying DT*B* here, because the firmware needs to fill in
> those properties after the DTS has been compiled. And since most of
> these resources are linked via phandle you actually need to resolve
> these first before you can fill in the new properties of this
> dynamically created node.
>
> So firmware needs to know exactly what device tree node to look for,
> find a corresponding phandle and then put the phandle value in the
> simplefb device tree node. And it needs to know intimate details about
> the clock provider binding because it needs to add an appropriate
> specifier, too.

Indeed. Complicated.

> And then all of a sudden something that was supposed to be simple and
> generic needs to know the specifics of some hardware device.

And suddenly we wish we could write a real driver and put the stuff in
the DTS, not DTB...

>> > The only reasonable thing for simplefb to do is not deal with any kind
>> > of resource at all (except perhaps area that contains the framebuffer
>> > memory).
>> >
>> > So how about instead of requiring resources to be explicitly claimed we
>> > introduce something like the below patch? The intention being to give
>> > "firmware device" drivers a way of signalling to the clock framework
>> > that they need rely on clocks set up by firmware and when they no longer
>> > need them. This implements essentially what Mark (CC'ing again on this
>> > subthread) suggested earlier in this thread. Basically, it will allow
>> > drivers to determine the time when unused clocks are really unused. It
>> > will of course only work when used correctly by drivers. For the case of
>> > simplefb I'd expect its .probe() implementation to call the new
>> > clk_ignore_unused() function and once it has handed over control of the
>> > display hardware to the real driver it can call clk_unignore_unused() to
>> > signal that all unused clocks that it cares about have now been claimed.
>> > This is "reference counted" and can therefore be used by more than a
>> > single driver if necessary. Similar functionality could be added for
>> > other resource subsystems as needed.
>>
>> This still won't work for modules, right? Or am I missing something?
>> With modules you will never know in advance what will be used and what
>> won't be used, so you need to keep all clocks, regulators, PM domains, ...
>> up and running?
>
> No. The way this works is that your firmware shim driver, simplefb in
> this case, will call clk_ignore_unused() to tell the clock framework
> that it uses clocks set up by the firmware, and therefore requests that
> no clocks should be considered unused (for now). Later on when the
> proper driver has successfully taken over from the shim driver, the shim
> driver can unregister itself and call clk_unignore_unused(), which will
> drop its "reference" on the unused clocks. When all references have been
> dropped the clock framework will then disable all remaining unused
> clocks.

So the shim must be built-in, not modular.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
