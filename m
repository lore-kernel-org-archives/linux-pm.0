Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030633EAEC
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368258; cv=none; b=ATYQQpiAzb+/pb7Tw1k+R1aXnGDjyegpkADeuZM7yc+oX/ArWdd65Jr5QFZzfsvp4nzdlPCXKfiniRmNfUgM3Yll2U/YQGnY9shBHZG2bH2waJuXQa/VsHklCaBDfDnqnda0hZ9dbHhGX0S6DZK48u8UYUskGqF+UUNmU7ky8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368258; c=relaxed/simple;
	bh=PVsMwaNVpZd4UiWHqxTTws5LFW4YyUdvehtqzhFsSL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oHpB/39gokYH6CaLyvoWKZskndI9NuZSq+MwgG2aEK479zV/MhUI6fg45+ccE8gazOf/8gw8NkNWqC12OsdbuQtdPKPx/xpVqvBqMBlzTn+UA8p95eF3/I31VGEf3oJjN6rfESyzqZ8ZP+Ub7bDOwUXUKXAOaXgKECWn5gxd3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3UvdQEA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XroZoowJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3UvdQEA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XroZoowJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5jdsp237805
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 06:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Q3VwgneHH/rWpuPJKdEurX
	tnPpT2xnItEnNcDucOK8k=; b=Q3UvdQEARWayoePybyNiUthloz/XXIq//Cx40r
	wwBMAQWF0FVTC3t7P5zgJqfzTkET6pyw5DAwk/jQLknyNlrVbwerIZg7/a8cICdT
	sjRPVzUKyx+kYSdjMxTn6wUn7QtD8tOfID/vtYgqDnJTycyEkoWaCLvp24Rp4JNS
	yjUQy0805FR+ythqZYNB3VYaNKsJbXLes+t4XWFfrw+SziEszQWgKuXuJyh0Izd1
	EyyXnygVW1upmdgXNRShmxGWPukFCjoxqfXg+NoIuvTl8BUiYiM9nM05Td63cp6+
	Selii3QFpZq2CQPK4NCAfQzjkf/k5cbXyFnAxS/YtF69tSzA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dnd27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 06:44:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a1de6d5c3so174196485a.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 23:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789368255; x=1789973055; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q3VwgneHH/rWpuPJKdEurXtnPpT2xnItEnNcDucOK8k=;
        b=XroZoowJvBVJoT+qJhjt72q762Pn4DlBcpGSDiyn1HPrnqauQrIpK4jb68yhB8G67J
         YQstVGFwWRrxSFOR5GXdQ/RhqqnjkVvkWfo0OIfA/hweXQmYK2juls2EF+QA9wd8XLIR
         iO/bsCnnVuYZ6VvDR6O1wo4uVKgduYedh5rM3F6y2A1Z9GdrGT7XSqrw959MKKQbQEif
         7AA1H3cDTRQx89L53jYawuQH5Wwgzy4YzgUD8DiHGJzdDoPACymVBShI+oqSbI12aLbQ
         sJyDkOAIJdmOcotYr7g4L9l6bq8TpJus/CWWjXoWb9FGGcOlZAEDiUt0gaMo3Su5laHl
         8w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789368255; x=1789973055;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q3VwgneHH/rWpuPJKdEurXtnPpT2xnItEnNcDucOK8k=;
        b=CR4o0yPWsMwZOAr8fb+j23ZgOwa1hXJKP7A7ZEJADVQDL/RXwhaI29HfStxXLHLgIt
         KY3XDnamxFFpdYQYMEqziQ9dTyo81ZTM1jHwYBHpD+BAfLW9qwg3XD6zEiiYDnEE65QE
         s3kbx4chvXy1O8UxLZ9LGPhxvf2nj7qhWbKXxwsYtQ9SHKPv2SldKszjrNgApBHoDBgA
         ulfIK21xMQ9OvD4gkBQxrn543l9BLeEaTeUriJzKObqYmFD+uTwL91IWswl/Tp/QWc4F
         +OghLp3uCWj3lZoJryoiGKkKjPycGq0Tt39u/2jaffzo8ikdW2hhrygIl+GqVGhF828X
         rZfA==
X-Forwarded-Encrypted: i=1; AKwUvBzEJxmYooddaHvqoLllYsKHaDRq3B9ruf29qiOBoj1N9UXoeGj6c6F2gp6pvA3KJeKoNW3LoadV4w==@vger.kernel.org
X-Gm-Message-State: AFuF++lwCRf11EEGqSfpsoNEAE8nIO2VbTSTk7KV8KDNrZv10eXPEKYt
	Qj/xCOoQBBt92ms8HzxpuFVrX2sN1NvGbFaJZD7NMazfGosq5D4vIJr97XNLZV9CeHFekXHluoF
	bsfD+m60nSDzZI8kreGnB76PecGAwywIxXwrz/E3PG8JOVq1dHcJ0vMZsxxcf1w==
X-Gm-Gg: AYBFou158tkMcz9Gh3EveYQfQEJKUqPDDNMdEGvrdMdJ0zApTUK9cXfukp5D+5RwL2l
	GARJ7nxpDL9UGj46eRO7w4Ml8oaigTyRPStKFycm/gRj0HdUpcXs0BZokQh1YAxg90/KooevDsS
	j5iixyMKQtxc7ravKO2wPHptkkdMHmkdt7y2Of14qpCL9+rF/sNoneM+90iuHmdvfWm5uD5k2e8
	Laun/iaPOqmDlKm4Lg5A200CQdPlCFNJigRIf+lu/9JkuvvzSI0qe2ermtXbQ7A+Mmdf63+JdSg
	Yi+cKfyd8b13Q/KxxATPFqRrsm2dOe8zq7f8c8k6pZxddL6ud/nJW0EsBGAlUlTIj3vkc7mvl1C
	/N60XccHk9xspX6/Bk1RYWcA=
X-Received: by 2002:a05:620a:8081:b0:92e:541e:632b with SMTP id af79cd13be357-93a2973d12fmr196483885a.2.1789368254925;
        Sun, 13 Sep 2026 23:44:14 -0700 (PDT)
X-Received: by 2002:a05:620a:8081:b0:92e:541e:632b with SMTP id af79cd13be357-93a2973d12fmr196481785a.2.1789368254453;
        Sun, 13 Sep 2026 23:44:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35f3d9sm23736954f8f.35.2026.09.13.23.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 23:44:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 0/2] interconnect: qcom: Some defconfig/defaults
 cleanups and improvements
Date: Mon, 14 Sep 2026 08:44:03 +0200
Message-Id: <20260914-interconnect-qcom-clean-arm64-v4-0-5b2c0e6a929a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Oza7CIBAF4FcxrMUU6J+ufI+buxjgqBgLFmpzb
 0zfXaoLNxrdTHKSM9/MlSVEh8Q2iyuLGF1ywedQLhfMHMjvwZ3NmclC1kUpW+78gGiC9zAD703
 ouDmBPKfY1SUnGEskUCmhWTbOETv3d/d/fh85XfQx787o3Di4NIT4f39gFHPv21uj4AVHrY3aN
 a2SVm9DSqv+Qqfc7FZ5sPnkKJ9oJapPqMwoWUCbRlXr2r5B1RNtZPEJVRldlxIt0EBbeoFO03Q
 DRK+/K40BAAA=
X-Change-ID: 20260428-interconnect-qcom-clean-arm64-aecdaa1e531b
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=PVsMwaNVpZd4UiWHqxTTws5LFW4YyUdvehtqzhFsSL0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqp5e3XUKEdpklYVPyX4YhJsTH0XW1kqsPtqwsw
 v6d9wWinBCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqeXtwAKCRDBN2bmhouD
 179fD/4yaUDPB5yPXczOLrAhAfwuQOReVZ7J/ETEAmeKvmEsZn1BGhrNUUgrbI9Xh5x3VnL0MC4
 yE7wQkgPaIl2yB8jJcvQRI0MgxGX33Aorp5M5iGhyN3ZJjM2POjzO+bzZeNQcMWQVEmXVvK3GXP
 WwRb42ZTH4DuhoEjWfS4NoqHlRPWBR04yelX/1LLM839lmDCkSid7HGYO6JdlkodveOn3wxBz2/
 DWxGMNlYQsuoeVudBinUncv3w0QZurLOE+bsyfTR6KcN2rWeYMEWB1FgCI0gj7fOXnXD/zfXKdD
 YvTBocqbclU3J5u/MAcyjGs5nGf4aGFKASP0RDh7TU5nsIdpNZk08VFyW087d1Vh0FMbN1f4m/Z
 WzFHcfIrj1lSygxb6CzWt/Xy2h+C8/fXXk/hh+JvM9uuKEWxcFDjviaRHb9811xWuLn8SOzawmp
 rQwfbSRPzPiKdQxXTL0/ZeRczTVrmxszDIxFrEUu1p4Ts/Mwx09utIo3DYkifo8Os+ArJFuJVlD
 zrLpP7AoVD8xb8pBuDspxFKCeghX58jRXRFR1oGWKXexHp0zT8YBrmCq3hBxuQsO/4DAaeQtQP2
 7e6qJqFEKToDCfQ7FXHZbF7VtRZuAt9tNrbZWlEWo13PXXaBt/rJfwrMgfobmRyFd5HyABCNmEy
 Mp30oBtd5E2+b3w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 0tVw0MNfxiPbuhMend9cuINorEWPovQu
X-Proofpoint-ORIG-GUID: 0tVw0MNfxiPbuhMend9cuINorEWPovQu
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa797bf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=tjA5nVWDIhs3vSZUhDcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5MyBTYWx0ZWRfX3pFls2qN5GH7
 jbb0DmZ+deWceS4cmLHbnif8X9XBeh0PKJkFn/MzFyBDz25rvwSuYTKIg5MDOm6z6uFI3hZnbS7
 YiDlp36l0q0+IMJIMnT2JuHUBuM6d3I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5MyBTYWx0ZWRfXz5fnhnKFoZMJ
 dzXAm97+gvkvPAAIYdjuIkcjG7dYKS12/LYNnb4YcQzZl114jqZ+QCEaF1K/k3EoUpxL61KxJ2C
 QveUIakFPr1BKqmm2eAjgNnrngPdQJkb+tM9KiB3Dxjmr8Pvl4dprIATSsYQKZLsLPXi3BjXduP
 mEd6PK7+fbDAwhX5KFTzve59nskNH2IcGZPotaj3hxcDSIJbpeNysL6KcSb1AaUKSgel6vbSaKb
 XYyf2XGcUJgcAtTPa2xSPyRTrlAvw1fwTGTQx341i3RH6VaJJ7VRKThDlKAmCKsIwy2eObDbXPQ
 d9nvLwdKK/NTHJPp2K1X1od2UvwAvVG0t5nNVcO2ch5E4tWOBXkmLbV7k6CC6wjUMi8MoxG38Tw
 wXO0nkA+zuotVvTpvBdXfOKFxlGIk0tYAzOopty+8tEKMelEUu2pVRKYuH7BSWVFSyVk439toGp
 aloIlZYY0mMxOB9k3BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140093

v3 was not picked, can this finally be applied?

Changes in v4:
- Add also Shikra since this was waiting so long that other drivers got
  merged in between!
- Split out defconfig update.
- Link to v3: https://patch.msgid.link/20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com

Changes in v3:
- Update also Nord and Hawi
- Split defconfig to separate patch #3.
- Add new patch #2 for arm64 dependency for Hawi, Nord, Shikra and Maili.
- Link to v2: https://patch.msgid.link/20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com

Changes in v2:
- Patch #3: Switch to built-in for everything, with explanation in
  commit msg.
- Tags
- Link to v1: https://patch.msgid.link/20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com

Similarly to clocks and pinctrl, interconnects should not be a user
visible choice.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      interconnect: qcom: Make important drivers default
      interconnect: qcom: Add missing depends to Hawi, Maili, Nord and Shikra

 drivers/interconnect/qcom/Kconfig | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
---
base-commit: 15331b9ab4bdf066cda327e4f99ebee61915e68f
change-id: 20260428-interconnect-qcom-clean-arm64-aecdaa1e531b

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

