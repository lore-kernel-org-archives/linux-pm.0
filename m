From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: exynos4412-trats2: Enable TMU support at
 Trats2
Date: Fri, 14 Nov 2014 10:26:03 +0100
Message-ID: <20141114102603.2b15d1f8@amdc2363>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
 <1381300194-13134-1-git-send-email-l.majewski@samsung.com>
 <1381300194-13134-6-git-send-email-l.majewski@samsung.com>
 <20131015082935.3d33eee7@amdc308.digital.local>
 <20131127081242.0591f911@amdc308.digital.local>
 <004d01ceeb64$da648200$8f2d8600$@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <004d01ceeb64$da648200$8f2d8600$@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: kgene@kernel.org
Cc: 'Linux PM list' <linux-pm@vger.kernel.org>, 'Lukasz Majewski' <l.majewski@majess.pl>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Kukjin,

> Lukasz Majewski wrote:
> > 
> > Hi Kukjin,
> > 
> > > Hi Kukjin,
> > >
> > > > This patch enables support for TMU at Exynos4412 based Trats2
> > > > board.
> > > >
> > > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > > Reviewed-by: Bartlomiej Zolnierkiewicz
> > > > <b.zolnierkie@samsung.com> Reviewed-by: Tomasz Figa
> > > > <t.figa@samsung.com>
> > > >
> > > > ---
> > > > Changes for v2:
> > > > - None
> > > >
> > > >  arch/arm/boot/dts/exynos4412-trats2.dts |    5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts
> > > > b/arch/arm/boot/dts/exynos4412-trats2.dts index fb7b9ae..57136f8
> > > > 100644 --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> > > > +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> > > > @@ -467,6 +467,11 @@
> > > >  		status = "okay";
> > > >  	};
> > > >
> > > > +	tmu@100C0000 {
> > > > +		vtmu-supply = <&ldo10_reg>;
> > > > +		status = "okay";
> > > > +	};
> > > > +
> > > >  	i2c_ak8975: i2c-gpio-0 {
> > > >  		compatible = "i2c-gpio";
> > > >  		gpios = <&gpy2 4 0>, <&gpy2 5 0>;
> > >
> > > Can you pull this DT node definition for TMU (as a fix to v3.12)?
> > >
> > > It is crucial for Exynos4412. Other patches from this patch set
> > > were already pulled as v3.12 fixes.
> > >
> > 
> > Kukjin, could you pull this patch?
> > 
> Applied, thanks.

It is strange, but it seems like this patch hasn't found its way to
mainline (3.18-rc3).

This patch should be applied with the following one:
"[PATCH v2 4/5] ARM: dts: exynos4x12: Device tree node definition for
TMU on Exynos4x12"

Anyway, I will resend them. If possible, please add them to your tree
ASAP.

> Kukjin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
