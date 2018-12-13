From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Thu, 13 Dec 2018 01:58:27 -0800
Message-ID: <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544687394-331-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>, Taniya Das <tdas@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-12-12 23:49:54)
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>=20
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

But I noticed that we don't release the I/O region anymore so hotplug
and replug of a whole clk domain fails. I guess devm_ioremap_resource()
was just too much magic so how about we downgrade to devm_ioremap()
instead?

BTW, Viresh, I see a lockdep splat when cpufreq_init returns an error
upon bringing the policy online the second time. I guess cpufreq_stats
aren't able to be freed from there because they take locks in different
order vs. the normal path?

-----8<-------
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufr=
eq-hw.c
index fce7a1162e87..0e1105151478 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -182,9 +182,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_pol=
icy *policy)
 	index =3D args.args[0];
=20
 	res =3D platform_get_resource(global_pdev, IORESOURCE_MEM, index);
-	base =3D devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (!res)
+		return -ENODEV;
+
+	base =3D devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return -ENOMEM;
=20
 	/* HW should be in enabled state to proceed */
 	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
