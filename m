Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66A409637
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966722; cv=none; b=MuLe9QsloE1qLIvAS9xv0ZgQwOgun9JWHvm/sb/NcFZYfNeRbVpCp7WSVocLESZgOU9najxQdQyG5GhJ31PFEZz+uwLAUCUSkOk65Ea3HVIbr7LMpJgZRKJsf/D2wmE3ptFoeRNVumPX7Dvzm2Mv2eimCgd4NDIj4EBJKWeV4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966722; c=relaxed/simple;
	bh=TwpeiWR/UqnE1Cw3Vk+9g58ehWh8NuPJqbiRVMfLREQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D7RMiO3DfTD6x0CCalZvvnePy+3Gvd1gNA933LfOLVJRcerZJzv1shgk3Ul4SJH9zPc/+EEKNXqN3wLonsRJmhmd7l13Tab7S1rLZvwCMudYgXTE+Q7nuOO038AWoEuYOh184feOEPg7WNAR3hQ3Uex5Hxo+RoxK0/L2qSTBkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0GpaUFS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jfZ7WsDY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0GpaUFS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jfZ7WsDY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H9dcDk1466555
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 11:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kH7KkUchQ9GzCdEH2/N+4h
	FkX3C86y5nR4n9xjHjDzk=; b=Z0GpaUFSkrKJWadzK+z8wWcdgUNXEceEnn4r0+
	9a8s3v/bLtBnNx2GjZOshlJbkqNr4/8J25HFFVFWNfm4hSeVcOm7jyoEOi5fHMVo
	TddAzlBf82Q0PLN8uNoKT6i+30Y3HCxfr0fdKTA8ISI2XPpzPlQsBqfVY5Fany4g
	LW1ST6F3sj0GiNyHtYHIoCgtKmmkB9ZlP14jkFciCHDuzMxj/LDlzFFzDVZFwRBL
	xeuf3eo5GJwITn+PCarpSYBlzbrmaNq/29aaGqv6AedmYjVB22lynJRD8HY7JS+O
	qbA4X4CtgjgjZhcJBEcPpcgGruDB/4RzUTHwMgDd02kPLUvg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xx7gp38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 11:38:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936aa34873bso295256885a.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786966719; x=1787571519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kH7KkUchQ9GzCdEH2/N+4hFkX3C86y5nR4n9xjHjDzk=;
        b=jfZ7WsDYDw+PIuAXH9e45QlXpTCpRRkbRUroy+a0XNJKKkMimywgYiZx96eOy4ZZVu
         w/q86TtSrGuRv6T8FnQClmqDUNAfpf8v8h6+iaTpJgeZdFEVFQnsK8DGUOXkvgqn2/vY
         qY/1dZMb5D2KnI6t9RbVjY4XeTOPdu9QM44P7Jk2J7/zTCGuNBnNpx+sDh6AcOXcVEqJ
         QfO5ye+lh7jITfLFhp46YdYtpCAQqUeOndhrXif80g8zto9zja1PKE0of+/9Yvvt1TwC
         zfoNRwmS50/awCN+DOVXavAh87acGADSz7vK+b2GWZt8wljj4we396vmRC3OAKGDVbPw
         3EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786966719; x=1787571519;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kH7KkUchQ9GzCdEH2/N+4hFkX3C86y5nR4n9xjHjDzk=;
        b=QC1CuElHYLP1ubgWo1KELChCbD3MyPAomF1tEXliS4PB0ebqnZIsvoqhBVJv7odJhc
         /KsWMb+PXz9uWpFUobCmWCuobn2Mg6afXLArhJWb1nG45A3s54PfN23xFK53nxFB45W8
         +YiNFZhVBiMnbZosGiuekW/CvUD0UzGDU+R0YZzN+PYvwsAknOe1IqaLJyfjNGo3o4ub
         frBVn8lhgFAGiSwRXC/okoeJejunHLdu667Gr+wLgWprbNwk+MvO+t2B/tBO8dV2IVXC
         OphzJdT5Rl2EgZtG2085ahWfgNBcjm06EWop0tHZD+tti2+VXFxjTcurLSbisbyUTjPb
         6v9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpkuGGoHi3SgxU32CNZmn+y5dNgO6Llwi4RELCWoalxg+wNdxxErsXgTBGGAenA/8F431ICWFoyPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmGZvIVALDmLJ60v71HlJjafrg6LDPo9NrAleNDezg9biv35F
	kB5lCOq1k2u+KEMhCaaBSJ5O90+JkP3zit/UxcbL63IFWoKASL45ygwa0M6zMy47WvA/nsaS7O5
	+BW/WUHXd5Hdc9g4HZ5LP6yr4XEcV5L6WoTSlBT7sYuVW33QIzhSM7lOXCmV3Aw==
X-Gm-Gg: AR+sD10kuIg6sqYBguEx5Ho8MYa79boj1jiG+nIxoWIgg1NKopDIheVn5enJYjNLr8S
	VdEOX2iBm+bZIDjgY5LkkdDaibN8ocxtYJg/JNntYoeg5Vhqh2nzfxvfuw4eypWCumKhfX76LKS
	Eo/tshfYq9RZ7Simwi59WUqtUKMFWOuLsmegpgcWNe1IsyKTvvrRAkjf13Ykb1vXSU9ZwzqpEvD
	6lNDQVh95XQdRJg1iBKaA7kJufL6wOk/qDHAJVx1rfU9p53fxvpKJfWfBSkSfV/WfsdiDyMN8td
	HDQc2oUpziIlMli83HVPTo25x0MXoJEQnYtO3yIA637Xji6k8JQZWxS6e/caHvs9Ql6eR4d2sfX
	DoB7kynqHlfiMqS/22RKsneSDfWW9dak2BmuqXHCB0IPBV59ZiyoiypNp/A==
X-Received: by 2002:a05:620a:8812:b0:936:d2a2:5fe with SMTP id af79cd13be357-936d2a24ffemr2544634085a.6.1786966719125;
        Mon, 17 Aug 2026 04:38:39 -0700 (PDT)
X-Received: by 2002:a05:620a:8812:b0:936:d2a2:5fe with SMTP id af79cd13be357-936d2a24ffemr2544631385a.6.1786966718719;
        Mon, 17 Aug 2026 04:38:38 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cf28d18sm330443e87.0.2026.08.17.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:38:37 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v7.3
Date: Mon, 17 Aug 2026 13:38:26 +0200
Message-ID: <20260817113836.134458-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfXyyYtGWpHmDWi
 +tJZwPDc2sfXYlvQlmQ5VKL5sParru4j0Cx6SQqb7va0/XSGYTC7tIGtmiK8+Q6FDKr1QtdHkoz
 x2EvKx/ZvSdr/pgbwNB/yOgLlMdQfjs=
X-Authority-Analysis: v=2.4 cv=TK91jVla c=1 sm=1 tr=0 ts=6a82f2c0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=cA1ofZphUsUmLjTjR6EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: PnCcDNmiUfmI8OjVzMO6OPuG1kwWvNdf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX+s5k5Z95p76z
 vVn2kpNpuVtSKxems8Rvlr3dNOad/+B1b/+AoD+Cys16g6hHdH5FHS1nsf5U4LWb4D1oSiZhJ3J
 SPBYyFMVrLPLCcfIE+kZm+17YQ/G1ECktiUKtiTmdjbIZ1trdPbQnrVmP/8t/Zjy6TxnJ8DHJDd
 +9M877ETlr6OMIoFbo+B5jwDCcWqAKrrn3ma3x0oSSR303X76L3xFDOpdDDBblo4Xto/1cCfv0m
 kHemQAyFXB8YFj80mNToisk45JQN80NAbU3PH+GY8Sl+QPjP6LwvsNKLYl5ea/sU2Famwbdn3F7
 OMdYbOM0dFxi47g8tdMp3hlH7gpsX7/2bYV1ej3zFQd8nj3oMpvr3LZN7/AzlTa/SZBUzUzEjXO
 tkMBhtuc8LjTIqVFGrqpBy6wjxO7TKerKpoHS2ulETh1mG8bgck38OsUeHm69gmgbHYioX/iIke
 taPzpYvvehTCcQ3QU1g==
X-Proofpoint-ORIG-GUID: PnCcDNmiUfmI8OjVzMO6OPuG1kwWvNdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170087

Hi Linus,

Here's the pull-request with pmdomain updates for v7.3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 090a95dbe13df9965279b588d97eda134831769c:

  pmdomain: mediatek: mfg: initialize prev_o in mtk_mfg_attach_dev() (2026-08-12 11:09:12 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.3

for you to fetch changes up to 3ca7b513aec1db32b75b909395be1111c1198afb:

  pmdomain: Merge branch fixes into next (2026-08-12 11:12:00 +0200)

----------------------------------------------------------------
pmdomain providers:
 - amlogic: Add support for A9 power domains
 - bcm: Raise ASB poll timeout to 100us for bcm2835-power
 - imx: Allow building power domain drivers as a modules
 - mediatek: Add support for the MT6858 power domains
 - mediatek: Add support for the MT8196 HFRP DirectCTL power domains
 - qcom: Add support for RPMh power domains for Maili
 - qcom: Skip retention by default for rpmhpd
 - renesas: Add support for R-Car X5H Module Controller
 - rockchip: Add a regulator to the RK3568 NPU power domain
 - tegra: Add support for multi-socket platforms

----------------------------------------------------------------
AngeloGioacchino Del Regno (4):
      dt-bindings: power: mediatek: Add support for MT8196 direct HFRP
      pmdomain: mediatek: Respect PD relationships during error cleanup
      pmdomain: mediatek: Add support for Direct CTL simple power sequence
      pmdomain: mediatek: Add support for MT8196 HFRP DirectCTL domains

Fenglin Wu (1):
      dt-bindings: power: qcom,rpmpd: document RPMh power domain for Maili

Geert Uytterhoeven (3):
      pmdomain: arm: Grammar s/may needed/may be needed/
      dt-bindings: power: Document Renesas R-Car X5H Module Controller
      pmdomain: renesas: Add R-Car X5H MDLC driver

Jon Hunter (1):
      pmdomain: tegra: Add support for multi-socket platforms

Krzysztof Kozlowski (1):
      pmdomain: qcom: rpmhpd: Sort table entries by index name

Maíra Canal (1):
      pmdomain: bcm: bcm2835-power: Raise ASB poll timeout to 100us

Midgy BALON (1):
      pmdomain: rockchip: Add a regulator to the RK3568 NPU power domain

Mike Tipton (1):
      pmdomain: qcom: rpmhpd: Skip retention by default

Nikolai Burov (3):
      dt-bindings: power: Add MediaTek MT6858 power domain controller
      pmdomain: mediatek: Add support for secure modem power domain control
      pmdomain: mediatek: Add support for MT6858 SoC

Pengpeng Hou (1):
      pmdomain: bcm: bcm2835: handle genpd provider registration errors

Ulf Hansson (13):
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch fixes into next

Uwe Kleine-König (1):
      pmdomain: imx8m{p,}-blk-ctrl: Add MODULE_DESCRIPTION

Xianwei Zhao (2):
      dt-bindings: power: Add Amlogic A9 power domains
      pmdomain: amlogic: Add support for A9 power domains controller

Zhipeng Wang (4):
      pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
      of: export of_stdout symbol
      pmdomain: imx: scu-pd: allow building as a module
      clk: imx: imx8qxp: add soft dependency on SCU power domain driver

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |   1 +
 .../bindings/power/mediatek,power-controller.yaml  |  22 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   4 +
 .../bindings/power/renesas,r8a78000-mdlc.yaml      |  61 +++
 drivers/clk/imx/clk-imx8qxp.c                      |   1 +
 drivers/of/base.c                                  |   1 +
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       |  69 +++
 drivers/pmdomain/arm/Kconfig                       |   2 +-
 drivers/pmdomain/bcm/bcm2835-power.c               |   9 +-
 drivers/pmdomain/imx/Kconfig                       |  13 +-
 drivers/pmdomain/imx/imx8m-blk-ctrl.c              |   1 +
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c             |   1 +
 drivers/pmdomain/imx/scu-pd.c                      |   8 +-
 drivers/pmdomain/mediatek/mt6858-pm-domains.h      | 466 +++++++++++++++++++++
 drivers/pmdomain/mediatek/mt8196-pm-domains.h      |  27 ++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         | 195 +++++++--
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |   7 +
 drivers/pmdomain/qcom/rpmhpd.c                     |  38 +-
 drivers/pmdomain/renesas/Kconfig                   |   4 +
 drivers/pmdomain/renesas/Makefile                  |   1 +
 drivers/pmdomain/renesas/r8a78000-mdlc.c           | 325 ++++++++++++++
 drivers/pmdomain/rockchip/pm-domains.c             |  36 +-
 drivers/pmdomain/tegra/powergate-bpmp.c            |   9 +-
 drivers/soc/renesas/Kconfig                        |   1 +
 include/dt-bindings/power/amlogic,a9-pwrc.h        |  61 +++
 include/dt-bindings/power/mediatek,mt6858-power.h  |  23 +
 include/dt-bindings/power/mediatek,mt8196-power.h  |   4 +
 include/dt-bindings/power/renesas,r8a78000-mdlc.h  |  15 +
 include/linux/soc/mediatek/mtk_sip_svc.h           |   3 +
 29 files changed, 1340 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
 create mode 100644 drivers/pmdomain/mediatek/mt6858-pm-domains.h
 create mode 100644 drivers/pmdomain/renesas/r8a78000-mdlc.c
 create mode 100644 include/dt-bindings/power/amlogic,a9-pwrc.h
 create mode 100644 include/dt-bindings/power/mediatek,mt6858-power.h
 create mode 100644 include/dt-bindings/power/renesas,r8a78000-mdlc.h
