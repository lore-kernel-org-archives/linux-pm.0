From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] clk: samsung: fix cpu clock's flags checking
Date: Tue, 30 Jun 2015 19:51:32 +0200
Message-ID: <4447533.YDhQZeS4fK@amdc1976>
References: <1435598978-21800-1-git-send-email-b.zolnierkie@samsung.com>
 <7416838.2ZUPGjSqFp@amdc1976> <5592D5AB.2020802@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45567 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbF3Rwv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 13:52:51 -0400
In-reply-to: <5592D5AB.2020802@collabora.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On Tuesday, June 30, 2015 07:45:15 PM Javier Martinez Canillas wrote:
> Hello Bartlomiej,
> 
> On 06/30/2015 07:17 PM, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Tuesday, June 30, 2015 08:27:36 AM Javier Martinez Canillas wrote:
> >> On Tue, Jun 30, 2015 at 2:06 AM, Krzysztof Kozlowski
> >> <k.kozlowski@samsung.com> wrote:
> >> > On 30.06.2015 02:29, Bartlomiej Zolnierkiewicz wrote:
> >> >> CLK_CPU_HAS_DIV1 and CLK_CPU_NEEDS_DEBUG_ALT_DIV masks were
> >> >> incorrectly used as a bit numbers.  Fix it.
> >> >>
> >> >> Tested on Exynos4210 based Origen board and on Exynos5250 based
> >> >> Arndale board.
> >> >>
> >> >> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> >> >> Cc: Michael Turquette <mturquette@baylibre.com>
> >> >> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >> >> Cc: Thomas Abraham <thomas.ab@samsung.com>
> >> >> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> >> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> >> ---
> >> >>  drivers/clk/samsung/clk-cpu.c | 10 +++++-----
> >> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >> >
> >> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> >
> >> 
> >> Looks good to me as well.
> >> 
> >> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > 
> > Krzysztof has noted that I should use your @dowhile0.org e-mail address
> > instead of @collabora.co.uk one, is this right?
> >
> 
> I don't know what is the policy for tags but Krzysztof is correct that
> this email address is going away this week so for future patches please
> use my personal @dowhile0.org address instead.

OK, I'll update my patches & scripts then.

Thank you for review.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

