From: Matthew Locke <matt@nomadgs.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Sun, 24 Sep 2006 14:33:23 -0700
Message-ID: <6c3c9c9fa4961ca081c2742684201418@nomadgs.com>
References: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com> <20060923111805.GF20778@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932156AbWIXVd1@vger.kernel.org>
In-Reply-To: <20060923111805.GF20778@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, "Scott E. Preece" <preece@motorola.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On Sep 23, 2006, at 4:18 AM, Pavel Machek wrote:

> Hi!
>
>> Note that I don't think PowerOp would cover all devices. In fact, I
>> think most devices would remain autonomous or controlled as part of
>> specific subsystems. The only things that PowerOp would bundle 
>> together
>> would be things that aren't independent (and may not even be visible 
>> as
>> "devices" in the usual Linux sense), but that have to be managed
>> together in changing frequency/voltage. At least, that's the way I
>> imagined it would work.
>
> Well, two objections to that
>
> a) current powerop code does not handle 256 CPU machine, because that
> would need 256 independend bundles, and powerop has hardcoded "only
> one bundle" rule.

The 256 is only a temporary implementation limitation.

>
> b) having some devices controlled by powerop and some by specific
> subsystem is indeed ugly. I'd hope powerop would cover all the
> devices. (Or maybe cover _no_ devices). Userland should not need to
> know if touchscreen is part of SoC or if it happens to be independend
> on given machine.

PowerOP does *not* cover devices.  It covers system level parameters 
such clocks, buses, voltages.

>
> 								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) 
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
