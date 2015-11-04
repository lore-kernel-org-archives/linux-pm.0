From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 3/5] thermal: exynos: Use IS_ERR() because regulator cannot
 be NULL
Date: Wed, 04 Nov 2015 12:17:54 +0100
Message-ID: <20151104121754.70c5f148@amdc2363>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
 <1444282446-6419-3-git-send-email-k.kozlowski@samsung.com>
 <CAGOxZ5398_iCw3qVpwmE5Cub09+M=g45psKOhPZo=zPv4L4fOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAGOxZ5398_iCw3qVpwmE5Cub09+M=g45psKOhPZo=zPv4L4fOA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Alim,

> Hello,
> 
> On Thu, Oct 8, 2015 at 11:04 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > The NULL check in probe's error path is not needed because in that
> > time the regulator cannot be NULL (regulator_get() returns valid
> > pointer or ERR_PTR).
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> 
> >  drivers/thermal/samsung/exynos_tmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > b/drivers/thermal/samsung/exynos_tmu.c index
> > bc71a61f0c4a..eac6aebf82f3 100644 ---
> > a/drivers/thermal/samsung/exynos_tmu.c +++
> > b/drivers/thermal/samsung/exynos_tmu.c @@ -1396,7 +1396,7 @@
> > err_clk_sec: if (!IS_ERR(data->clk_sec))
> >                 clk_unprepare(data->clk_sec);
> >  err_sensor:
> > -       if (!IS_ERR_OR_NULL(data->regulator))
> > +       if (!IS_ERR(data->regulator))
> >                 regulator_disable(data->regulator);
> >
> >         return ret;
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-samsung-soc" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> 
> 
> 

Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Tested-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
