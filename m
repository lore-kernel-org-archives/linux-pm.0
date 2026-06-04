Received: from outbound4.mail.transip.nl (outbound4.mail.transip.nl [136.144.136.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB239EF3D;
	Thu,  4 Jun 2026 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598655; cv=none; b=Mt0C3xWwTiKUYY7WzhOmaouHQORZ7CPbcLy4mf9bM40gmhplWKy9iBe82C4xksaeZkYBBteQIPzM1CU7j/UGdAojYAjJ07u4+9zDxrPiwsy5bhZ3ExoaGafhVZ1mpzoXdk7t515hFIFL5NqE+ELoXLuWg40l+GqRk3v/3shsvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598655; c=relaxed/simple;
	bh=yTTK8VtoRBYVbAh8BEyW+596U/dAce9FYmrXs0nOn+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rou0Sfie9/TcU+IP+ZSx8/0POg+FvprEXJGK7HdKlH5kXWzVnlrz7VjXMBetOe78ig+Xk6l5rKnMadE5SOgd96uKcV17pEHfObEilCxPJ3XnHpHsFcZ6r265Sbi/L19qEe3nBtT+m1KOheNKkbePd6MknGJr1NEuaOqjR9pp4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=Iq2N4/ID; arc=none smtp.client-ip=136.144.136.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="Iq2N4/ID"
Received: from submission0.mail.transip.nl (unknown [10.100.4.69])
	by outbound4.mail.transip.nl (Postfix) with ESMTP id 4gWYPY3jgLzwPYn;
	Thu,  4 Jun 2026 20:44:01 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission0.mail.transip.nl (Postfix) with ESMTPA id 4gWYPX46Q8zZyxrx;
	Thu,  4 Jun 2026 20:44:00 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: djakov@kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com,
	odelu.kukatla@oss.qualcomm.com,
	raviteja.laggyshetty@oss.qualcomm.com,
	luca.weiss@fairphone.com,
	abel.vesa@oss.qualcomm.com,
	jie.gan@oss.qualcomm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH v2 0/2] interconnect: qcom: add MSM8x60 NoC driver
Date: Thu,  4 Jun 2026 20:43:58 +0200
Message-ID: <20260604184400.801543-1-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission0.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780598641; h=from:subject:to:cc:date:
 mime-version; bh=xONqXCRPpfu0N8QcFXhHqD/ouGS1shZfT4TapA+CFNk=;
 b=Iq2N4/IDz4bDYQ2QeMZ1+XLVUyhlYFs8e79h/lPtGIPtIzWsSE+wAOTouc9jTHMzNRkxov
 jiSWcTWNa8obzG7zt15XQ8JjeZve5NG6fHvHcNpSs5dHuvzn3tFJNXAEixlWKY3GTsomnM
 URRa9Z7YVeIleKeiQOOVwyoTPDPSsBsxOa4Cw3ui9moS3v43+y4IZcm9VffRbECo4jrJ31
 QApAJwRxOD2JAG45Zf/QSHrZEDxXRcVPk7DJ8cAKKxyhvddUKefV9DOPN+2clEYP+pHzRg
 gdJLAojeDkhXUB91k3ZR4pKTSXs91LsbXffMqunR8UVpm/o+Nv5G0IJ7YH9H5A==
X-Report-Abuse-To: abuse@transip.nl

v2 addresses Jie's, Sashiko's and Dmitry's review of v1:

Binding (PATCH 1/2):
 - Add the dt-binding schema (qcom,msm8660.yaml).  v1 only shipped
   the ID header (Jie flagged the missing schema).  The schema
   covers all four compatibles, per-fabric clock-name lists
   (bus/bus_a/ebi1/ebi1_a for AFAB; bus/bus_a/smi/smi_a for MMFAB;
   bus/bus_a for SFAB and DFAB) with descriptions for each clock
   (Dmitry), the required qcom,rpm phandle, and
   #interconnect-cells = <1>.

 - Drop the SFPB/CFPB mention from the header commit message;
   those fabrics aren't modelled by the driver (Sashiko Low).

Driver (PATCH 2/2):
 - Fix the bandwidth aggregation in msm8660_icc_set() (Sashiko
   High).  v1 walked provider->nodes and re-summed n->avg_bw
   across all nodes, which double-counts: the framework already
   writes each path's bw to every node it traverses, so summing
   here gives e.g. master_bw + slave_bw for the same flow.  v2
   takes the max per-node rate across the provider (matches the
   qcom_icc_bus_aggregate() convention in icc-rpm.c).

 - Switch to dynamic ICC node IDs via icc_node_create_dyn() and
   pointer-based linking via icc_link_nodes(), matching the
   icc-rpmh-style pattern (Dmitry).  Drop the internal MSM8660_*
   enum entirely; struct msm8660_icc_node now carries a struct
   icc_node *node and a flexible link_nodes[] array of qnode
   pointers.

 - Expand the DEFINE_QNODE macro (Dmitry); each of the 63 qnodes
   is now an explicit static struct definition, with forward
   declarations grouped at the top.

 - Use dev_err_ptr_probe() in msm8660_get_rpm()'s deferred-probe
   paths (Dmitry).

 - Limit the clock-bulk-get fallback to -ENOENT only (Dmitry);
   propagate every other error including -EPROBE_DEFER instead
   of "any non-DEFER continues without clock scaling".

 - Kconfig: depend on MFD_QCOM_RPM=y so a built-in interconnect
   provider can't link against a modular RPM (Sashiko Low).

 - struct msm8660_icc_node: const char *name (Sashiko Low).

On-device validation (HP TouchPad / APQ8060):
  All four fabric providers probe cleanly:

    qnoc-msm8660 soc:interconnect@0: RPM fabric ARB enabled
                 (4 masters, 4 slaves, 2 tiered)             [AFAB]
    qnoc-msm8660 soc:interconnect@1: RPM fabric ARB enabled
                 (17 masters, 9 slaves, 2 tiered)            [SFAB]
    qnoc-msm8660 soc:interconnect@2: RPM fabric ARB enabled
                 (14 masters, 4 slaves, 3 tiered)            [MMFAB]
    qnoc-msm8660 soc:interconnect@3: MSM8660 interconnect provider
                 registered                                  [DFAB]
    mmcc-msm8660: MMSS fabric: unhalted all master ports (0-13)
    msm_hsusb 12500000.usb: USB HS: Setting interconnect
                 bandwidth avg=61440 peak=61440 kBps

  interconnect_summary shows the expected per-node aggregation
  (e.g. slv_ebi_ch0 sums MMC + MDP + DMA + USB consumer requests)
  and msm8660_icc_set() then derives a single fabric clock rate
  from the per-node max rather than the per-node sum (the v1
  double-count is gone in v2).

The companion DTS patches that enable the providers for the
HP TouchPad will be sent separately to the ARM/DTS tree.

Herman van Hazendonk (2):
  dt-bindings: interconnect: qcom: add msm8660 NoC
  interconnect: qcom: add MSM8x60 NoC driver

 .../bindings/interconnect/qcom,msm8660.yaml   |  157 ++
 drivers/interconnect/qcom/Kconfig             |   14 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/msm8660.c           | 1619 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8660.h   |  156 ++
 5 files changed, 1948 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
 create mode 100644 drivers/interconnect/qcom/msm8660.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8660.h


base-commit: 944125b4c454b58d2fe6e35f1087a932b2050dff
-- 
2.43.0

