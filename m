From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 1/2] MAINTAINERS: add new entries for Armada 8K cpufreq
 driver
Date: Sat, 22 Sep 2018 20:48:26 +0300
Message-ID: <87efdlifth.fsf@tkos.co.il>
References: <20180921154326.10776-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20180921154326.10776-1-gregory.clement@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Viresh Kumar <viresh.kumar@linaro.org>, Hanna Hawa <hannah@marvell.com>, Omri Itach <omrii@marvell.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, Igal Liberman <igall@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Gregory,

Gregory CLEMENT writes:
> This new driver belongs to the mvebu family, update the MAINTAINER file
> to document it.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b25905..7e969fbb3626 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1657,6 +1657,7 @@ F:	arch/arm/configs/mvebu_*_defconfig
>  F:	arch/arm/mach-mvebu/
>  F:	arch/arm64/boot/dts/marvell/armada*
>  F:	drivers/cpufreq/armada-37xx-cpufreq.c
> +F!	drivers/cpufreq/armada-8k-cpufreq.c

s/!/:/

baruch

>  F:	drivers/cpufreq/mvebu-cpufreq.c
>  F:	drivers/irqchip/irq-armada-370-xp.c
>  F:	drivers/irqchip/irq-mvebu-*

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
