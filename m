Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277922;
	b=zt+EKCG4/BdOyYY6HVqpZjfVTEMj1MtOOqAuMIG57gu/T7sSWzHJC2w/pJkVlEQCr3Ns
	 XXNiCmtLA4aYUDplK+9qaEuDQV3HwlpOxeJW5f1RJvkealmeXsbYBh3umBMOYeDqvDTJv
	 UZFfYdAqV2ZPKChO0VNbOylEXXzyob4df9SICOGBnT9UFns8MRuMKWwts/GH5YQE50sAN
	 /SpXy+Tt+fI2oRht2vjmGxK2TzqfR4ItoLHjXQAxLUhWjuIqkmaff56g5h+dTMmdDjGLX
	 MNkK3EsfgTxPg8Oucr7HuheQci9gVdlIL3yuxQ/rFsoRKlQ6+URFqcSMO7oowL/30VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277922;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pnqRYTpBuVHV86GkkrK5BLeCNnmR/WXFULxDazlhXCc=;
	b=LJTwzh+Hdcb8T2o7D2lMCijRpQV6OJB5Ln1uI5NdBi/WJd07AdT+3868BoskKi9WdCFT
	 YPD3/BIQcBwYDQPc1cmzNlAvF97AdJCGTu8zkj5iv1KJ5TEbBJSFmlxqy42IwBdvA6IZI
	 j8/oOZWc3lepJTlJmqKl3FpavWmNkFmaPdJMYYn6XjmuVNGAbNr+I+t2SWTTOVNY0QMAS
	 wY5s2KX1Yus0BL4JBLE/nsTrWlyVwVuLSIVmXZyM8u0npwWl6/JSyc1rN3+3AEM9O4+fH
	 8KaDEdWMF1b5nmgfewQWxMjuykNFFQrCBXUDxa+AllCoHgyaGSIqP7sMRUNCV+AAW9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="hwgd/W3L";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=nzJHqhyo;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013C606A31C;
	Tue, 10 Nov 2026 02:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0013C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=hwgd/W3L;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=nzJHqhyo
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0kmMC2799690;
	Mon, 9 Nov 2026 21:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=pnqRYTpBuVHV86Gk
	krK5BLeCNnmR/WXFULxDazlhXCc=; b=hwgd/W3LX6hUfu0tY0BqRNAdDY1K3Tpn
	7CWoF3PY6v8lSR4AmOxmFzlYsi1rHYf2ZG57Xr0j3YuNRC4pAOvegEVYx7icHChe
	VvxmPh6kM6+5/zaC0FlW+ygCR3H0dWEbEvFrwwYepZTMukyNBWSnebFywNHoFAjC
	Md1RVzZPUEQpld1wecnLME9PRXDsXtEHq48zDEAWfsYtE3BBNsLvkYbf9ycFKVHz
	yR1exL6OyFze7ltw0BibN/HkjHbIJEYCZx4lscU9xBU7dAhrNYH99B4PuxR/qJhS
	QOEXxJOVXrM8eM9632lYcdq3fq0S4Z8PPllMUOvP9U1AaP+f58/Tlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=pnqRYTpBuVHV86GkkrK5BLeCNnm
	R/WXFULxDazlhXCc=; b=nzJHqhyoyVgqa4FHsf1WOHHAnELiaFP5WdUtK2E1YVi
	P8EByR9DGlH705zezVw9OuezRY/2MPhVHmyi412L+VJ4hnn78oz7o26epRnBse6R
	cXocpZEbQz8VK0xIaYriXgX8VcL24O+DP+P6sQ9B9wbAHzPDOdH4NGSybTnX2EIX
	FeXIBDIA7NybMhM0zm0zh9XgVOzvVGQ0w2OOtz0hQXXNh6I73a1MfvT4YQ9ODMKb
	BivD7Zur/mF7aeAHELcZfse1VgAjL7WkBp336xe5BCEMnKuW5kjALC4UGqJRVHf6
	pmrIeV/KyKebGYRG011UUzL9uKkeMPnvQ6AUF1svEVA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hugta4302-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 21:31:59 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6AA2VwxF039269
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 21:31:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 21:31:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 21:31:58 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AA2Vme9016682;
	Mon, 9 Nov 2026 21:31:51 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <sre@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] Add LT8491 driver
Date: Tue, 10 Nov 2026 10:31:38 +0800
Message-ID: <20261110023140.468-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwOSBTYWx0ZWRfX7xs6TlHh5jSK
 mduVLBs752LyFszQr1HUtHVTNEEGF2jRT5aubnoxoKXJ7yD/o7J3dVucS3by+jVmZMF2QIxlZqf
 tmTt1uPhAV4/Mu41NbFIF6JW1uCA2nNw5rEyuTBAaRUBXMQtAwos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwOSBTYWx0ZWRfX461W9a2kNpPN
 OllynwjgPO3QAyC7q0PbgfRsOcRPW4JMpUeU1VBXEY4B0mzLSxg4k8/U/dRBDM7io0rbSyaRjf3
 2MMI71x1ja4J4kgl1sqWL6yrcAwG6dwu09SpAgCbgMhapQnsDMMPNV2SZR56P/0/uAIJPH23c0P
 It0/Y+oVMEdUIQhMpPY3rQl2ND0PoCOj1gWK2ByIfsO1JWxr6yQCO6VXE8vlC1FjQeN9cFxM9m8
 RWF14vPf1Hc1bCby07ysbCYBG1YgODpArAR6qUUwTL71Oy/HO6ouVyriS4ELGyXgNeUN3ZYpIDk
 lXNsLkW4PNmLAAmfDzlSuP2shHxSAGQDyr5nTzjXn36zTlbq01yHQz280P9fWwvE8qJnWsJAiDu
 8eASfnqvAbjsyxmTu44YGG4L4OPYVe2fMhZa6+ND9F4C4yQ9+WcBsi7cRk3cwhOWx+O1fKxZx1Q
 jvkPzoN8MBKA46IKg+w==
X-Proofpoint-ORIG-GUID: -61l3VvMZswP6iqCuimUJ7FEvNC72dW9
X-Authority-Analysis: v=2.4 cv=UP5Ijyfy c=1 sm=1 tr=0 ts=6af2821f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=v8pZUxbVQAUMEgVANrMA:9
X-Proofpoint-GUID: -61l3VvMZswP6iqCuimUJ7FEvNC72dW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100009

The LT8491 is a buck-boost switching regulator battery charger that
implements a constant-current constant-voltage (CCCV) charging profile.

Changes since v3:
https://lore.kernel.org/all/20261029073012.1498-1-johnerasmusmari.geronimo@analog.com/
 - dt-bindings: add Krzysztof Kozlowski's Reviewed-by.
 - driver: set psy_cfg.fwnode so that the power supply gets a firmware
   node (sashiko-bot).

Tested on a DC2703A-A-KIT evaluation board with a Raspberry Pi 4B
(6.12-based vendor kernel) with no battery connected; charging was not
tested, nor was the -ENODATA handling of the not-measured and
thermistor-disconnected temperature values. Build-tested against the
power-supply for-next tree.

John Erasmus Mari Geronimo (2):
  dt-bindings: power: supply: add adi,lt8491.yaml
  power: supply: add LT8491 battery charger driver

 .../bindings/power/supply/adi,lt8491.yaml     |  92 ++++
 MAINTAINERS                                   |   7 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/lt8491_charger.c         | 430 ++++++++++++++++++
 5 files changed, 539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
 create mode 100644 drivers/power/supply/lt8491_charger.c


base-commit: 7071d4750856abbc68dfe431acc58a1d45dd42e8
-- 
2.34.1

