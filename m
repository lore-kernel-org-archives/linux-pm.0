From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v5 1/3] clk: samsung: Add clock driver for s5pc110/s5pv210
Date: Tue, 24 Sep 2013 15:58:06 +0200
Message-ID: <52419A6E.9020203@samsung.com>
References: <1380027009-2239-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1380027009-2239-2-git-send-email-m.krawczuk@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1380027009-2239-2-git-send-email-m.krawczuk@partner.samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Cc: rjw@sisk.pl, kgene.kim@samsung.com, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, kyungmin.park@samsung.com, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, mturquette@linaro.org, tomasz.figa@gmail.com, thomas.abraham@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, t.stanislaws@samsung.com, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 24/09/13 14:50, Mateusz Krawczuk wrote:
> +++ b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
> @@ -0,0 +1,75 @@
> +* Samsung S5PC110/S5PV210 Clock Controller
> +
> +The S5PV210 clock controller generates and supplies clock to various controllers
> +within the SoC. The clock binding described here is applicable to all SoCs in
> +the S5PC110/S5PV210 family.
> +
> +Required Properties:
> +
> +- compatible: should be "samsung,s5pv210-clock".

I have nothing against this compatible value, but wouldn't it be more
accurate to use, e.g. "samsung,s5pv210-cmu" - for Clock Management Unit,
as this IP block is also referred to in the documentation ?

May just be me, but "samsung,s5pv210-clock" sounds like just one
specific clock type.

--
Thanks,
Sylwester
