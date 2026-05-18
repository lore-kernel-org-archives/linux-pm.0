Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AC6480349;
	Mon, 18 May 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112370; cv=none; b=kPtx7ZxWSeO4vPGyFLdg2hEWFOYYuuPR3Yeju2o6xyaCY/Qvm29PLu7JXTyAyq3QPJcX6ofiK4cDPiAAAQCO9hAT3UcgvurZDOGfpCpi/FqD4bQS4tmyaSxGFLcLpS2+otKHzWgYdTLfJsH23HGmO4r0qT33NSEC3mGFE3xKrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112370; c=relaxed/simple;
	bh=B+I+7XUz/1EgWzsqnsGp4E6KyBtLtwzkCK06boWZTQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqDYVyO0N8x8jKcKUX4JdKA3o9ZA11YeXL+pG6/H60Qx1vgwswCUCuILE5tPHxZhQfbHWOBEG3hntx9HWo0RPFDsVlf1ceN8NnZgeCQLdjyjAtBtV6mDr9u44p6/22arMO/j77xvnaMUPl3TptoTEhup9odBSxGv3JijYNoglB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lxGE8zLd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lxGE8zLd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 117441D6F;
	Mon, 18 May 2026 06:52:43 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44A143F7B4;
	Mon, 18 May 2026 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779112368; bh=B+I+7XUz/1EgWzsqnsGp4E6KyBtLtwzkCK06boWZTQE=;
	h=From:To:Cc:Subject:Date:From;
	b=lxGE8zLdgKsYXuAGGZNllozNcz+4K7OnGMEIiOF61mOLSH2l6rQE6NrY7c5YV9Mz4
	 Q3Y/KfTZF0VL8D8qLeCOrHC9cmkuwlS9k1V4FCJTD4htAocoMaep2G/YT38Gjhn5bk
	 kMQXT3U2t8GCZZBI6I6fx9jISMhtHOXsVlUSerMg=
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
Subject: [PATCH v6 00/12] Add support for SCMIv4.0 Powercap Extensions
Date: Mon, 18 May 2026 14:52:22 +0100
Message-ID: <20260518135234.2953532-1-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I will be taking over this series from Cristian and in doing so I have
addressed a couple of issues raised by the first version and added five
additional patches since Cristian's original series:

[6/12] exposes the measurement averaging interval (MAI) value when the
agent has registered to receive power measurement change notifications
for the power capping domain.

[9/12] adds MAI get and set support for the powercap protocol.

[10/12] introduces a synthetic root zone to act as a common parent for all
top-level domains.

[11/12] adds get_power_uw to synthetic root zone, summing the per-zone
power of immediate child zones.

[12/12] adds enable/disable functionality to synthetic root zone to
enable/disable immediate children.

The original series was based on v6.17-rc1 whereas this version has been
based on v7.1-rc1.

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

Based on v7.1-rc1.

Thanks,
Phil
---
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

Philip Radford (5):
  firmware: arm_scmi: Extend powercap report to include MAI
  firmware: arm_scmi: add Powercap MAI get/set support
  powercap: arm_scmi: Create synthetic parent node for multi-instance
  powercap: arm_scmi: Add get_power_uw to synthetic node
  powercap: arm_scmi: Synthetic zone enable/disable

 drivers/firmware/arm_scmi/driver.c    |  12 +-
 drivers/firmware/arm_scmi/perf.c      |  16 +-
 drivers/firmware/arm_scmi/powercap.c  | 999 ++++++++++++++++++++------
 drivers/firmware/arm_scmi/protocols.h |   2 +-
 drivers/powercap/arm_scmi_powercap.c  | 291 +++++++-
 include/linux/scmi_protocol.h         |  97 ++-
 include/trace/events/scmi.h           |  12 +-
 7 files changed, 1150 insertions(+), 279 deletions(-)

--
2.47.3

