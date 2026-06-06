Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [136.144.136.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D548A3815D6;
	Sat,  6 Jun 2026 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750855; cv=none; b=p/XkPH4OtwG8up961FdvE/bc/kaUIn2Jhd1U8XB9Lbhf1T1XcXbUpPTzAOkRcSCEk5UPwlpbxFznZn1AwenV/+trV6wdS1dnb7pnJ6KATSb5B5ZovwW+HBHOSPhge43ifyfW9iTf0WD0eT3uDcN44u3JPTJPNu1cMWlRA/oKmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750855; c=relaxed/simple;
	bh=EKwA13TTp8X4A2Xq+W/Opfww6d71iNbkAZSvcGYtCP0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hLKNBwrnr69RiPBh0mCBgu0kaj2YAlrv0G+QJWHzgSwXYDRh8j43pcb/IevqOkrdXzOpm0nvW306aqv2KUaafB4BhJNMqiB1AdA6Vu3j2tGk97mTtpsOpXy3xfc/GXbnLJr3a4MePMfTc2H5+cShDBnTO7rqvg4LLoMfGWhT4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=fJPqkxea; arc=none smtp.client-ip=136.144.136.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="fJPqkxea"
Received: from submission12.mail.transip.nl (unknown [10.103.8.163])
	by outbound8.mail.transip.nl (Postfix) with ESMTP id 4gXdhZ5pQgzY75r6;
	Sat,  6 Jun 2026 15:00:46 +0200 (CEST)
Received: from [127.0.1.1] (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission12.mail.transip.nl (Postfix) with ESMTPA id 4gXdhY6kYhz3SJ37P;
	Sat,  6 Jun 2026 15:00:45 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH v4 0/2] interconnect: qcom: add MSM8x60 NoC driver
Date: Sat, 06 Jun 2026 15:00:45 +0200
Message-Id: <20260606-submit-interconnect-msm8660-v4-0-6e1e5c5efa26@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP0ZJGoC/x3MQQqEMAxA0atI1hPolBLUqwyz0Bo1i8ah6Ygg3
 t0if/U2/wTjLGzQNydk3sVk04rwaiCugy6MMlWDd55cDe0/JikoWjjHTZVjwWSpJXJIPngX310
 YaYB6+GWe5Xjun+913cZaJrFtAAAA
To: Georgi Djakov <djakov@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Herman van Hazendonk <github.com@herrie.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780750845; l=6015;
 i=github.com@herrie.org; s=20240417; h=from:subject:message-id;
 bh=EKwA13TTp8X4A2Xq+W/Opfww6d71iNbkAZSvcGYtCP0=;
 b=WMbUHSWXAJ9J+JRvBVWP7D2lRelnKtu075QuBhOrK7S4t0B14e1zh3kz99qASw7Wk33ComfrJ
 jSh0WUGMp5yCdr7j78Tvk8kn7YRr5hXR1pTKa+vWE2iZsNaO96Upzuj
X-Developer-Key: i=github.com@herrie.org; a=ed25519;
 pk=YYxdq8fb5O9vhkW3n2dCH044FPZZO5718v/du7fRhFw=
X-Scanned-By: ClueGetter at submission12.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780750846; h=from:subject:to:cc:date:
 mime-version:content-type;
 bh=QcxQoUjtieXaUgzJq2gSym2dcmRJK6RuVtfbbGEBMEM=;
 b=fJPqkxeab9j6g1ShUhkT8kwRDnxTvQCbqljPhw7TosXAR4Ilbb2VGhNNZt1+4fkw7RGf0F
 dblQDqVySiaN7cYNRPqJGuQwt/H/tmA5fPjrDDEUw3v8MLS4CuQmLR/tZyOO944ZK8nu9X
 Zkyc1vNFWCD9QMWRUP7Com2VQ+YRGnE28CdE+2laGr/tVugdxtAfkCbwIPVohaYl7LVlkA
 4h4YDhxRTHkCIo+1YKXu80OWykbvQjQTxH4IiZakPUIDRHjAiv+VprMuuqTYyNkFKE4opY
 +FOPCn3You3lsdr0Sn06ra5a1YLGZgusAaYxoQDp65wL35Hd/r800qUaKZXlRw==
X-Report-Abuse-To: abuse@transip.nl

Add an interconnect provider for the MSM8x60 family (MSM8260 / MSM8660
/ APQ8060). The driver describes the four NoC fabrics (System, Apps,
MMSS, Daytona) and the RPM-managed fabric arbitration tables that
program per-master / per-tiered-slave bandwidth budgets via
QCOM_RPM_*_FABRIC_ARB resources.

v4 folds 3 High + 1 Low review findings from the v3 round, all
verified on HW (see "Test results" below).

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
Changes in v4:

  - [High] msm8660_icc_set() per-node clock-rate calculation now uses
    the per-node bus width
    (((struct msm8660_icc_node *)n->data)->buswidth) instead of the
    fabric-global qp->desc->bus_width. Narrow links such as
    sfab_to_system_fpb (4 bytes) were having their requested clock
    rate halved by dividing their bandwidth by the 8-byte fabric
    width -- the framework writes path bw to every node it
    traverses, so a 4-byte node carrying X bytes/s needs rate=X/4
    to actually push X bytes/s, not X/8. Defensive fallback to
    qp->desc->bus_width if n->data is NULL.

  - [High] msm8660_icc_probe() split into a two-pass node init:
    Pass 1 creates and adds every qnode to provider->nodes; Pass 2
    only links. Previously, icc_link_nodes() could forward-allocate
    a target node for a still-unprocessed qnode; on subsequent
    probe failure, icc_nodes_remove() did not see those nodes
    (not yet in provider->nodes) and msm8660_clear_node_cache()
    dropped the only reference to the allocation, leaking it.
    With the split, every target node already exists when linking
    runs, so icc_link_nodes() never allocates, and err_remove_nodes
    cleans up everything via icc_nodes_remove().

  - [High] platform driver: add .suppress_bind_attrs = true. The
    four fabrics register as independent platform devices but link
    to each other via raw struct icc_node * pointers. Allowing
    individual sysfs unbind would let a target fabric free its
    nodes while a still-bound source fabric still holds pointers
    to them, dereferenced during path finding -> use-after-free.
    Suppressing the bind/unbind attrs forces module-level unload
    (all fabrics together) which is the only safe teardown.

  - [Low] dt-bindings: drop the $ref to qcom,rpm-common.yaml. That
    common schema marks '#interconnect-cells: const: 1' as
    deprecated, so referencing it triggered a dt_binding_check
    deprecation warning every time. The common schema otherwise
    adds no real constraint (additionalProperties: true), so the
    reference provided no functional value. Reworded the
    '#interconnect-cells' description to drop the now-stale
    rpm-common.yaml mention.

Changes in v3 (already sent 2026-06-06):

  - [High Sashiko] msm8660_rpm_commit() ran with no synchronisation.
    Shared per-fabric scratch buffers (qp->arb, qp->bwsum,
    qp->rpm_buf) reused across all ICC set operations would have
    been concurrently memset()'d / written from multiple CPUs,
    corrupting the qcom_rpm_write() packet. Added a
    'struct mutex commit_lock' to msm8660_icc_provider, taken
    across the entire memset -> iterate -> pack -> qcom_rpm_write
    sequence with a scoped guard(mutex)().

Changes in v2 (already sent 2026-06-04):

Maintainer / LKP feedback on v1:

  - [Medium] dt-bindings: add explicit '#interconnect-cells: const: 1'.
  - [High] msm8660_get_rpm(): drop manual device_link_remove() with
    DL_FLAG_AUTOREMOVE_CONSUMER (would double-put -> UAF).
  - [Low] devm_clk_bulk_get_optional(): drop dead ret == -ENOENT
    branch (helper internally masks per-clock ENOENT to NULL).
  - [High] static msm8660_qnode .node cache cleared on err_remove_nodes
    and remove() via new msm8660_clear_node_cache() helper.
  - [High] icc_link_nodes() return value checked instead of ignored.

Test results (v4, HP TouchPad APQ8060, kernel 7.1.0-rc1):

  - All four fabrics probe clean at boot
    (4096000.qnoc, 4400000.qnoc, 4500000.qnoc, 4540000.qnoc).
    Real bandwidth votes flow through slv_ebi_ch0 (DDR), MDP,
    video-codec, camss.

  - Narrow-link rate check: triggered traffic across
    sfab_to_system_fpb (4-byte) and confirmed via /sys/kernel/
    debug/clk/.../clk_rate that the fabric clock now requests
    2 * (node_bw / 8) instead of 1 * (node_bw / 8) when the
    narrow-link slave is the hottest node on the fabric.

  - 120s concurrent multi-subsystem load (camera stream loop + dd
    to eMMC + /dev/urandom + filesystem walk + USB I/O):
    zero qcom_rpm errors, zero icc warnings, USB stayed up, MDP
    stayed active, no display glitches or USB stalls.

  - dmesg post-load: 0 WARN, 0 BUG, 0 Oops. Specifically no
    "qcom_rpm: ARB write failed" and no "interconnect: ... failed".

  - dt_binding_check: clean, no deprecation warning. SCHEMA -> CHKDT
    -> LINT -> DTEX -> DTC all pass with exit code 0.

  - Kernel build clean (ARCH=arm, CONFIG_INTERCONNECT_QCOM_MSM8660=y).

- Link to v1: https://lore.kernel.org/r/20260603163410.2312712-1-github.com@herrie.org
- Link to v2: https://lore.kernel.org/r/20260604184400.801543-1-github.com@herrie.org
- Link to v3: https://lore.kernel.org/r/20260606-submit-interconnect-msm8660-v3-0-a003e3da0501@herrie.org

---
Herman van Hazendonk (2):
      dt-bindings: interconnect: qcom: add msm8660 NoC
      interconnect: qcom: add MSM8x60 NoC driver

 .../bindings/interconnect/qcom,msm8660.yaml        |  164 ++
 drivers/interconnect/qcom/Kconfig                  |   14 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/msm8660.c                | 1716 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,msm8660.h    |  156 ++
 5 files changed, 2052 insertions(+)
---
base-commit: 944125b4c454b58d2fe6e35f1087a932b2050dff
change-id: 20260606-submit-interconnect-msm8660-62420c194b6a

Best regards,
-- 
Herman van Hazendonk <github.com@herrie.org>

