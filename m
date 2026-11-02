Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630821;
	b=F1KKrNmx+JGEZkYOCF5uqm1dpQMXVMruZwP3nrHk7jsZFlgUvGEX+DquLB9SPranyW2N
	 SXH1r0uNL03dc1GbexV3m4NLVpBs16XU9HarosybCFdA9rf0g2R4uglt4SFiNLJcZvmKg
	 FH5a3pjZ/o3qxbXwiRJjjSxyGKL4gT3V8LKg7WNQRtzt3gxEEmfCR5ninIX70gUtulmSD
	 eilPxzwc3EfEPHdNCjxv2r0Zke7QcsxZfs8QtUEizvS+KI9+c/sy/Gx6ttsTztNxNIqEm
	 OJB4fVFWvt5Mb8zmU4L5j6grR+B2SeZ3iOA5Qgud4XJ6cw5Z3zmjiXf+rzNwsNcJYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630821;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kshJ8ilku53BZA7u6QxWWNnkRsV6tkRQiXc+t6nZXtA=;
	b=xdxwsNRYglonmj2RJ/N6chs2p7rEcS/OWo+qQyZeMNAZrkXLa9YKalVtCTwNGK1bvu75
	 t2lyovhSTZjoAi06LzSe3DKHgHI5ADZpILg/Tit6vjXqU3HHZrVrs2PIC9RhWYKMFBvwF
	 jImaGVItTTvZCUuvb64sxcwz7hNwxZlB97qoM1DaOcUwillx+j3LsBH1S/gRGvURFPUdX
	 BNLpQKBhMyrWUPQ69atJMU9wxK3Eq1pyjp2ZFw4atm+DKWaveDMLQobNdiI/jxNm1RF5V
	 WJeGzOx85qk3GMJJ22XecfrMGbQYUF2DMN8GFhotxyqb/zp4Oh4v+MGS1V67tqtuuQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iGY7swdt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bgTRiow1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CD60A5BD1
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 14:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 573CD60A5BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iGY7swdt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bgTRiow1
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dq5ab453985
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 14:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kshJ8ilku53BZA7u6QxWWN
	nkRsV6tkRQiXc+t6nZXtA=; b=iGY7swdtNcKNWt6Nr51LKWCaoLr7rQqSjYKbLi
	djhl4Q/lc94srtJ56alt5d0hlmRqvC4lrZVFBvUHVJzQNLu/QbpflRgWODahdLBu
	jjuA7nLYvlAFtnAsI3EI1BT04Wl6jokF8XJ96zLL+TwE6D/2igfBzGTPiENbvQRC
	T5xSRxCciXHdYefnrhy1i3yXT9iLJL++1DlQ7WguTpzJHnc0iwm0aWCv3sqRyb8L
	+fYD8KINjTdQsNci6iAuzNGtAAkvxPKIxfjpXT0nVIaYiJQOqviUsBpYXrKAosdI
	M5K2cPBEQ5x3zie+z1/VV0YYAn0FnBCv8jL5igxzwuObnNAg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6rsxp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 14:47:00 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7d06f3784e2so760855137.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 06:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793630819; x=1794235619; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kshJ8ilku53BZA7u6QxWWNnkRsV6tkRQiXc+t6nZXtA=;
        b=bgTRiow1UcGLPEH/KDguYB1BmPxSR4neGrKm0Vm96kXQTWPGUrnA67NVFyfrXfKHfS
         HyEwkGI9EAlSFcn6SLMc6xwBb/Mj2lqORN4e2WqGt7KBtc9hoq6JUB+ms9EtT5WIDGmw
         B1hQ65DLwdxWp6x36++JoMqYUXNNAAj56tZOULlhIc9sNQyF4uUx6q0KXOj0RBCwNZv4
         mlQX+ODaa01W59WMKy2J92DaLmkK4TBzqTyUcfoLeYpEBNjKPXmqPgSXJ73WXTCtQz3W
         NgoLgai4+AZdQn6fbGnAgwE5UojiaW11/kasfnfX01f4UF8Cupm+WyJb7qC22LMZjNVB
         pphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630819; x=1794235619;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kshJ8ilku53BZA7u6QxWWNnkRsV6tkRQiXc+t6nZXtA=;
        b=w0Zd2NO2gKbXLrU1KSsWVajl8rfuis1+wKVNOgIXJf9IRugJO7uY47qi2UTi0UpY7S
         3Qpw1ZtRQMradXmkJakqsTZfCGHE49Ie4CfspuFP7blWmyEMCGgMLEdYxVkP42WFllxs
         GRqbDHaPkFMcI0Tf5nQvM2DOft1XM9hYZ/dwheEekjA70jcYc4bFQjPVedLxbNSzhPGo
         o8pFjL195STLnJISE2KglxFW+EbB637Utpp+r7x4eizzcdnPulJisp2uHx+1DDZL6m2E
         kFRKrEJooYmhJU/txfrKm5PXpOCEarbuxyq1baFfX4Xn5zx5w5vRUWX6hDvM2PzKPHeL
         AnMw==
X-Forwarded-Encrypted: i=1; AKwUvBy9dBFh9NUb2wKKGKEaGumluEAO4i0aaF/5obsYEdHjNkgFFQU0qkvLHCywECgPMOWwZxC9JcTQww==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ISLMHXzDNslSDi08y6mW2Jh6B9NwdRD6R+6ukhM8AkTOcub1Z
	Y+A0DNDf+jUMYiIFWl2aBdQmHTyjytStovzaqnCgCxR27L1WJa+J44C2StW2XoBbEekMb9IkQ+h
	zV6bvBKJ/bSYPpVq9YyzjF2y57mf4enn9nUPg/wy/quPABW7hly0TkZL340qPXw==
X-Gm-Gg: AYBFou3O8GTQ+0BkXW//MKpolDTgaifX0ISVkGhgGzkxOk9fvteRbnwX6i7bKApVIaP
	ehRuWeiWhRc3SmcuRUbJ6i5Mt49B+xIATKrLPEvnwcBvUsms7Mv90N1i3V27o9cOtaWTVDNOGre
	mmqSXw8qnmHzd8Dr/uhg4wXwwiBtKgT2D7+BJrnDegsoLuC7z/qhSkihCbzKQT03YlsBZDM4R3R
	E6GfLAIGKecpoGH9eZNI2QAxlXX4w2D9sgn4+rK+e9gPzkN9tZLPhqy4In3IxoxLPV0wyBwjP/n
	f4rBVcgXTRtdKUvlXthxJSy49J1K2TYunFCL2yeNgd8VQu4bMIA0epaVTjClYl8mcvZ1Lpl/J7d
	piyXqefwS0wSYs5W+Dmjiir2VMr8EwbIkxK9NxHTa8QS8s5D315DgnD73AA==
X-Received: by 2002:a05:6102:3707:b0:7c2:799c:9031 with SMTP id ada2fe7eead31-7d072d11c63mr3314633137.30.1793630819106;
        Mon, 02 Nov 2026 06:46:59 -0800 (PST)
X-Received: by 2002:a05:6102:3707:b0:7c2:799c:9031 with SMTP id ada2fe7eead31-7d072d11c63mr3314617137.30.1793630818177;
        Mon, 02 Nov 2026 06:46:58 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e86a06078sm4004893f8f.54.2026.11.02.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:46:57 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH 0/2] PM: sleep: Fix hibernation resume issues
Date: Mon, 02 Nov 2026 16:46:49 +0200
Message-Id: <20261102-b4-pm-sleep-hibernation-fixes-v1-0-51fac96d080d@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAFmi6GoC/yXMUQrCMBCE4auUfXYhTUugXkV8SOJoVzSGbBWh9
 O6u+vgzzLeSogmU9t1KDS9ReRSLftdRnmO5gOVkTd750Ds/cBq53llvQOVZElqJi334LG8o52H
 COMUYgnNkRm34DUYcjv/WZ7oiL1+Utu0D5itbCoEAAAA=
X-Change-ID: 20261023-b4-pm-sleep-hibernation-fixes-c39e49aa6600
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Ulf Hansson <ulfh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=TpjDCDxjyShMTioaXJsBmpTOt9aj2od6L/uCbcKk7O4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6KJdPWGen0uj+yjZxJs22KFL+4uFJr+n3DwDQ
 6RkFmzZWwiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCauiiXQAKCRAbX0TJAJUV
 VmEzD/9cS8LENi3UEa0MwSEH5UXPCIzmHZqlPVZg9sHCdolXVwSQ3Y+Z64HNEIs6nUt8JSSNE6e
 2SJCO1KwAy9lVx3JJ5VnWshO39bXf1o9gpGLYMzxZuqcadXHHhRovuLVPHuEAH+/Hzb/zR755Ui
 YxzE7k2xQcuWA9hyzhIFnHRvrm+sbuTh6/J/jYrur9gpwoy0Ls9ml1bAciTXl90hsWk3PX8ncKF
 IjTDlmwIKan3oVyj2nxzmBFO9FodSxcp1q0Gv1n74SgVDNg3i55LFdtyqIc9z0qonmmSd0aNUye
 a+MNZXRjsg94JUgIE1NVXeTfHSw7upItC4FVWyMZnE7cK47uB3Qj1lew9jei/nXijh16TzAw+uS
 ZqN9iL0BU/FpcAuoPPhPOz5miWHoV+yVlq8Rq6DW+t4tgoZgiOpEDDRgprkAsHOp9jlp2wRd6d3
 wKydanQYIx90UKDRrI3dbn6BcrtgX33yLX9ZsBG0/nm+zXS+tZ7/Sy+WsoesOjzFdH266p0BpsC
 mb3f/D39Zt4V/ME1vJ0r1QuDKg6eaSRGVEpGwcsneKMHZPWlD4Y2w4mIlW4cvkWCdGlCdzVsQt2
 eGRby5SnWkNKAZFeDmCRrXmv7dqSJ419cOfKG13La78jl374sC9ymMC9LxJoolzRwpk2FzzTyhQ
 QflY5tF6Z2SbrSA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX9WdIttRf2cz2
 H5DilWghkrLvVxxNOoK6UVw+1dN98wqGLAywRIg0Dgb2TuuRIqdwBCsmArRY2598IkYMclcXqbE
 nAeqmySQw0rdqZJ+knDXIN7Fnw9T1NbTffL9UnDC/v5GNxzuEp5ZCRT6Sn6ainLqPJqTXV+M+WJ
 h2F2VVjGjze/f3z4jhwTp/SeRS2YW0C5/vTvtscA5F5z8lNGreYzHjebiXjXBhsRk1oMhstYSMS
 kAWuuID0lI3wG7TQDzjVsEkrSwPqu+XemPzGh5HgFb5LKncdklH7nsv4ctwE6To6+jbxgbHM5Ks
 E+1Mf1fdRAAmaz3T7SwJ9xahgNyBL3YzDulqB+50S0el28mxxW9H+/ioJ7SNugZLS+SNwntnC1Y
 OZgaPXG9Y4s4gGD5YTJCjZu5LuNEfXZvgdj9y4nUdcKp/XuzvtJRwywTi6ycr/k2OjZ4rtGS648
 XHGvrbsK0sCNhiTRqHw==
X-Proofpoint-GUID: 35V1XVniVAw7VmRe8AZp434VwgMZsZmn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX80AUU4b0VdQY
 I63bEqbL+MOAMb7BDJp4oKcqpL3ypuUpe6m0bdtTLGk6CfooN5hb3N4Q0P1bUhulvOPJeaqngrq
 MZ8xxhPEqZLqLvqtSLDcMufUW5xedK0=
X-Proofpoint-ORIG-GUID: 35V1XVniVAw7VmRe8AZp434VwgMZsZmn
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae8a264 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=UGObRx22djLrfVSxTIgA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020058

Two things the PM core gets wrong on the hibernation paths, found while
getting the Qualcomm Glymur CRD to resume from hibernation.

The first one marks devices without PM callbacks as active when
restoring from hibernation, even though nothing resumes them, so the
next runtime suspend of such a device releases resources that are
already off. Seen with the CoreSight devices, whose AMBA bus clock gets
disabled twice.

The second one arms the wakeup interrupts for the freeze and quiesce
phases of a hibernation, which can only abort the operation, since the
system never goes to sleep there. The WWAN slot WAKE# of the Glymur CRD
fires as soon as the modem is powered down, and the hibernation never
gets to write the image.

Tested on the Qualcomm Glymur CRD, where hibernation and restore now
complete.

Prepared with help from an LLM-based assistant.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Abel Vesa (2):
      PM: sleep: Do not mark devices without PM callbacks active on resume
      PM: sleep: Do not arm wakeup IRQs for hibernation freeze and quiesce

 drivers/base/power/main.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261023-b4-pm-sleep-hibernation-fixes-c39e49aa6600

Best regards,
--  

Abel

