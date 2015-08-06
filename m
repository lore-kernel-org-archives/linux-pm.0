From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2] PM / Domains: Return -EPROBE_DEFER if we fail to init
 or turn-on domain
Date: Thu, 6 Aug 2015 14:10:57 +0200
Message-ID: <CAMuHMdXyUaFrT_ec556iR1zuUzcrB_seb9xZy=pabCpjFfWkwA@mail.gmail.com>
References: <1438334400-26367-1-git-send-email-jonathanh@nvidia.com>
	<55C0C4D3.2050600@nvidia.com>
	<CAMuHMdW8H-mxG9poJpjijBCUHWs+Q4Xe3muXeTqnd7npBEzXRA@mail.gmail.com>
	<1911839.6SetkcFuZL@vostro.rjw.lan>
	<55C30FE4.9080206@nvidia.com>
	<55C31AA9.8050202@nvidia.com>
	<CAMuHMdU3y-wn5W3-9BD8epkqdWu+0_16pYwktVhqBHku+Mo2mg@mail.gmail.com>
	<55C3284F.8070305@nvidia.com>
	<CAMuHMdV7AMQD564AgUSACAJFTdqtmMxU9yoefuZ2CXEEhR57RQ@mail.gmail.com>
	<55C3490F.20307@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36258 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbbHFMK6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2015 08:10:58 -0400
Received: by oiev193 with SMTP id v193so7529513oie.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2015 05:10:57 -0700 (PDT)
In-Reply-To: <55C3490F.20307@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Aug 6, 2015 at 1:46 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> It still sounds to me that the nodes should be disabled/removed from the
>>> dtb. Having a dynamic way to do this would be useful, I can see.
>>
>> I had a quick look, and it already seem to exist..
>> Hence on platforms not implementing power controllers yet, the early platform
>> code could do:
>>
>>         struct device_node *np;
>>         for_each_node_with_property(dn, "power-domains")
>>                 of_remove_property(np, "power-domains");
>>
>> Haven't tested that yet, though...
>
> Yes that could be an option, however, it would mean doing this type of
> thing for various types of nodes. You mentioned dma was another case.

DMA is different, as many drivers can fall back to PIO if the DMA engine
driver is mssing (not implemented/not enabled/module not loaded).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
