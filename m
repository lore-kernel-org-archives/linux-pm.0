From: Igor Stoppa <igor.stoppa@gmail.com>
Subject: Build error in drivers/cpufreq/intel_pstate.c
Date: Tue, 30 Oct 2018 18:00:52 +0200
Message-ID: <e176a41a-eb24-7f2c-bb75-a9b18eab420f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,
I'm getting the following build error:

/home/igor/dev/kernel/linux/drivers/cpufreq/intel_pstate.c: In function 
‘show_base_frequency’:
/home/igor/dev/kernel/linux/drivers/cpufreq/intel_pstate.c:726:10: 
error: implicit declaration of function 
‘intel_pstate_get_cppc_guranteed’; did you mean ‘intel_pstate_get_epp’? 
[-Werror=implicit-function-declaration]
   ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           intel_pstate_get_epp



on top of:

commit 11743c56785c751c087eecdb98713eef796609e0
Merge: 929e134c43c9 928002a5e9da

--
igor
