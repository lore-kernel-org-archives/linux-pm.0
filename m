From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH V5 2/6] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Sun, 18 Sep 2016 18:05:59 +0200
Message-ID: <4D9CBC7C-FB79-4B3F-8896-4E8341763248@martin.sperl.org>
References: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org> <1473759262-27031-3-git-send-email-kernel@martin.sperl.org> <1999564031.209213.6508fbdb-00c5-486b-a34e-3d60ae68fe88.open-xchange@email.1und1.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1999564031.209213.6508fbdb-00c5-486b-a34e-3d60ae68fe88.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Stefan!

> On 18.09.2016, at 13:31, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> 
>> +	rate = clk_get_rate(data->clk);
>> +	if ((rate < 1920000) || (rate > 5000000)) {
>> +		dev_warn(&pdev->dev,
>> +			 "Clock %pCn is running at %pCr Hz, which is outside the recommended range
>> of 1.9 to 5.0 MHz\n",
>> +			 data->clk, data->clk);
> 
> Instead of printing the clock name twice your intension would be to print the
> actual clock rate?
%pCn (and %pC) prints the clock name
%pCr prints the clock rate - I guess I could use “%lu” and rate instead

So I do not see an issue here - I will reword the text to shorten it.

Everything else I will fix as mentioned.

Martin--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
