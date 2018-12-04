From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Tue, 04 Dec 2018 14:28:11 -0800
Message-ID: <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2018-12-03 21:12:31)
> Hi Taniya,
> =

> Sorry that I haven't been reviewing it much from last few iterations as I=
 was
> letting others get this into a better shape. Thanks for your efforts..
> =

> On 02-12-18, 09:25, Taniya Das wrote:
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> =

> > +struct cpufreq_qcom {
> > +     struct cpufreq_frequency_table *table;
> > +     void __iomem *perf_state_reg;
> > +     cpumask_t related_cpus;
> > +};
> > +
> > +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> =

> Now that the code is much more simplified, I am not sure if you need this
> per-cpu structure at all. The only place where you are using it is in
> qcom_cpufreq_hw_cpu_init() and probe(). Why not merge qcom_cpu_resources_=
init()
> completely into qcom_cpufreq_hw_cpu_init() and get rid of this structure
> entirely ?
> =


Good point. Here's an untested patch to handle that. It removes the
related functionality and makes an array of pointers to the domains that
are created each time qcom_cpu_resources_init() is called.

---8<----

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufr=
eq-hw.c
index 8dc6b73c2f22..04e7cfd70316 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -23,14 +23,14 @@
 #define REG_LUT_TABLE			0x110
 #define REG_PERF_STATE			0x920
 =

+#define MAX_FREQ_DOMAINS		2
+
 struct cpufreq_qcom {
 	struct cpufreq_frequency_table *table;
 	void __iomem *perf_state_reg;
 	cpumask_t related_cpus;
 };
 =

-static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
-
 static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
@@ -76,9 +76,14 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct c=
pufreq_policy *policy,
 =

 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
+	struct cpufreq_qcom **freq_domain_map;
 	struct cpufreq_qcom *c;
 =

-	c =3D qcom_freq_domain_map[policy->cpu];
+	freq_domain_map =3D cpufreq_get_driver_data();
+	if (!freq_domain_map)
+		return -ENODEV;
+
+	c =3D freq_domain_map[policy->cpu];
 	if (!c) {
 		pr_err("No scaling support for CPU%d\n", policy->cpu);
 		return -ENODEV;
@@ -171,39 +176,17 @@ static int qcom_cpufreq_hw_read_lut(struct device *de=
v, struct cpufreq_qcom *c,
 	return 0;
 }
 =

-static void qcom_get_related_cpus(int index, struct cpumask *m)
-{
-	struct device_node *cpu_np;
-	struct of_phandle_args args;
-	int cpu, ret;
-
-	for_each_possible_cpu(cpu) {
-		cpu_np =3D of_cpu_device_node_get(cpu);
-		if (!cpu_np)
-			continue;
-
-		ret =3D of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
-						 "#freq-domain-cells", 0,
-						  &args);
-		of_node_put(cpu_np);
-		if (ret < 0)
-			continue;
-
-		if (index =3D=3D args.args[0])
-			cpumask_set_cpu(cpu, m);
-	}
-}
-
 static int qcom_cpu_resources_init(struct platform_device *pdev,
 				   unsigned int cpu, int index,
 				   unsigned long xo_rate,
-				   unsigned long cpu_hw_rate)
+				   unsigned long cpu_hw_rate,
+				   struct cpufreq_qcom **freq_domain_map)
 {
 	struct cpufreq_qcom *c;
 	struct resource *res;
 	struct device *dev =3D &pdev->dev;
 	void __iomem *base;
-	int ret, cpu_r;
+	int ret;
 =

 	c =3D devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
 	if (!c)
@@ -220,12 +203,6 @@ static int qcom_cpu_resources_init(struct platform_dev=
ice *pdev,
 		return -ENODEV;
 	}
 =

-	qcom_get_related_cpus(index, &c->related_cpus);
-	if (!cpumask_weight(&c->related_cpus)) {
-		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
-		return -ENOENT;
-	}
-
 	c->perf_state_reg =3D base + REG_PERF_STATE;
 =

 	ret =3D qcom_cpufreq_hw_read_lut(dev, c, base, xo_rate, cpu_hw_rate);
@@ -234,8 +211,7 @@ static int qcom_cpu_resources_init(struct platform_devi=
ce *pdev,
 		return ret;
 	}
 =

-	for_each_cpu(cpu_r, &c->related_cpus)
-		qcom_freq_domain_map[cpu_r] =3D c;
+	freq_domain_map[index] =3D c;
 =

 	return 0;
 }
@@ -245,9 +221,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platfor=
m_device *pdev)
 	struct device_node *cpu_np;
 	struct of_phandle_args args;
 	struct clk *clk;
-	unsigned int cpu;
+	unsigned int cpu, domain;
 	unsigned long xo_rate, cpu_hw_rate;
 	int ret;
+	struct cpufreq_qcom **freq_domain_map, *freq_domain;
+
+	freq_domain_map =3D devm_kcalloc(&pdev->dev, MAX_FREQ_DOMAINS,
+				       sizeof(*freq_domain_map), GFP_KERNEL);
+	cpufreq_qcom_hw_driver.driver_data =3D freq_domain_map;
+	if (!freq_domain_map)
+		return -ENOMEM;
 =

 	clk =3D clk_get(&pdev->dev, "xo");
 	if (IS_ERR(clk))
@@ -273,16 +256,28 @@ static int qcom_cpufreq_hw_driver_probe(struct platfo=
rm_device *pdev)
 =

 		ret =3D of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
 						 "#freq-domain-cells", 0,
-						  &args);
+						 &args);
 		of_node_put(cpu_np);
 		if (ret)
 			return ret;
 =

-		if (qcom_freq_domain_map[cpu])
+		domain =3D args.args[0];
+		if (domain >=3D MAX_FREQ_DOMAINS)
 			continue;
 =

-		ret =3D qcom_cpu_resources_init(pdev, cpu, args.args[0],
-					      xo_rate, cpu_hw_rate);
+		/*
+		 * If we've already populated the frequency table for this domain
+		 * just mark it related and get out of here
+		 */
+		freq_domain =3D freq_domain_map[domain];
+		if (freq_domain) {
+			cpumask_set_cpu(cpu, &freq_domain->related_cpus);
+			continue;
+		}
+
+		ret =3D qcom_cpu_resources_init(pdev, cpu, domain,
+					      xo_rate, cpu_hw_rate,
+					      freq_domain_map);
 		if (ret)
 			return ret;
 	}
