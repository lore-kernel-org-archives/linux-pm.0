Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A293F0775
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091036; cv=none; b=rVTF6qFhUd2XIbNO5NnErVVck+PX6cFxVy5j4P6ROs+q4syeoX3djVoHAsX7XjAtPwH0vm4HjEWnAXeEPevZu6P7tG9eYTryH8Vo/Tsph9zo9co4Lp4Phig78qBPWuxfJUeLogfYh6jsnWV5/W0IYMMyZeeDji8On9q9GzgN958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091036; c=relaxed/simple;
	bh=jd31RYFzQU0URhnPGlL2rbPUQervEbd6tI7V3VQntLE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Oxp1Ow31CWXMUm96xSfbC/4/PRYzDRrg2x0ktJYCRHG6h18LdUq1ATSu05QLsN9AGd8n51aHYHX6o4qNY4E45vB4ZicHvcw6AJVTex2BPDQRRYbBI5tuRLoXmpfqILYAscQp0l6dkDh+7rwhXrKmrhAtp4RXqgvAyUlWEUJGefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVuseEiz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVuseEiz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6175C2BCB0
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778091035;
	bh=jd31RYFzQU0URhnPGlL2rbPUQervEbd6tI7V3VQntLE=;
	h=From:To:Subject:Date:From;
	b=dVuseEiz970PqX7U/1OoCUlM6VcAs14mkadzGcCzjJrBAf0oo0+7wkbbyuN90SvuJ
	 T3nuDnzk9oOR4Axnq7dKDTrXl5HFbxtbjvDgtu9la5wusM2z4stsSN+bkjzaQ11cO+
	 nV9wSdeK3P+tR1a5e4y6JBBO64XrFHzEB1w1iGdlls69E0BnKN6A81KmcMEGWEtIBZ
	 OcLTrUxI3zK5KlOvsYnPWxMvRIM+t115Q05ztCVn8SN8Aoc+QxGimKuFG8mBHXUmn4
	 eyb3bHK/MkO4exPl40TpdKgi5OBEMIH5HK8rEh7GIqNkxY9vryIG0kin4RsP9itOcr
	 xjsWaFElL0DYQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AA4A3C41616; Wed,  6 May 2026 18:10:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221473] New: amd-pstate dynamic EPP regression on Ryzen 5 3600
Date: Wed, 06 May 2026 18:10:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stuartmeckle@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cc cf_regression cf_bisect_commit
 attachments.created
Message-ID: <bug-221473-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221473

            Bug ID: 221473
           Summary: amd-pstate dynamic EPP regression on Ryzen 5 3600
           Product: Power Management
           Version: 2.5
    Kernel Version: 7.1.0-rc2
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: stuartmeckle@gmail.com
                CC: mario.limonciello@amd.com
        Regression: Yes
           Bisected e30ca6dd5345c5b8ba05f346a8e81105352fe571
         commit-id:

Created attachment 310042
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310042&action=3Dedit
dmesg and config

amd-pstate dynamic EPP regression on Ryzen 5 3600

My CPU which normally boosts to 4.0GHz (PBO enabled) was stuck at 1.7GHz un=
der
full load. Same result with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP set to either=
 'y'
or 'n'. I bisected to this commit:

commit e30ca6dd5345c5b8ba05f346a8e81105352fe571
Author: Mario Limonciello (AMD) <superm1@kernel.org>

    cpufreq/amd-pstate: Add dynamic energy performance preference


Arch Linux
Linux version 7.1.0-rc2-00099-gadc1e5c6203c (stuart@romano) (gcc (GCC) 16.1=
.1
20260430, GNU ld (GNU Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Wed May  6
15:30:26 UTC 2026
Gigabyte Technology Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F67 10/28/2025
Advanced Micro Devices, Inc. [AMD/ATI] Navi 44 [Radeon RX 9060 XT] (rev c0)
AMD Ryzen 5 3600 6-Core Processor
32GB DDR4 DRAM F4-3000C16-8GVRB


CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
CONFIG_X86_AMD_PSTATE=3Dy
CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=3Dy
CONFIG_X86_AMD_PSTATE_UT=3Dm


=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus <=3D=3D
0
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_highest_perf <=3D=3D
166
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_hw_prefcore <=3D=3D
enabled
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_lowest_nonlinear_fr=
eq <=3D=3D
1723944
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_max_freq <=3D=3D
4208451
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_prefcore_ranking <=
=3D=3D
171
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/boost <=3D=3D
1
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_avg_freq <=3D=3D
1723944
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq <=3D=3D
4208451
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq <=3D=3D
557747
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency <=
=3D=3D
0
=3D=3D>
/sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferenc=
es
<=3D=3D
default performance balance_performance balance_power power custom
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference =
<=3D=3D
performance
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/related_cpus <=3D=3D
0
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors <=
=3D=3D
performance powersave
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq <=3D=3D
1736801
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver <=3D=3D
amd-pstate-epp
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor <=3D=3D
powersave
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq <=3D=3D
4208451
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq <=3D=3D
1723944
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed <=3D=3D
<unsupported>

For comparison, here are the same settings on kernel 7.0.3-arch1-2:

=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus <=3D=3D
0
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_highest_perf <=3D=3D
166
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_hw_prefcore <=3D=3D
enabled
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_lowest_nonlinear_fr=
eq <=3D=3D
1723944
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_max_freq <=3D=3D
4208451
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_prefcore_ranking <=
=3D=3D
171
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/boost <=3D=3D
1
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_avg_freq <=3D=3D
3656148
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq <=3D=3D
4208451
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq <=3D=3D
557747
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency <=
=3D=3D
0
=3D=3D>
/sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferenc=
es
<=3D=3D
default performance balance_performance balance_power power
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference =
<=3D=3D
balance_performance
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/related_cpus <=3D=3D
0
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors <=
=3D=3D
performance powersave
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq <=3D=3D
3693566
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver <=3D=3D
amd-pstate-epp
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor <=3D=3D
powersave
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq <=3D=3D
4208451
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq <=3D=3D
1723944
=3D=3D> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed <=3D=3D
<unsupported>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
