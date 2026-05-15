Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582553B38A4
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840290; cv=none; b=edh53TOvKjzQdqJbYm+a3I60fOC4NQ7O+4rDw+tDTcCjtKTi2VE3pw+Y/ujkrLIoe9tdD7fm2mwOaCPfXV8yC7DHkCESq3diiRxclmDUtR8cLaPy0G/miIHvPYwQPM5HvKfCVim+dNpBZCY+uaCpZoRyLu4LRZKcNeLNqAxjQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840290; c=relaxed/simple;
	bh=fp4rXDHMI+TsCqseevlNwiYIftUlifpkg75ssIkoF7A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C8kRfP0LZUCcIQ92mNmY/7jGca2bHc68QuC/Tpj7w5GNbuuybBL9KuK1UJHhCoCY4+D3dI14nsveOEts5O5AdQzEUnwB4jCPhZkMT4XUnsp4UMx0uBDisu2GUm/F+0D1J33/h1Rqv+oIzdER0H2+R0tNzZ987/SRohoY6s181d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o/wuunIa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d3kQ8EPl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o/wuunIa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d3kQ8EPl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5Cb2h4008231
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kWY90ZN64g/mMK51PCkI1c
	YOEZZNPa5iD/EZWSO5kuI=; b=o/wuunIaL7O+ytDQFD7b2WH4fIs5Sb6i2ZHHZD
	RAaDhBw5Ylj7zO1nzpQnGS9xtABFBtDFyMlpgeyFqsy86hYJ8yj7Lz4/JRQbA/L6
	baCt/qybSLoD8/V4DyxY+u69WadZj8g9cTAUdT5CnjRuZzfHfTaDP0p7NVI/79Ga
	GQoEWPQfeW5Gtt6BO1JSCn4Sd5lyutnBFeqsdYF5MRnh4riJin1B514CQ55vsIk2
	STidMay38ur9Fjc9xIrR8TCgCpuSI0LRtxzxfBQXNmnO4U6Jyd/PnPuhwgH9Dkdf
	bORm0mQsGigPABPWRW7G0xRZrFPUBFlzecRb/XtTEw95vdsw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sttjw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f9429f49cso11494070b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778840287; x=1779445087; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWY90ZN64g/mMK51PCkI1cYOEZZNPa5iD/EZWSO5kuI=;
        b=d3kQ8EPlv+q3W2VyUdLpdoYVrsvmyIGp/IDb2BxGPXzkAS+uP89wfpNiSlx25lGRGa
         jUOHd10gYsiUE94HingTXoag+h+jUPOT8nmuvZVBaNAzgjgPBoeH0o0cx6BGKOsNFEt6
         Y/t6DA6EtTfcUYFFrgqL8iaX77JAzUAqQ/D8juX4mtp7ebM3O403ypOP+QJl4VzzT4sM
         EIGxzxfsE32kq3mW/hwZmRL0HrjZMaeIAPK0IzRnSZqCeYq1cArZOp/Jy2NolTwvo2V5
         xEvb4bt/+gMzJ6LGJY65k78tXB1dP7c3Zxes/oI8fv8sv4PRuMVqGrggVi8xxKcl0Gbs
         Ha9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840287; x=1779445087;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWY90ZN64g/mMK51PCkI1cYOEZZNPa5iD/EZWSO5kuI=;
        b=h+BycbwTJ5wli93mAXqmqiT1KhRXuCv65s/R7yBYXaBw8ShawBsL+2NpuuegOkuHVt
         I9LYQ5vb+2Vtk67QA4oyMd6P0u2HNnFo1S394sOQzzsIDl3ZMSH+rwTsf8ABGLmX2VzR
         6zCmNiVD4UCvJZER/RePXitsi+DgauE+x4iDjz5rq+vEfD6wxAx2Kn7dIKZh16ANIwPy
         W2gTKbk5Ee6RZn6eG0K7OCcmwFi43wgaV1oEGnz64zP+UEDXWayYkzJiHQxftgYqBLdF
         48BnAlDYQ7g2+FHZtbGyoRteJarSLhNNK5mM9C2QjizY+4AQhiuIBo80oC83KfJizefr
         LGKA==
X-Forwarded-Encrypted: i=1; AFNElJ//Kp6+dnNBEg2bxyB3X+WzwZhdl5jmxYu+bR+NkA3p2lhULRBIaqA5pUOmRUNKuzr17nRCq+XdXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyozGRxYZMorvR0DLVnzUvCWCq1ZMz5eTV/koShALqW8URygbr5
	nx5sx7EeYFDSSKodPTAHyxGypzhZppG86MXJ0SBmL9Fqi3R1KzTeE0rd0f/F3PajfEjxn4TjO6+
	j17VY28fSUgiCheHzYZGFw/9w2pgxl9pLu2i4rwMOgW6WduwHljz7fD83GguonQ==
X-Gm-Gg: Acq92OGYKu/U8xNFXX5aXTPH98LkHPqqKq0Uy7Bzyg4yRw+SZTnRksJYEZRIAYj86aG
	XoWLM7lxgWHhGmvO9nfGPsE3dU0Dl29mwcXBufsYNd2aK8NRvyCWGRuXbqFi4zPLBxlo4YKA3X3
	lfKqGFhoLTQxNL2OlTOyOJvDIzfvxFI9d2iXpxNako2zWnFNYY9An7joDLXj3eejE/VWrvFANAz
	zXQbKMZDVzJ0CT7/qycnGB7yKoxbFBiyMR6TSHV5mUsZNoXzUGHtjqmQe2JgxzvaidEENtb7WB6
	xg3ks1UkcVp2dAkTfvRGJ74P8Ichvg9axIGaGQeGZdJRLjCBR9QjM6VQIuMhHLXk1FjNMRO+MZA
	ECv6qIt7otaLAnbhq2dFB6BQPiYUHv/gD6ethsmaEXHRAPn5T7q4V4rRp6lzQuB4IcfvDIdDECv
	Q6bdKmLq17nh6BiWHXWhEOlFWjwMfn7jI7ZCMKeccHxJ1otFC5HPo=
X-Received: by 2002:a05:6a00:a203:b0:83e:e897:a394 with SMTP id d2e1a72fcca58-83f33c34a8bmr3943998b3a.7.1778840287032;
        Fri, 15 May 2026 03:18:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:a203:b0:83e:e897:a394 with SMTP id d2e1a72fcca58-83f33c34a8bmr3943973b3a.7.1778840286542;
        Fri, 15 May 2026 03:18:06 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm6878482b3a.49.2026.05.15.03.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:18:06 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH 0/2] Add support tsens in ipq5210 & ipq9650
Date: Fri, 15 May 2026 15:47:58 +0530
Message-Id: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbyBmoC/13MSw7CIBSF4a00jCXhQqHAVkwHPC5KYqtCbTRN9
 261AxOH/0nOt5CKJWMltllIwTnXfB23gENDwtmNJ6Q5bk0444pJkHSqOFYaS56x0K4zHlKrotO
 SbJdbwZSfX+7Y713w/tjUaR9/qG3+yJcbLlQmCV0wrfba2Bk+pncVabgOQ55sg0ZHDgE65hnEi
 EkolRgX3qeQlBcgmUlOC9Kv6xsKVx0U3AAAAA==
X-Change-ID: 20260515-tsens-driver-779b1f46da85
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: i7ThQoUqpLICN8yGIlDVtuiP6gsFTKpO
X-Proofpoint-GUID: i7ThQoUqpLICN8yGIlDVtuiP6gsFTKpO
X-Authority-Analysis: v=2.4 cv=cZPiaHDM c=1 sm=1 tr=0 ts=6a06f2e0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=DOJe6fkaggpdGCZYqIUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwMyBTYWx0ZWRfX5Da8jqS70u2J
 Tc5Tndr9xUjPjkPlrQm57Zpk8RtWm1a+JGnsly1f3cyKrDE+5Lxfry3SxuhIW4oAHibN6IyzVRr
 v7xhdDPY1WsxhVcYh9O6rVpBU4i2m4+bo8eUbmc5WnJAzcc6wkBlJ34IiUagNqMk8FRpagQW5BE
 Ttb1mMfOOmWV0tCD/LweERLj8oMORCQbBxfmPI9urSgo0XiLiu4mN+Jh7XyY2+j169kHogmral5
 G4AJf0RuF0KfNj+GsYxU6O7GYHBe0R9CTl9FbFfqk5TFLd83Cgmh8VZawpBx1qGdJWspObDzqXo
 AURgtC050mCHY9agNFzMi8WziF+eKRmJafeeb1l4TIvZYbLrvQjXAB5FekhUIRKPataJl7vsrDG
 zXuEkjA0UjbYELY4FQ/LW8ijnOBp2ub1Vc5YL15UX/Iw+yNFN3ecgf+sHXmc+NvfOFYrr5muwOm
 j8i9/REC12wmugFVeCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150103

ipq5210 and ipq9560 have the Qualcomm tsens-v2 IP. The tsens framework
in these two SoCs are similar to the one found in ipq5332. This series
adds the sensor data to the tsens-v2 driver.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Varadarajan Narayanan (2):
      thermal/drivers/qcom/tsens: Add support for ipq5210 tsens
      thermal/drivers/qcom/tsens: Add support for ipq9650 tsens

 drivers/thermal/qcom/tsens-v2.c | 8 ++++++++
 drivers/thermal/qcom/tsens.c    | 6 ++++++
 drivers/thermal/qcom/tsens.h    | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260515-tsens-driver-779b1f46da85
prerequisite-change-id: 20260515-tsens-yaml-5f517c948b89:v1
prerequisite-patch-id: 23a443cf15da9852d647ceb75a1b7ca98078a1e3

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

