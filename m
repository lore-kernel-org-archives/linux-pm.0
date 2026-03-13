Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B982366061
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385738; cv=none; b=euTqluHM5UJD/gVq5npzVOSgYjEG0vgsyuUG9n3GopLi4v7qZUDx3TDtgK5nSL7DULCleoOj+Lrdgfpvg4l8d05E6s/pwO7OJTKdVqcJf3kfZiseM8SmddfkMa5yJD6xSMx/BDI9m6OaQowXIAzvvYzP3/b+OPd6HldPzW/MkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385738; c=relaxed/simple;
	bh=jNYQs7plAlKB4GPMoV6aaPXbKYzbU5BDR/SxJA7HBwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C11CQ33gwEYmayHdI7JuQeJx7RR2ihQtXa/gqLE4944jXZ+5ckktYMNCqEfh5RwD04YRyekLQqokh/lGjUOeNMdGn51pkpyBDBo9HmWEImONuj7x1RoIn0G8mQaJQfN+Ft8w3dFII46oC1WFJWgKjx96CePVHffb2IjRJml97p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLpuaS5O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PGWCtmFD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLpuaS5O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PGWCtmFD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tdaL2017750
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mupIkLccalRDrukQF23t40
	a8I0ddQYNnwfRbZ7/jpyY=; b=hLpuaS5OXowV2oUZun+7CRQeFqOM+6pdBXB7Qv
	jL89mx8bOqpVSHTU9a7igawgeWkQ7tdbZW1DB+FtoOcVukDMB9hs9ePpV1RCcFOF
	Z1zzxzie5QYHRECvPvJBnLoVrZvqluYgv1/zr+D94+f4+nvvHvliim3+fAVXYM7/
	bmaAB4d6jP1J47vqjd5+XNBpJ8CaiDnnrVizs6hGFLJ7OSKHyDpSdO314fc1ulri
	1KTOvpULs83g9xOvS1Ffpn3YAiCkuuupxp6Jnwl7g0sXRXVLVBU5hgHI4n0f6LeN
	Sra+hLS/vnZIMBLrmJgbJ1s+ikrquhf7nS2ziRjkeh7B3vgA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4wvxq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 07:08:54 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c738f71723aso1075611a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773385732; x=1773990532; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mupIkLccalRDrukQF23t40a8I0ddQYNnwfRbZ7/jpyY=;
        b=PGWCtmFDx1NDrt0fSTw3RA7vI6njEDbP59Ucj+Sq6leP6cXDgmxdMd4LF94fQnSDWD
         n1kOaRyFZ40yDLDuiUt6a7JV6qGgm2OYFj0wWOrx7bKBiXZd+Bpp53PZeQGMBXMi79BN
         zcVESK77iluw7029v1Pkg1Sa06HWRM6j5WC3bPd+RxwjGsqHjZReDkIqOpkiXri2AXCL
         Vs39gl3POW/JgwMrqfecwW7Z4uR+5frbPkLPFU3oeUw8FcU/30/se9i+TzEj0rwDrN2m
         HJDvzGx6Byo7eA8+uxsbdHo/jiLhC4vBl0Oh8hheA9rmzbxbpsIEIguFkMadZhfJPjmW
         zIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385732; x=1773990532;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mupIkLccalRDrukQF23t40a8I0ddQYNnwfRbZ7/jpyY=;
        b=ExH/xx9FX0DkqA1j4Of3iXBDx8pd3CMmk6L4+VpwCtw/jI8bCbRUhhBYaO/jmT0f/i
         Z1HMHqlsvY4HCaOAoPII/uDU+qpHEBNUdfdqk/hhOimlVzKmf5Ge63pQQND0MhS2gRD+
         RusLTvK1QcdD58aPDliOqOGjlBvDtTdBr2GGmX0HBOaQSaU62lcp43PNHrGWFJYr7ewJ
         +CrGIWM3bVAX84E6uq3S95mvjRsNzqH5gTrqGv0NuT60t8bAKiusvUTkt7S8BeKIQb/1
         5AxyvHfIcmPkZSsZWA+L4xQEHN8plIucmXR779uj/2SukOXrAGan1qrWvWkp2Gp2T8HT
         aQ2w==
X-Gm-Message-State: AOJu0YzdclbhFH1gkl4tKKLOMPzbB8BRdKNn/NGRCLnf8cJbqIuzYDGp
	cS/Z86ssxkOHbZ5ouPTNaYA097OCRxL+4ChJMxhUFAKaicO8DafdrjwRPGAklaeRvxgLLcbBGam
	dKS9rvD0GdfEPdObreRrqgSRA75pf/BHo1pUmlYnLLK5ka71L4TDlBlQ9o1YxGA==
X-Gm-Gg: ATEYQzzRGJ+DmtH8UWxgC6qHm5vUyaDR8RWWVY6A13xULfxiTw47wSPO8mtTAIsR3xJ
	umoQxELVRzsnJXF2rwXS7Fwm0y41zND3ablYmjlkU8e5/8+5V1XbkK88z9hNaz4EMvmoxDAykk1
	yTrmNQIrYW1a/7rgNvX1YfGgpctv7cFmmxgOERBj5rN19FBC+Gi3/O7o4Kbn4MnQq/b08DVXYqt
	G+6MbfFHKnno+kRtvpteX4Iw9L0c3HjgVk3IOQKWrdVxL2RaUcF8JfAsC3sQ9n1ktMhIUR6qEPe
	ymsELvHRdIitwNkXyrfJKSuos5h6fM1AnKpyjSF8TT6OVYAWJPjI9sErahjDqKXr03gwRQ/++Nd
	jzbqFCNunbyzeT4Sup3BD+b6wiz4oMNHBUsUa9rz0jF6osLNyEOvIxsbz
X-Received: by 2002:a05:6a00:8018:b0:824:afe1:f7e3 with SMTP id d2e1a72fcca58-82a19722448mr1884724b3a.15.1773385732445;
        Fri, 13 Mar 2026 00:08:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:8018:b0:824:afe1:f7e3 with SMTP id d2e1a72fcca58-82a19722448mr1884711b3a.15.1773385731950;
        Fri, 13 Mar 2026 00:08:51 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340518sm5148536b3a.34.2026.03.13.00.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:08:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v8 0/3] PCI: Add support for PCIe WAKE# interrupt
Date: Fri, 13 Mar 2026 12:38:39 +0530
Message-Id: <20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPe3s2kC/3XN3QrCIBTA8VcJr3Mcza+66j0iwkxLarnpZkXs3
 bPBIKhuDvwPnN95omSjtwmtZk8UbfbJh2sJNZ8hc9LXo8X+UBpRoJwQYPimz9bHdpf6pgmxw44
 zw/ZaE2U4KldNtM7fR3GzLX3yqQvxMT7I/L2dLPllZY4BM8EskY4aCmYdUqraXl9MqOuqDPQms
 /hg6A9GFEaA44q4JaPA/zByYgRQor4ZWRg4MKGWagEU5A9mGIYXCnCEW0MBAAA=
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
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773385725; l=4319;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=jNYQs7plAlKB4GPMoV6aaPXbKYzbU5BDR/SxJA7HBwU=;
 b=y8e5wn+GPIWFPATU7djvUgfzIyrSOJk1QmKF4EOb8Y05aGRybZSoSGl1CjYqqn2eCTSY/H48Q
 Xxvc8C52XheAWv7lF1CASiJAd9FlqEZfXG+WtZCff7PkFasbX0Woy16
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=GcoaXAXL c=1 sm=1 tr=0 ts=69b3b806 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8 a=s8YR1HE3AAAA:8
 a=oBmXpkfWcQESfIqoYmwA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: zzrhf9Pnw6rUj-T2UQ4NWdJ3ASwFAGAg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NiBTYWx0ZWRfX5ef0KCIGVVYA
 F1xkFu42mmeqmfYlDXYFUnQCRi34Wgb0FadzR652eJ+V6En1peTJBxz045ZqQzcjdmDJsK0vvP7
 HUJpyz0gpsxDmICiGR5mIIEDLIgxVuuRfllx/IB/JsyJvS10kwSYKWXgWX5Hrdjyccld5J3ueVE
 k8GLEe1IfhZuGoda+NNWQ3edaOYkEQmxs6ahKPdgr8k/bx5PYBQEHQ6oUOxnvRmIlbZXHBhZPtu
 FIL9hzXQ+HlgRp7dDoAI88tx/jbCdOBjH14fhVvdcULcwi9tE1JsZa/7zHfRIZPapylaaGE/s7G
 9qo9NTEk+SAl2WgNWhmXdYGqqmMlZvc+jJih8cq6e+o8Is+osd9MnhHrktENVS3xRKvIWxhdm1m
 MXPGOfURSupKifrYfLbbQiRSQjaE2PTDGmiQ8heoCXS3UDhMbUrBik7iJPpCoXUiEhqUOfSaNzG
 wEtLtdfT4NZ9GvwzJ0g==
X-Proofpoint-ORIG-GUID: zzrhf9Pnw6rUj-T2UQ4NWdJ3ASwFAGAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130056

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
base-commit: b29fb8829bff243512bb8c8908fd39406f9fd4c3
change-id: 20251104-wakeirq_support-f54c4baa18c5

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

