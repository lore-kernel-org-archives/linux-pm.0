From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 07/13] ARM: dts: mvebu: Add a new set of registers to
 the PMSU node
Date: Wed, 19 Feb 2014 17:00:33 +0100
Message-ID: <20140219170033.4ca8343b@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
	<1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392312816-17657-8-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Dear Gregory CLEMENT,

On Thu, 13 Feb 2014 18:33:30 +0100, Gregory CLEMENT wrote:

>  - reg: Should contain PMSU registers location and length. First pair
> -  for the per-CPU SW Reset Control registers, second pair for the
> -  Power Management Service Unit.
> +  for the per-CPU SW Reset Control registers, second pair for the CPU
> +  Power Management Service Unit registers, third pair for the Fabric Power
> +  Management Service Unit registers.
>  
>  Example:
>  
> -armada-370-xp-pmsu@d0022000 {
> +armada-370-xp-pmsu@22000 {
>  	compatible = "marvell,armada-370-xp-pmsu";
> -	reg = <0xd0022100 0x430>,
> -	      <0xd0020800 0x20>;
> +	reg = <0x22100 0x430>,
> +	      <0x20800 0x20>,
> +	      <0x22000 0x24>;

I am not too happy with this because:

 *) We have to remove the second register pair from the PMSU. I haven't
    yet posted the patches on LAKML for SMP on 375 and 38x, but the 375
    doesn't have a PMSU. It however has the same CPU reset control
    registers as 370 and XP. Therefore, these 0x20800 registers have to
    be handled by a separate driver (that uses the reset framework),
    and not handled by the PMSU driver. This way, Armada 370/XP can use
    PMSU+CPU reset, while 375 will only use CPU reset.

 *) I think making the PMSU register start at 0x22100 was a mistake.
    The PMSU registers actually start at 0x22000 and they seem to go all
    the way to 0x23000. So we should have only one register pair. This
    of course raises some backward compatibility questions for the DT.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
