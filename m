From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 6/8] acpi: bus: Enable HWP CPPC objects
Date: Thu, 01 Sep 2016 16:46:17 -0700
Message-ID: <1472773577.5025.47.camel@linux.intel.com>
References: <201609020709.8zHryPZ7%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6839 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750697AbcIAXqS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Sep 2016 19:46:18 -0400
In-Reply-To: <201609020709.8zHryPZ7%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com

On Fri, 2016-09-02 at 07:15 +0800, kbuild test robot wrote:
> Hi Srinivas,
> 
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on v4.8-rc4 next-20160825]
> [cannot apply to tip/x86/core]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --
> base=auto for convenience) to record what (public, well-known) commit
> your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more
> information]
> 
> url:    https://github.com/0day-ci/linux/commits/Srinivas-Pandruvada/
> Support-Intel-Turbo-Boost-Max-Technology-3-0/20160902-053224
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tes
> ts.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/acpi/bus.c: In function 'acpi_bus_osc_support':
> > 
> > > 
> > > drivers/acpi/bus.c:333:32: error: implicit declaration of
> > > function 'boot_cpu_has' [-Werror=implicit-function-declaration]
>      if (IS_ENABLED(CONFIG_X86) && boot_cpu_has(X86_FEATURE_HWP)) {
>                                    ^
I have to change back to 
#ifdef CONFIG_X86
 if (boot_cpu_has(X86_FEATURE_HWP)) {

I will submit an update.

> > 
> > > 
> > > drivers/acpi/bus.c:333:45: error: 'X86_FEATURE_HWP' undeclared
> > > (first use in this function)
>      if (IS_ENABLED(CONFIG_X86) && boot_cpu_has(X86_FEATURE_HWP)) {
>                                                 ^
>    drivers/acpi/bus.c:333:45: note: each undeclared identifier is
> reported only once for each function it appears in
>    cc1: some warnings being treated as errors
> 
> vim +/boot_cpu_has +333 drivers/acpi/bus.c
> 
>    327		if (IS_ENABLED(CONFIG_ACPI_PROCESSOR))
>    328			capbuf[OSC_SUPPORT_DWORD] |=
> OSC_SB_PPC_OST_SUPPORT;
>    329	
>    330		capbuf[OSC_SUPPORT_DWORD] |=
> OSC_SB_HOTPLUG_OST_SUPPORT;
>    331		capbuf[OSC_SUPPORT_DWORD] |=
> OSC_SB_PCLPI_SUPPORT;
>    332	
>  > 333		if (IS_ENABLED(CONFIG_X86) &&
> boot_cpu_has(X86_FEATURE_HWP)) {
>    334			capbuf[OSC_SUPPORT_DWORD] |=
> OSC_SB_CPC_SUPPORT;
>    335			capbuf[OSC_SUPPORT_DWORD] |=
> OSC_SB_CPCV2_SUPPORT;
>    336		}
> 
> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
