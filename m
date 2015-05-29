From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / clock_ops: Print acquired clock name instead of con_id
Date: Fri, 29 May 2015 12:53:04 +0200
Message-ID: <CAMuHMdU9iboF9oWWAQSO67JLdQ67mFo6edv_O4uA74Pn_PUijA@mail.gmail.com>
References: <1432839849-1432-1-git-send-email-geert+renesas@glider.be>
	<5568423A.4080200@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34058 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbbE2KxE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2015 06:53:04 -0400
In-Reply-To: <5568423A.4080200@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-clk@vger.kernel.org

Hi Grygorii,

On Fri, May 29, 2015 at 12:40 PM, Grygorii.Strashko@linaro.org
<grygorii.strashko@linaro.org> wrote:
> On 05/28/2015 10:04 PM, Geert Uytterhoeven wrote:
>> Currently the con_id of the acquired clock is printed for debugging
>> purposes.  But in several cases, the con_id is NULL, which doesn't
>> provide much debugging information when printed.  These cases are:
>>    - When explicitly passing a NULL con_id (which means the first clock
>>      tied to the device, if available),
>>    - When not using pm_clk_add(), but pm_clk_add_clk() (which takes a
>>      "struct clk *" directly).
>>
>> Hence print the actual clock name instead of the con_id.
>>
>> As the clock name is not available with legacy clock frameworks, and a
>> (non-NULL) con_id is more useful than a hex address, keep printing the
>> con_id if the Common Clock Framework is not enabled.
>
> overall:
> Reviewed-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> But, It seems case !CONFIG_COMMON_CLK is handled by vsprintf, may we can assume

Yes it is, it will print the hex pointer value.

> that printk will handle invalid input parameters values correctly:
>
> like
>  dev_dbg(dev, "Clock %pC con_id:%s managed by runtime PM.\n", ce->clk, ce->con_id);

Thanks, I didn't think about printing both, as I was too focused on printing
a single perfect value ;-)

BTW, what I wanted to do was something like

        dev_dbg(dev, "Clock %s managed by runtime PM.\n",
                ce->con_id ? ce->con_id : __clk_get_name(ce->clk));

but __clk_get_name() doesn't exist if !CONFIG_COMMON_CLK.

Having the con_id too, is useful if it's non-NULL, so I'll follow your
suggestion.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
