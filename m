From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] cpufreq: create sysfs symlink for cpus onlined after
 boot (fwd)
Date: Sun, 26 Mar 2017 15:47:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1703261546000.2204@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:37390
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751313AbdCZNrK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Mar 2017 09:47:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, pprakash@codeaurora.org, kbuild-all@01.org

Hello,

Should there be an unlock just before the goto on line 1185?

julia

---------- Forwarded message ----------
Date: Sun, 26 Mar 2017 20:49:50 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] cpufreq: create sysfs symlink for cpus onlined after boot

Hi Prashanth,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.11-rc3 next-20170324]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Prashanth-Prakash/cpufreq-create-sysfs-symlink-for-cpus-onlined-after-boot/20170326-163305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
:::::: branch date: 4 hours ago
:::::: commit date: 4 hours ago

>> drivers/cpufreq/cpufreq.c:1290:1-7: preceding lock on line 1178

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 58ceb5a72b06374a87493ed27c410b8a3335374f
vim +1290 drivers/cpufreq/cpufreq.c

5a7e56a5d Viresh Kumar       2014-03-04  1172  	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
5a7e56a5d Viresh Kumar       2014-03-04  1173
194d99c7e Rafael J. Wysocki  2015-07-29  1174  	if (new_policy) {
5a7e56a5d Viresh Kumar       2014-03-04  1175  		policy->user_policy.min = policy->min;
5a7e56a5d Viresh Kumar       2014-03-04  1176  		policy->user_policy.max = policy->max;
6d4e81ed8 Tomeu Vizoso       2014-11-24  1177
652ed95d5 Viresh Kumar       2014-01-09 @1178  		write_lock_irqsave(&cpufreq_driver_lock, flags);
58ceb5a72 Prashanth Prakash  2017-03-23  1179  		for_each_cpu(j, policy->related_cpus) {
58ceb5a72 Prashanth Prakash  2017-03-23  1180  			/* Setup sysfs links only for real CPUs */
58ceb5a72 Prashanth Prakash  2017-03-23  1181  			if (cpumask_test_cpu(j, cpufreq_real_cpus)) {
58ceb5a72 Prashanth Prakash  2017-03-23  1182  				ret = add_cpu_dev_symlink(policy,
58ceb5a72 Prashanth Prakash  2017-03-23  1183  							get_cpu_device(j));
58ceb5a72 Prashanth Prakash  2017-03-23  1184  				if (ret)
58ceb5a72 Prashanth Prakash  2017-03-23  1185  					goto out_delete_symlinks;
58ceb5a72 Prashanth Prakash  2017-03-23  1186  			}
652ed95d5 Viresh Kumar       2014-01-09  1187  			per_cpu(cpufreq_cpu_data, j) = policy;
58ceb5a72 Prashanth Prakash  2017-03-23  1188  		}
652ed95d5 Viresh Kumar       2014-01-09  1189  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
ff010472f Viresh Kumar       2017-03-21  1190  	} else {
ff010472f Viresh Kumar       2017-03-21  1191  		policy->min = policy->user_policy.min;
ff010472f Viresh Kumar       2017-03-21  1192  		policy->max = policy->user_policy.max;
988bed09d Viresh Kumar       2015-05-08  1193  	}
652ed95d5 Viresh Kumar       2014-01-09  1194
2ed99e39c Rafael J. Wysocki  2014-03-12  1195  	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
da60ce9f2 Viresh Kumar       2013-10-03  1196  		policy->cur = cpufreq_driver->get(policy->cpu);
da60ce9f2 Viresh Kumar       2013-10-03  1197  		if (!policy->cur) {
da60ce9f2 Viresh Kumar       2013-10-03  1198  			pr_err("%s: ->get() failed\n", __func__);
8101f9970 Viresh Kumar       2015-07-08  1199  			goto out_exit_policy;
da60ce9f2 Viresh Kumar       2013-10-03  1200  		}
da60ce9f2 Viresh Kumar       2013-10-03  1201  	}
da60ce9f2 Viresh Kumar       2013-10-03  1202
d3916691c Viresh Kumar       2013-12-03  1203  	/*
d3916691c Viresh Kumar       2013-12-03  1204  	 * Sometimes boot loaders set CPU frequency to a value outside of
d3916691c Viresh Kumar       2013-12-03  1205  	 * frequency table present with cpufreq core. In such cases CPU might be
d3916691c Viresh Kumar       2013-12-03  1206  	 * unstable if it has to run on that frequency for long duration of time
d3916691c Viresh Kumar       2013-12-03  1207  	 * and so its better to set it to a frequency which is specified in
d3916691c Viresh Kumar       2013-12-03  1208  	 * freq-table. This also makes cpufreq stats inconsistent as
d3916691c Viresh Kumar       2013-12-03  1209  	 * cpufreq-stats would fail to register because current frequency of CPU
d3916691c Viresh Kumar       2013-12-03  1210  	 * isn't found in freq-table.
d3916691c Viresh Kumar       2013-12-03  1211  	 *
d3916691c Viresh Kumar       2013-12-03  1212  	 * Because we don't want this change to effect boot process badly, we go
d3916691c Viresh Kumar       2013-12-03  1213  	 * for the next freq which is >= policy->cur ('cur' must be set by now,
d3916691c Viresh Kumar       2013-12-03  1214  	 * otherwise we will end up setting freq to lowest of the table as 'cur'
d3916691c Viresh Kumar       2013-12-03  1215  	 * is initialized to zero).
d3916691c Viresh Kumar       2013-12-03  1216  	 *
d3916691c Viresh Kumar       2013-12-03  1217  	 * We are passing target-freq as "policy->cur - 1" otherwise
d3916691c Viresh Kumar       2013-12-03  1218  	 * __cpufreq_driver_target() would simply fail, as policy->cur will be
d3916691c Viresh Kumar       2013-12-03  1219  	 * equal to target-freq.
d3916691c Viresh Kumar       2013-12-03  1220  	 */
d3916691c Viresh Kumar       2013-12-03  1221  	if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
d3916691c Viresh Kumar       2013-12-03  1222  	    && has_target()) {
d3916691c Viresh Kumar       2013-12-03  1223  		/* Are we running at unknown frequency ? */
d3916691c Viresh Kumar       2013-12-03  1224  		ret = cpufreq_frequency_table_get_index(policy, policy->cur);
d3916691c Viresh Kumar       2013-12-03  1225  		if (ret == -EINVAL) {
d3916691c Viresh Kumar       2013-12-03  1226  			/* Warn user and fix it */
d3916691c Viresh Kumar       2013-12-03  1227  			pr_warn("%s: CPU%d: Running at unlisted freq: %u KHz\n",
d3916691c Viresh Kumar       2013-12-03  1228  				__func__, policy->cpu, policy->cur);
d3916691c Viresh Kumar       2013-12-03  1229  			ret = __cpufreq_driver_target(policy, policy->cur - 1,
d3916691c Viresh Kumar       2013-12-03  1230  				CPUFREQ_RELATION_L);
d3916691c Viresh Kumar       2013-12-03  1231
d3916691c Viresh Kumar       2013-12-03  1232  			/*
d3916691c Viresh Kumar       2013-12-03  1233  			 * Reaching here after boot in a few seconds may not
d3916691c Viresh Kumar       2013-12-03  1234  			 * mean that system will remain stable at "unknown"
d3916691c Viresh Kumar       2013-12-03  1235  			 * frequency for longer duration. Hence, a BUG_ON().
d3916691c Viresh Kumar       2013-12-03  1236  			 */
d3916691c Viresh Kumar       2013-12-03  1237  			BUG_ON(ret);
d3916691c Viresh Kumar       2013-12-03  1238  			pr_warn("%s: CPU%d: Unlisted initial frequency changed to: %u KHz\n",
d3916691c Viresh Kumar       2013-12-03  1239  				__func__, policy->cpu, policy->cur);
d3916691c Viresh Kumar       2013-12-03  1240  		}
d3916691c Viresh Kumar       2013-12-03  1241  	}
d3916691c Viresh Kumar       2013-12-03  1242
194d99c7e Rafael J. Wysocki  2015-07-29  1243  	if (new_policy) {
d9612a495 Rafael J. Wysocki  2015-07-27  1244  		ret = cpufreq_add_dev_interface(policy);
19d6f7ec3 Dave Jones         2009-07-08  1245  		if (ret)
8101f9970 Viresh Kumar       2015-07-08  1246  			goto out_exit_policy;
1aefc75b2 Rafael J. Wysocki  2016-05-31  1247
1aefc75b2 Rafael J. Wysocki  2016-05-31  1248  		cpufreq_stats_create_table(policy);
c88a1f8b9 Lukasz Majewski    2013-08-06  1249
c88a1f8b9 Lukasz Majewski    2013-08-06  1250  		write_lock_irqsave(&cpufreq_driver_lock, flags);
c88a1f8b9 Lukasz Majewski    2013-08-06  1251  		list_add(&policy->policy_list, &cpufreq_policy_list);
c88a1f8b9 Lukasz Majewski    2013-08-06  1252  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
988bed09d Viresh Kumar       2015-05-08  1253  	}
8ff69732d Dave Jones         2006-03-05  1254
7f0fa40f5 Viresh Kumar       2015-07-08  1255  	ret = cpufreq_init_policy(policy);
7f0fa40f5 Viresh Kumar       2015-07-08  1256  	if (ret) {
7f0fa40f5 Viresh Kumar       2015-07-08  1257  		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
7f0fa40f5 Viresh Kumar       2015-07-08  1258  		       __func__, cpu, ret);
194d99c7e Rafael J. Wysocki  2015-07-29  1259  		/* cpufreq_policy_free() will notify based on this */
194d99c7e Rafael J. Wysocki  2015-07-29  1260  		new_policy = false;
194d99c7e Rafael J. Wysocki  2015-07-29  1261  		goto out_exit_policy;
08fd8c1cf Viresh Kumar       2013-12-24  1262  	}
e18f1682b Srivatsa S. Bhat   2013-07-30  1263
4e97b631f Viresh Kumar       2014-03-04  1264  	up_write(&policy->rwsem);
08fd8c1cf Viresh Kumar       2013-12-24  1265
038c5b3e4 Greg Kroah-Hartman 2007-12-17  1266  	kobject_uevent(&policy->kobj, KOBJ_ADD);
7c45cf31b Viresh Kumar       2014-11-27  1267
7c45cf31b Viresh Kumar       2014-11-27  1268  	/* Callback for handling stuff after policy is ready */
7c45cf31b Viresh Kumar       2014-11-27  1269  	if (cpufreq_driver->ready)
7c45cf31b Viresh Kumar       2014-11-27  1270  		cpufreq_driver->ready(policy);
7c45cf31b Viresh Kumar       2014-11-27  1271
2d06d8c49 Dominik Brodowski  2011-03-27  1272  	pr_debug("initialization complete\n");
^1da177e4 Linus Torvalds     2005-04-16  1273
^1da177e4 Linus Torvalds     2005-04-16  1274  	return 0;
^1da177e4 Linus Torvalds     2005-04-16  1275
58ceb5a72 Prashanth Prakash  2017-03-23  1276  out_delete_symlinks:
58ceb5a72 Prashanth Prakash  2017-03-23  1277  	for_each_cpu(j, policy->related_cpus) {
58ceb5a72 Prashanth Prakash  2017-03-23  1278  		if (per_cpu(cpufreq_cpu_data, j) &&
58ceb5a72 Prashanth Prakash  2017-03-23  1279  			cpumask_test_cpu(j, cpufreq_real_cpus))
58ceb5a72 Prashanth Prakash  2017-03-23  1280  			remove_cpu_dev_symlink(policy, get_cpu_device(j));
58ceb5a72 Prashanth Prakash  2017-03-23  1281  		per_cpu(cpufreq_cpu_data, j) = NULL;
58ceb5a72 Prashanth Prakash  2017-03-23  1282  	}
8101f9970 Viresh Kumar       2015-07-08  1283  out_exit_policy:
7106e02ba Prarit Bhargava    2014-09-10  1284  	up_write(&policy->rwsem);
7106e02ba Prarit Bhargava    2014-09-10  1285
da60ce9f2 Viresh Kumar       2013-10-03  1286  	if (cpufreq_driver->exit)
da60ce9f2 Viresh Kumar       2013-10-03  1287  		cpufreq_driver->exit(policy);
8101f9970 Viresh Kumar       2015-07-08  1288  out_free_policy:
f9f41e3ef Viresh Kumar       2017-01-05  1289  	cpufreq_policy_free(policy);
^1da177e4 Linus Torvalds     2005-04-16 @1290  	return ret;
^1da177e4 Linus Torvalds     2005-04-16  1291  }
^1da177e4 Linus Torvalds     2005-04-16  1292
597f03f9d Linus Torvalds     2016-10-03  1293  static int cpufreq_offline(unsigned int cpu);

:::::: The code at line 1290 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
