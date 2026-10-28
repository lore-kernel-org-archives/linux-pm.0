Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176301;
	b=sGyGzkD3/JhiK0oqehRz+BSl8st/z3ouP0AvSjHI8mT6SrjaB0aY2ep83EoOGo7V/8mK
	 AtZRzyberRtffk/736RJ4I2TK8Jj3uc0ZDlPZpB4DzJCBfHUVbyF0JbRU8aIsJ84YZCiS
	 5xmmPPj0FS6NFp4sxnq5aMlKE27STE400T11FHKgyNl0ejo4Nk85xAhvqDLCbxVDpWW1/
	 ctxssnseGjXkJ2IDcMDfo8XaeP+262QRAQS7Jo2qcyTf0B3qdItI6esHDmu6K7BYNHXXE
	 bFhHwAEjaoKUrUq2PyoEjXSDsAoyZs2sjzVwj6E8hFL4ttASiebnR2fdnv4q2xWo2Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176301;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Wm5c6oDxTUXFgDI7tpfgfJjE81RVl+ZbeydpXbK8vfk=;
	b=ScYZ6uIOkO1q77XcgW8mLkWZT90JQDlAp4p1bnoh87ynV1iyBOGV4cjmC9NtyxDb5LDr
	 kNWzfVdFHbg4STVvTMlnOFm/Kxd95KTFbT4t+HxhaJCJWel2FsQwzBQ5LOmXZ8lQt2Mp2
	 MURf3gZNNLdLKnCq+l+LMjdt4e5VS4OoLXwyy/iXA9G8j28+A5YTy5ttRe3mypDdw7G40
	 k1WezC560hKkR/8u5W9zmLUILQhv9l8lH/MxGE4MK05BAO5Dt7bFnEkv1iV/Qm0z5xABG
	 dYgSQQkQY3XSZNTo0VjZKS4PJ8atxkcYg7mQGPnmPj8C/Q7B/b9jciDR86MrWAlF5wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P2zuzFgz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RRZL+54p;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D86606A31A
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P2zuzFgz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RRZL+54p
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8KNxh570423
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wm5c6oDxTUXFgDI7tpfgfJjE81RVl+ZbeydpXbK8vfk=; b=P2zuzFgzcg9j5W1Y
	jU59M3iewI99LKeW1c1IQYAccvVeZikXewKZvyw6u4i18BZSKtVEqAYjDXTMZZbb
	39fkpst11DB90LG5b+FqNx6gOrdf/OJU9Ggx14YLeWmEl471FbugKCU6+/dAN30S
	IP0T41onVq941SU02Idnbgp6ryF6kS2dXrqH8PyfMbxzdpGhfZos3Elh35zq3OU1
	mM2rMe3DH3PfTpesUD95sBjjvYcGnkB5+rRIGOLsDMGPGKlP3K7NsNVHUeHwSZWJ
	Ytqm0S3mMEg/lgbyBB00B73FQCfM7x73ClDt1t9tgT7DYNxgmUsf9jXvgIfDvmKz
	ENk8YQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6738dp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:31:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2c0e6653so111428485a.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793176299; x=1793781099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wm5c6oDxTUXFgDI7tpfgfJjE81RVl+ZbeydpXbK8vfk=;
        b=RRZL+54p/7C9Vi0xkMnTXcxfK9CWAolI0gDs9CGQ6Q7cIbhEimVGK0Al18GAPgB0u2
         igtbiqjmoxdk+vCAVDBTpxpnGIV9H8+qbmEt7Ei8YEZOT7aEO/BPQ7XlwP5D2lf6F+D0
         c8PpKQLHR/b/2HlBEIv1fr51NTy+mZg3j8g9pXBX7tnzoMlCikZbZqn2eEAWNzjBHvuO
         IDWK0ryUGc1/kQnIs5Yo4h97tJwl4tf7hM0041kI21ihaNBnT5GFmBaupf7S29WJDoQ8
         l0RMJieFCyVHkPxJKPU2Kqidc3ZxaEbxsJEX2T1kuP8PAxk6T1NuyzMwqZs+pF2rQZ0k
         kD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793176299; x=1793781099;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wm5c6oDxTUXFgDI7tpfgfJjE81RVl+ZbeydpXbK8vfk=;
        b=dLJm5H0JcW3ZabnCG7gEetqBMN/OQyM0IhWqwIWzoe9ckdUD5KxyBKSjhPXg+w/G68
         bbpiHAw9CewlX+/OH3AKZRKR/seGy1qftpbzWgnAyMzlT+liSNniNuT8HbDaGmtCQdaI
         hgohHhqNWaQbODeCLFt8X0gQLIH2nvvtZxvsWzWiZWfkK4eA3swVlDjeKFNCYiaybtG+
         lry38hBRPjndGwhCpOZ13JQrOYPddO1nevBlUkJVeiL2idF/ascVuz32itU0SmoeVeTu
         y+rbaWJk04sELv5741/5/rqzB1yNgw4CP+yu8yR6EnM5NjHx2CR3v1MAt6lisBMusUtI
         5/Dw==
X-Forwarded-Encrypted: i=1; AKwUvBzl87RsVLMwqNMCE8jmTvx/hISgfdHFiFw9BC0m8MFTPkkngMKUUudnqYlogP+UKI4hRQYIJ/wd+Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLmCHutaJwPPpVvchRH1fAFgvm+XFKJ2GMLBSG0NjitnsIU7PWS
	mc9RUeWP2bDJMsGWf7K8vw6LL7h42GVMo+NH7oRp/PTo764n1jkPihsu+UDK9G8IbkvQQFvaPX1
	cNHf6sIGAhi5c6tRIS8kghkARhIMJvJ+kJtZOWOBH4HD2ETclriincXCBn4ThqX/8Ei62Cw==
X-Gm-Gg: AYBFou1TgoqtgVczFDfRIelXb5I2i4x9snWNzz+abB/fVfgwtQr/S+ebTQqLAhm8585
	+cN3smuyyyFmM8JT5yo5RKvudnA/dtct11kd4Tsby/tnY0jth6oasOqb2kP+Gw6d6UUiNKjc2Fs
	snvTIhnVaVrQ0eG3gRQGNTcHrmbfkKvY/HH52zCtJI+F4nEVH0KcBoh5tOqFcaFRFFNlP4/qPP2
	bL92nJb1O90lTyos8OvH1jTz174fsmbLTNg7RTMLyWK/RVkI1UkUXWvalO2sM/SdwYiGGcNjR/n
	BzdOYeMRrCUji65/0MpIGwYNoKDKrb+cFb4ZkmFSK9Yf1OlF6XSlaM+irg9wKMINJZrfneyshbh
	RpmaIT4OVhQ0aHe90XIVI26cdkWHyuuQZqqpw7CUeswROkFD/yO1TIO/Mb5iEyQUTgUQCfuyPg/
	WE
X-Received: by 2002:a05:620a:600a:b0:93f:61a6:b89 with SMTP id af79cd13be357-944089dce60mr207357785a.7.1793176299485;
        Wed, 28 Oct 2026 01:31:39 -0700 (PDT)
X-Received: by 2002:a05:620a:600a:b0:93f:61a6:b89 with SMTP id af79cd13be357-944089dce60mr207355685a.7.1793176299060;
        Wed, 28 Oct 2026 01:31:39 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97bf5d6besm27476175e9.4.2026.10.28.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 01:31:38 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: add .kunitconfig
Date: Wed, 28 Oct 2026 09:31:36 +0100
Message-ID: <179317629372.6556.15170359641937178329.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023-pwrseq-kunitconfig-v1-1-0576e431565b@oss.qualcomm.com>
References: <20261023-pwrseq-kunitconfig-v1-1-0576e431565b@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ff8Ac5N66CCzvQTUeXyYkpcHCmCRQs67
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae1b2ec cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VJ3RpJvl78RufH2NLqgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzMyBTYWx0ZWRfX1LOEIhuEM9CW
 rxNr3INKKkstK/CE1SDpaNi5+7t5FyOmMw+5I3/S30zRfdoLhlfa7xqwwiEkvHtFXNUzX//pzne
 JVDLm9KK4W4nsOh0YljpCHhMFJxssew=
X-Proofpoint-GUID: ff8Ac5N66CCzvQTUeXyYkpcHCmCRQs67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzMyBTYWx0ZWRfXw74v//dJHK34
 MBxv5xboVkIaWsuDowqpVf6lEXoqvtDi7G2mZlAW/xvc0FVh4aAl2DWIoXcSdieem1VWn3h86zJ
 udVx2OKaCiNyFFNOJ+H27MOsx/BFT+WqEfVOpvp+jySNTFIVI59Pc+ZENk/RJKpIeYD7JDSRZnZ
 kGPLKVmVlXTB6oMlG9PYZS065X9KO0ykut364dyOhVk3TAMnuIxFjpfqZdo5EKlbcxcRDC4tYfP
 GFoWspcOgzBSAEIFDd1t7iZo3fQP70uyVxkJKwD/foL8muvfikfPS6B+WOADqTjRpbE5pRqjwE5
 BNVcTFbIbXol8R3UqBaNzJoMiMvboK+s9cp1GHgFoqjSRrbAZ8Q+VCiFeAcF0b0Cl2wUSpj1BZW
 OKKt0zC8YtZDUj07VRORI+d8KAFsBv99YiGVrlZKJ9wS2OLmeU6rzN9Zzl82lbylLmx+ozjQeWu
 2icCsmr1iuySysqeKBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280033


On Fri, 23 Oct 2026 11:59:16 +0200, Bartosz Golaszewski wrote:
> Add the Kconfig fragment allowing to run power sequencing kunit tests
> with kunit.py.
> 
> 

Applied, thanks!

[1/1] power: sequencing: add .kunitconfig
      https://git.kernel.org/brgl/c/f1f9cc4aadd9e1cb47626df5ce1cfb12c455f390

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
