Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519739A815
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345873; cv=none; b=hw0LYiXagrL0OhEEPncZ/MQqPHTfJf+LZciI3d8U9z9arQyWnn8qtbSjtX3Hr53aU1EMzmHCKXs3sfGGVXY0U/UNtjJDjUQsgbRRwga17OpMAq7WqsrRV6K1iRtGrfhL8ke3k1GQdQ789FyGvBLahtcLQaEgDxye5/G944Q9c4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345873; c=relaxed/simple;
	bh=L/8fMTR/45p2Bgt7Oq0/m23ikeBGM1Y6DORM+lyIJDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMAOo5/T81DRZvWnN9RDCMIO3DpBdfqubFG302C8MVijg1HFvFXz1EcCMi2z9l9XDBuep4JTS27rXmr2dvRqaLx4gCvhSYUismdTyJmdT8PauMJh3y9ZAVKY7mDosC1FmnQHDUsxrCU/zZwmuzZ9WUsIr8ekqO3+/zhzFaTBZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4XL9uVb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PuL0c3nT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4XL9uVb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PuL0c3nT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682AR0oJ1287089
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 10:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nucwFt37zXBwQFN0WyrwqjTBOM2Ta92KWejqAkDMZ8g=; b=g4XL9uVbjwJUVEBU
	PMdxXwVAG1aSs6e5KLaLQpB5NTR19CN3OYA0xfOFAv6AVLUtn+3DR0xg48DPziXu
	tbUhprMWXkvqHDVBpx4rvL8hnYe64Ivw4IrW9mRzYFN4mzItchooodKXjCn+1rdj
	xGqhw1Ok9V6S5ts3cdgnpKxyqqZsJQ9kwrsDNDojfH9so2cMPzmFOx7SznTbdMuF
	lShjkWdAX94F/HGmmy1ps6BSIm+VMFELI9dkCAXK6yZdwTXU9lIcDBrAaQq+PLnZ
	eDpc/rnVhkbTZD3MRSbyxIH9sHKwOxZN6TbZatFJLxXlaALBUvdABbSbYTBraQY0
	+/IbIA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c820y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 10:44:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936e393061dso140383385a.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788345867; x=1788950667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nucwFt37zXBwQFN0WyrwqjTBOM2Ta92KWejqAkDMZ8g=;
        b=PuL0c3nT0N1GrTDr/9FHfjgmzr9CN/D6yi3TVGq2Q4L9I+Ry/oqYErzDUA2RJdwpjd
         O7k1leFF6GYxeMsdR8Rx9IYuLdcSRjdXOs7AmOXPbuaQHVQHtpPRCMqJihDIdwxGVHHR
         D7nOzZzKdC3THa7jwFOjzLN3M8aXmXgKC/wQ4d54P/Ev0lwuB9kjZLWDlVUyIE9Bu5um
         SbAgclnLJ4U/23LZViGW8cKNyk/sFy98iGA8XC5rnIhv794Qi7GD3DR2gHl9dzSfgtPp
         qHWKkOsDEd/wg1LzP4mn5+n+TWN1sg6DmzN3Z24nKXc8oqbrvYmDdTkAV62K8WdrgvR+
         /Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788345867; x=1788950667;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nucwFt37zXBwQFN0WyrwqjTBOM2Ta92KWejqAkDMZ8g=;
        b=UG8XuCiyyo6C83QqeACA6DM1B3RoiVl19WlaWibM4GdBZRnF2XGVptHogdZ3RRf/je
         ruHF40xhl3BpUIiz/TC3i1korEG3gHwKBYoks/W2dnFg0T25Yp94sMTWvu4ZlT9UwHg3
         qv0SOXEuPrWC1l5A5LC0AqrWPSnjwQrUUSVnPdShr2a8L6RuBMmoOxPPno0dTZe9RIIs
         JuXH5TvkJkyiA6fK2AckTeZ8BYzd+ntUY7+E+FgSXSjc0+JKL+EvI/ulXEcgU+fhvG2z
         5FkSw2TGr75cPCgoIDKY/3PTXllVUBWbnRsqztUk0hYBDgKb6Wq+asE4Bbh5niHd9q8v
         Uc7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpivm7U4h1P7HH4Ly2Htsg0qqANDwtWRfUJoR45e6DCZFaBihLq8KCtxApuzomloJKSl7EjRmWbdA==@vger.kernel.org
X-Gm-Message-State: AFuF++l7LiGcBIuULvnKilo0xhkgYyuLdhGWpypOH4/M6jiLX+7O15Nt
	YQrGSLcadIGpMBmcI7G9I/LLCAki4c4yBYg9FEsEhYQpzAW2lJnZptWVaP4BYcT5P3r3VCc5OyW
	qosAlmsWPNFgHIpA/v+ScUAqh9AwL7SFgtgDkObjeuLaHWtEUKQJV70upGjABbA==
X-Gm-Gg: AR+sD13C7d0Xny8zyI8ArB31l5VxsJhY98dZhq5itWxqZ4ywF0EuLsdIMbfn7Vk9tgH
	vDDcnsDWDCuNXSnJMe2MiuI1rEMDb59DyKxeMBybRImZVfPUkdJSpwUFwI/rhUi6b9foGb4fdt3
	4J/ReJNCz3jXDdxAPR5p4TpyKc+JuKO2syUuCLMj0hgHDLG3vSNwNvTUIHNraeZC/2D5cw8zndR
	eYYgdElwujvAYNBOwg/VxlpySTOBdxRF3M8KrmTSnf2rhWa1UPSUh7IwuhITO8PenOP0FZy+B2b
	/6J2BKsWbfPfBWYhFK03cngcYT786kj7VQRAR3LutCnWxFYcKK72sIgjQ1JcL3EOk0xLIlVGvaC
	U+zKNTq6TqwZub6cqnfpKtY0//OI=
X-Received: by 2002:a05:620a:25ce:b0:936:a5c3:512f with SMTP id af79cd13be357-93960fa200bmr388503685a.34.1788345866954;
        Wed, 02 Sep 2026 03:44:26 -0700 (PDT)
X-Received: by 2002:a05:620a:25ce:b0:936:a5c3:512f with SMTP id af79cd13be357-93960fa200bmr388495885a.34.1788345866263;
        Wed, 02 Sep 2026 03:44:26 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b759:bed7:f8b6:ccad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce7d04c69sm26431115e9.8.2026.09.02.03.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:44:25 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, Biju <biju.das.au@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: (subset) [PATCH v5 0/4] Add RZ/G3L PWRRDY power sequencing support
Date: Wed,  2 Sep 2026 12:44:23 +0200
Message-ID: <178834586046.14988.12802695879784899486.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
References: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5NCBTYWx0ZWRfX1pPgWDxfbo53
 +bgH5SDng6Ck/ZLjqN3ZmOOClx6aeW3I1I/4T2wF+49SSZqh5N9U+i0CZ2+exC1FRHxmvVVGX3B
 yJr7cVu6O0J8B4Dj/B1/nTFLi8hH3dE=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a97fe0c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=yC-0_ovQAAAA:8 a=EUspDBNiAAAA:8 a=_GP6QsbVdMz18HCjZqUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Ej39lj0Gf0FNmHR60U6K7D7282yRvNYm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5NCBTYWx0ZWRfX1y6E8KFpLQXD
 dKxRyraUQSZib1V2pff88Ania39V0FI/XwufP0r+qahLYCXXs5KH/BlDHf2XgiVzqlbBkXwKHI3
 6yRG2sL0mQrsoN0jsFfGuQQNZ72n4iM1dteOKrj7rbvzjIHSMLqKrVUS+b987buZM2mjnqTvAEm
 Sk1b0W2aSo6Y4lFfnNY94N7sSPXGSUy3lF4LmvHiTdmxSRwssFa8uTfPbqvJ3w8yrN0CM4Xe/2O
 E55irzqVicxqi6FI+yvoe/tzFkqNqN6yZ6yCA4Zjk+DjOf3cNXy6nCBdvSrCpiCxwl5SUIuPkSM
 dI+dHQxsFOUaD0Wvx2wgYMkPTkNTM553FwHZwV6RfYjk8h6cbVGf32wx6y8mtK0ewKBfKVPbZff
 I93RLYUltoqYPdgKaDacJ7hCZTgiHFvXABSfdfLPyjIo1AeJ5bvxEQ1Fcbv9H5x/Nyc5eZi497s
 lt4hgaB7X+fId66VIgQ==
X-Proofpoint-ORIG-GUID: Ej39lj0Gf0FNmHR60U6K7D7282yRvNYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020094


On Wed, 26 Aug 2026 13:27:22 +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Hi All,
> 
> Some RZ SoCs (e.g. RZ/G3L) have a PWRRDY register that signals power
> readiness for various IPs (USB, DSI, CSI, etc.) to their respective
> controllers. This register is part of the SYSC IP. Add a dedicated
> power sequencing driver to handle these signals.
> 
> [...]

Applied, thanks!

[2/4] power: sequencing: Fix build issue with COMPILE_TEST
      https://git.kernel.org/brgl/c/3b54dbd119805361695cb50ca6a875f4c7518b74

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
