From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 04/11] sched,x86: Enable Turbo Boost Max Technology
Date: Mon, 22 Aug 2016 12:04:12 -0700
Message-ID: <20160822190412.GA27546@linux.intel.com>
References: <1471559812-19967-5-git-send-email-srinivas.pandruvada@linux.intel.com>
 <201608221707.jlJguIhg%fengguang.wu@intel.com>
Reply-To: tim.c.chen@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201608221707.jlJguIhg%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, kbuild-all@01.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 22, 2016 at 05:01:15PM +0800, kbuild test robot wrote:
> Hi Tim,
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.8-rc3 next-20160822]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/Srinivas-Pandruvada/Support-Intel-Turbo-Boost-Max-Technology-3-0/20160819-101955
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 

Should be fixed by the patch below.  Will incorporate the fix in next
rev of the patch series.

Tim

---

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index f148843..bcf3e85 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -147,6 +147,8 @@ int x86_pci_root_bus_node(int bus);
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
 #ifdef CONFIG_SCHED_ITMT
+#include <asm/percpu.h>
+
 DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
 
 static inline bool sched_asym_prefer(int a, int b)
