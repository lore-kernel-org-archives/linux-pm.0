Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779797;
	b=pSZ66geOt0CrWEA2TFZB5TRbeoC0X34A674gfBZgUw8Vll5e6ynUmSPiMqhqodKnql9x
	 zOWZYUeMVJMO3/YD6aVDaCEyA5FXZ4H2NChEgdiBQyZN7ZS7IgID/haiRCFKwFjMoKiSS
	 xtFnmWP6iCWYXQiH9TSBjPjAx46dn3tA3Z3ijrGhrOQ8n0oCFubgPC39X87wpXhe2l3O9
	 nVWnzgyxnMXx9+eEgRT8hBvJfyUe8TQatzPlvkbS/Y0IQZYy03imR0mlFX3rwqjzpRBhv
	 GalDz6Xyn85KPira3VIMatG7RYP1ydnIlDxGhcpi8++Cvrw+9Addme+xvJ5aGv1x/Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W4hdi13GHlYzp+OY02oIK20xUZuO13ngbeGQEaJOjyI=;
	b=sJSRnOqs1AFY/BqPDR9xyHDexBMwbAjKqoDULWiHd099MZfTQU0YB1VZFlDamA7D1z/L
	 o0vhuyEUe7F7F02VgfrgLSTcoovggKdsNf3cfZtwKABP6AhmjT6YJAmkRNcXzoLqL2WqE
	 33iVTIQ4u0YhypKTUFUgE5wECEjKdDRxPMgnoA5HZvII3pSXKQvOW2WnLcbOI6PYKj1Im
	 XSSmcK+gOLXAEyflREcN1QQWmLZl4REXA8YUlVZHQVu64nW+QPmz/u/XujHTc5NWGqNNZ
	 yWll/jEsSscZxwFj5OuwPgjfhvoDVUC8+F8DTQbNPaA7LCD1EEtx7AfF0BIFOfKl5Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XTjHcMpd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HmxRrMnu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF78606A321
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFF78606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XTjHcMpd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HmxRrMnu
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApACx2906432
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W4hdi13GHlYzp+OY02oIK2
	0xUZuO13ngbeGQEaJOjyI=; b=XTjHcMpdxoIIrVdi4NLaPNZWUk99IG1NCqA4UB
	G7QXLw48O7SFXYBKJIZCdv6gL9dMAOKjml3XgPC3dDaRsKV7of8HzbxbGXvWhvLc
	y+DyqVZIGmYqRv3KEM8tqS6ns4kMucJz7jS6WXfzk3VI7SkLLuYvmdXx5Exnrwaj
	LanI5Bh29db7G6b7yo+FhqdNmXziHQmJ6OC6hTQpOd3+GDW06RdoyrF5vkO1q9k0
	0vAdjYw0eaDx2B3Rjs826QBv09pp7KG7eQFe/XZ17h8R4PYd3zL3vbOxQXJaZNjg
	s535o2LIUdCwVDfTJdWHEoD8NbWGCqCPOKtHnb6y0LhoMWhg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf93b8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:43:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e92aad34aso1345825185a.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779795; x=1796384595; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W4hdi13GHlYzp+OY02oIK20xUZuO13ngbeGQEaJOjyI=;
        b=HmxRrMnuHX52CBbWjNEbAVkUqFy6qNAACWRF8VM8DbpP5wyf+2DHMIruGSqlPEjUHV
         rpRo2/02PmeYw25oDLqdW9RKhqBv771f2Kit3RnhUqbI10+uMq16uCnfWfwdQVFKl+J5
         HCnsSAokahXFQPhvomKm8qu3QnsrNFKeq4bXPmCYGOD9RngMBEhiHY54gJe5BiEGuBpe
         5Q0mdJ35UlRvmZxJB2zA/8uneHr6fuGXNvy9/ZH3llEznFvy63EbpbCDVTM7hgj9wxqR
         uUC6hrSjytu6xEKKLXmtcttRjpIFmcMERdKdGIfRBAAwYLSERxBljiFUK9t/u2KX5iqS
         Qf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779795; x=1796384595;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W4hdi13GHlYzp+OY02oIK20xUZuO13ngbeGQEaJOjyI=;
        b=J+27LdNx88XP1g4e6BnaJmWZmne7NVUdAr+53P5RwdHyWqBFjFnY0OB062Cnl9+mpu
         p/Z4rnBRHGVdZpEa+B0zW1D9VSnqDgvCPcSUqlyVNUpLdoqUp3G2Sqy6+VWn1S9s4D9d
         NnuPZBbhrfGHakRZQuNHCKtH7RSMOHMj6yI5Qm/MR6Xy6YHVmUw+IcuT87htBT4tZML8
         Tq7Oxg94+v1WRqk6DDtjp0JXbWhH3NhGt6qM+yIshcNmPZWfUM/4lV2Jw6YQLzmjsbf2
         S21s4ae50G7qxIpHTHiOFqKBvabgI48bXcRXEz0cuhwm7/bMgWteJzCrCx350BAEbMVV
         Focg==
X-Forwarded-Encrypted: i=1; AL+hErFIiX+D/mseOKCYNl9drb6TEcRGnWTK/vKvZA2ZA4wsY9mL4Zn+8QeFDKPH0dbdt1NOvDHoHep0KQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9c+RLVIxjk2HJWY77F+psANraS1ePYYET0oPoOo8ggNqjSXdXr
	zgpYn5vT0vsuB3VXY3LDkqDpONMuNGyyWMSO4bLHllJcrwqYHBbNwfpW97XVOMeL+lU22irED9+
	fVzFZ0Xme1jfiavfu8NX1/a5Wi6Lv68W4WVKMsm5V/rsDHi/3OMMAqoayLXSV8A==
X-Gm-Gg: AZFdTZdPjsTWgFq7zgq2HePfb+VKLv97PE9YlNurBYw1H9ANYoSdpubD3IycrwlalXC
	LZowlTCXod30/uZaXyoEzem7kzQlRexEzzsrwPABQHq+Tt3axybqau2w5NbApKDtuwHQCvDc8qi
	AVTTuT2C4fIjJmYMX2q/Fd3F2zSKD6gs3GewMx1KEZmkZxxzOU+r0in3MKy/EL3u3qgzDreEskB
	XTT/8kZldoKFyqLYg4PjKVVo0g939Vf9QG2I9UucTR/uzeyN+FLRleTiP5/Axr2r7/X4WkZaBOF
	Yiz2nJ8V6h8CEEkXmYwyvAQgAaenv0kB7WUWfvH7p7pBYC4a8VUY70elC2J+KfkLRrvogW4YIAm
	W5C4QgwwV7QUwyxa38bhJEc9wsVyGMC80fLdKA4esGgl39VAYD7JovfyXOXGyPFo2oxfNe4Q11N
	uA1pP4K4jU4EF6lgelZNJDWK/nxrGK7SGGmanHXnwPDun14A9ro83xEdmemOeJlng=
X-Received: by 2002:a05:620a:4488:b0:949:91c6:973e with SMTP id af79cd13be357-949bab66f99mr4293534085a.65.1795779795095;
        Fri, 27 Nov 2026 03:43:15 -0800 (PST)
X-Received: by 2002:a05:620a:4488:b0:949:91c6:973e with SMTP id af79cd13be357-949bab66f99mr4293526585a.65.1795779794594;
        Fri, 27 Nov 2026 03:43:14 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm716120385e9.8.2026.11.27.03.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:43:13 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/2] pmdomain: qcom: rpmhpd: add RPMh power domains for
 Seca
Date: Fri, 27 Nov 2026 12:43:08 +0100
Message-Id: <20261127-seca-pm-domains-v1-0-013c28eafc5f@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxsCWsC/x3MMQqAMAxA0atIZgO2xSJeRRxKk2oGqzQggvTuF
 sc3/P+CchFWmLsXCt+icuYG03cQ95A3RqFmsIP1xliPyjHgdSCdR5CsyMm5yUUisiO06iqc5Pm
 Py1rrB+p1kglhAAAA
X-Change-ID: 20261126-seca-pm-domains-ef3383cddd25
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=793;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=x26m/gbEgJMZg/btKIREp/6kDbwNz18lHPMCLbWMwn4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrCWzQTsjdObDAZJskW+9KrR5Dy6V94wXeP68G5
 NXrsJe2kUaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawls0AAKCRAFnS7L/zaE
 w4MqD/wOCta7pD4t6ZjiiZiD4CE7C7EfvK+kYJhqQseI2ximKm9v6yN15dYNnjyqVr0YmVF3Dxf
 Gz51BEhYaSRyXOV0N6YXO0QXvMz1jF2BG/iBKrLQEsA0p3fRXvfPMrvdmiW1Q+n39ZWpQfGTZ1K
 oTNjsQ0pRpUED2+L1ighQ3b2f1yg7H71Tw4xaxeYbV46XmAMUGS6qWNTPFynFJAY0bdsE62a/6b
 t1LHSF+UZBLRS79uRqNKtkFipIdAwigCyQJ4tnycqrRXgKfpB+NDS+HNcuYrHcfZ1OJqYx/E//J
 5EzUYXg8OctzhzmRPgxq1TbcpNDQhSjooVZKcrkQQzLAEkQ1Gbhhz1Hyce7IlCC0KcglFZYp3tA
 qgjlQW9bQALzKUxI7BuHhU+md3teHkJBNzPNap4RfPX9o1bMsQVFHIS78f/AgtlX5RvNxfvnLdc
 exjKLEgCDC5rxPGaJATCypwpOgfib/HftnJYVu+v09gxXMKdfWv0Nv9exm4YD25ZKaMHessK3J1
 WUOso8fxWA+vAlq2KaWZITeMLRbLheGI3JEAimQRimgBJJlr6Bq2W+FUyTNlPMjhUsq9Vzcp33z
 +JSAG35f+GJRxvnks2h1l/5B7C/ivqbtEdeUibvvRFlRwZnBHm1WTkfTw1EZn3cG8oeTRew1u5M
 c0R+ApXOpmd+d3A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 171vvVf1SUMoWmpdzkLKvgCCykva41j2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX3P8Q7uM9dTFK
 MdwjR0WYviodxYMRBzLZeiwsJj1Hua2Cg1+VA0E/4n5ZttHqqoBKz7r8DYxmWUz3SlFyWFKgecH
 5Zt1hRdERz2hj7TDeCFxrmo4LjFBhGgD+zX9yVV6FL1w9Lqudqfv78bdyDDeH+08wMKqehvQJO7
 AFkgG1GkAZ+L5vW6PydexK+ZzndSyMAlwYwaT+bdmS2TEb7igyCjaQVHy9dTl8uLrPf9BZ+EXnm
 Ue2+EacTZ045bciwQdLFEhjsZW7mHGDqpHvoKvKkEmi0UNrlzt49bkO92NcSqxpB3zDWsR1XlNq
 8HTxi2hr+1pMEiwuSIhV2P2ebJ0fYQDdL8YVMMn/k7LIyuXSuwgXIU68HQf2oQ/A4+jeh5nFM7J
 SikwKNng7DkD0NWFMBF2B+9M93XW2xWkQrEyiolpGlh09f6NA/7w87VVU8h+1BhHu6lc+IVujfi
 CYR77UbHUrbzawSlJSw==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b096cd4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=EmnG9ksW2TcYSj2vAuMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfXzye+25UegsM1
 2BCDlhIXV68tLMdPdejf8aWzy87waM/ZC2JhCeoKp1/g4DoSZUosQMjOKNsi6su3EEQC4Oy6b4u
 rad2AIMiZscGr2pFgZg1id2LfR+Jo7o=
X-Proofpoint-GUID: 171vvVf1SUMoWmpdzkLKvgCCykva41j2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

Qualcomm Seca is an automotive SoC with 12 Oryon CPU cores that's a
slightly less powerful cousin of the Nord SoC.

Document the RPMh power domains for this platform.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (2):
      dt-bindings: power: qcom,rpmpd: document the RPMh power domains for Seca
      pmdomain: qcom: rpmhpd: add RPMh power domains for Seca

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     | 24 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)
---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20261126-seca-pm-domains-ef3383cddd25

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

