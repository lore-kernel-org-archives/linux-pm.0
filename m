From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC v2 4/4] clk: shmobile: rcar-gen2: Switch from old MSTP
 to new MSSR driver
Date: Tue, 29 Sep 2015 22:30:30 +0900
Message-ID: <CANqRtoTMgZRU6bmp9VoK6O5xDNKc0zkf-xmepgkY2ZyYXW5-mQ@mail.gmail.com>
References: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
	<1442936646-30362-5-git-send-email-geert+renesas@glider.be>
	<CAMuHMdW3o0WCGCXuyYJtd8nC691N62wK7NNTzTQTM7fAvCn8jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36789 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964828AbbI2Nab (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 09:30:31 -0400
In-Reply-To: <CAMuHMdW3o0WCGCXuyYJtd8nC691N62wK7NNTzTQTM7fAvCn8jg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert,

On Tue, Sep 29, 2015 at 9:48 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Sep 22, 2015 at 5:44 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
>> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
>> @@ -431,7 +431,7 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
>>
>>         of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
>>
>> -       cpg_mstp_add_clk_domain(np);
>> +       cpg_mssr_add_clk_domain(np);
>
> Of course this should become conditional on the presence of the new
> "renesas,r8a7791-cpg-mssr" compatible value, to preserve
> backwards-compatibility with old DTSes.

Yeah, and we should probably link in both clk-mstp.o and clk-mssr.o
for older SoCs.

Cheers,

/ magnus
