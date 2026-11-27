Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779756;
	b=WqLUkhadpfq3LMBF31XR/F7Lh++ScqCMPQcP/y/0ivdKd2eJYFq6nzGADSM17EllfVii
	 dOUgkGPYQ8euB1MxqTbK2+/k/Za8Vb3lJ/XUd4hYmOORo4aMoMFyKyllOTzm6PGxGXpkv
	 pT1rV2ekPppJ4+u15nsndk8i2P0b9me7iCq0QV79wGWXXW4vcqMduWTycxqRZz/MMDwEB
	 JdvkUFMIXnQkBKK3sdFY1nJ3tp2EGZwrcWLHKokor7CKklKm5vrzdHDvfl8famhkL8xM4
	 yOIh92j/6hjfyxoEmKdGIQe/OdED2S6hm0GtIWEmar34jIbrTLoTmK0q7o+J9qMSu0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779756;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NyDUwgrh6wWbTckiN+W3o/gquXyln8i4quGDrjK+rpw=;
	b=yw3xDNMq0s4ljOl+hWftUue1NOoQ3PPOJfIhdmMADPJI6hOS8SVA5Pe5xudgmRz4MRj3
	 jLNwPgmCRPQpOTF2P/6ugGOBrbdQsvpLAaHgUyyBWyQigVlehgtF94Zoxl3WlMOAU/dAi
	 Z743BlpRKZHDxFrXgUx0Ozx33zeUIS3lynZcGf6lvUXuF3RVkiMMPAJjjMz3JkybfBtSU
	 cwQLBNGE3skpyYeJcH+uMVry/0nOBjW/4tFzhOeo5Kn1+RYzUb0Na0iWOHjMoWIw3laTa
	 nRuw0vwxMUx3C7dKVUqtyMbyLTp1kTYPQO1kDFGZXCHlxHupLgC8MUhmI6df999b6GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Z7cl/HqJ";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iJdW2Dau;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBE606A321
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74EBE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z7cl/HqJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iJdW2Dau
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp2I61047047
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NyDUwgrh6wWbTckiN+W3o/
	gquXyln8i4quGDrjK+rpw=; b=Z7cl/HqJCSj8mduH7FEaRvabZFow0DwkuHHlFM
	Y1HTH92Y2f8dWljTKMZdM85PZqr9NzRL4y/4I1dAbCZSftgz1Okll7kZ2YpJTk6V
	xnr7lOznw/qUiiD2EK4nazWGiSfVUIMKQGZlseipztNWCkSQoXJYTicPgmh62dzD
	wSwbcM7RfoSNob+JeC9sqRP93XHlpUs4X+TrniKWrC85pSiCiKjBPa/I06//1W9e
	ZsY9q/ZxWG5Fkihoprslzzwngxc3/TU/Gs9ujo0FK8TjlOTVM92gZ1NgZdKrC3mS
	3wsqud8j18MaLe6HonMQF1TqkMeR4d9mHhyjuS09wYspUqzg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqksc5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:42:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-949b0d3232fso1098798485a.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779754; x=1796384554; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NyDUwgrh6wWbTckiN+W3o/gquXyln8i4quGDrjK+rpw=;
        b=iJdW2Dau1eHiyIzITJ7HUvaLcQ28wTyzNyE1D63lhphhNREEg2oc9nQwdqs1mDoTga
         gccZjtt0T42BhYTW37/sLPDr5vXet1YJNenuZP0gNQOHhw4BDHL6a+YUW3uytxdz81m9
         s++bVTeBzjfF4JDMGUEh3U1V/zTlAXhfEHNSaJjZAgr7KZS21ysGdkl84aDc73OzrXYj
         oEYmrXRXp+Pg6poS8WfEUba8K8Wc6bvt6ZhDlBl2dVagBKaL4N3opWF/cezo3UDdRj/E
         QXskifGj5ezGG+XgLFeWH267SlIaM5iPMN9LIq6QSeMJX1geRh9C2VMuoBX2fTa85YTg
         U0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779754; x=1796384554;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NyDUwgrh6wWbTckiN+W3o/gquXyln8i4quGDrjK+rpw=;
        b=vCQLiO3rPfhNNrEmWCFLcN0oGojFMiRyEqF527nMBl3J0ScWZoZbZP9A2yOMdjIcSf
         E3nOEk3Jl5cuarZun6H4xMU8gkeld6we+yZ7JNpKrJFJ7s8EOTPKgU+6fJrGTiSeeUsL
         BJMTTfczhqFz/aqAF7rVuvThd2w9aHvcDVBoabpc806KgEJTGsL3i4RckbSho1fnjo5p
         JI/DcRaBNoLRGpd5D8DyMjIlkR9Pl8Y4i4nqkUT0ngdL9xVsESee7A+KdAfx7v83CMWN
         1PmHM+dIE1NBCvgF0z0UBVafcOyNxkM9rQJzy1sR/neRCQnrTiEMTQYMKVG6hbnfsd0q
         44oQ==
X-Forwarded-Encrypted: i=1; AL+hErFxrgIH488kLRutBjZOgh+yXYknhA5IXhuWi4YSPGlOSAhvN7Hmyd/rxn/jd4agSUrP0N5DQkjVLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+M59fdA/Jhy7eosBtW4E4bap50cd76dMjsMWUQcYCUPLcpjx3K
	9T/Q4pMmUrcuyK1aSGuT+N8LvZHm8pWFipxDZGaot1HbB190wC+gR4oo6vKUx46vDomS9IicEhs
	UYa/6BLGid2oJ3YdL1/f0vl9Myxya0v95ixrPRxq/iOsFbYhNcGD+t/j4Z9iigw==
X-Gm-Gg: AZFdTZdvJyPB9ol3osliW79Od2hqnx1lpQ52G/+4A9GT+HSizS+eQrJcjc8RTMme8Df
	pPXJ0sI+QTyeOIZteGawJhGzMCnOTOAFUzVscBEYQyrGSCTG641026tGJl+d4zQGwykiZk6uazf
	mjEpLFdaySkgjmzQxjV9WwG26ycH1oafqPc3pMsD/g5J4RYpXdjs4yH0m7wZ0ZqgO1rppe6p6Ep
	2TzumaDwsFCVvnkVtYVbReTH/dvfgm0BLXVcEjMwjKl/qnbvOILxgJG27u8bcyt61xySI0DMx2X
	djiuvLcsE4IePNTVwiXTijqeGOPIznDmPo/A5PFuvcc5BCxUDkO/k/f9VhE2j6HKbG/NjnfDybo
	P18oz/yulPgb79M7XCqfbPQon7U3ElpTvpMb0o6U4AGJM/X8N9I2i5Z2I+XsGrvWRkZbwd+C48B
	NkqEiOr3UkXl3PJttmQc50x/ywIiXbEGd+oLxwFh2SzPfD6dUSLP0EG5hZgd+2e00=
X-Received: by 2002:a05:620a:c42:b0:949:5c62:e77e with SMTP id af79cd13be357-949ba9c6de4mr4265140785a.14.1795779753778;
        Fri, 27 Nov 2026 03:42:33 -0800 (PST)
X-Received: by 2002:a05:620a:c42:b0:949:5c62:e77e with SMTP id af79cd13be357-949ba9c6de4mr4265136985a.14.1795779753306;
        Fri, 27 Nov 2026 03:42:33 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm56457254f8f.21.2026.11.27.03.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:42:32 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/2] interconnect: qcom: add interconnect drivers for
 Qualcomm Seca
Date: Fri, 27 Nov 2026 12:42:28 +0100
Message-Id: <20261127-seca-interconnects-v1-0-a31bf9b36ac4@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAKRsCWsC/x3MMQqAMAxA0atIZgtthVS9ijiUGjVLlEZEkN7d4
 viG/19QykwKY/NCppuVD6lwbQNpj7KR4aUavPXonA9GKUXDclFOhwilS00/OG8DIsbOQg3PTCs
 //3SaS/kAYkpvNGQAAAA=
X-Change-ID: 20261127-seca-interconnects-891207666a30
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=T5L/ehKajD3lC8IkBxCGBFiU3AnyDbdankjiDTN/CUQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrCWynaNU4v9gsq42PA5w0vDEQ9Pux/2f/2KROY
 1Y4njgT/AGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawlspwAKCRAFnS7L/zaE
 w9jED/44rFltmRX3o1MM89yXJkc0vId5h6c56ucCmoOZc8fXZxq9v2dbxdYhF7TBEaT/R9yOpmu
 nj10ikKCqGJs/wD6SHZlf7QEr/viB9qTGrklYu5TVoRr18/EqdHxiFStFUm4Mro/MprTo67ngQl
 Obyjy59Ir41JmgXLDZ+0LoYNi6+ahFoQS54/KXWMAdI3MwFHsaCVtXwMDpeucSJOiBQ+JDLojzF
 k5zNR8h5uunisaHi/FfBPvUBSsgc+y7dodqK3+vl71RWLvyYq7qAbRqsFOQ822nT63aiU0lTS2I
 VqqqcSmy1SGn/Jqkv9/Pw1+HmUhG/YsSHPdsHwGamJWmWkMsDTU1noaDmcX15rqSfpqmBHtSRd5
 dCBVueY3m1FTfwRTw9UQFsRE/5Zn4y6oS/qSWt5xoP3whiPBUiBTYU6wi/efENORYfE+YaHFBKQ
 MDohUi0SIE6+n008gXszRiHSKKmlEF0OfPVeMzOV3djHoLFuiu5AwmweySE0vkYqsM1GFnytr2h
 eDvAxPCIPw055CdwPXgNh7qw2z0CL33zktKrbngnGlLtNsT3WIwPaB+ks1mjLYTvpXCGOitmJtQ
 86KyNaELdGt25Y2Uf88A38W69/i9Qm5pFEZrxUKCENFfVLdn6A0vPReghY9K3nFJAPeTwUcWfy2
 YGuUfJdxZ91+YrQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: UpTUBiD5Y_Qo1ITg0OhAQgp4_zLeHawr
X-Proofpoint-ORIG-GUID: UpTUBiD5Y_Qo1ITg0OhAQgp4_zLeHawr
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b096caa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0vBr5WPP46mkPm4xHpsA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX9qJX0KKYDwAg
 6cpRFiv4C8xBqvm//z9w7n8jIfR3qK45bbfBFwCPPvPLyLTi33lBMpX2zyKQQWZi/86i3dYDI+B
 +HeL///TlkXrTa0zAOxtOddkr4qYn64=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NiBTYWx0ZWRfX3MjAKvTRe0zU
 Lo7qOxZW0ZuaiEJOvG3Ivgx+jlnlY5dUlWvclD7h5EISui5eZmyD1dpd2Sl9UQiXX0BkhbEOonb
 DZIWShhvyIcAcAj318kkQ4sV29XNI+wRY6zPeksIotdkPIuL7XZxaGcaHYizwpD115q6wwbg9h6
 OAFKIy6Zch68lQE3iw86ZpDQ7wCGBW57Yb8uJwDs4+IqzQNMBo8w2Xty2kl2CsXOU74lB76i2vx
 TvLLFQsBRr8ahIdyhyBLueJHgAeYZ9GYFSASqdyycI7iYQX+eFiPbFrS2XxbOb/Hsf1i7Ee8jFL
 MkaW5SpvzuE3kh5h+HR1wFf5uEwnm29bQ7skYxmqYmzHTaJEKC6UhTC/dbajXeOIOdyI5vN00NT
 I+bO6DLqBZPf8owywweBm5bncdf69eEIifjWQqF24BBuln9+X5pFC4nM1B37eRekoHYfhgOj2dA
 lP+DPxUK5Oq4ENupXeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270046

Qualcomm Seca is an automotive SoC with 12 Oryon CPU cores that's a
slightly less powerful cousin of the Nord SoC.

Add the interconnect driver along with bindings documenting the hardware.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (2):
      dt-bindings: interconnect: qcom: document the RPMh Network-On-Chip interconnect for Seca
      interconnect: qcom: add the Seca interconnect provider driver

 .../bindings/interconnect/qcom,seca-rpmh.yaml      |  141 ++
 drivers/interconnect/qcom/Kconfig                  |   11 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/seca.c                   | 2335 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,seca-rpmh.h  |  191 ++
 5 files changed, 2680 insertions(+)
---
base-commit: a9c48428cbd8d96b26f92631d0db6f8519c5fcc5
change-id: 20261127-seca-interconnects-891207666a30

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

