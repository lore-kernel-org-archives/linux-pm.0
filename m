From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC v2 04/11] soc: renesas: rcar: Add DT support for SYSC
 PM domains
Date: Wed, 17 Feb 2016 13:45:37 +0100
Message-ID: <CAMuHMdVOMgHu2rV98m4GQ3TFJq74efh2jihFzuWBV3qQq39AmQ@mail.gmail.com>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
	<1455571020-18968-5-git-send-email-geert+renesas@glider.be>
	<3535519.g4KL1PCIZy@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3535519.g4KL1PCIZy@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Mon, Feb 15, 2016 at 11:51 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Monday 15 February 2016 22:16:53 Geert Uytterhoeven wrote:
>> Populate the SYSC PM domains from DT.
>>
>> Special cases, like PM domains containing CPU cores or SCUs, are
>> handled by scanning the DT topology.
>>
>> The SYSCIER register value is derived from the PM domains found in DT,
>> which will allow to get rid of the hardcoded values in pm-rcar-gen2.c.
>> However, this means we have to scan for PM domains even if CONFIG_PM=n.
>>
>> FIXME:
>>   - This needs better integration with the PM code in pm-rcar-gen2, the
>>     SMP code in smp-r8a7790, and Magnus' DT APMU series.
>
> Have you given this some thoughts already ? Unfortunately smp_prepare_cpus()
> is called before any initcall :-/ How do the other platforms handle this ?

I'm afraid no other platform already handles this.

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
