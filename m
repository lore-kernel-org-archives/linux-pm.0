From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/2] dmaengine: usb-dmac: Runtime PM Related Fixes
Date: Fri, 16 Oct 2015 15:10:37 +0200
Message-ID: <CAMuHMdVGq19174R=+D_hrzj-XPY8PaKvif3nB=sDq62KCuM5Xg@mail.gmail.com>
References: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
	<20151007140124.GC3320@vkoul-mobl.iind.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33789 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbbJPNKi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 09:10:38 -0400
In-Reply-To: <20151007140124.GC3320@vkoul-mobl.iind.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Vinod,

On Wed, Oct 7, 2015 at 4:01 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Oct 01, 2015 at 09:22:16AM +0200, Geert Uytterhoeven wrote:
>>       Hi Vinod, Shimoda-san,
>>
>> This series fixes a crash and an imbalance in the usb-dmac driver.
>
> Sorry this fails for me, what was this generated against

Strange, this series still applies cleanly on top of slave-dma/next and
linus/master.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
