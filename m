From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 8/8] cpufreq: intel_pstate: Use CPPC to get max
 performance
Date: Fri, 2 Sep 2016 06:31:54 +0800
Message-ID: <201609020616.X0hzEvoR%fengguang.wu@intel.com>
References: <1472762024-88771-9-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472762024-88771-9-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Srinivas,

[auto build test ERROR on tip/sched/core]
[also build test ERROR on v4.8-rc4 next-20160825]
[cannot apply to tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Pandruvada/Support-Intel-Turbo-Boost-Max-Technology-3-0/20160902-053224
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

warning: (X86_INTEL_PSTATE && ACPI_CPPC_CPUFREQ) selects ACPI_CPPC_LIB which has unmet direct dependencies (ACPI && ACPI_PROCESSOR && !ACPI_CPU_FREQ_PSS)
>> drivers/cpufreq/intel_pstate.c:202:8: error: redefinition of 'struct cpudata'
    struct cpudata {
           ^~~~~~~
   In file included from drivers/cpufreq/intel_pstate.c:47:0:
   include/acpi/cppc_acpi.h:117:8: note: originally defined here
    struct cpudata {
           ^~~~~~~
   drivers/cpufreq/intel_pstate.c: In function 'intel_pstate_init_acpi_perf_limits':
>> drivers/cpufreq/intel_pstate.c:399:35: error: invalid application of 'sizeof' to incomplete type 'struct cppc_cpudata'
      cpu->cppc_data = kzalloc(sizeof(struct cppc_cpudata),
                                      ^~~~~~
>> drivers/cpufreq/intel_pstate.c:404:30: error: dereferencing pointer to incomplete type 'struct cppc_cpudata'
      perf_caps = &cpu->cppc_data->perf_caps;
                                 ^~

vim +202 drivers/cpufreq/intel_pstate.c

938d21a2a Philippe Longepe        2015-11-09   41  #define ATOM_VIDS		0x66b
938d21a2a Philippe Longepe        2015-11-09   42  #define ATOM_TURBO_RATIOS	0x66c
938d21a2a Philippe Longepe        2015-11-09   43  #define ATOM_TURBO_VIDS		0x66d
61d8d2abc Dirk Brandewie          2014-02-12   44  
9522a2ff9 Srinivas Pandruvada     2016-04-27   45  #ifdef CONFIG_ACPI
9522a2ff9 Srinivas Pandruvada     2016-04-27   46  #include <acpi/processor.h>
cc2eccd40 Srinivas Pandruvada     2016-09-01  @47  #include <acpi/cppc_acpi.h>
9522a2ff9 Srinivas Pandruvada     2016-04-27   48  #endif
9522a2ff9 Srinivas Pandruvada     2016-04-27   49  
f0fe3cd7e Dirk Brandewie          2014-05-29   50  #define FRAC_BITS 8
93f0822df Dirk Brandewie          2013-02-06   51  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
93f0822df Dirk Brandewie          2013-02-06   52  #define fp_toint(X) ((X) >> FRAC_BITS)
f0fe3cd7e Dirk Brandewie          2014-05-29   53  
a1c9787dc Rafael J. Wysocki       2016-05-11   54  #define EXT_BITS 6
a1c9787dc Rafael J. Wysocki       2016-05-11   55  #define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
a1c9787dc Rafael J. Wysocki       2016-05-11   56  
93f0822df Dirk Brandewie          2013-02-06   57  static inline int32_t mul_fp(int32_t x, int32_t y)
93f0822df Dirk Brandewie          2013-02-06   58  {
93f0822df Dirk Brandewie          2013-02-06   59  	return ((int64_t)x * (int64_t)y) >> FRAC_BITS;
93f0822df Dirk Brandewie          2013-02-06   60  }
93f0822df Dirk Brandewie          2013-02-06   61  
7180dddf7 Prarit Bhargava         2015-06-15   62  static inline int32_t div_fp(s64 x, s64 y)
93f0822df Dirk Brandewie          2013-02-06   63  {
7180dddf7 Prarit Bhargava         2015-06-15   64  	return div64_s64((int64_t)x << FRAC_BITS, y);
93f0822df Dirk Brandewie          2013-02-06   65  }
93f0822df Dirk Brandewie          2013-02-06   66  
d022a65ed Dirk Brandewie          2014-10-13   67  static inline int ceiling_fp(int32_t x)
d022a65ed Dirk Brandewie          2014-10-13   68  {
d022a65ed Dirk Brandewie          2014-10-13   69  	int mask, ret;
d022a65ed Dirk Brandewie          2014-10-13   70  
d022a65ed Dirk Brandewie          2014-10-13   71  	ret = fp_toint(x);
d022a65ed Dirk Brandewie          2014-10-13   72  	mask = (1 << FRAC_BITS) - 1;
d022a65ed Dirk Brandewie          2014-10-13   73  	if (x & mask)
d022a65ed Dirk Brandewie          2014-10-13   74  		ret += 1;
d022a65ed Dirk Brandewie          2014-10-13   75  	return ret;
d022a65ed Dirk Brandewie          2014-10-13   76  }
d022a65ed Dirk Brandewie          2014-10-13   77  
a1c9787dc Rafael J. Wysocki       2016-05-11   78  static inline u64 mul_ext_fp(u64 x, u64 y)
a1c9787dc Rafael J. Wysocki       2016-05-11   79  {
a1c9787dc Rafael J. Wysocki       2016-05-11   80  	return (x * y) >> EXT_FRAC_BITS;
a1c9787dc Rafael J. Wysocki       2016-05-11   81  }
a1c9787dc Rafael J. Wysocki       2016-05-11   82  
a1c9787dc Rafael J. Wysocki       2016-05-11   83  static inline u64 div_ext_fp(u64 x, u64 y)
a1c9787dc Rafael J. Wysocki       2016-05-11   84  {
a1c9787dc Rafael J. Wysocki       2016-05-11   85  	return div64_u64(x << EXT_FRAC_BITS, y);
a1c9787dc Rafael J. Wysocki       2016-05-11   86  }
a1c9787dc Rafael J. Wysocki       2016-05-11   87  
13ad7701f Srinivas Pandruvada     2016-04-03   88  /**
13ad7701f Srinivas Pandruvada     2016-04-03   89   * struct sample -	Store performance sample
a1c9787dc Rafael J. Wysocki       2016-05-11   90   * @core_avg_perf:	Ratio of APERF/MPERF which is the actual average
13ad7701f Srinivas Pandruvada     2016-04-03   91   *			performance during last sample period
13ad7701f Srinivas Pandruvada     2016-04-03   92   * @busy_scaled:	Scaled busy value which is used to calculate next
a1c9787dc Rafael J. Wysocki       2016-05-11   93   *			P state. This can be different than core_avg_perf
13ad7701f Srinivas Pandruvada     2016-04-03   94   *			to account for cpu idle period
13ad7701f Srinivas Pandruvada     2016-04-03   95   * @aperf:		Difference of actual performance frequency clock count
13ad7701f Srinivas Pandruvada     2016-04-03   96   *			read from APERF MSR between last and current sample
13ad7701f Srinivas Pandruvada     2016-04-03   97   * @mperf:		Difference of maximum performance frequency clock count
13ad7701f Srinivas Pandruvada     2016-04-03   98   *			read from MPERF MSR between last and current sample
13ad7701f Srinivas Pandruvada     2016-04-03   99   * @tsc:		Difference of time stamp counter between last and
13ad7701f Srinivas Pandruvada     2016-04-03  100   *			current sample
13ad7701f Srinivas Pandruvada     2016-04-03  101   * @time:		Current time from scheduler
13ad7701f Srinivas Pandruvada     2016-04-03  102   *
13ad7701f Srinivas Pandruvada     2016-04-03  103   * This structure is used in the cpudata structure to store performance sample
13ad7701f Srinivas Pandruvada     2016-04-03  104   * data for choosing next P State.
13ad7701f Srinivas Pandruvada     2016-04-03  105   */
93f0822df Dirk Brandewie          2013-02-06  106  struct sample {
a1c9787dc Rafael J. Wysocki       2016-05-11  107  	int32_t core_avg_perf;
157386b6f Philippe Longepe        2015-12-04  108  	int32_t busy_scaled;
93f0822df Dirk Brandewie          2013-02-06  109  	u64 aperf;
93f0822df Dirk Brandewie          2013-02-06  110  	u64 mperf;
4055fad34 Doug Smythies           2015-04-11  111  	u64 tsc;
a4675fbc4 Rafael J. Wysocki       2016-02-05  112  	u64 time;
93f0822df Dirk Brandewie          2013-02-06  113  };
93f0822df Dirk Brandewie          2013-02-06  114  
13ad7701f Srinivas Pandruvada     2016-04-03  115  /**
13ad7701f Srinivas Pandruvada     2016-04-03  116   * struct pstate_data - Store P state data
13ad7701f Srinivas Pandruvada     2016-04-03  117   * @current_pstate:	Current requested P state
13ad7701f Srinivas Pandruvada     2016-04-03  118   * @min_pstate:		Min P state possible for this platform
13ad7701f Srinivas Pandruvada     2016-04-03  119   * @max_pstate:		Max P state possible for this platform
13ad7701f Srinivas Pandruvada     2016-04-03  120   * @max_pstate_physical:This is physical Max P state for a processor
13ad7701f Srinivas Pandruvada     2016-04-03  121   *			This can be higher than the max_pstate which can
13ad7701f Srinivas Pandruvada     2016-04-03  122   *			be limited by platform thermal design power limits
13ad7701f Srinivas Pandruvada     2016-04-03  123   * @scaling:		Scaling factor to  convert frequency to cpufreq
13ad7701f Srinivas Pandruvada     2016-04-03  124   *			frequency units
13ad7701f Srinivas Pandruvada     2016-04-03  125   * @turbo_pstate:	Max Turbo P state possible for this platform
13ad7701f Srinivas Pandruvada     2016-04-03  126   *
13ad7701f Srinivas Pandruvada     2016-04-03  127   * Stores the per cpu model P state limits and current P state.
13ad7701f Srinivas Pandruvada     2016-04-03  128   */
93f0822df Dirk Brandewie          2013-02-06  129  struct pstate_data {
93f0822df Dirk Brandewie          2013-02-06  130  	int	current_pstate;
93f0822df Dirk Brandewie          2013-02-06  131  	int	min_pstate;
93f0822df Dirk Brandewie          2013-02-06  132  	int	max_pstate;
3bcc6fa97 Srinivas Pandruvada     2015-10-14  133  	int	max_pstate_physical;
b27580b05 Dirk Brandewie          2014-10-13  134  	int	scaling;
93f0822df Dirk Brandewie          2013-02-06  135  	int	turbo_pstate;
93f0822df Dirk Brandewie          2013-02-06  136  };
93f0822df Dirk Brandewie          2013-02-06  137  
13ad7701f Srinivas Pandruvada     2016-04-03  138  /**
13ad7701f Srinivas Pandruvada     2016-04-03  139   * struct vid_data -	Stores voltage information data
13ad7701f Srinivas Pandruvada     2016-04-03  140   * @min:		VID data for this platform corresponding to
13ad7701f Srinivas Pandruvada     2016-04-03  141   *			the lowest P state
13ad7701f Srinivas Pandruvada     2016-04-03  142   * @max:		VID data corresponding to the highest P State.
13ad7701f Srinivas Pandruvada     2016-04-03  143   * @turbo:		VID data for turbo P state
13ad7701f Srinivas Pandruvada     2016-04-03  144   * @ratio:		Ratio of (vid max - vid min) /
13ad7701f Srinivas Pandruvada     2016-04-03  145   *			(max P state - Min P State)
13ad7701f Srinivas Pandruvada     2016-04-03  146   *
13ad7701f Srinivas Pandruvada     2016-04-03  147   * Stores the voltage data for DVFS (Dynamic Voltage and Frequency Scaling)
13ad7701f Srinivas Pandruvada     2016-04-03  148   * This data is used in Atom platforms, where in addition to target P state,
13ad7701f Srinivas Pandruvada     2016-04-03  149   * the voltage data needs to be specified to select next P State.
13ad7701f Srinivas Pandruvada     2016-04-03  150   */
007bea098 Dirk Brandewie          2013-12-18  151  struct vid_data {
21855ff5b Dirk Brandewie          2014-05-08  152  	int min;
21855ff5b Dirk Brandewie          2014-05-08  153  	int max;
21855ff5b Dirk Brandewie          2014-05-08  154  	int turbo;
007bea098 Dirk Brandewie          2013-12-18  155  	int32_t ratio;
007bea098 Dirk Brandewie          2013-12-18  156  };
007bea098 Dirk Brandewie          2013-12-18  157  
13ad7701f Srinivas Pandruvada     2016-04-03  158  /**
13ad7701f Srinivas Pandruvada     2016-04-03  159   * struct _pid -	Stores PID data
13ad7701f Srinivas Pandruvada     2016-04-03  160   * @setpoint:		Target set point for busyness or performance
13ad7701f Srinivas Pandruvada     2016-04-03  161   * @integral:		Storage for accumulated error values
13ad7701f Srinivas Pandruvada     2016-04-03  162   * @p_gain:		PID proportional gain
13ad7701f Srinivas Pandruvada     2016-04-03  163   * @i_gain:		PID integral gain
13ad7701f Srinivas Pandruvada     2016-04-03  164   * @d_gain:		PID derivative gain
13ad7701f Srinivas Pandruvada     2016-04-03  165   * @deadband:		PID deadband
13ad7701f Srinivas Pandruvada     2016-04-03  166   * @last_err:		Last error storage for integral part of PID calculation
13ad7701f Srinivas Pandruvada     2016-04-03  167   *
13ad7701f Srinivas Pandruvada     2016-04-03  168   * Stores PID coefficients and last error for PID controller.
13ad7701f Srinivas Pandruvada     2016-04-03  169   */
93f0822df Dirk Brandewie          2013-02-06  170  struct _pid {
93f0822df Dirk Brandewie          2013-02-06  171  	int setpoint;
93f0822df Dirk Brandewie          2013-02-06  172  	int32_t integral;
93f0822df Dirk Brandewie          2013-02-06  173  	int32_t p_gain;
93f0822df Dirk Brandewie          2013-02-06  174  	int32_t i_gain;
93f0822df Dirk Brandewie          2013-02-06  175  	int32_t d_gain;
93f0822df Dirk Brandewie          2013-02-06  176  	int deadband;
d253d2a52 Brennan Shacklett       2013-10-21  177  	int32_t last_err;
93f0822df Dirk Brandewie          2013-02-06  178  };
93f0822df Dirk Brandewie          2013-02-06  179  
13ad7701f Srinivas Pandruvada     2016-04-03  180  /**
13ad7701f Srinivas Pandruvada     2016-04-03  181   * struct cpudata -	Per CPU instance data storage
13ad7701f Srinivas Pandruvada     2016-04-03  182   * @cpu:		CPU number for this instance data
13ad7701f Srinivas Pandruvada     2016-04-03  183   * @update_util:	CPUFreq utility callback information
4578ee7e1 Chen Yu                 2016-05-11  184   * @update_util_set:	CPUFreq utility callback is set
13ad7701f Srinivas Pandruvada     2016-04-03  185   * @pstate:		Stores P state limits for this CPU
13ad7701f Srinivas Pandruvada     2016-04-03  186   * @vid:		Stores VID limits for this CPU
13ad7701f Srinivas Pandruvada     2016-04-03  187   * @pid:		Stores PID parameters for this CPU
13ad7701f Srinivas Pandruvada     2016-04-03  188   * @last_sample_time:	Last Sample time
13ad7701f Srinivas Pandruvada     2016-04-03  189   * @prev_aperf:		Last APERF value read from APERF MSR
13ad7701f Srinivas Pandruvada     2016-04-03  190   * @prev_mperf:		Last MPERF value read from MPERF MSR
13ad7701f Srinivas Pandruvada     2016-04-03  191   * @prev_tsc:		Last timestamp counter (TSC) value
13ad7701f Srinivas Pandruvada     2016-04-03  192   * @prev_cummulative_iowait: IO Wait time difference from last and
13ad7701f Srinivas Pandruvada     2016-04-03  193   *			current sample
13ad7701f Srinivas Pandruvada     2016-04-03  194   * @sample:		Storage for storing last Sample data
9522a2ff9 Srinivas Pandruvada     2016-04-27  195   * @acpi_perf_data:	Stores ACPI perf information read from _PSS
9522a2ff9 Srinivas Pandruvada     2016-04-27  196   * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
cc2eccd40 Srinivas Pandruvada     2016-09-01  197   * @cppc_data:		Stores CPPC information for HWP capable CPUs
cc2eccd40 Srinivas Pandruvada     2016-09-01  198   * @valid_cppc_table:	Set to true for valid CPPC entries are found
13ad7701f Srinivas Pandruvada     2016-04-03  199   *
13ad7701f Srinivas Pandruvada     2016-04-03  200   * This structure stores per CPU instance data for all CPUs.
13ad7701f Srinivas Pandruvada     2016-04-03  201   */
93f0822df Dirk Brandewie          2013-02-06 @202  struct cpudata {
93f0822df Dirk Brandewie          2013-02-06  203  	int cpu;
93f0822df Dirk Brandewie          2013-02-06  204  
a4675fbc4 Rafael J. Wysocki       2016-02-05  205  	struct update_util_data update_util;
4578ee7e1 Chen Yu                 2016-05-11  206  	bool   update_util_set;
93f0822df Dirk Brandewie          2013-02-06  207  
93f0822df Dirk Brandewie          2013-02-06  208  	struct pstate_data pstate;
007bea098 Dirk Brandewie          2013-12-18  209  	struct vid_data vid;
93f0822df Dirk Brandewie          2013-02-06  210  	struct _pid pid;
93f0822df Dirk Brandewie          2013-02-06  211  
a4675fbc4 Rafael J. Wysocki       2016-02-05  212  	u64	last_sample_time;
93f0822df Dirk Brandewie          2013-02-06  213  	u64	prev_aperf;
93f0822df Dirk Brandewie          2013-02-06  214  	u64	prev_mperf;
4055fad34 Doug Smythies           2015-04-11  215  	u64	prev_tsc;
63d1d656a Philippe Longepe        2015-12-04  216  	u64	prev_cummulative_iowait;
d37e2b764 Dirk Brandewie          2014-02-12  217  	struct sample sample;
9522a2ff9 Srinivas Pandruvada     2016-04-27  218  #ifdef CONFIG_ACPI
9522a2ff9 Srinivas Pandruvada     2016-04-27  219  	struct acpi_processor_performance acpi_perf_data;
9522a2ff9 Srinivas Pandruvada     2016-04-27  220  	bool valid_pss_table;
cc2eccd40 Srinivas Pandruvada     2016-09-01  221  	struct cppc_cpudata *cppc_data;
cc2eccd40 Srinivas Pandruvada     2016-09-01  222  	bool valid_cppc_table;
9522a2ff9 Srinivas Pandruvada     2016-04-27  223  #endif
93f0822df Dirk Brandewie          2013-02-06  224  };
93f0822df Dirk Brandewie          2013-02-06  225  
93f0822df Dirk Brandewie          2013-02-06  226  static struct cpudata **all_cpu_data;
13ad7701f Srinivas Pandruvada     2016-04-03  227  
13ad7701f Srinivas Pandruvada     2016-04-03  228  /**
13ad7701f Srinivas Pandruvada     2016-04-03  229   * struct pid_adjust_policy - Stores static PID configuration data
13ad7701f Srinivas Pandruvada     2016-04-03  230   * @sample_rate_ms:	PID calculation sample rate in ms
13ad7701f Srinivas Pandruvada     2016-04-03  231   * @sample_rate_ns:	Sample rate calculation in ns
13ad7701f Srinivas Pandruvada     2016-04-03  232   * @deadband:		PID deadband
13ad7701f Srinivas Pandruvada     2016-04-03  233   * @setpoint:		PID Setpoint
13ad7701f Srinivas Pandruvada     2016-04-03  234   * @p_gain_pct:		PID proportional gain
13ad7701f Srinivas Pandruvada     2016-04-03  235   * @i_gain_pct:		PID integral gain
13ad7701f Srinivas Pandruvada     2016-04-03  236   * @d_gain_pct:		PID derivative gain
13ad7701f Srinivas Pandruvada     2016-04-03  237   *
13ad7701f Srinivas Pandruvada     2016-04-03  238   * Stores per CPU model static PID configuration data.
13ad7701f Srinivas Pandruvada     2016-04-03  239   */
93f0822df Dirk Brandewie          2013-02-06  240  struct pstate_adjust_policy {
93f0822df Dirk Brandewie          2013-02-06  241  	int sample_rate_ms;
a4675fbc4 Rafael J. Wysocki       2016-02-05  242  	s64 sample_rate_ns;
93f0822df Dirk Brandewie          2013-02-06  243  	int deadband;
93f0822df Dirk Brandewie          2013-02-06  244  	int setpoint;
93f0822df Dirk Brandewie          2013-02-06  245  	int p_gain_pct;
93f0822df Dirk Brandewie          2013-02-06  246  	int d_gain_pct;
93f0822df Dirk Brandewie          2013-02-06  247  	int i_gain_pct;
93f0822df Dirk Brandewie          2013-02-06  248  };
93f0822df Dirk Brandewie          2013-02-06  249  
13ad7701f Srinivas Pandruvada     2016-04-03  250  /**
13ad7701f Srinivas Pandruvada     2016-04-03  251   * struct pstate_funcs - Per CPU model specific callbacks
13ad7701f Srinivas Pandruvada     2016-04-03  252   * @get_max:		Callback to get maximum non turbo effective P state
13ad7701f Srinivas Pandruvada     2016-04-03  253   * @get_max_physical:	Callback to get maximum non turbo physical P state
13ad7701f Srinivas Pandruvada     2016-04-03  254   * @get_min:		Callback to get minimum P state
13ad7701f Srinivas Pandruvada     2016-04-03  255   * @get_turbo:		Callback to get turbo P state
13ad7701f Srinivas Pandruvada     2016-04-03  256   * @get_scaling:	Callback to get frequency scaling factor
13ad7701f Srinivas Pandruvada     2016-04-03  257   * @get_val:		Callback to convert P state to actual MSR write value
13ad7701f Srinivas Pandruvada     2016-04-03  258   * @get_vid:		Callback to get VID data for Atom platforms
13ad7701f Srinivas Pandruvada     2016-04-03  259   * @get_target_pstate:	Callback to a function to calculate next P state to use
13ad7701f Srinivas Pandruvada     2016-04-03  260   *
13ad7701f Srinivas Pandruvada     2016-04-03  261   * Core and Atom CPU models have different way to get P State limits. This
13ad7701f Srinivas Pandruvada     2016-04-03  262   * structure is used to store those callbacks.
13ad7701f Srinivas Pandruvada     2016-04-03  263   */
016c81508 Dirk Brandewie          2013-10-21  264  struct pstate_funcs {
016c81508 Dirk Brandewie          2013-10-21  265  	int (*get_max)(void);
3bcc6fa97 Srinivas Pandruvada     2015-10-14  266  	int (*get_max_physical)(void);
016c81508 Dirk Brandewie          2013-10-21  267  	int (*get_min)(void);
016c81508 Dirk Brandewie          2013-10-21  268  	int (*get_turbo)(void);
b27580b05 Dirk Brandewie          2014-10-13  269  	int (*get_scaling)(void);
fdfdb2b13 Rafael J. Wysocki       2016-03-18  270  	u64 (*get_val)(struct cpudata*, int pstate);
007bea098 Dirk Brandewie          2013-12-18  271  	void (*get_vid)(struct cpudata *);
157386b6f Philippe Longepe        2015-12-04  272  	int32_t (*get_target_pstate)(struct cpudata *);
93f0822df Dirk Brandewie          2013-02-06  273  };
93f0822df Dirk Brandewie          2013-02-06  274  
13ad7701f Srinivas Pandruvada     2016-04-03  275  /**
13ad7701f Srinivas Pandruvada     2016-04-03  276   * struct cpu_defaults- Per CPU model default config data
13ad7701f Srinivas Pandruvada     2016-04-03  277   * @pid_policy:	PID config data
13ad7701f Srinivas Pandruvada     2016-04-03  278   * @funcs:		Callback function data
13ad7701f Srinivas Pandruvada     2016-04-03  279   */
016c81508 Dirk Brandewie          2013-10-21  280  struct cpu_defaults {
016c81508 Dirk Brandewie          2013-10-21  281  	struct pstate_adjust_policy pid_policy;
016c81508 Dirk Brandewie          2013-10-21  282  	struct pstate_funcs funcs;
016c81508 Dirk Brandewie          2013-10-21  283  };
016c81508 Dirk Brandewie          2013-10-21  284  
157386b6f Philippe Longepe        2015-12-04  285  static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
e70eed2b6 Philippe Longepe        2015-12-04  286  static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
157386b6f Philippe Longepe        2015-12-04  287  
4a7cb7a96 Jisheng Zhang           2016-06-27  288  static struct pstate_adjust_policy pid_params __read_mostly;
4a7cb7a96 Jisheng Zhang           2016-06-27  289  static struct pstate_funcs pstate_funcs __read_mostly;
4a7cb7a96 Jisheng Zhang           2016-06-27  290  static int hwp_active __read_mostly;
016c81508 Dirk Brandewie          2013-10-21  291  
9522a2ff9 Srinivas Pandruvada     2016-04-27  292  #ifdef CONFIG_ACPI
9522a2ff9 Srinivas Pandruvada     2016-04-27  293  static bool acpi_ppc;
9522a2ff9 Srinivas Pandruvada     2016-04-27  294  #endif
13ad7701f Srinivas Pandruvada     2016-04-03  295  
13ad7701f Srinivas Pandruvada     2016-04-03  296  /**
13ad7701f Srinivas Pandruvada     2016-04-03  297   * struct perf_limits - Store user and policy limits
13ad7701f Srinivas Pandruvada     2016-04-03  298   * @no_turbo:		User requested turbo state from intel_pstate sysfs
13ad7701f Srinivas Pandruvada     2016-04-03  299   * @turbo_disabled:	Platform turbo status either from msr
13ad7701f Srinivas Pandruvada     2016-04-03  300   *			MSR_IA32_MISC_ENABLE or when maximum available pstate
13ad7701f Srinivas Pandruvada     2016-04-03  301   *			matches the maximum turbo pstate
13ad7701f Srinivas Pandruvada     2016-04-03  302   * @max_perf_pct:	Effective maximum performance limit in percentage, this
13ad7701f Srinivas Pandruvada     2016-04-03  303   *			is minimum of either limits enforced by cpufreq policy
13ad7701f Srinivas Pandruvada     2016-04-03  304   *			or limits from user set limits via intel_pstate sysfs
13ad7701f Srinivas Pandruvada     2016-04-03  305   * @min_perf_pct:	Effective minimum performance limit in percentage, this
13ad7701f Srinivas Pandruvada     2016-04-03  306   *			is maximum of either limits enforced by cpufreq policy
13ad7701f Srinivas Pandruvada     2016-04-03  307   *			or limits from user set limits via intel_pstate sysfs
13ad7701f Srinivas Pandruvada     2016-04-03  308   * @max_perf:		This is a scaled value between 0 to 255 for max_perf_pct
13ad7701f Srinivas Pandruvada     2016-04-03  309   *			This value is used to limit max pstate
13ad7701f Srinivas Pandruvada     2016-04-03  310   * @min_perf:		This is a scaled value between 0 to 255 for min_perf_pct
13ad7701f Srinivas Pandruvada     2016-04-03  311   *			This value is used to limit min pstate
13ad7701f Srinivas Pandruvada     2016-04-03  312   * @max_policy_pct:	The maximum performance in percentage enforced by
13ad7701f Srinivas Pandruvada     2016-04-03  313   *			cpufreq setpolicy interface
13ad7701f Srinivas Pandruvada     2016-04-03  314   * @max_sysfs_pct:	The maximum performance in percentage enforced by
13ad7701f Srinivas Pandruvada     2016-04-03  315   *			intel pstate sysfs interface
13ad7701f Srinivas Pandruvada     2016-04-03  316   * @min_policy_pct:	The minimum performance in percentage enforced by
13ad7701f Srinivas Pandruvada     2016-04-03  317   *			cpufreq setpolicy interface
13ad7701f Srinivas Pandruvada     2016-04-03  318   * @min_sysfs_pct:	The minimum performance in percentage enforced by
13ad7701f Srinivas Pandruvada     2016-04-03  319   *			intel pstate sysfs interface
13ad7701f Srinivas Pandruvada     2016-04-03  320   *
13ad7701f Srinivas Pandruvada     2016-04-03  321   * Storage for user and policy defined limits.
13ad7701f Srinivas Pandruvada     2016-04-03  322   */
93f0822df Dirk Brandewie          2013-02-06  323  struct perf_limits {
93f0822df Dirk Brandewie          2013-02-06  324  	int no_turbo;
dd5fbf70f Dirk Brandewie          2014-06-20  325  	int turbo_disabled;
93f0822df Dirk Brandewie          2013-02-06  326  	int max_perf_pct;
93f0822df Dirk Brandewie          2013-02-06  327  	int min_perf_pct;
93f0822df Dirk Brandewie          2013-02-06  328  	int32_t max_perf;
93f0822df Dirk Brandewie          2013-02-06  329  	int32_t min_perf;
d8f469e9c Dirk Brandewie          2013-05-07  330  	int max_policy_pct;
d8f469e9c Dirk Brandewie          2013-05-07  331  	int max_sysfs_pct;
a04759924 Kristen Carlson Accardi 2015-01-29  332  	int min_policy_pct;
a04759924 Kristen Carlson Accardi 2015-01-29  333  	int min_sysfs_pct;
93f0822df Dirk Brandewie          2013-02-06  334  };
93f0822df Dirk Brandewie          2013-02-06  335  
51443fbf3 Prarit Bhargava         2015-10-15  336  static struct perf_limits performance_limits = {
51443fbf3 Prarit Bhargava         2015-10-15  337  	.no_turbo = 0,
51443fbf3 Prarit Bhargava         2015-10-15  338  	.turbo_disabled = 0,
51443fbf3 Prarit Bhargava         2015-10-15  339  	.max_perf_pct = 100,
51443fbf3 Prarit Bhargava         2015-10-15  340  	.max_perf = int_tofp(1),
51443fbf3 Prarit Bhargava         2015-10-15  341  	.min_perf_pct = 100,
51443fbf3 Prarit Bhargava         2015-10-15  342  	.min_perf = int_tofp(1),
51443fbf3 Prarit Bhargava         2015-10-15  343  	.max_policy_pct = 100,
51443fbf3 Prarit Bhargava         2015-10-15  344  	.max_sysfs_pct = 100,
51443fbf3 Prarit Bhargava         2015-10-15  345  	.min_policy_pct = 0,
51443fbf3 Prarit Bhargava         2015-10-15  346  	.min_sysfs_pct = 0,
51443fbf3 Prarit Bhargava         2015-10-15  347  };
51443fbf3 Prarit Bhargava         2015-10-15  348  
51443fbf3 Prarit Bhargava         2015-10-15  349  static struct perf_limits powersave_limits = {
93f0822df Dirk Brandewie          2013-02-06  350  	.no_turbo = 0,
4521e1a0c Gabriele Mazzotta       2014-10-13  351  	.turbo_disabled = 0,
93f0822df Dirk Brandewie          2013-02-06  352  	.max_perf_pct = 100,
93f0822df Dirk Brandewie          2013-02-06  353  	.max_perf = int_tofp(1),
93f0822df Dirk Brandewie          2013-02-06  354  	.min_perf_pct = 0,
93f0822df Dirk Brandewie          2013-02-06  355  	.min_perf = 0,
d8f469e9c Dirk Brandewie          2013-05-07  356  	.max_policy_pct = 100,
d8f469e9c Dirk Brandewie          2013-05-07  357  	.max_sysfs_pct = 100,
a04759924 Kristen Carlson Accardi 2015-01-29  358  	.min_policy_pct = 0,
a04759924 Kristen Carlson Accardi 2015-01-29  359  	.min_sysfs_pct = 0,
93f0822df Dirk Brandewie          2013-02-06  360  };
93f0822df Dirk Brandewie          2013-02-06  361  
51443fbf3 Prarit Bhargava         2015-10-15  362  #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
51443fbf3 Prarit Bhargava         2015-10-15  363  static struct perf_limits *limits = &performance_limits;
51443fbf3 Prarit Bhargava         2015-10-15  364  #else
51443fbf3 Prarit Bhargava         2015-10-15  365  static struct perf_limits *limits = &powersave_limits;
51443fbf3 Prarit Bhargava         2015-10-15  366  #endif
51443fbf3 Prarit Bhargava         2015-10-15  367  
9522a2ff9 Srinivas Pandruvada     2016-04-27  368  #ifdef CONFIG_ACPI
cc2eccd40 Srinivas Pandruvada     2016-09-01  369  static cpumask_t cppc_rd_cpu_mask;
cc2eccd40 Srinivas Pandruvada     2016-09-01  370  
cc2eccd40 Srinivas Pandruvada     2016-09-01  371  /* Call set_sched_itmt from a work function to be able to use hotplug locks */
cc2eccd40 Srinivas Pandruvada     2016-09-01  372  static void intel_pstste_sched_itmt_work_fn(struct work_struct *work)
cc2eccd40 Srinivas Pandruvada     2016-09-01  373  {
cc2eccd40 Srinivas Pandruvada     2016-09-01  374  	set_sched_itmt(true);
cc2eccd40 Srinivas Pandruvada     2016-09-01  375  }
cc2eccd40 Srinivas Pandruvada     2016-09-01  376  
cc2eccd40 Srinivas Pandruvada     2016-09-01  377  static DECLARE_WORK(sched_itmt_work, intel_pstste_sched_itmt_work_fn);
2b3ec7650 Srinivas Pandruvada     2016-04-27  378  
2b3ec7650 Srinivas Pandruvada     2016-04-27  379  static bool intel_pstate_get_ppc_enable_status(void)
2b3ec7650 Srinivas Pandruvada     2016-04-27  380  {
2b3ec7650 Srinivas Pandruvada     2016-04-27  381  	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
2b3ec7650 Srinivas Pandruvada     2016-04-27  382  	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
2b3ec7650 Srinivas Pandruvada     2016-04-27  383  		return true;
2b3ec7650 Srinivas Pandruvada     2016-04-27  384  
2b3ec7650 Srinivas Pandruvada     2016-04-27  385  	return acpi_ppc;
2b3ec7650 Srinivas Pandruvada     2016-04-27  386  }
2b3ec7650 Srinivas Pandruvada     2016-04-27  387  
9522a2ff9 Srinivas Pandruvada     2016-04-27  388  static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
9522a2ff9 Srinivas Pandruvada     2016-04-27  389  {
9522a2ff9 Srinivas Pandruvada     2016-04-27  390  	struct cpudata *cpu;
9522a2ff9 Srinivas Pandruvada     2016-04-27  391  	int ret;
9522a2ff9 Srinivas Pandruvada     2016-04-27  392  	int i;
9522a2ff9 Srinivas Pandruvada     2016-04-27  393  
cc2eccd40 Srinivas Pandruvada     2016-09-01  394  	cpu = all_cpu_data[policy->cpu];
cc2eccd40 Srinivas Pandruvada     2016-09-01  395  
cc2eccd40 Srinivas Pandruvada     2016-09-01  396  	if (hwp_active) {
cc2eccd40 Srinivas Pandruvada     2016-09-01  397  		struct cppc_perf_caps *perf_caps;
cc2eccd40 Srinivas Pandruvada     2016-09-01  398  
cc2eccd40 Srinivas Pandruvada     2016-09-01 @399  		cpu->cppc_data = kzalloc(sizeof(struct cppc_cpudata),
cc2eccd40 Srinivas Pandruvada     2016-09-01  400  					 GFP_KERNEL);
cc2eccd40 Srinivas Pandruvada     2016-09-01  401  		if (!cpu->cppc_data)
e59a8f7ff Srinivas Pandruvada     2016-05-04  402  			return;

:::::: The code at line 202 was first introduced by commit
:::::: 93f0822dff5dae2f0a2645f16300c14af41ca777 cpufreq/x86: Add P-state driver for sandy bridge.

:::::: TO: Dirk Brandewie <dirk.brandewie@gmail.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--X1bOJ3K7DJ5YkBrT
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
w+X/B5jygWF6awMA

--X1bOJ3K7DJ5YkBrT--
