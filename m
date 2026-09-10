Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE8917DFFA
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026157; cv=none; b=aTq7RPvOUfwftqWiBhaz1NuxQvBx11uTrfjxeOBDDaVM5S4tXZZgiGm5laZpXLZrBQ9Q41FJy122ELAzD01s9XV7DuLrKfgTmsqKBiVp1TIpPGUTMoinbRyiMwNEVDKIJrjyiX+b2RkKM+6fsQVysdOjPW9khC5kvLo0v4qjBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026157; c=relaxed/simple;
	bh=vjldFUlWJ3Bv467WKqjWPrWJr/pIs/4SUNGMbgof+iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYJdKXBcn3DwIK83RkVQivNUTjm/lKIQNA7C2IvBRIAXub28hJfoAQiHjU57WgwFddRKITCYAc5uvf9e2UVW4boyIXvSr49iNG9fhPe5KnLpXq4PJ2QM8mtEuJZAWEpK9jLz+o0NgN+/M+5S1ZFqZa2QJtxRfmD6sjZ63Wk+NuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/Wrz/In; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EgpY3e0s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/Wrz/In";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EgpY3e0s"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GuaG3520330
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HD3KIZI/JGXXpi3r04AqikoOKtna+WhS+DJyoZDd85I=; b=Z/Wrz/InqhesG7hS
	sa34X9S+yBKauVlfeHvla8IFGF9qjU0McP+8Ndraa8Ofnz6oUBJWL7l6SZp/piht
	9h1DeGK8asV2PFTmA4dw7OSLPZc5pSUEa0oXHoEkzcmtfbJ6FfimW+9adkIQixE6
	Rvb+RwWfTZs4MGi4Mx5+xl46rj/xKKoJGR0UI/IIq745I8Sgf5txYZZFljnLMTqb
	/L4/Q8aiQhYtlYA6ZOHocxgHlE8noTNcGLGzbnDW1wmFX01zmlCwx6Kcy7z+0r5M
	csYfHoCJzgB+dCSR2d4gy3mS0aS+59hsKnNw5untPZutxxTp5NoHF7UbKT3w27M0
	3b+T6w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfjs14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:42:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d7ef17031so10779871cf.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789026150; x=1789630950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HD3KIZI/JGXXpi3r04AqikoOKtna+WhS+DJyoZDd85I=;
        b=EgpY3e0sixdtjP6MMBmCb4qb3kAt0lSK6SIekiMe1fEc3Qngv9e2e04+94j6+E0b7J
         XsUJYTkOUaVl0z0iMLys4RmQui1r/pTrK9TpFKoF3qu3wVszF/UVoxOUwYHGGT3y52B9
         oLAE61CwfesWdIlWqimzA4a5CL+Trd1I++/PeLzBt2a3O2DhonufT7joEz3Iai0uqsDI
         e1rb7CFeRuaQz/Fti2gunSs5jkVll1HbZl7vxh1tRcnlkWUIHTnYwrMdGbUqb8d0X/YD
         b7p6YWH/RJjhZVqbesh1nB2+AN+YaEzdGIGnolnu1dyiJcOADeLDIaZjvZMeqQBbkHfU
         Ua9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789026150; x=1789630950;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HD3KIZI/JGXXpi3r04AqikoOKtna+WhS+DJyoZDd85I=;
        b=NquHhdp/ffvf7R0fJ2fExo4wbliye1nDxPedfmao336PlSVPQCd+Irmr8uAnNFkJ/C
         WzBnxtZlgcNaHxJ1wqZfDSdL9Gu9MNcPQly44p3oE6FonbsNPu06kdJYdrojZw5NJIvr
         8YkXpzbsWPYgBxdg9P9pl83Xr7QChQUK3L2jk5UlBP3WqwQK7TezAwGNCtxES23hM9bn
         LlXLsUxBdtGWqhA6D8Y6xvuofkXK4cC4M4gaznzadwjszWYlvAKYm+mnJ5FSMenI1E+2
         wmHZN8/AMarmWVBlWkb7HxhgSHfO5PplqdG08AIv3Owz6Dp5iNgAhqQhxDwiZo35kK18
         FprA==
X-Forwarded-Encrypted: i=1; AKwUvBzFQ2Fd2MY4Z6Ny8WrG2DwfyeZmYUVkmzqWWaUKUw+GdyQ5rd2HHzS3eNfhTiPQ68xI5Pv8/2h53g==@vger.kernel.org
X-Gm-Message-State: AFuF++lkSdYjKdKbiFdUYorJ4wKYrsgcQal9E54VnyWC9HeZselT0h3k
	eKil9cnPK1J4BEf65lObPeMUDszOnEi6eY3LyJ6scNl9xSWfvkx2yvNOrEFimd5ELUcwQNyJWXl
	G07i4JEiYdAmxVecu2NTiZOYQDm1Jpa5FkfpxX9EzBRMrslK0iXIJf026vdzd7A==
X-Gm-Gg: AYBFou0TiLC5qjS5xJMDN0RKGru1xSuiDcHpW9XZlP6EKjDx/f1Vp7E4WkpHHng9K3H
	3Y8wriIxacL1v5ygQa8X29bEJnYoFC97Gck6DoD3p9OlpDv3cO5n9J0S5iMUTHo08U1UVgD/SAK
	P8+zJQ0JAFgrEGlTjDF1uWrcoOj8b/6XZPqMiNo+qx7JlgSncqMQ9TUEmLTTBDkE8grN/+qeqnn
	y53g4Bqgbzh1nL2dqKT/EkGRy+I+ZwY8OIpUhFJbV5Zm5PEfY/ObxMFtLfLYRne0GlRvdBpAv6J
	7wV+ZP151jsXx3mD+0vyn+8gC6dhyKS9DV0EqOcd8JvK0HfHtj9mnlDcsLiqOEbKenNG7/e4+VB
	mPdo1xtvnAk/f1Aw89XKnNA==
X-Received: by 2002:a05:6214:3d8b:b0:907:bdb6:6534 with SMTP id 6a1803df08f44-910477624ffmr125141826d6.3.1789026150351;
        Thu, 10 Sep 2026 00:42:30 -0700 (PDT)
X-Received: by 2002:a05:6214:3d8b:b0:907:bdb6:6534 with SMTP id 6a1803df08f44-910477624ffmr125141576d6.3.1789026149993;
        Thu, 10 Sep 2026 00:42:29 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26204ecdbcsm793516066b.25.2026.09.10.00.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 00:42:29 -0700 (PDT)
Message-ID: <c23c26bf-d0e3-4bd3-9dbf-3096b0050f87@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 09:42:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] power: supply: bq27xxx: autodetect bq27411 and
 bq27541
To: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: David Heidelberg <david@ixit.cz>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260829205258.26955-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-3-rinat.muhamedgaliev@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260909234744.1177153-3-rinat.muhamedgaliev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4NCBTYWx0ZWRfX0xZ7Ymzav7Dy
 /BsFI8ugR2aQqM7+eLBq749vrkJebG/I5Psg9Z5FynssVCgbnjFgKBpgPtGG2Ictcxv2Oau0cBM
 jjCei5kFq5SrO/L2EItwgxQYdT4X9L8=
X-Proofpoint-ORIG-GUID: Ct3KOKQMGMJeJLNavFeT7zidiEaA8evE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4NCBTYWx0ZWRfX9Ghtm0ih3BPk
 60d9rTo8l3MQPrMlYBphfNDw9WlfPhcJxyo/fGM7Zhg04rQ9IqUhIuO6HvWkFfpLQm//Aq5h/Rx
 grrMnHmAvncAjTaG13UkockCBxenGEOwxT3FJDSezvBV/2IAzQwdtN8ZbsvxHySRe9txjK3P9Ue
 yWM8C/D15v1B5APQbjIZr+4QdJ/cnz3GQxquk7ef8BH9bkRMbUo2gBmQwf8LTM5f6KDB5tPd+NX
 RngYzlZgq6jiaWnkJeuWeJ2Cin58bDG92D0jL2n9bsDdrvQcPPX3HDaD+sfBrQIwKVpgmssChQS
 UrN6/KnGd0Ex30wW98XW4z/wEeN15kXi+ArEsp1mXwe268d3uV0oWcdMmexHzdTe8lUR1F6qJyy
 74QIflHgGYTC1hAnzX00I59nZCS+ry8B98lDqrjqhprUgVTDbjCpPiHunTXCpkTvOfjvSkWklSf
 4CB23YUBRRl8oFU1WMg==
X-Authority-Analysis: v=2.4 cv=H5pOUOYi c=1 sm=1 tr=0 ts=6aa25f66 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bY1bNIcL0Yak-Vr8utcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Ct3KOKQMGMJeJLNavFeT7zidiEaA8evE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100084

On 9/10/26 1:47 AM, Rinat Muhamedgaliev wrote:
> Some replaceable battery packs used by OnePlus 6 and OnePlus 6T
> phones contain a bq27411, while others contain a bq27541. These
> devices require different register maps.
> 
> Add support for the generic ti,bq27xxx compatible. At probe time,
> issue the DeviceType control command and select the bq27411 or bq27541
> register map from the returned value.
> 
> Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> ---

[...]

First off, please don't send new revisions as a reply to the
previous one, this creates very messy thread structures and confuses
tooling. You may use the b4 tool for easy management:

https://b4.docs.kernel.org/en/latest/


>  static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
> +	{ "bq27xxx", 0 },
>  	{ "bq27200", BQ27000 },
>  	{ "bq27210", BQ27010 },
>  	{ "bq27500", BQ2750X },
> @@ -262,6 +300,7 @@ MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
> +	{ .compatible = "ti,bq27xxx" },

I don't think we need a new compatible here, especially given wildcard
compatibles are very much not going to be accepted by the dt folks.

I think it's fine to add a chip_id readback mechanism that would be in
place regardless of the compatible and would say something to the lines
of: "detected another chip, proceeding based on chip_id"

Konrad
