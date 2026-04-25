Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1801E399001;
	Sat, 25 Apr 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142880; cv=none; b=qJIyYO26bTfUzR62k2uPTE5KskibAzH/0tR9JxnU3Oy/qRHBMPQIvMiIV8jHgoiXmt6p3M8IPfw7/Ig9SURWqYfoKdffGKue0tQKyYH4vuGr1BnEDnaoGG6MIKSXb296xI2+DbsZtiqR6xzm4dYp4YgLNkp09+umN50tAeX1kv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142880; c=relaxed/simple;
	bh=G+R1+P5h1NDgoPXLaDRukokl/KQiXVqMxUxdhcABpeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urOOkjxwXpT7eBwLTnUzxEjMRs6v75aPL4lpKUwrD2LBcRHNb+doiFx6XR11GJz+E5+oB9BkdL2BtqTmlY9new4lRA9zjYJDQDKMBPCI9+6elBtm9lkmoaTLinbtRk4RabCnKrKuzFuge2sHLuM8+cuLlBm8/qpi/6H+SLgxSNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P290PV1z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P290PV1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E45C2BCB0;
	Sat, 25 Apr 2026 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142879;
	bh=G+R1+P5h1NDgoPXLaDRukokl/KQiXVqMxUxdhcABpeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=P290PV1zPfUx1gK+iPg5nNWfHabBLsQdDMi5/zP3TX15frKXcL0Hbxn24qkmMA2dt
	 grjTUiWWuO7KUTcmcltyNowwVC3wngZ4JUbUEDVPZpQ77ztScCeeU0rDbeJ71lJqjt
	 Ibr+9vGoEA4ccOzGNRFbx/zTmDALiC1YzZZdLe737gQ0VsPc+FSVPftoFUrZKN58V3
	 xoP53+CncfqjCybVLhQsrc8zkfuLSvD+9+6QqQCbzjKjmOBpAdmkHMWvzCE2B9VVJl
	 NVHAagh8rbBoQsM5F9vU0V08BPgzI2LOXQ82f950PPQsFWctrYUdDp4UqxGsF6LewV
	 T7mDM7OAwaa1Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] tools/power x86_energy_perf_policy.8: Document SoC Slider Options
Date: Sat, 25 Apr 2026 14:42:15 -0400
Message-ID: <18c5b9ea4ea4be5ed9b5b6add30a2a7911326224.1777141988.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
References: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

x86_energy_perf_policy accesses the SoC Slider via standard
user/kernel APIs to the processor_thermal_soc_slider driver.

Machines that support SoC Slider largely use it instead of EPP,
which may continue to exist in a diminished role, or vanish entirely.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.8                  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
index 0aa981c18e56..836553e9a92c 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
@@ -15,6 +15,8 @@ x86_energy_perf_policy \- Manage Energy vs. Performance Policy
 .br
 .RB "other: (\-\-force | \-\-hwp-enable | \-\-turbo-enable)  value)"
 .br
+.RB "soc-slider: --soc-slider-balance # | --soc-slider-offset # | --platform-profile <name>"
+.br
 .RB "value: # | default | performance | balance-performance | balance-power | power"
 .SH DESCRIPTION
 \fBx86_energy_perf_policy\fP
@@ -154,6 +156,26 @@ level on this processor, specified in multiples of 100 MHz.
 in the sliding window that HWP uses to maintain average frequency.
 This parameter is meaningful only when the "desired" field above is non-zero.
 Default is 0, allowing the HW to choose.
+.SH SOC SLIDER OPTIONS
+.PP
+Note that the Platform Profile Name must be "SoC Slider", and the
+Platform Profile must be "balanced" for the --soc-slider-balance
+and --soc-slider-offset options to take effect.
+.PP
+\fB--soc-slider-balance #\fP write numeric value to the SoC Slider.
+Values range from 0 to 6.
+Lower values result in higher performance,
+and higher values improve energy efficiency.
+Actual values are model specific.
+.PP
+\fB--soc-slider-offset #\fP write the numeric value to the Soc Slider Offset.
+The slider offset is the maximum value that software allows the SoC to
+autonomously add to the SoC Slider to improve energy efficiency.
+The value 0 prohibits the SoC from autonomously changing the slider.
+.PP
+\fB--platform-profile <name>"\fP set the platform profile to <name>.
+Available choices are in platform-profile-0/choices.  The Soc Slider
+driver currently supports "low-power", "balanced", and "performance".
 .SH OTHER OPTIONS
 .PP
 \fB-f, --force\fP writes the specified values without bounds checking.
@@ -208,6 +230,10 @@ runs only as root.
 EPB: /sys/devices/system/cpu/cpu*/power/energy_perf_bias
 EPP: /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
 MSR: /dev/cpu/*/msr
+Platform Profile Name: /sys/class/platform-profile/platform-profile-0/name
+Platform Profile: /sys/class/platform-profile/platform-profile-0/profile
+SOC Slider Balanced: /sys/module/processor_thermal_soc_slider/parameters/slider_balance
+SOC Slider Balanced Offset: /sys/module/processor_thermal_soc_slider/parameters/slider_offset
 .fi
 .SH "SEE ALSO"
 .nf
-- 
2.45.2

