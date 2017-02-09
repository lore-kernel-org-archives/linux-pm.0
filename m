From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2 v2] cpufreq: qoriq: added arm64 socs support
Date: Thu, 09 Feb 2017 01:00:16 +0100
Message-ID: <4804946.bZzESQTVmR@aspire.rjw.lan>
References: <201702090419.Fn6qZqnq%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201702090419.Fn6qZqnq%fengguang.wu@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: yuantian.tang@nxp.com
Cc: kbuild test robot <lkp@intel.com>, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, Tang Yuantian <Yuantian.Tang@nxp.com>, kbuild-all@01.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thursday, February 09, 2017 04:51:46 AM kbuild test robot wrote:
> Hi Tang,
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.10-rc7 next-20170208]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

Please fix this.

Thanks,
Rafael


> url:    https://github.com/0day-ci/linux/commits/yuantian-tang-nxp-com/cpufreq-qoriq-added-arm64-socs-support/20170208-163748
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> Note: the linux-review/yuantian-tang-nxp-com/cpufreq-qoriq-added-arm64-socs-support/20170208-163748 HEAD bf166f8dd442ff4715f94496bc14e12a1d0778f1 builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/cpufreq/qoriq-cpufreq.c: In function 'get_cpu_physical_id':
> >> drivers/cpufreq/qoriq-cpufreq.c:83:9: error: implicit declaration of function 'get_hard_smp_processor_id' [-Werror=implicit-function-declaration]
>      return get_hard_smp_processor_id(cpu);
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/get_hard_smp_processor_id +83 drivers/cpufreq/qoriq-cpufreq.c
> 
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  67  /*
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  68   * the minimum allowed core frequency, in Hz
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  69   * for chassis v1.0, >= platform frequency
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  70   * for chassis v2.0, >= platform frequency / 2
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  71   */
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  72  static u32 min_cpufreq;
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  73  static const u32 *fmask;
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  74  
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  75  #if defined(CONFIG_ARM)
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  76  static int get_cpu_physical_id(int cpu)
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  77  {
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  78  	return topology_core_id(cpu);
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  79  }
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  80  #else
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  81  static int get_cpu_physical_id(int cpu)
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  82  {
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13 @83  	return get_hard_smp_processor_id(cpu);
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  84  }
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  85  #endif
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  86  
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  87  static u32 get_bus_freq(void)
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  88  {
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  89  	struct device_node *soc;
> a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  90  	u32 sysfreq;
> defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  91  
> 
> :::::: The code at line 83 was first introduced by commit
> :::::: a4f207428b53975069d12d49a509b440c707d691 cpufreq: qoriq: Make the driver usable on all QorIQ platforms
> 
> :::::: TO: Tang Yuantian <Yuantian.Tang@freescale.com>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
