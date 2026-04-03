Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C03018AFE
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237630; cv=none; b=KSFCDnoTYdi8Ifm8HjGIW6EZ9+a0d1i+ePeI/O3nPq3o8WnlNrBIo3NDipEKdQkDow3jaZTrLj3G4tiHs1+LnJnkcCTRCVCm9IxyARe8HjP468k/jKCMUMLfoAElZD7GWBzGZClmvi5YT7giW5ZUGfYFVcBInEgIF5InFk5Yw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237630; c=relaxed/simple;
	bh=lquwIt3pxmUHrqV0hylBWdUZ9FzuojFhb4iwrjx2pmw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IQwPEzjVqWPRS/cuh85aMWRSO1Ruaza6LUW8ISEGsOrC+kQ0GaAtPD208Tm9SopnH+5OgQfxRpdCznlY/r8YIMiwzP87iZ5/d1xcmYT7V3WpIXFD4YE3J3SQy7CmHN3RKB597JiwUKInv3F8O7mAAzwDbLrX2FKQRFENEPbCARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=at2SJ6nb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KN1j6/XE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="at2SJ6nb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KN1j6/XE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633G718W2707224
	for <linux-pm@vger.kernel.org>; Fri, 3 Apr 2026 17:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WhdmUQMs0c12v3Jvg9TgqF
	jhlSe7hCaVqUcHAfWSqgE=; b=at2SJ6nbgXLGzolnsKGvZCjdDEWefMJ7i4Dpv3
	bybqmytK2vg4v876pkVJOa2bZrGAv4MKclN4uMMtGxwh91oQzbsxDNGRa58/VhS4
	BbrQHyLuDD9yXqWFj5febnt7YArMUMX0/xI284Dp380kkwM03/Qf6kPZTK/WGJ2Q
	jSGPB6O8ahVFfm7/WUaV+PCtjGKPAbeRc3BSnNMxGkVIFs7T61AaXwjxsJuWs3oF
	C9QFkl+QYZqn68jv6wXoGn5AfPAl3t/8q62uhJbuusZHA56HyP/moH+g0UJB7Me4
	EZOlYrvN5KRap8GkrICEUQ0KYSb2ghDrdOPvBRjLpVfRQw3A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9yfjk8ca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 17:33:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso3294695a12.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775237626; x=1775842426; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WhdmUQMs0c12v3Jvg9TgqFjhlSe7hCaVqUcHAfWSqgE=;
        b=KN1j6/XE1watPmnFdhIuCmoFOhKdohe25WGM1tDxg//XYHDecClRdit5b0u9rFrlRP
         NYykJn771DmpLWZFkmfHejlv0At6dmtrJqFcnA5vUju9aoSjKXcW3oRonMWQ1uVxBPzD
         1PKN69ZD5MqZSCH+Xcjo8b7rGH7/a7b60mFMXO6nig0g00BvS8kIf1Z5ChLWOx847htM
         mf3h/DV2KSg0yvN2/RanrydVsU/4Yu03VwEPGxgyo+RA0LWVZXbFu0zqOV5mUROLQy1N
         pf79aJ+TzT5o9/JhqLk2dM1KPOUb7aW/QeKswZCdj1yk++LRfoVrheZxlRg4dJY8hGGJ
         /g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775237626; x=1775842426;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhdmUQMs0c12v3Jvg9TgqFjhlSe7hCaVqUcHAfWSqgE=;
        b=qhl1yseMokDHXGG4zT6Wj4zlH5QjQM2eDF8+oncSDPS9i4mrTAotk5tL8mPfa9KXVt
         pNgqXXKG0VY8aPhBJfG/J4BopN0n4Zh6ODN8AfpbqDI3fe//THUPBH2uV9RsnXPB/zdi
         a+rxfTqoEUyrcizgTBQBFJJDodsX59VHlDu1coAhnmkA1OSzV1zpKudcGHNGAGV1OYaw
         D1nfFPmEKVHAPq2m0g684H8yK4YvzHHFd3sFObxOnHzZhRzgLdmlmRqbkERq0ZCcNQ6M
         3HT7wh08qYweQ14zJ8MuI26LGu4Oq/YwBd9LaibPZq0Cj9+5fWa/RbGRSfcxXNjUwVxp
         xL1Q==
X-Gm-Message-State: AOJu0Yy/d9+S0z5TS5xUHqJZD1WqawFZiSO8I/TYcRggLea3ejNiv/vE
	lnqPKt0kDbq6Cc/2Gj4INXW0EluKv01AQ5jtiQ4VxOKhLXHeZ9DkeXP099ATXY6dn8PPn4AQ14c
	IG1MLtjYKvMzNdaHVRIKdI+dlF14Oh4nRnv9dOFQBKZ1YZSEjsPdyWlAGt2B1RQ==
X-Gm-Gg: AeBDieuOw+X94fRF/VeBIb5tONwdKrgqaTTh6pifkyKU0qtjK82O6HjBK4VtcLm/EQg
	Yi0MdjqQIoDodjoATESF655dyoyLALTXIRVKG8x1qC+ZNc311OuN0hl0tlxLoHIs7gDf5xde1Kt
	R1gJcbtyywXelJ7ymnvmnzsKUgEqxJSOg8nAOMvm+v+j9EivjPvLtggzYu2mzy5PKPSdd/2Wjvv
	xpQHPqU6ZWwsvXHV/3QcoPbnlGsaOPw1fBP5HwbVr+1a4CrZd4IlB0t+90rn+2a9B7HuZbkQtcR
	R92AUZAdEk/57HwfgyZEggaVN5y0cueDFXObKede14100IH3EMdBNGFCSl3dyPxSVC8JztDG3SP
	mGUyxM4aF/X+EPMbsvaI5XrJsnKBiXIQCrZXdzZjHrjc4BJZqjo0lw7XU
X-Received: by 2002:aa7:88d1:0:b0:82c:9e00:f958 with SMTP id d2e1a72fcca58-82d0d743763mr3740155b3a.0.1775237626168;
        Fri, 03 Apr 2026 10:33:46 -0700 (PDT)
X-Received: by 2002:aa7:88d1:0:b0:82c:9e00:f958 with SMTP id d2e1a72fcca58-82d0d743763mr3740120b3a.0.1775237625642;
        Fri, 03 Apr 2026 10:33:45 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm6359125b3a.18.2026.04.03.10.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:33:45 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v9 0/3] PCI: Add support for PCIe WAKE# interrupt
Date: Fri, 03 Apr 2026 23:03:32 +0530
Message-Id: <20260403-wakeirq_support-v9-0-1cbecf3b58d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOz5z2kC/3XP2wrCMAwG4FeRXltJux4yr3wPEam11eKhs9Wpy
 N7dThCF6U3gD+RL8iDZpeAymY4eJLk25BCPJdTjEbFbc9w4GtYlEw5cMgaCXs3OhXRa5kvTxHS
 mXgorVsYwtJKUqSY5H24vcb4oeRvyOab7a0Er++7b0gOrlRSoUMIx7bnlYGcx58npYvY2Hg6TU
 khPtuqL4T8YVRgFXiLzteAg/zD6zSjgDIeMLgyshcIaK+Cg/zD4YSpWDRnsn0IDRvcHo/nBdF3
 3BIk/+A+KAQAA
X-Change-ID: 20251104-wakeirq_support-f54c4baa18c5
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775237619; l=4614;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=lquwIt3pxmUHrqV0hylBWdUZ9FzuojFhb4iwrjx2pmw=;
 b=QXHiJZg8wKuUbnPRDefxKLKofMd2Hk//kpYpGCOguqCazl1tI4dSFeEgjPx3SLlmZYoib9O7B
 pJsk97SePNcD5M71XJY7KBn/d/1IUOfBLASlz2yrkMzmJKqUWandkNL
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: WJehBu73VNNeT1crp64dxinTK8V_4znD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE1NiBTYWx0ZWRfX8cyRupRVmDqU
 xHU+CCi7nTaF/XVDDjegy4W+IpXps3/4eMY/HY6FD78Y64Q35T45roWCrEeudO80VCuLLgG2j8T
 qv5+4hrWkxalv3D5h4b3rs82pQqFAt+mPOkXoHJlWY1QI3hkaI2bhSz0wC5F5j7yKxfp+mQxTFe
 aZXG7QiWqqMccdL91R9mEVnTz7kTcUlU2di0MDGTV7QlDtGh7rcZ8H3mSk7qSm8XdVEv0AMK9Kl
 A1B6Ng37QLRKn0zuDyivYc/YBD/n6Fx8BolK2JOFw2DNgwywcEL4q/PqWqpB3qlVjCrAO0u/qew
 f0lb2Ca0VVp4Z9+ImdGyZUCO3tAgfguXBNpQC4lQYMnU9d7ZDCaMAnoqg54oRpFDFezCKWEaNd3
 VO1T2Mg/b5s27G31OH3/kOmLaMyKRRx/8BRPPhDCYabW5N3aJvNAVLykYcq06bLYyUW5EPRUnW5
 mMt/fhHt8CFcLYQpPbg==
X-Authority-Analysis: v=2.4 cv=OrpCCi/t c=1 sm=1 tr=0 ts=69cff9fc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8 a=s8YR1HE3AAAA:8
 a=bBQ1TlrZeL130n7Dx0UA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: WJehBu73VNNeT1crp64dxinTK8V_4znD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030156

PCIe WAKE# interrupt is needed for bringing back PCIe device state from
D3cold to D0.

This is pending from long time, there was two attempts done previously to
add WAKE# support[1], [2]. Those series tried to add support for legacy
interrupts along with WAKE#. Legacy interrupts are already available in
the latest kernel and we can ignore them. For the wake IRQ the series is
trying to use interrupts property define in the device tree.

This series is using gpio property instead of interrupts, from
gpio desc driver will allocate the dedicate IRQ.

Bjorn,
Can you take this series through PCI branch, once other subsystem
maintainers give us ACK. 

WAKE# is added in dts schema and merged based on this patch.
https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/

[1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
[2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v9:
- Call device_init_wakeup() only if
  dev_pm_set_dedicated_shared_wake_irq() succeeds (Mani).
- Change the IRQ_TYPE from IRQ_TYPE_EDGE_FALLING to IRQ_TYPE_LEVEL_LOW (Mani).
- Link to v8: https://lore.kernel.org/r/20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com

Changes in v8:
- Moved the stub functions under CONFIG_OF_IRQ(mani).
- Added the description of how dev_pm_set_dedicated_shared_wake_irq()
  works.
- Link to v7: https://lore.kernel.org/r/20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com

Changes in v7:
- Updated the commit text (Mani).
- Couple of nits like using pci_err instead of dev_err,
  use platform_pci_configure_wake(), platform_pci_remove_wake() instead
  of calling directly calling pci_configure_of_wake_gpio() & pci_remove_of_wake_gpio() etc (Mani).
- Add a new fwnode_gpiod_get() API that wraps fwnode_gpiod_get_index(..0..), similar to
  devm_fwnode_gpiod_get() (Mani).
- Link to v6: https://lore.kernel.org/r/20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com

Changes in v6:
- Change the name to dev_pm_set_dedicated_shared_wake_irq() and make the
  changes pointed by (Rafael). 
- Link to v5: https://lore.kernel.org/r/20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com

Changes in v5:
- Enable WAKE# irq only when there is wake -gpios defined in its device
  tree node (Bjorn).
- For legacy bindings for direct atach check in root port if we haven't
  find the wake in the endpoint node.
- Instead of hooking wake in driver bound case, do it in the framework
  irrespective of the driver state (Bjorn).
- Link to v4: https://lore.kernel.org/r/20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com

Changes in v4:
- Move wake from portdrv to core framework to endpoint (Bjorn).
- Added support for multiple WAKE# case (Bjorn). But traverse from
  endpoint upstream port to root port till you get WAKE#. And use
  IRQF_SHARED flag for requesting interrupts.
- Link to v3: https://lore.kernel.org/r/20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com

Changes in v3:
- Update the commit messages, function names etc as suggested by Mani.
- return wake_irq if returns error (Neil).
- Link to v2: https://lore.kernel.org/r/20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com

Changes in v2:
- Move the wake irq teardown after pcie_port_device_remove
  and move of_pci_setup_wake_irq before pcie_link_rcec (Lukas)
- teardown wake irq in shutdown also.
- Link to v1: https://lore.kernel.org/r/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      PM: sleep: wakeirq: Add support for dedicated shared wake IRQ setup
      gpio: Add fwnode_gpiod_get() helper
      PCI: Add support for PCIe WAKE# interrupt

 drivers/base/power/wakeirq.c  | 39 ++++++++++++++++++++---
 drivers/pci/of.c              | 74 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c             | 10 ++++++
 drivers/pci/pci.h             |  2 ++
 drivers/pci/probe.c           |  2 ++
 drivers/pci/remove.c          |  1 +
 include/linux/gpio/consumer.h |  9 ++++++
 include/linux/of_pci.h        |  4 +++
 include/linux/pci.h           |  2 ++
 include/linux/pm_wakeirq.h    |  6 ++++
 10 files changed, 144 insertions(+), 5 deletions(-)
---
base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
change-id: 20251104-wakeirq_support-f54c4baa18c5

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

