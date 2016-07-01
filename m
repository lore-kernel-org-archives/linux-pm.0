From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/7] arm: mach-shmobile: pm-rmobile: add missing
 of_node_put after calling of_parse_phandle
Date: Fri, 1 Jul 2016 14:31:58 +0200
Message-ID: <CAMuHMdVE8VzPunLzr7WO-kzcg25rKvFkoQcjJ4czwrQxX_obiw@mail.gmail.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com> <1467366121-14120-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36193 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcGAMck (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 08:32:40 -0400
In-Reply-To: <1467366121-14120-3-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>

Hi Peter,

On Fri, Jul 1, 2016 at 11:41 AM, Peter Chen <peter.chen@nxp.com> wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/mach-shmobile/pm-rmobile.c
> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -209,6 +209,7 @@ static void __init add_special_pd(struct device_node *np, enum pd_types type)
>         special_pds[num_special_pds].pd = pd;

The pd pointer is stored in the line above, and released later in
put_special_pds().

>         special_pds[num_special_pds].type = type;
>         num_special_pds++;
> +       of_node_put(pd);

Hence it must not be released here, as that would cause a double release
when put_special_pds() is executed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
