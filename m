From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: exynos4412-trats2: Enable TMU support at
 Trats2
Date: Wed, 27 Nov 2013 08:12:42 +0100
Message-ID: <20131127081242.0591f911@amdc308.digital.local>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
 <1381300194-13134-1-git-send-email-l.majewski@samsung.com>
 <1381300194-13134-6-git-send-email-l.majewski@samsung.com>
 <20131015082935.3d33eee7@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14885 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab3K0HMt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2013 02:12:49 -0500
In-reply-to: <20131015082935.3d33eee7@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "kgene.kim@samsung.com" <kgene.kim@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Hi Kukjin,

> Hi Kukjin,
> 
> > This patch enables support for TMU at Exynos4412 based Trats2 board.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > 
> > ---
> > Changes for v2:
> > - None
> > 
> >  arch/arm/boot/dts/exynos4412-trats2.dts |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts
> > b/arch/arm/boot/dts/exynos4412-trats2.dts index fb7b9ae..57136f8
> > 100644 --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> > +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> > @@ -467,6 +467,11 @@
> >  		status = "okay";
> >  	};
> >  
> > +	tmu@100C0000 {
> > +		vtmu-supply = <&ldo10_reg>;
> > +		status = "okay";
> > +	};
> > +
> >  	i2c_ak8975: i2c-gpio-0 {
> >  		compatible = "i2c-gpio";
> >  		gpios = <&gpy2 4 0>, <&gpy2 5 0>;
> 
> Can you pull this DT node definition for TMU (as a fix to v3.12)?
> 
> It is crucial for Exynos4412. Other patches from this patch set were
> already pulled as v3.12 fixes.
> 

Kukjin, could you pull this patch?

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
