Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7965AA672;
	Wed,  9 Sep 2026 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991493; cv=none; b=KUk2wOgJACo+g6mnnTgdVU8aI2n/iYyFIrPrfFjoar4XOxMGbcU1A9Nlqkwr3GD7bYuwjR7OZnd9D9H5vJaLySLd8yeZ1kCuiICHAXv9XfJ5gcth7XkA/4BvBLBPE3fBA8vIEJmSwzCZLUdFE4bV707lmns77GsEBAcOny7+V88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991493; c=relaxed/simple;
	bh=0pMRxRUl1BBFFP0PzvidyLdVgiqNiFeXVQQ8cUjgB1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nQEwLjP5paFeLDg8Twmh34G/AovPSkfsRNaUJedGWIqL3YzKU175PjeeQkaMXQT9RhfqEa0d08E8rOFTOxPE79u2oQ1Jf93xkW68GQDl3er+F88PQyj3Zin3giwRfm+h7NXKRlZGUVIi/9iaaLNYmDOrGcBmd/r/+iZyvHqx3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bTInTTkP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bTInTTkP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 224351570;
	Wed,  9 Sep 2026 15:04:45 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48493F7D8;
	Wed,  9 Sep 2026 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991488; bh=0pMRxRUl1BBFFP0PzvidyLdVgiqNiFeXVQQ8cUjgB1g=;
	h=From:To:Cc:Subject:Date:From;
	b=bTInTTkPGQvCf0hB54rRkXHr20RfDAHKRZT/r8LPzmkMtIZIcQTyYWie+W7GUDW42
	 ouzIaQWRXFL068Lj3vGf+YxtZy2kOgh7Mng3QQjJUWUoY3v333AMIYku4hxnrWergV
	 UOBDM4R/5sjSev8fesy3rFAcFjDRxslEa8X4Z/Ro=
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
	philip.radford@arm.com
Subject: [PATCH v9 00/13] Add support for SCMIv4.0 Powercap Extensions
Date: Wed,  9 Sep 2026 22:04:24 +0000
Message-Id: <20260909220437.1254412-1-philip.radford@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I have taken over this series from Cristian and in doing so I have
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

Changes for this version are in response to numerous concerns identified
by Sashiko review system.

The original series was based on v6.17-rc1 whereas this version has been
based on v7.3-rc1.

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

Tested on a single and multi-instance scenario on an emulated setup
implementing the new protocol extensions.

Based on v7.3-rc1.

Thanks,
Phil
---
V8->V9
- rebased on 7.3-rc1
- added check to powercap_set_root_children_enable to make sure it is configurable
- added rollback in powercap_control_type_set_enable in case of failure of one root zone
- included validation of the number of cpls in iter_powercap_cpls_update_state
- re-ordered validation of cap_config and num_cpli in powercap_domain_attrs_process
- included validation of length in powercap_domain_attributes_get
- amended cap_get and cap_set referencing apl_id array index instead fo firmware CPL identifier
- added bounds check to make sure cpl_id is less than num_cpli
- fixed CAP_CHANGED notification paring to accept old payload without cpli
- changed secondary CPL validation to use scmi_powercap_validate to catch
  zero steps when min and max differ
- Added validation check to make sure powercap domain doesn't have too
  many constraints
- Separated out domain specific fastchannel initialisation from per-cpl loop
- Amended per-cpl fast channels to use firmware cpl id instead of relying on
  num_cpli numbering
- Removed redundant scmi_powercap_get_zone_height
- Added scmi_powercap_parent_name helper
- Replaced tiernary operator that checked empty parent->info->name
- Removed redundant if (!pr) check from instance_root_get_power_uw()
- Stopped returning a partial sum if one child read fails
- Added mutex lock to instance_root_set_enable and instance_root_get_enable
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
 drivers/firmware/arm_scmi/powercap.c  | 1042 ++++++++++++++++++++-----
 drivers/firmware/arm_scmi/protocols.h |    2 +-
 drivers/powercap/arm_scmi_powercap.c  |  427 +++++++++-
 include/linux/scmi_protocol.h         |   97 ++-
 include/trace/events/scmi.h           |   12 +-
 7 files changed, 1322 insertions(+), 286 deletions(-)

--
2.25.1

