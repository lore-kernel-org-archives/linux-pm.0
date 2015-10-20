From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] cpufreq: imx6q: cleanup resource allocation
Date: Tue, 20 Oct 2015 23:55:47 +0800
Message-ID: <201510202341.rs7NtAOZ%fengguang.wu@intel.com>
References: <20151020134404.GA954@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21183 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbbJTP5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Oct 2015 11:57:04 -0400
Content-Disposition: inline
In-Reply-To: <20151020134404.GA954@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: kbuild-all@01.org, Heiner Kallweit <heiner.kallweit@web.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sascha,

[auto build test ERROR on pm/linux-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Sascha-Hauer/cpufreq-imx6q-cleanup-resource-allocation/20151020-214609
config: arm-imx_v6_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/cpufreq/imx6q-cpufreq.c: In function 'imx6q_cpufreq_put_resources':
>> drivers/cpufreq/imx6q-cpufreq.c:272:1: warning: no return statement in function returning non-void [-Wreturn-type]
    }
    ^
   drivers/cpufreq/imx6q-cpufreq.c: In function 'imx6q_cpufreq_probe':
>> drivers/cpufreq/imx6q-cpufreq.c:419:2: error: too few arguments to function 'imx6q_cpufreq_put_resources'
     imx6q_cpufreq_put_resources();
     ^
   drivers/cpufreq/imx6q-cpufreq.c:229:12: note: declared here
    static int imx6q_cpufreq_put_resources(struct platform_device *pdev)
               ^
>> drivers/cpufreq/imx6q-cpufreq.c:327:3: error: label 'put_reg' used but not defined
      goto put_reg;
      ^
   drivers/cpufreq/imx6q-cpufreq.c: In function 'imx6q_cpufreq_remove':
   drivers/cpufreq/imx6q-cpufreq.c:432:2: error: too few arguments to function 'imx6q_cpufreq_put_resources'
     imx6q_cpufreq_put_resources();
     ^
   drivers/cpufreq/imx6q-cpufreq.c:229:12: note: declared here
    static int imx6q_cpufreq_put_resources(struct platform_device *pdev)
               ^

vim +/imx6q_cpufreq_put_resources +419 drivers/cpufreq/imx6q-cpufreq.c

   266	
   267		if (!IS_ERR_OR_NULL(secondary_sel_clk))
   268			clk_put(secondary_sel_clk);
   269		secondary_sel_clk = NULL;
   270	
   271	
 > 272	}
   273	
   274	static int imx6q_cpufreq_probe(struct platform_device *pdev)
   275	{
   276		struct device_node *np;
   277		struct dev_pm_opp *opp;
   278		unsigned long min_volt, max_volt;
   279		int num, ret;
   280		const struct property *prop;
   281		const __be32 *val;
   282		u32 nr, i, j;
   283	
   284		cpu_dev = get_cpu_device(0);
   285		if (!cpu_dev) {
   286			pr_err("failed to get cpu0 device\n");
   287			return -ENODEV;
   288		}
   289	
   290		np = of_node_get(cpu_dev->of_node);
   291		if (!np) {
   292			dev_err(cpu_dev, "failed to find cpu0 node\n");
   293			return -ENOENT;
   294		}
   295	
   296		ret = imx6q_cpufreq_get_resources(pdev);
   297		if (ret)
   298			goto drop_resources;
   299	
   300		/*
   301		 * We expect an OPP table supplied by platform.
   302		 * Just, incase the platform did not supply the OPP
   303		 * table, it will try to get it.
   304		 */
   305		num = dev_pm_opp_get_opp_count(cpu_dev);
   306		if (num < 0) {
   307			ret = dev_pm_opp_of_add_table(cpu_dev);
   308			if (ret < 0) {
   309				dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
   310				goto drop_resources;
   311			}
   312	
   313			/* Because we have added the OPPs here, we must free them */
   314			free_opp = true;
   315	
   316			num = dev_pm_opp_get_opp_count(cpu_dev);
   317			if (num < 0) {
   318				ret = num;
   319				dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
   320				goto out_free_opp;
   321			}
   322		}
   323	
   324		ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
   325		if (ret) {
   326			dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
 > 327			goto put_reg;
   328		}
   329	
   330		/* Make imx6_soc_volt array's size same as arm opp number */
   331		imx6_soc_volt = devm_kzalloc(cpu_dev, sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
   332		if (imx6_soc_volt == NULL) {
   333			ret = -ENOMEM;
   334			goto free_freq_table;
   335		}
   336	
   337		prop = of_find_property(np, "fsl,soc-operating-points", NULL);
   338		if (!prop || !prop->value)
   339			goto soc_opp_out;
   340	
   341		/*
   342		 * Each OPP is a set of tuples consisting of frequency and
   343		 * voltage like <freq-kHz vol-uV>.
   344		 */
   345		nr = prop->length / sizeof(u32);
   346		if (nr % 2 || (nr / 2) < num)
   347			goto soc_opp_out;
   348	
   349		for (j = 0; j < num; j++) {
   350			val = prop->value;
   351			for (i = 0; i < nr / 2; i++) {
   352				unsigned long freq = be32_to_cpup(val++);
   353				unsigned long volt = be32_to_cpup(val++);
   354				if (freq_table[j].frequency == freq) {
   355					imx6_soc_volt[soc_opp_count++] = volt;
   356					break;
   357				}
   358			}
   359		}
   360	
   361	soc_opp_out:
   362		/* use fixed soc opp volt if no valid soc opp info found in dtb */
   363		if (soc_opp_count != num) {
   364			dev_warn(cpu_dev, "can NOT find valid fsl,soc-operating-points property in dtb, use default value!\n");
   365			for (j = 0; j < num; j++)
   366				imx6_soc_volt[j] = PU_SOC_VOLTAGE_NORMAL;
   367			if (freq_table[num - 1].frequency * 1000 == FREQ_1P2_GHZ)
   368				imx6_soc_volt[num - 1] = PU_SOC_VOLTAGE_HIGH;
   369		}
   370	
   371		if (of_property_read_u32(np, "clock-latency", &transition_latency))
   372			transition_latency = CPUFREQ_ETERNAL;
   373	
   374		/*
   375		 * Calculate the ramp time for max voltage change in the
   376		 * VDDSOC and VDDPU regulators.
   377		 */
   378		ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
   379		if (ret > 0)
   380			transition_latency += ret * 1000;
   381		if (!IS_ERR(pu_reg)) {
   382			ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
   383			if (ret > 0)
   384				transition_latency += ret * 1000;
   385		}
   386	
   387		/*
   388		 * OPP is maintained in order of increasing frequency, and
   389		 * freq_table initialised from OPP is therefore sorted in the
   390		 * same order.
   391		 */
   392		rcu_read_lock();
   393		opp = dev_pm_opp_find_freq_exact(cpu_dev,
   394					  freq_table[0].frequency * 1000, true);
   395		min_volt = dev_pm_opp_get_voltage(opp);
   396		opp = dev_pm_opp_find_freq_exact(cpu_dev,
   397					  freq_table[--num].frequency * 1000, true);
   398		max_volt = dev_pm_opp_get_voltage(opp);
   399		rcu_read_unlock();
   400		ret = regulator_set_voltage_time(arm_reg, min_volt, max_volt);
   401		if (ret > 0)
   402			transition_latency += ret * 1000;
   403	
   404		ret = cpufreq_register_driver(&imx6q_cpufreq_driver);
   405		if (ret) {
   406			dev_err(cpu_dev, "failed register driver: %d\n", ret);
   407			goto free_freq_table;
   408		}
   409	
   410		of_node_put(np);
   411		return 0;
   412	
   413	free_freq_table:
   414		dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
   415	out_free_opp:
   416		if (free_opp)
   417			dev_pm_opp_of_remove_table(cpu_dev);
   418	drop_resources:
 > 419		imx6q_cpufreq_put_resources();
   420	
   421		of_node_put(np);
   422		return ret;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ReaqsoxgOBHFXBhH
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ReaqsoxgOBHFXBhH--
