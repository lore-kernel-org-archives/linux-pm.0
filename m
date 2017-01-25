From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v3] dt-bindings: power: supply: bq24735: reverse the
 polarity of ac-detect
Date: Wed, 25 Jan 2017 13:20:27 +0100
Message-ID: <c4528a3d-5ff7-8fca-6dbf-18b3792edda7@axentia.se>
References: <1481804479-8711-1-git-send-email-peda@axentia.se>
 <5f5fe01a-7c7a-58f7-2171-5f6879392ea7@wwwdotorg.org>
 <c3e87e2b-5d0d-c1ff-8edf-f4a77de31c1e@axentia.se>
 <1485275073.1087.10.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485275073.1087.10.camel-W9ppeneeCTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 2017-01-24 17:24, Paul Kocialkowski wrote:
> Le jeudi 15 décembre 2016 à 18:50 +0100, Peter Rosin a écrit :
>> The bindings are fine.
>>
>> The Tegra dts files are buggy, but the driver is also buggy, so those
>> two bugs cancel each other. So, the option is to either introduce
>> regressions by fixing the two bugs thus creating a flag day where
>> the kernel and dt needs to match. Or, just document what is going on
>> and change the bindings even if they are not wrong.
> 
> After reading the discussion, I would rather be in favor of fixing the driver
> and the tegra dts files, which are both wrong.
> 
> Keeping things as-is is very counter-intuitive: the GPIO on nyan boards is
> active-low and should be described as such (think of other projects, like
> U-Boot, reusing the dts). It's also very counter-intuitive to require that any
> new board using that driver use active-low polarity in the GPIO declaration when
> the line is really active-high.

Agreed, it very counter-intuitive. I have a board w/o an invert and it
does look odd with active-low in the dts. It really should be active-high.

The (new) binding helps a bit though.

But that said, for various reasons I ended up not using that binding anyway
and instead rely on polling the internal register for the ACOK bit.

> So yes, it means that older dtbs won't work with new kernels and vice-versa, but
> as it was pointed out, this is a bug fix, not even a cosmetic change.
> 
> Is anyone strongly opposed to that solution? I'd really rather see the issue
> fixed that way instead of the current proposal (this patch).

It's a little bit more than a proposal since it is in linux-next. But not set
in stone of course. I personally do not care as long as it is changed before
hitting Linus' tree as I have no deployed devices. But docs are just that.
Docs. Anything that worked before is going to break with the change you are
proposing. Are you really willing to break who knows how many tegra boards?

What will you do a few months down the line when the regression reports start
to creep in??? Argue about it with Linus? And then revert and create an even
bigger mess? You could skip the arguing step and revert right away, but how
is that helpful?

Or do you somehow know that *all* tegra users will always update their kernel
and dtb in sync, so that regressions will not happen?

> I'd also be happy to implement and test that solution on nyans, as I've done
> other bq24735-related work for nyans recently.

Changing this is trivial. Testing that the change does what it is supposed to
is not the main obstacle...

Cheers,
peda

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
