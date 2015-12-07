From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller nodes
Date: Mon, 7 Dec 2015 21:18:05 +0100
Message-ID: <CAMuHMdWrXiYkcFwSkgbEfQRXvT2FsSTbqD72vtiedmeEZZKxLg@mail.gmail.com>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
	<1449512659-16688-7-git-send-email-geert+renesas@glider.be>
	<5665D4C7.1050705@arm.com>
	<20151207190355.GE28024@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151207190355.GE28024@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Mon, Dec 7, 2015 at 8:03 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Mon, Dec 07, 2015 at 06:49:43PM +0000, Sudeep Holla wrote:
>> On 07/12/15 18:24, Geert Uytterhoeven wrote:
>> >+    L2_CA57: cache-controller@0 {
>> >+            compatible = "cache";
>> >+            arm,data-latency = <4 4 1>;
>> >+            arm,tag-latency = <3 3 3>;
>>
>> Interesting, only PL2xx/3xx cache controller driver reads this from the
>> DT and configures the controller. The integrated L2 found in
>> A15/A7/A57/A53 needs doesn't make use of these values from the DT.
>
> These properties seem to be from l2cc.txt, which really only corresponds
> to PL210/PL220/PL310 (and variants) and isn't as generic as it sounds.
>
> I don't see that these are necessary at all.

The datasheet does mention the data/tag RAM latencies/setup values, so
I put them in DT using the properties I could fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
