From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/6] Revert "staging: board: disable as it breaks the build"
Date: Tue, 7 Apr 2015 15:16:54 +0200
Message-ID: <CAMuHMdX1uHq23h_qsq2csTSYbAhN9ZDdMviDi=KtbLuWucYWXA@mail.gmail.com>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
	<1428064923-24950-2-git-send-email-geert+renesas@glider.be>
	<20150406004031.GD1841@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150406004031.GD1841@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, driverdevel <devel@driverdev.osuosl.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 6, 2015 at 2:40 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Apr 03, 2015 at 02:41:58PM +0200, Geert Uytterhoeven wrote:
>> This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.
>>
>> Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
>> fixed the build of drivers/staging/board/board.c.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by? Reviewed-by? Tested-by? Rejected-by?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
