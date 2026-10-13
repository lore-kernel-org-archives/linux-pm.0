Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3484FC8EB
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900120; cv=none; b=cj2JVwQy5X2PW2Gf87OoewwA2ONoW1N8ge/+GrBi1F2iycW9W4ewmlldcV1Rm7VuHGVhvQNPHr2SXoxiK+FMdVb2Osy30N0K1zeoNvntQvjdjcshyvsAgWxhDa2J/4XfJuQgff+O/a59kDf9hT2upbf+TXcSGCF3D3R30zJSrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900120; c=relaxed/simple;
	bh=ssqHTpXGgabYsxdvcp1m8bbcmPreD+147iRzWVW6JUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MToUH4PW/AvEwonTt2bz8G6avdAxr0drTR/tgdXiZhNJD9Gt9rdGiJj6bXz+jRFQExAeR6I5Dgmwx1tjkeg5CFUIfLC05UJ3wLtKx3t3E7jZdYc/9GVO8/IHesAoc5lxXiv3x596OTmi7W9/zXafQknQuUu5G8wwpfCsWzXz0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wpjj8CGK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O+qPpj3s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wpjj8CGK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O+qPpj3s"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDxexU923086
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cLsYpGybDcFYL54DVjqRniJMNcGDsEoOwITI4R6fhMQ=; b=Wpjj8CGKvd6syAsW
	wtKuWOEMzXdAwfjyWwU63oFbmTGJfc9gDeAOVjepqzpkkwH2dYSgTtltVa7IPRAA
	75SD+S49d5Ta2NT8UQbJavnB1yms8R04z7KGX9/T2o8WZZYRTbsiDOiYK5+X+fbq
	ADm3eslKt96bcRGzrl58ToWkng3HWPaKp5Kxq102O5hvnQJ96HuQ2ghQThOjYg6/
	D2GT8VtVNImIR797Bb40m6XIzGj3ztNJbUjovqtOLzJMGC16JTJK812OFSw4ofAn
	khHOX9hNckkAnRUnuoA1OKmbr2Jm5WZjW0+wrGX+m7dXsNNhbMOnrxOY5Kx52GUt
	ZFBK/Q==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1ua5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:01:53 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5e0a8f73addso3450862e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791900113; x=1792504913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLsYpGybDcFYL54DVjqRniJMNcGDsEoOwITI4R6fhMQ=;
        b=O+qPpj3sc3Qsu1ijR5JNfBPshJhgFrbuRtC6V03Hkgxz6wc5tVE1DcXD8KVy0EcHGs
         vX/3FfSTf8DTfpuKMubQwLkVUbJCeKH334VL+CaSarIHRJabGaefXlsTbqkt49yZKnj9
         YxX4BpEBSE76fRwX5TZA5rXiX7E+4y8ZGXaNRUWNujGKwvTKjRcRoShA5W8yrFYN8yfG
         Rk9VkS28qFAnguDFA8EARI+NmxX6ScNyxW2fyUhNOiKt1f/jk1KxCzBiJLtWszJF5eV7
         rQj7k3hdm8q1jXiaNPPLNYJOnUcTiilP4+38ch1ZIm+6gFDH/inbzk59p78KAUvXf+eZ
         0FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900113; x=1792504913;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLsYpGybDcFYL54DVjqRniJMNcGDsEoOwITI4R6fhMQ=;
        b=qN5WQA+v14Kf0lNpOJBHjUKfA1QCSnBR2f738YK/XDEjlGmLDUdYQcQqtVvqJe8GOm
         DsR3yBHAYinKo+VpPr9Xos9rtSvgK4ttkllLagm0PE1z4dswQ/7AG16x4kDmR6iyX8zx
         zSZNxqXb0YjYw0156GprUgAlRurffb1ZGKGvakTi217bRQ8X/p7xSmftYT9UHXXio5DL
         atAyjogQi2xnCRSL83T8QPmLIXMPWqdFHiyFGiIhqEEekCTfFMJJngwV3s2uqoVjiJkm
         wuaZJqeAD6J/5x2YevWhf6F+nJ387nc0tZLr10nQ9b6KWrXgZbPScoGuIVHVW8Axwzmz
         I4PQ==
X-Forwarded-Encrypted: i=1; AKwUvByBKHs6Eq9QAuRg7R18SBtEmN18z7ES7ljrbjTS2EvGMNCKlE0VhlavQ/hkZx+iLKuMDE90ftOu4g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJMIvcLAS53171Rl+Fn7K7Atq6v0qqvL9diXQtLnKnoN1RO+xef
	z6gnBD8U0YEZdjEHvQFvPADx0Y+ygs0CSv11XfA70+NgGzLtFFK5YW3S6ajqN2x+BDUmC6e+lGa
	zA56aeHpf40U26MvK/ZWm34/YqVN+dmVlaBletqFndHJG0D3UcNK0/T8pRwAUwg==
X-Gm-Gg: AYBFou15VJhPf/J8YHfH1R+fv+FW3+mOmvNf/EcT0pS0K7Y5CPhGsW91TMeLmxwTW7i
	RY/5827bohRVG1qaerExOWRJre0EBxQEJu0qSzoTxjMwvz6s6+biiUwIictgpnfO29+av8dMglG
	86Sl0x7QrozNaE80CthgffNCahRVpWVHvF9FIHn7NHMsJQ966CBm7Og0qzX+57cqGpPcAUB9Y+u
	P4tKapUQwIrbVWYD86RvtspjOCPKg2hjEX2FAOjRcBC+mkgWB7Gpc+lfYPON0Asgf5jSE01siGY
	FeuVDhNfALdsf4k3jhyFaK9JB6nUZHkso4CgtHJMeDNr/s8+U2dS34QHRDUht+2UMwPOi+ox1uM
	dTFHU+5QylynEtG+XuTkvdSArgyot
X-Received: by 2002:a05:6122:d1b:b0:5e7:8bd1:731f with SMTP id 71dfb90a1353d-5e91f4815a8mr4193276e0c.10.1791900112844;
        Tue, 13 Oct 2026 07:01:52 -0700 (PDT)
X-Received: by 2002:a05:6122:d1b:b0:5e7:8bd1:731f with SMTP id 71dfb90a1353d-5e91f4815a8mr4193151e0c.10.1791900111802;
        Tue, 13 Oct 2026 07:01:51 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a195002123sm377260985e9.1.2026.10.13.07.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:01:50 -0700 (PDT)
Message-ID: <8796cfa1-5ae0-41fd-b3f2-c6b588157b12@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: usesSix2L-g7eAgvpEp5bho8UFutTwFV
X-Proofpoint-ORIG-GUID: usesSix2L-g7eAgvpEp5bho8UFutTwFV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NSBTYWx0ZWRfX+VibZiv9RNrT
 XFPhHgxKhzxCebLzyrqyNXQW+zCk83gheVzZb25h9skTXaGjoQbETKoO3F+ntts4FSA8Ra1ZWUb
 /hR24k9+7WfXRj7eFBip0oOzer5uhTk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NSBTYWx0ZWRfXxm4n7LQhr1eN
 9gfJs43tKBmlj2VW+J68sv6wwQCBqqFh2TL1TVFmSg522jdcgh5Nz2t74BdJ6vfdimXoU6rqkOC
 NkfKQseTfsTyFpGPb4Lk9fiJrxJ7fZqPW0DM6cZSc8uScPcwO2kxlKzZqRzB3wMR3nDivMmfPJR
 qtBij3Bd5tNwgUrOsmAuZLN+iTxvKs9fBVdZlzY6pAInJ1fCSHUngH/70NNXwmkIoIcirUPvxwb
 Qay6cql/fp99mgXQh4tqYI+VaDaL1B2a/TL+iPQt14SLXS3j0eeBD5WhfgpQa/k9A6aCC9j2Tuw
 l4iv0EFF2jiGopPplNG9IWotTk6Cmf1BJZzq4WITbFI8gumrmsd4RBqQgI88YNj6E1JU6vUQhCE
 3AAmkzk9RZYz1eqKIPnFehBsA9n1rQ==
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace39d2 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=xpaw9_Cwbs5_s0yaehoA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610080000 definitions=main-2610130055

On 13/10/2026 15:33, Daniel Lezcano wrote:
> Hi Tudor,
> 
> I noticed I picked up your series without notifying you
> 
> However, I did not pay attention but picked also the dts files.
> 
> Shall I drop them ? (AFAICS there is one comment) and let you handle 
> them separately ?

Were they reviewed? I think no, so that's another reason not to take
DTS. Anyway, it must not go via driver subsystem, so please drop.

Best regards,
Krzysztof
