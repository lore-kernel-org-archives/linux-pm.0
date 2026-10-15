Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26A52CCF9
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069121; cv=none; b=XqSz7cCo0oYmZ+feE+N1SzrVLwz1EPLHV7mYVRpGY+NoQR0rcsdO31CHMxFk0LIKRjjRCofGj782J4/xh8jIA2rUijcMmqpo3EZntPqDHSbHFOHDREimmH8Ollq2cF8sh5iaQ20PdEo8GoYg+49HudJrtc0YFkh2qSHw+YwGSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069121; c=relaxed/simple;
	bh=v70FRW5iiRhX/4+aCXUZxMXenF3esiNtKu86as7Ptlk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iY4DoAQkBGDt9JO02JR41JXX8cbMkYY2dpyhN88mxuUR4eNVjBxGs6eXNBhapzrS9fh/j+C9n7zlXdU3u7YyGdByXPGhozac7JCRs9Gh/FKevlWsfBKOkEm/hHhpc4c/2Gi4uc6YSQiOEw6/zaIkiHXxVdEv/SZKyZB5QKpiiuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKljQCPe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UzwOTpSZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKljQCPe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UzwOTpSZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kGH92999177
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fn80m7lvIkTjz807COGpVE
	82JK0kaqF+rlFlpuCly0s=; b=pKljQCPe4m8ZDljQiurPI5am68GgBOMrgcdWYY
	7qp0lbfjVuJmJiR1wFrlmBprCAZ1IYBJZajlZcYLnoWXBc/QxDMGKGMYBXRbScml
	YyQrb7HyJgAxVpdBxrnVOa9ps7CAU48f+gkbPIqjUcrPblsoo0GlS/ZrHdK21Etq
	mg92OeS3LSxAP1kFuVgTkzIDFPcEA9YJ1JEKMQfduWfeQT4teghicjS47L60aesO
	c5NluH+rj8SiUjVw8Db7ENRUcm0D00dLSqoP07fmmyajp6vAlvOUVNp6/OloNHBf
	TkO36L8XLx6dT85GTYQCOJMplll2/gTDwrARXjqOX/JFY9RQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hausm10q5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:58:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa4e4684bso29933575ad.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069119; x=1792673919; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fn80m7lvIkTjz807COGpVE82JK0kaqF+rlFlpuCly0s=;
        b=UzwOTpSZt9VEGtO/vrfcYI8Z/y+BMCpI0/Ht2epOuidC7nem9S5M/yzrXJ/z5OcYSJ
         e6ntvGbXjVJ0yUrAYYEWpUQ8Qz2sJFfOncO8MekN7Hsuve9H0VSS7oivkWTzokMGyE2R
         GKzZBZKSv8+BK8LVpWmbQuF/hQua8J+ls3pvs9GGP4Q7A5rYwK4TKl7WSEQ5yYUvcc+1
         rlsD1D+JhHq8es/jOIGKgyxpqterDwjurG+qDOjGi6W7NPmAuvWz1DBAySJAyWkX4EHU
         sAk+e+oCQSkmr3DZ8sToyIfhs9b//x1d1B5IVguT9qjHysdPtQIh1svEEUG6f/9w8nVN
         ZrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069119; x=1792673919;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fn80m7lvIkTjz807COGpVE82JK0kaqF+rlFlpuCly0s=;
        b=zZ+0Au0JF0B7q9Ve6Unj4t1i/rean/NZ3g2/q1qo3tYbJT9ecqYG1ERHL27+k8+2om
         ONO8Zzeojw5DDWsqlg6evds/4CmodCbFdXRDfC0Efa1yqaHazlRBvepi5jy1uVgfjYGv
         vlAHJVPk5Dl6l3QGKFW9SkLfwZ5uvn2o0Ja5UkyW9+RpxkPIgcNc6375CXnP3Xo8/IeZ
         sIHubE90/IRo9zpC+rIWtWyUzXmva6+/GYCbvbqXcsDUmHGnNLrDHa0izt1DDLfWc0O5
         +KDgTFIigPhidsUKcyf9T2a2bfBQvDYZE0uuuNEmdXarVQCYH3KLZWyiaz4FIK3WtsJ8
         +6jQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYX5hulF/6q9s+5TIsYWio0xmJgldKYvcX7rW82SojrpJ5CgnB3lf5bQOZeL/q5CYY7l3jAdmV9w==@vger.kernel.org
X-Gm-Message-State: AFq9FYLeqNuN9z1zCAlvgdGZziNYItXHFnnbjtgxqaqK9SSdWGSwylbh
	as0wlwJjRMkxd3gD4la5fimApqa9ujVsAVKBfKT+K3tz17ovH4hB64Xex1X/cRPqJl6wWDa6wLc
	5vQxcHoGzL9DXZyfvxzhi3ifSujeIa9Fm+5tfkOza4SMMEwfV7PAV/8uTHWhHuw==
X-Gm-Gg: AYBFou1j5+4h/AGWbYNCsNmtFxw41lptCOCEvetw2HORfo/+QmPAWtb9a8NAD4GNuJv
	ZJm27FjIZRoJstALZixuUMGN1ZSLnJo8rPtTtVfjjxjce7KVG2YniXmsoLOO0hiXfMbUuECkDtQ
	ZVLCuFhbha5ky/uh80L4++u4LI6DlX7cX1hrkV3D2EZG3SuSPHihfb6nK3RUHk3/YkO2OGgMHsS
	FTdQzHIGADvgXpvxFM1FUgDkyioDO54UW7zKJzX5LBmO6mGrI6p4OzjXcgLazSZH0uV6XC5akI4
	eNJOxJd0Erd06ljsRj4TesO7jn4f4eh/nJZjIuLv/qmF7tgtFnSSTfIvke5YlA4wP/RPHrx7Qpy
	knXn5pkEcKhAAAsgBZn5KKrB4YhFU9rSZYw==
X-Received: by 2002:a17:902:d50a:b0:2e3:1bb4:610d with SMTP id d9443c01a7336-2e842f31562mr166590005ad.50.1792069118607;
        Thu, 15 Oct 2026 05:58:38 -0700 (PDT)
X-Received: by 2002:a17:902:d50a:b0:2e3:1bb4:610d with SMTP id d9443c01a7336-2e842f31562mr166588895ad.50.1792069116492;
        Thu, 15 Oct 2026 05:58:36 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:58:35 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/8] soc: qcom: geni: Derive SE clock configuration from
 OPP table on SA8255P
Date: Thu, 15 Oct 2026 18:28:20 +0530
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzN0GoC/52OzQ6CMBAGX4X0bE27RBBPvocxTX8WqQLFFhqN4
 d0tevHgRS+bTDLZ+R4koLcYyC57EI/RBuv6BPkqI7qR/QmpNYkJMCjYlm2oSX5EoduLGNDXYlS
 tqL3r3mRcJ20v3DCIUaoWKdRQSZMDQCFJejp4rO3tFTwc3xwmdUY9LpXFaGwYnb+/FkW+eH/HI
 6eMFpyXXCqujca9C2F9nWSrXdet0yHLhggfFSh/rkCqsIoXVWkUKgZfKvM8PwHOdkKGawEAAA=
 =
X-Change-ID: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=4235;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=v70FRW5iiRhX/4+aCXUZxMXenF3esiNtKu86as7Ptlk=;
 b=u1m3iW5BCkVT1gNC6NXOBIobcvi6p6ZecmCB7PJ6QxVqlmRw8ffyqb9rCaDH04jFYYTlQZXWh
 YSWnLJ0Bgu1BjkBTlL/XVn6X+JoGHcmU9dOvlGgu3Qc/pr8Uza3vAAY
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: HrQUITEMEKQz1K5fyqqdK-HiaMRumbb-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX3xK55B85E64l
 yxbRRtJdFuei0E0pVm8xAPih0ZVkF9PZtcuymWPdVIQm+H/xlruyNrrJTMNzSRPI+x657vVGAf9
 ygeucctsjySYJozIRmAwH/nZZfXrxXRBYaNn3eHc/U1xyjKnZSlOTFdMdPC9LkoktpJx/B9TiSi
 R+IolranlGu46EBIrtL0HC5G2u5nLCInB5YKqDWmOIG1KQkMIJ2jf//dPFe2aV5iI5zv2sZByJa
 YCjEYtbkurVOU2s45dMGloB0HmY5kNKSHKUudgBgGdsTMT2Lbl5NpWujWuQR+rOtB4erW/hZ4Wz
 pCzgg6b3+azcNRAhm1SeQSswm/tnxIoMyQQGBL1/9ZRXOurppyzX6vzI+UBtmtOs3SxwuMDFQzD
 sKT3w1gAFV7OhddsnbMAXq2M+JN/0Zoy9nEkSbH8z+UgrQgl9ZoqTkKSiZT5Y0BkOSDi8dz7OpK
 6fA2bRk8I2K9OoRLxaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX8pH+hzIKjZwy
 OTxU+9mnU3yPAFa80GvcwfyuO+PNxCcjg4uV7FYGBgkznWYPInketB8dcBmPsqXzMetwxuA4tAL
 xQoTbuYAPSbGCWvvt1eAVt098ilVBJw=
X-Authority-Analysis: v=2.4 cv=Eb5d0/mC c=1 sm=1 tr=0 ts=6ad0cdff cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=2LTROXezBIF7KgQVBLEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: HrQUITEMEKQz1K5fyqqdK-HiaMRumbb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

On firmware-managed platforms such as SA8255P, there is no Linux clock
handler available to determine the appropriate SE source clock, source
clock index, and divider values for a requested protocol frequency.
However, these parameters are required when programming GSI TREs, where
the hardware expects an explicit clock source selection and divider
configuration for the serial engine.

In contrast, platforms using Linux-managed clocks derive these
parameters through geni_se_clk_freq_match() using the source clock
information stored in clk_perf_tbl. Since the firmware-managed path
lacks equivalent clock information, protocol drivers cannot reuse the
existing frequency matching logic and instead rely on a direct mapping
between protocol-requested frequencies and performance levels. This
creates a separate clock configuration flow and prevents
firmware-managed platforms from deriving the actual SE clock parameters
required for GSI TRE programming.

To address this limitation, the performance-domain OPP table is treated
as the representation of SE-supported source clock frequencies. During
geni_se_domain_attach(), the OPP entries are used to populate
clk_perf_tbl and related clock performance data, allowing
firmware-managed platforms to leverage the same clock frequency matching
infrastructure used by Linux-managed platforms.

With this change, protocol drivers can use geni_se_clk_freq_match() to
select the closest supported source clock frequency for a requested
protocol rate, derive the corresponding source clock index and divider
values required for GSI TRE programming, and apply the matched clock
through the OPP framework. This removes the dependency on direct
protocol-frequency-to-performance-level mappings and provides a common
clock selection and configuration mechanism across both firmware-managed
and Linux-managed GENI deployments.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Added a return check for set_rate.
- Remove redundant source-frequency fields from clock tables.
- Store the validated frequency in gi2c->src_freq.
- Use it for OPP configuration and runtime resume.
- Preserve exact source-frequency validation.
- Simplify OPP level iteration in geni_se_domain_attach().
- Keep level initialisation outside the loop.
- Increment level explicitly after processing each OPP.
- Link to v2: https://patch.msgid.link/20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com

Changes in v2:
- Add new patch to remove OPP rate reset from resource deactivation
- Add new patch to vote source frequency via OPP for I2C
- Compress the SPI, I2C and serial commit messages per review feedback
- Drop a stray blank line before trace_geni_i2c_bus_setup() in the
  I2C resource-initialization helper commit.
- Link to v1: https://patch.msgid.link/20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com

---
Praveen Talari (8):
      soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies from perf OPP table
      soc: qcom: geni-se: Add helper to set SE clock rate via OPP
      soc: qcom: geni-se: Remove OPP rate reset from resource deactivation
      serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
      spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
      i2c: qcom-geni: Vote for SE clock rate using OPP
      i2c: qcom-geni: Use common GENI resource initialization helper
      i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

 drivers/i2c/busses/i2c-qcom-geni.c    | 58 ++++++++++++++++----------------
 drivers/soc/qcom/qcom-geni-se.c       | 63 +++++++++++++++++++++++++++++++----
 drivers/spi/spi-geni-qcom.c           | 24 ++++++-------
 drivers/tty/serial/qcom_geni_serial.c | 26 ++++++++-------
 include/linux/soc/qcom/geni-se.h      |  2 ++
 5 files changed, 113 insertions(+), 60 deletions(-)
---
base-commit: 1fffefb00cc0b0da1f2ae24e3d33364530ea6515
change-id: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

