From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pm:linux-next 14/21] drivers/cpufreq/intel_pstate.c:272:2: error:
 'limits' undeclared
Date: Thu, 19 Nov 2015 06:54:46 +0800
Message-ID: <201511190644.FCnrvNPe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17193 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932794AbbKRWzo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 18 Nov 2015 17:55:44 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kbuild-all@01.org, linux-pm@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   1af72cf8cf7cab6cd8badae1dcf071318bf7a573
commit: f5a34f298881ce43b8594d4c9914ceb8e2fb0b3c [14/21] Revert "cpufreq: intel_pstate: Use ACPI perf configuration"
config: x86_64-randconfig-x018-11181928 (attached as .config)
reproduce:
        git checkout f5a34f298881ce43b8594d4c9914ceb8e2fb0b3c
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/cpufreq/intel_pstate.c: In function 'update_turbo_state':
>> drivers/cpufreq/intel_pstate.c:272:2: error: 'limits' undeclared (first use in this function)
     limits->turbo_disabled =
     ^
   drivers/cpufreq/intel_pstate.c:272:2: note: each undeclared identifier is reported only once for each function it appears in
   drivers/cpufreq/intel_pstate.c: In function 'intel_pstate_hwp_set':
   drivers/cpufreq/intel_pstate.c:291:15: error: 'limits' undeclared (first use in this function)
      adj_range = limits->min_perf_pct * range / 100;
                  ^
   drivers/cpufreq/intel_pstate.c: In function 'show_no_turbo':
   drivers/cpufreq/intel_pstate.c:403:6: error: 'limits' undeclared (first use in this function)
     if (limits->turbo_disabled)
         ^
   drivers/cpufreq/intel_pstate.c: In function 'store_no_turbo':
   drivers/cpufreq/intel_pstate.c:422:6: error: 'limits' undeclared (first use in this function)
     if (limits->turbo_disabled) {
         ^
   drivers/cpufreq/intel_pstate.c: In function 'store_max_perf_pct':
   drivers/cpufreq/intel_pstate.c:445:2: error: 'limits' undeclared (first use in this function)
     limits->max_sysfs_pct = clamp_t(int, input, 0 , 100);
     ^
   drivers/cpufreq/intel_pstate.c: In function 'store_min_perf_pct':
   drivers/cpufreq/intel_pstate.c:470:2: error: 'limits' undeclared (first use in this function)
     limits->min_sysfs_pct = clamp_t(int, input, 0 , 100);
     ^
   drivers/cpufreq/intel_pstate.c: In function 'show_max_perf_pct':
   drivers/cpufreq/intel_pstate.c:367:31: error: 'limits' undeclared (first use in this function)
      return sprintf(buf, "%u\n", limits->object);  \
                                  ^
>> drivers/cpufreq/intel_pstate.c:485:1: note: in expansion of macro 'show_one'
    show_one(max_perf_pct, max_perf_pct);
    ^
   drivers/cpufreq/intel_pstate.c: In function 'show_min_perf_pct':
   drivers/cpufreq/intel_pstate.c:367:31: error: 'limits' undeclared (first use in this function)
      return sprintf(buf, "%u\n", limits->object);  \
                                  ^
   drivers/cpufreq/intel_pstate.c:486:1: note: in expansion of macro 'show_one'
    show_one(min_perf_pct, min_perf_pct);
    ^
   drivers/cpufreq/intel_pstate.c: In function 'byt_set_pstate':
   drivers/cpufreq/intel_pstate.c:556:6: error: 'limits' undeclared (first use in this function)
     if (limits->no_turbo && !limits->turbo_disabled)
         ^
   drivers/cpufreq/intel_pstate.c: In function 'core_set_pstate':
   drivers/cpufreq/intel_pstate.c:685:6: error: 'limits' undeclared (first use in this function)
     if (limits->no_turbo && !limits->turbo_disabled)
         ^
   drivers/cpufreq/intel_pstate.c: In function 'intel_pstate_get_min_max':
   drivers/cpufreq/intel_pstate.c:768:6: error: 'limits' undeclared (first use in this function)
     if (limits->no_turbo || limits->turbo_disabled)
         ^
   drivers/cpufreq/intel_pstate.c: In function 'intel_pstate_set_policy':
   drivers/cpufreq/intel_pstate.c:1062:3: error: 'limits' undeclared (first use in this function)
      limits = &performance_limits;
      ^
   drivers/cpufreq/intel_pstate.c: In function 'intel_pstate_cpu_init':
   drivers/cpufreq/intel_pstate.c:1133:6: error: 'limits' undeclared (first use in this function)
     if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
         ^
   drivers/cpufreq/intel_pstate.c: In function 'show_min_perf_pct':
>> drivers/cpufreq/intel_pstate.c:365:32: warning: control reaches end of non-void function [-Wreturn-type]
     (struct kobject *kobj, struct attribute *attr, char *buf) \
                                   ^
   drivers/cpufreq/intel_pstate.c:486:1: note: in expansion of macro 'show_one'
    show_one(min_perf_pct, min_perf_pct);
    ^
   drivers/cpufreq/intel_pstate.c: In function 'show_max_perf_pct':
>> drivers/cpufreq/intel_pstate.c:365:32: warning: control reaches end of non-void function [-Wreturn-type]
     (struct kobject *kobj, struct attribute *attr, char *buf) \
                                   ^
>> drivers/cpufreq/intel_pstate.c:485:1: note: in expansion of macro 'show_one'
    show_one(max_perf_pct, max_perf_pct);
    ^

vim +/limits +272 drivers/cpufreq/intel_pstate.c

4521e1a0c Gabriele Mazzotta       2014-10-13  266  {
4521e1a0c Gabriele Mazzotta       2014-10-13  267  	u64 misc_en;
4521e1a0c Gabriele Mazzotta       2014-10-13  268  	struct cpudata *cpu;
4521e1a0c Gabriele Mazzotta       2014-10-13  269  
4521e1a0c Gabriele Mazzotta       2014-10-13  270  	cpu = all_cpu_data[0];
4521e1a0c Gabriele Mazzotta       2014-10-13  271  	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
51443fbf3 Prarit Bhargava         2015-10-15 @272  	limits->turbo_disabled =
4521e1a0c Gabriele Mazzotta       2014-10-13  273  		(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
4521e1a0c Gabriele Mazzotta       2014-10-13  274  		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
4521e1a0c Gabriele Mazzotta       2014-10-13  275  }
4521e1a0c Gabriele Mazzotta       2014-10-13  276  
2f86dc4cd Dirk Brandewie          2014-11-06  277  static void intel_pstate_hwp_set(void)
2f86dc4cd Dirk Brandewie          2014-11-06  278  {
74da56ce5 Kristen Carlson Accardi 2015-09-09  279  	int min, hw_min, max, hw_max, cpu, range, adj_range;
74da56ce5 Kristen Carlson Accardi 2015-09-09  280  	u64 value, cap;
74da56ce5 Kristen Carlson Accardi 2015-09-09  281  
74da56ce5 Kristen Carlson Accardi 2015-09-09  282  	rdmsrl(MSR_HWP_CAPABILITIES, cap);
74da56ce5 Kristen Carlson Accardi 2015-09-09  283  	hw_min = HWP_LOWEST_PERF(cap);
74da56ce5 Kristen Carlson Accardi 2015-09-09  284  	hw_max = HWP_HIGHEST_PERF(cap);
74da56ce5 Kristen Carlson Accardi 2015-09-09  285  	range = hw_max - hw_min;
2f86dc4cd Dirk Brandewie          2014-11-06  286  
2f86dc4cd Dirk Brandewie          2014-11-06  287  	get_online_cpus();
2f86dc4cd Dirk Brandewie          2014-11-06  288  
2f86dc4cd Dirk Brandewie          2014-11-06  289  	for_each_online_cpu(cpu) {
2f86dc4cd Dirk Brandewie          2014-11-06  290  		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
51443fbf3 Prarit Bhargava         2015-10-15  291  		adj_range = limits->min_perf_pct * range / 100;
74da56ce5 Kristen Carlson Accardi 2015-09-09  292  		min = hw_min + adj_range;
2f86dc4cd Dirk Brandewie          2014-11-06  293  		value &= ~HWP_MIN_PERF(~0L);
2f86dc4cd Dirk Brandewie          2014-11-06  294  		value |= HWP_MIN_PERF(min);
2f86dc4cd Dirk Brandewie          2014-11-06  295  
51443fbf3 Prarit Bhargava         2015-10-15  296  		adj_range = limits->max_perf_pct * range / 100;
74da56ce5 Kristen Carlson Accardi 2015-09-09  297  		max = hw_min + adj_range;
51443fbf3 Prarit Bhargava         2015-10-15  298  		if (limits->no_turbo) {
74da56ce5 Kristen Carlson Accardi 2015-09-09  299  			hw_max = HWP_GUARANTEED_PERF(cap);
74da56ce5 Kristen Carlson Accardi 2015-09-09  300  			if (hw_max < max)
74da56ce5 Kristen Carlson Accardi 2015-09-09  301  				max = hw_max;
2f86dc4cd Dirk Brandewie          2014-11-06  302  		}
2f86dc4cd Dirk Brandewie          2014-11-06  303  
2f86dc4cd Dirk Brandewie          2014-11-06  304  		value &= ~HWP_MAX_PERF(~0L);
2f86dc4cd Dirk Brandewie          2014-11-06  305  		value |= HWP_MAX_PERF(max);
2f86dc4cd Dirk Brandewie          2014-11-06  306  		wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
2f86dc4cd Dirk Brandewie          2014-11-06  307  	}
2f86dc4cd Dirk Brandewie          2014-11-06  308  
2f86dc4cd Dirk Brandewie          2014-11-06  309  	put_online_cpus();
2f86dc4cd Dirk Brandewie          2014-11-06  310  }
2f86dc4cd Dirk Brandewie          2014-11-06  311  
93f0822df Dirk Brandewie          2013-02-06  312  /************************** debugfs begin ************************/
93f0822df Dirk Brandewie          2013-02-06  313  static int pid_param_set(void *data, u64 val)
93f0822df Dirk Brandewie          2013-02-06  314  {
93f0822df Dirk Brandewie          2013-02-06  315  	*(u32 *)data = val;
93f0822df Dirk Brandewie          2013-02-06  316  	intel_pstate_reset_all_pid();
93f0822df Dirk Brandewie          2013-02-06  317  	return 0;
93f0822df Dirk Brandewie          2013-02-06  318  }
845c1cbef Stratos Karafotis       2014-07-18  319  
93f0822df Dirk Brandewie          2013-02-06  320  static int pid_param_get(void *data, u64 *val)
93f0822df Dirk Brandewie          2013-02-06  321  {
93f0822df Dirk Brandewie          2013-02-06  322  	*val = *(u32 *)data;
93f0822df Dirk Brandewie          2013-02-06  323  	return 0;
93f0822df Dirk Brandewie          2013-02-06  324  }
2d8d1f18e Stratos Karafotis       2014-07-18  325  DEFINE_SIMPLE_ATTRIBUTE(fops_pid_param, pid_param_get, pid_param_set, "%llu\n");
93f0822df Dirk Brandewie          2013-02-06  326  
93f0822df Dirk Brandewie          2013-02-06  327  struct pid_param {
93f0822df Dirk Brandewie          2013-02-06  328  	char *name;
93f0822df Dirk Brandewie          2013-02-06  329  	void *value;
93f0822df Dirk Brandewie          2013-02-06  330  };
93f0822df Dirk Brandewie          2013-02-06  331  
93f0822df Dirk Brandewie          2013-02-06  332  static struct pid_param pid_files[] = {
016c81508 Dirk Brandewie          2013-10-21  333  	{"sample_rate_ms", &pid_params.sample_rate_ms},
016c81508 Dirk Brandewie          2013-10-21  334  	{"d_gain_pct", &pid_params.d_gain_pct},
016c81508 Dirk Brandewie          2013-10-21  335  	{"i_gain_pct", &pid_params.i_gain_pct},
016c81508 Dirk Brandewie          2013-10-21  336  	{"deadband", &pid_params.deadband},
016c81508 Dirk Brandewie          2013-10-21  337  	{"setpoint", &pid_params.setpoint},
016c81508 Dirk Brandewie          2013-10-21  338  	{"p_gain_pct", &pid_params.p_gain_pct},
93f0822df Dirk Brandewie          2013-02-06  339  	{NULL, NULL}
93f0822df Dirk Brandewie          2013-02-06  340  };
93f0822df Dirk Brandewie          2013-02-06  341  
317dd50e8 Stratos Karafotis       2014-07-18  342  static void __init intel_pstate_debug_expose_params(void)
93f0822df Dirk Brandewie          2013-02-06  343  {
317dd50e8 Stratos Karafotis       2014-07-18  344  	struct dentry *debugfs_parent;
93f0822df Dirk Brandewie          2013-02-06  345  	int i = 0;
93f0822df Dirk Brandewie          2013-02-06  346  
2f86dc4cd Dirk Brandewie          2014-11-06  347  	if (hwp_active)
2f86dc4cd Dirk Brandewie          2014-11-06  348  		return;
93f0822df Dirk Brandewie          2013-02-06  349  	debugfs_parent = debugfs_create_dir("pstate_snb", NULL);
93f0822df Dirk Brandewie          2013-02-06  350  	if (IS_ERR_OR_NULL(debugfs_parent))
93f0822df Dirk Brandewie          2013-02-06  351  		return;
93f0822df Dirk Brandewie          2013-02-06  352  	while (pid_files[i].name) {
93f0822df Dirk Brandewie          2013-02-06  353  		debugfs_create_file(pid_files[i].name, 0660,
93f0822df Dirk Brandewie          2013-02-06  354  				    debugfs_parent, pid_files[i].value,
93f0822df Dirk Brandewie          2013-02-06  355  				    &fops_pid_param);
93f0822df Dirk Brandewie          2013-02-06  356  		i++;
93f0822df Dirk Brandewie          2013-02-06  357  	}
93f0822df Dirk Brandewie          2013-02-06  358  }
93f0822df Dirk Brandewie          2013-02-06  359  
93f0822df Dirk Brandewie          2013-02-06  360  /************************** debugfs end ************************/
93f0822df Dirk Brandewie          2013-02-06  361  
93f0822df Dirk Brandewie          2013-02-06  362  /************************** sysfs begin ************************/
93f0822df Dirk Brandewie          2013-02-06  363  #define show_one(file_name, object)					\
93f0822df Dirk Brandewie          2013-02-06  364  	static ssize_t show_##file_name					\
93f0822df Dirk Brandewie          2013-02-06 @365  	(struct kobject *kobj, struct attribute *attr, char *buf)	\
93f0822df Dirk Brandewie          2013-02-06  366  	{								\
51443fbf3 Prarit Bhargava         2015-10-15  367  		return sprintf(buf, "%u\n", limits->object);		\
93f0822df Dirk Brandewie          2013-02-06  368  	}
93f0822df Dirk Brandewie          2013-02-06  369  
d01b1f48c Kristen Carlson Accardi 2015-01-28  370  static ssize_t show_turbo_pct(struct kobject *kobj,
d01b1f48c Kristen Carlson Accardi 2015-01-28  371  				struct attribute *attr, char *buf)
d01b1f48c Kristen Carlson Accardi 2015-01-28  372  {
d01b1f48c Kristen Carlson Accardi 2015-01-28  373  	struct cpudata *cpu;
d01b1f48c Kristen Carlson Accardi 2015-01-28  374  	int total, no_turbo, turbo_pct;
d01b1f48c Kristen Carlson Accardi 2015-01-28  375  	uint32_t turbo_fp;
d01b1f48c Kristen Carlson Accardi 2015-01-28  376  
d01b1f48c Kristen Carlson Accardi 2015-01-28  377  	cpu = all_cpu_data[0];
d01b1f48c Kristen Carlson Accardi 2015-01-28  378  
d01b1f48c Kristen Carlson Accardi 2015-01-28  379  	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
d01b1f48c Kristen Carlson Accardi 2015-01-28  380  	no_turbo = cpu->pstate.max_pstate - cpu->pstate.min_pstate + 1;
d01b1f48c Kristen Carlson Accardi 2015-01-28  381  	turbo_fp = div_fp(int_tofp(no_turbo), int_tofp(total));
d01b1f48c Kristen Carlson Accardi 2015-01-28  382  	turbo_pct = 100 - fp_toint(mul_fp(turbo_fp, int_tofp(100)));
d01b1f48c Kristen Carlson Accardi 2015-01-28  383  	return sprintf(buf, "%u\n", turbo_pct);
d01b1f48c Kristen Carlson Accardi 2015-01-28  384  }
d01b1f48c Kristen Carlson Accardi 2015-01-28  385  
0522424ec Kristen Carlson Accardi 2015-01-28  386  static ssize_t show_num_pstates(struct kobject *kobj,
0522424ec Kristen Carlson Accardi 2015-01-28  387  				struct attribute *attr, char *buf)
0522424ec Kristen Carlson Accardi 2015-01-28  388  {
0522424ec Kristen Carlson Accardi 2015-01-28  389  	struct cpudata *cpu;
0522424ec Kristen Carlson Accardi 2015-01-28  390  	int total;
0522424ec Kristen Carlson Accardi 2015-01-28  391  
0522424ec Kristen Carlson Accardi 2015-01-28  392  	cpu = all_cpu_data[0];
0522424ec Kristen Carlson Accardi 2015-01-28  393  	total = cpu->pstate.turbo_pstate - cpu->pstate.min_pstate + 1;
0522424ec Kristen Carlson Accardi 2015-01-28  394  	return sprintf(buf, "%u\n", total);
0522424ec Kristen Carlson Accardi 2015-01-28  395  }
0522424ec Kristen Carlson Accardi 2015-01-28  396  
4521e1a0c Gabriele Mazzotta       2014-10-13  397  static ssize_t show_no_turbo(struct kobject *kobj,
4521e1a0c Gabriele Mazzotta       2014-10-13  398  			     struct attribute *attr, char *buf)
4521e1a0c Gabriele Mazzotta       2014-10-13  399  {
4521e1a0c Gabriele Mazzotta       2014-10-13  400  	ssize_t ret;
4521e1a0c Gabriele Mazzotta       2014-10-13  401  
4521e1a0c Gabriele Mazzotta       2014-10-13  402  	update_turbo_state();
51443fbf3 Prarit Bhargava         2015-10-15  403  	if (limits->turbo_disabled)
51443fbf3 Prarit Bhargava         2015-10-15  404  		ret = sprintf(buf, "%u\n", limits->turbo_disabled);
4521e1a0c Gabriele Mazzotta       2014-10-13  405  	else
51443fbf3 Prarit Bhargava         2015-10-15  406  		ret = sprintf(buf, "%u\n", limits->no_turbo);
4521e1a0c Gabriele Mazzotta       2014-10-13  407  
4521e1a0c Gabriele Mazzotta       2014-10-13  408  	return ret;
4521e1a0c Gabriele Mazzotta       2014-10-13  409  }
4521e1a0c Gabriele Mazzotta       2014-10-13  410  
93f0822df Dirk Brandewie          2013-02-06  411  static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
93f0822df Dirk Brandewie          2013-02-06  412  			      const char *buf, size_t count)
93f0822df Dirk Brandewie          2013-02-06  413  {
93f0822df Dirk Brandewie          2013-02-06  414  	unsigned int input;
93f0822df Dirk Brandewie          2013-02-06  415  	int ret;
845c1cbef Stratos Karafotis       2014-07-18  416  
93f0822df Dirk Brandewie          2013-02-06  417  	ret = sscanf(buf, "%u", &input);
93f0822df Dirk Brandewie          2013-02-06  418  	if (ret != 1)
93f0822df Dirk Brandewie          2013-02-06  419  		return -EINVAL;
4521e1a0c Gabriele Mazzotta       2014-10-13  420  
4521e1a0c Gabriele Mazzotta       2014-10-13  421  	update_turbo_state();
51443fbf3 Prarit Bhargava         2015-10-15  422  	if (limits->turbo_disabled) {
f16255eb9 Doug Smythies           2015-05-31  423  		pr_warn("intel_pstate: Turbo disabled by BIOS or unavailable on processor\n");
4521e1a0c Gabriele Mazzotta       2014-10-13  424  		return -EPERM;
dd5fbf70f Dirk Brandewie          2014-06-20  425  	}
2f86dc4cd Dirk Brandewie          2014-11-06  426  
51443fbf3 Prarit Bhargava         2015-10-15  427  	limits->no_turbo = clamp_t(int, input, 0, 1);
4521e1a0c Gabriele Mazzotta       2014-10-13  428  
2f86dc4cd Dirk Brandewie          2014-11-06  429  	if (hwp_active)
2f86dc4cd Dirk Brandewie          2014-11-06  430  		intel_pstate_hwp_set();
2f86dc4cd Dirk Brandewie          2014-11-06  431  
93f0822df Dirk Brandewie          2013-02-06  432  	return count;
93f0822df Dirk Brandewie          2013-02-06  433  }
93f0822df Dirk Brandewie          2013-02-06  434  
93f0822df Dirk Brandewie          2013-02-06  435  static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
93f0822df Dirk Brandewie          2013-02-06  436  				  const char *buf, size_t count)
93f0822df Dirk Brandewie          2013-02-06  437  {
93f0822df Dirk Brandewie          2013-02-06  438  	unsigned int input;
93f0822df Dirk Brandewie          2013-02-06  439  	int ret;
845c1cbef Stratos Karafotis       2014-07-18  440  
93f0822df Dirk Brandewie          2013-02-06  441  	ret = sscanf(buf, "%u", &input);
93f0822df Dirk Brandewie          2013-02-06  442  	if (ret != 1)
93f0822df Dirk Brandewie          2013-02-06  443  		return -EINVAL;
93f0822df Dirk Brandewie          2013-02-06  444  
51443fbf3 Prarit Bhargava         2015-10-15  445  	limits->max_sysfs_pct = clamp_t(int, input, 0 , 100);
51443fbf3 Prarit Bhargava         2015-10-15  446  	limits->max_perf_pct = min(limits->max_policy_pct,
51443fbf3 Prarit Bhargava         2015-10-15  447  				   limits->max_sysfs_pct);
51443fbf3 Prarit Bhargava         2015-10-15  448  	limits->max_perf_pct = max(limits->min_policy_pct,
51443fbf3 Prarit Bhargava         2015-10-15  449  				   limits->max_perf_pct);
51443fbf3 Prarit Bhargava         2015-10-15  450  	limits->max_perf_pct = max(limits->min_perf_pct,
51443fbf3 Prarit Bhargava         2015-10-15  451  				   limits->max_perf_pct);
51443fbf3 Prarit Bhargava         2015-10-15  452  	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
51443fbf3 Prarit Bhargava         2015-10-15  453  				  int_tofp(100));
845c1cbef Stratos Karafotis       2014-07-18  454  
2f86dc4cd Dirk Brandewie          2014-11-06  455  	if (hwp_active)
2f86dc4cd Dirk Brandewie          2014-11-06  456  		intel_pstate_hwp_set();
93f0822df Dirk Brandewie          2013-02-06  457  	return count;
93f0822df Dirk Brandewie          2013-02-06  458  }
93f0822df Dirk Brandewie          2013-02-06  459  
93f0822df Dirk Brandewie          2013-02-06  460  static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
93f0822df Dirk Brandewie          2013-02-06  461  				  const char *buf, size_t count)
93f0822df Dirk Brandewie          2013-02-06  462  {
93f0822df Dirk Brandewie          2013-02-06  463  	unsigned int input;
93f0822df Dirk Brandewie          2013-02-06  464  	int ret;
845c1cbef Stratos Karafotis       2014-07-18  465  
93f0822df Dirk Brandewie          2013-02-06  466  	ret = sscanf(buf, "%u", &input);
93f0822df Dirk Brandewie          2013-02-06  467  	if (ret != 1)
93f0822df Dirk Brandewie          2013-02-06  468  		return -EINVAL;
a04759924 Kristen Carlson Accardi 2015-01-29  469  
51443fbf3 Prarit Bhargava         2015-10-15 @470  	limits->min_sysfs_pct = clamp_t(int, input, 0 , 100);
51443fbf3 Prarit Bhargava         2015-10-15  471  	limits->min_perf_pct = max(limits->min_policy_pct,
51443fbf3 Prarit Bhargava         2015-10-15  472  				   limits->min_sysfs_pct);
51443fbf3 Prarit Bhargava         2015-10-15  473  	limits->min_perf_pct = min(limits->max_policy_pct,

:::::: The code at line 272 was first introduced by commit
:::::: 51443fbf3d2cde16011b994252c8004ebcd66fb0 cpufreq: intel_pstate: Fix intel_pstate powersave min_perf_pct value

:::::: TO: Prarit Bhargava <prarit@redhat.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tThc/1wpZn/ma/RB
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RcpxAQA=

--tThc/1wpZn/ma/RB--
