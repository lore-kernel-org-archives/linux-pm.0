Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25BE0CE;
	Mon, 27 Nov 2023 08:08:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D2162F4;
	Mon, 27 Nov 2023 08:09:46 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D48D3F6C4;
	Mon, 27 Nov 2023 08:08:57 -0800 (PST)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	sumitg@nvidia.com
Cc: sudeep.holla@arm.covm,
	will@kernel.org,
	catalin.marinas@arm.com,
	viresh.kumar@linaro.org,
	rafael@kernel.org,
	ionela.voinescu@arm.com,
	yang@os.amperecomputing.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for AArch64 AMUv1-based arch_freq_get_on_cpu
Date: Mon, 27 Nov 2023 16:08:36 +0000
Message-Id: <20231127160838.1403404-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing AArch64 specific version of arch_freq_get_on_cpu, cashing on
existing implementation for FIE and AMUv1 support.
Additionally wiring it up with cpufreq_verify_current_freq to hopefully
eliminate issues when cpufreq_driver->get() returns frequency that is not
entirely aligned.

The changes have been rather lightly (due to some limitations) tested on
an FVP model.

v2:
- Splitting the patches
- Adding comment for full dyntick mode
- Plugging arch_freq_get_on_cpu into cpufreq_verify_current_freq instead
  of in show_cpuinfo_cur_freq to allow the framework to stay more in sync
  with potential freq changes

[1]
https://lore.kernel.org/lkml/20230606155754.245998-1-beata.michalska@arm.com/


Beata Michalska (1):
  arm64: Provide an AMU-based version of arch_freq_get_on_cpu

Sumit Gupta (1):
  cpufreq: Wire-up arch-flavored freq info into
    cpufreq_verify_current_freq

 arch/arm64/kernel/topology.c | 39 ++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq.c    |  3 ++-
 2 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.25.1

