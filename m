From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 8/8] drivers: cpuidle: initialize Exynos driver
 through DT
Date: Fri, 15 Aug 2014 22:52:01 +0100
Message-ID: <20140815215201.GA15590@red-moon>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-9-git-send-email-lorenzo.pieralisi@arm.com>
 <20140815211233.GA46224@ilina-mac.local>
 <20140815214034.GA10552@e102568-lin.cambridge.arm.com>
 <20140815214513.GB46224@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140815214513.GB46224@ilina-mac.local>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <k.chander@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Rob Herring <robh+dt@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 15, 2014 at 10:45:13PM +0100, Lina Iyer wrote:
> On Fri, Aug 15, 2014 at 10:40:34PM +0100, Lorenzo Pieralisi wrote:
> >On Fri, Aug 15, 2014 at 10:12:33PM +0100, Lina Iyer wrote:
> >
> >[...]
> >
> >> > static int exynos_cpuidle_probe(struct platform_device *pdev)
> >> > {
> >> >-	int ret;
> >> >+	int ret, i;
> >> >+	struct cpuidle_driver *drv = &exynos_idle_driver;
> >> >
> >> > 	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
> >> >
> >> >-	ret = cpuidle_register(&exynos_idle_driver, NULL);
> >> >+	drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> >> >+	if (!drv->cpumask)
> >> >+		return -ENOMEM;
> >> drv->cpumask would not have any cpu set. I dont see it being modified
> >> elsewhere.
> >
> >Gah, I should have missed that while refactoring, I can just compile test this
> >patch so it went unnoticed. Fixed (by copying the possible mask to
> >drv->cpumask).
> >
> >Thank you !
> >Lorenzo
> Noticed that in the big.little exynos driver  as well.

If you mean drivers/cpuidle-big_little.c, there masks are initialized
before parsing DT, so code is correct and I could test that.

Thanks,
Lorenzo
