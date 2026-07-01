Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DFC48A2A1;
	Wed,  1 Jul 2026 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910685; cv=none; b=szHB0fcku0ijFYKsR1GNEIgrIM9BDziI1OqtuRuXMdWtmlu63LeG3exthZk4HD0LCsD9bqPsXL/J8btkxLBFB32oula/DCqIW0XhXA2oHrd1fI+K8opSdNguK3jOgK8/ul8Gqk7Slq6Ar19M47xb+7QVem8nwuy2V+gYDF7f1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910685; c=relaxed/simple;
	bh=OW1yanwv+0ixyNeEd7kxlbVmpODlAcEqvXTlW8AAbpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qKt99gtIix5EvGY0/1xnt7BtZOflkzJfiJJdMrOOjG+jzgEPWVhXvr4+j3jHQK2Iy25Xj9BdPVdx7ETUfevMZb/77DbNFqa0FQCqt35JOGJEDWhMuJkegVu8f741thyJIFEz/hutAmvJT06yVO8lewQ+7nEvW04RLguGvqPrsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sYjFR/sA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sYjFR/sA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A429B2309;
	Wed,  1 Jul 2026 05:57:58 -0700 (PDT)
Received: from oss-apollo7005.oss.cambridge.arm.com (oss-apollo7005.oss.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7E343F85F;
	Wed,  1 Jul 2026 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782910683; bh=OW1yanwv+0ixyNeEd7kxlbVmpODlAcEqvXTlW8AAbpI=;
	h=From:To:Cc:Subject:Date:From;
	b=sYjFR/sA2H2wbPSkz1r8hDsDIe4Npzo940YP37bKLLLqfXzB+X91Y08nxdf7tF3oK
	 Ei5m6VHvlAuvIWlmHTGZtaXk/isH+MUbByy2kMsAN0xreY4nxKLFIQspwXLqJ9+E1N
	 kLNvaS0xw+PCB53wRbVmLUSqT7cwnljUrxKeUbzY=
From: Philip Radford <philip.radford@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v8 00/13] Add support for SCMIv4.0 Powercap Extensions
Date: Wed,  1 Jul 2026 12:57:34 +0000
Message-Id: <20260701125747.407921-1-philip.radford@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I will be taking over this series from Cristian and in doing so I have
addressed a couple of issues raised by the first version and added six
additional patches since Cristian's original series:

[1/13] addresses an omission from the original powercap functionality. The
ABI documentation describes allowing enabling and disabling power capping
for a control type via /sys/class/powercap/<control type>/enabled. This
first patch implements this functionality but as stated before, this was an
omission rather than a bug that requires fixing. Disabling the control type
disables any immediate children of the control type.

The logic for this patch is based on the logic I was using for enabling and
disabling the synthetic node in the final patch of this series. As a result,
the synthetic node enable/disable patch has now been significantly reduced.

[7/13] exposes the measurement averaging interval (MAI) value when the
agent has registered to receive power measurement change notifications
for the power capping domain.

[10/13] adds MAI get and set support for the powercap protocol.

[11/13] introduces a synthetic root zone to act as a common parent for all
top-level domains.

[12/13] adds get_power_uw to synthetic root zone, summing the per-zone
power of immediate child zones.

[13/13] adds enable/disable functionality to synthetic root zone to
enable/disable immediate children.

The original series was based on v6.17-rc1 whereas this version has been
based on v7.2-rc1.

The rest of Cristian's series is explained below;

SCMIv4.0 [1] introduces some new features and commands into the Powercap
protocol. In a nutshell, such protocol changes add support for:

 - setting multiple powercap limit/interval constraints for each SCMI
   powercap domain which supports multiple Concurrent Power Limit
 - enabling more Powercap commands to use Fastchannels mechanism
 - adding multiple constraints support to the existing notifications

After a bit of needed updates in the SCMI core this series adds:

- support for the idea of optional multiple Concurrent Power Limit (CPLs)
- support for the new FCs
- support for extended notifications
- enable usage of such multiple constraint in the ARM SCMI Powercap driver

Note that the public SCMIv4.0 spec at [1] is currently still BETA0, so
this series could anyway need some minor rework along the way and
definitely will need to wait for a final public release before being
possibly merged.

Tested on a single and multi-instance scenario on an emulated setup
implementing the new protocol extensions.

Based on v7.2-rc1.

Thanks,
Phil
---
V7->V8
- Rebased on v7.2-rc1
- Fixed conflict due to updates to v7.2
V6->V7
- Added control type enable/disable patch
- Refactored Synthetic zone enable disable patch
- Corrected naming of define V2/V3 payload sizes
- Prevent possible cpli[0] out-of-bounds access
- Added cleanup for zones during scmi_powercap_probe
- Prevent instance_root_get_enable reporting a stale state
- Rebased on v7.1-rc7
V5->V6
- Re-worded existing comment for POWERCAP_MEASUREMENTS_NOTIFY
- Added define for V2/V3 payload sizes
- Used new definitions for payload sizes
- Fixed comment length
- Changed warning message warning
- Fixed line lengths and alignment
- Updated docs for new fields
- Amended omission of spz initialization when unregistering powercap zones
- Tested unloading and loading powercap module
- Re-wrote commit message
- Added use of to_scmi_powercap_root macro
- Changed instance_root_set_enable_state to bail out on any error
V4->V5
- Added enable/disable functionality to synthetic node
- Rebased on v7.1-rc1
V3->V4
- Rebased on v7.0-rc4
- Added sythentic parent node and functionality
- Moved fastchannel inits outside of loop
- Renamed arguments for consistency
V2->V3
- Added powercap MAI get/set support
V1->V2
- Rebased on sudeep/for-next/scmi/updates
- Amended Copyright to include 2026
- Added patch to extend powercap report to include MAI
- Removed creation of pi powercap_info struct due to legacy code change
- Amended references to pi->version and similar, which were based on
  legacy code
- Wrapped two variables in le32_to_cpu() to appease Sparse warnings
- Amended comparing operator value in response to feedback

Cristian Marussi (7):
  firmware: arm_scmi: Add an optional custom parameter to fastchannel
    helpers
  firmware: arm_scmi: Refactor powercap domain layout
  firmware: arm_scmi: Add SCMIv4.0 Powercap basic support
  firmware: arm_scmi: Add SCMIv4.0 Powercap FCs support
  firmware: arm_scmi: Add SCMIV4.0 Powercap notifications support
  include: trace: Add new parameter to trace_scmi_fc_call
  powercap: arm_scmi: Enable multiple constraints support

Philip Radford (6):
  powercap: Add enable disable control-type
  firmware: arm_scmi: Extend powercap report to include MAI
  firmware: arm_scmi: add Powercap MAI get/set support
  powercap: arm_scmi: Create synthetic parent node for multi-instance
  powercap: arm_scmi: Add get_power_uw to synthetic node
  powercap: arm_scmi: Synthetic zone enable/disable

 drivers/firmware/arm_scmi/driver.c    |   12 +-
 drivers/firmware/arm_scmi/perf.c      |   16 +-
 drivers/firmware/arm_scmi/powercap.c  | 1001 ++++++++++++++++++++-----
 drivers/firmware/arm_scmi/protocols.h |    2 +-
 drivers/powercap/arm_scmi_powercap.c  |  355 ++++++++-
 include/linux/scmi_protocol.h         |   97 ++-
 include/trace/events/scmi.h           |   12 +-
 7 files changed, 1214 insertions(+), 281 deletions(-)

--
2.25.1

