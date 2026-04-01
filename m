Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825D3CC9E4;
	Wed,  1 Apr 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037249; cv=none; b=ZuapYYRW++sxnV6tofE+5EAoZk5ROoU8IFZ4GlyErOuQYOHIfEEc8588/2p4Z4hVl1XkmOOy6VlL4NUxSOgx75HfRZDrz/bdAeOsO4BbAaoNRKwdzv0Rl/GcksccnhqR7Qkm27+s/+otY7Z//KaBaZ37/Xu8DsJDt4sRETkpNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037249; c=relaxed/simple;
	bh=i42+s6XO9ayfJbTxs15bhdHqXGP9BlXksfsMpCDjvl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udAtoAO47PIBmFbT+gVyNeQncR6edy4hLcPwrQ7hRLj4LS+oqOBCWaVgn5M2kgBMMEaoNNWH6gVCb33lb+Bv09jLEucTRAM/hk/m2yx2J2piLfZzR7Tf0dyMJqazyk/w2DiT+ey280nFG5bcXdM8MMeXW0Hyzkpx38bZL/SPJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AuZucK64; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AuZucK64"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 633C1288E;
	Wed,  1 Apr 2026 02:53:55 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CEFC3F7D8;
	Wed,  1 Apr 2026 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775037241; bh=i42+s6XO9ayfJbTxs15bhdHqXGP9BlXksfsMpCDjvl8=;
	h=From:To:Cc:Subject:Date:From;
	b=AuZucK64ulnXiFMNDbCSNCc7zF2jvMF8jF7WhLGd2vu35XFWOahxbThVYSDkP1Hia
	 BU78SNhKtUmB4RpmJ9CAeitf+P/YIcpKOEfhYWx/sREcyTPk8SdI5wZhAt0v7IPnhF
	 BPU62wh0TAZffxJWybOvI/g6FrDlOlm7zQqUrMmg=
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
Subject: [PATCH v4 00/11] Add support for SCMIv4.0 Powercap Extensions
Date: Wed,  1 Apr 2026 10:53:38 +0100
Message-ID: <20260401095349.2217840-1-philip.radford@arm.com>
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
addressed a couple of issues raised by the first version and added four
additional patches since Cristian's original series:

[6/11] exposes the measurement averaging interval (MAI) value when the
agent has registered to receive power measurement change notifications
for the power capping domain.

[9/11] adds MAI get and set support for the powercap protocol.

[10/11] introduces a synthetic root zone to act as a common parent for all
top-level domains.

[11/11] adds get_power_uw to synthetic root zone, summing the per-zone
power of immediate child zones.

TODO:
- Add enable/disable functionality to synthetic root zone to enable/disable
  immediate children.

The original series was based on v6.17-rc1 whereas this version has been
based on v7.0-rc4.

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

Based on v7.0-rc4.

Thanks,
Phil

---
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

Philip Radford (4):
  firmware: arm_scmi: Extend powercap report to include MAI
  firmware: arm_scmi: add Powercap MAI get/set support
  powercap: arm_scmi: Create synthetic parent node for multi-instance
  powercap: arm_scmi: Add get_power_uw to synthetic node

 drivers/firmware/arm_scmi/driver.c    |  12 +-
 drivers/firmware/arm_scmi/perf.c      |  16 +-
 drivers/firmware/arm_scmi/powercap.c  | 984 ++++++++++++++++++++------
 drivers/firmware/arm_scmi/protocols.h |   2 +-
 drivers/powercap/arm_scmi_powercap.c  | 146 +++-
 include/linux/scmi_protocol.h         |  87 ++-
 include/trace/events/scmi.h           |  12 +-
 7 files changed, 986 insertions(+), 273 deletions(-)

--
2.47.3

