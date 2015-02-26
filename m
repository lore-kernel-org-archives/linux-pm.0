From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] dmaengine: shdma: Move DMA stop to (runtime) suspend callbacks
Date: Thu, 26 Feb 2015 14:30:36 +0100
Message-ID: <CAMuHMdXfrVYicT6mW9igFZ9xt_Pv3BtNve0nSQHDRrkTkt5m=A@mail.gmail.com>
References: <1424946394-6784-1-git-send-email-geert+renesas@glider.be>
	<54EF1DC2.30703@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:59490 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbbBZNah (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 08:30:37 -0500
In-Reply-To: <54EF1DC2.30703@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, dmaengine@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Feb 26, 2015 at 2:21 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>>   static struct platform_driver sh_dmae_driver = {
>> -       .driver         = {
>> +       .driver         = {
>
>
>    Hm, don't understand what was changed on this line...

One silly space that should have been a TAB.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
