Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9ED4399EF
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581019; cv=none; b=ut42STD4rTWcYViSJFsOXFn8sFwaPqIAv3p3VmoZ2j48G/Rz0jWlg/9iekcpIJTHYDYroOnkhTiG+fic0Go9rn2hFw5kG6J18bMnFEcmbLvY5tQ2r7v7MXNxWPPblIQkQxGjUEB/I2ntuwVOE4GWskEGM20IiF/b7dXY1QxJihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581019; c=relaxed/simple;
	bh=fuz1AwDiVrmz2H6qeqwqyHnsETUV/yZMakfR4Wcq4iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a38KlzKFaj5TlZgnNsFR8CIBH7rabAdmLlipMRCbCunJ4odOjK5NyKiENxWpO6uQBtX7RidgOPNyuaGGkc+AJaxXOU1MZs8YhxgRnwNMNSG8C4bjQDG1ZbdyJr+Vcfavc+Rh8gzWqO2fnauo6fexDgJhJ48BdhPSGoZMdQFLZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gUykcsMl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gbe3dMYu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gUykcsMl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gbe3dMYu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCuqXb2479684
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xcI9eJLymLtY8QiSEy8OAOxzGxCvQ8zOPHqU1Dbx/ZQ=; b=gUykcsMlJeSHlcUm
	/1k6rbBHbuQ/FVBh1Y3GazAmQq3shBdn7oVi7sPnJgLdyxUqwrpk6e0Tbuz74jS0
	YkHs37ACHPQ4Iddobo7q2Cmk9f5pr6/y0cZ5ICn/xCaLKtTmbzcitfnB38S1v0Jf
	J43vMfL29dZY7SC9g1200OzOBWTo8v+dPwAoWnmNqXY3+/LqbAj4QPocFZuWtRTo
	D2WpbNTrijfQhD5yagBvG9YrDrS1G7L87cefcJgYxolOhukN1fSgagIeUEXzs4lw
	w5+0bXASnkEUU9ohV+6ZLaLMe77fUsxmNheJ/k85RMHomwFTtWy/RcxodXaNZTwB
	j1AlvQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdsh3k8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 14:16:55 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-77969cb40dcso59715137.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787581015; x=1788185815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xcI9eJLymLtY8QiSEy8OAOxzGxCvQ8zOPHqU1Dbx/ZQ=;
        b=gbe3dMYuR/Rnfg+5bhYPYCN3r8i9lyPVVTSG3XqQPuT7gMoXX4h56n+4p9AyAjGcZ7
         +hIesCOGkRGDLkkC/9uYe35lZqgSZ1cHPECTbovfKZzOU/GozrILgBXVDnRMQWWanG6r
         Z9W20HvXBzDzOah0G2tkZyEJkF5niPvy62A/ABTcTwcGgSoqrDcOl/Tb8MK/3wObBhAO
         hueO+V/LYl6jrEKPuDAWz20z64ljzK2b5afR6s96M8uo7SmVzp5X8pNoil7C6tOrVPd0
         l1HwbEw/p0pIIrjAx+SK3FPYSBqo7aPyha1/SUMh4yECUYVYOZmfkpyuTwv39D8mMjqy
         9GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581015; x=1788185815;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcI9eJLymLtY8QiSEy8OAOxzGxCvQ8zOPHqU1Dbx/ZQ=;
        b=Q/fYbAn7HVFyV/xgogTq0WMnQVbor7YMyM9muYc0NxeT4FTIzqfFrf7BKM4FRb5DS2
         bav7zm6b0ilub2upRyjC4FMlgKqMPz489gYAvBJgQQW7VpVH4Za0yqVANNW2BzYe6X40
         0OKVWNm6ECWizq1fxag5jTKhTpLPvvK7QwZLRexvNnhHWtJz5c5Qzmvm3bQZgLegqowj
         ffrRCJ3CwfiPs6FhAcADRznTpAJjESU7g2DK2uToQbtPzTLjGzSGkyKzV0+iXVnXruG+
         1uMqusFYHwUQVkMXYcLyocWiq5uhtQQCqee7UR+dyrMERAv7OHgwR0CanATYBCTQFjqo
         Diug==
X-Forwarded-Encrypted: i=1; AHgh+RpRs9ZAT4Ol+eKv9vveiwfqq6IVUim8Cnzil2VLJn8OXPiy8jkSFYGY+/7q8Jd8cNj7zoHsmGcuzQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mHvg1MlYCpAW0+XIthgctItAL2diLxGlxUuJOjqBu56zZ8+sbp
	yAdi8KB2Icf/+69dVWIprruMLh22L3GdLHR9GU/rBFUQx/gLz/Z2lt6IpJAPSaoY6Rf24saeSjZ
	oK1+DhQ7hY7Qr8N3MmyJs4KR5y9gr2vRNbhwWXwht1SCgTeQDcnQs2jEjOkcJyA==
X-Gm-Gg: AR+sD12qvGT1U3iam0DJqzE/hXTCkR3ILi6texcsUJaJwxXupsmv6hTNLZ0eJ861jjj
	lUWIUoF8H+ueRUVCioI6esryhARe2gM5NbeaXWaoNdA64SzFXRVUD7jASMG6bW/tH5pyHVbU5Ek
	YTvJlK94AAO38k8EnRJYwxsTNBr28h9YG2JvBF4uwK2oFWd+qGX1DVxKeT9b0KzJiQ/20ClvBU5
	hya1mc562KPiqNc2uSwfcQDiNhI2FmA8m3CSIP+dTYzFX901dkW+iqjD94WFwQP09skE1AnYU7s
	lvgdHbe2t0xmxPmsKoERLswvPRxxZvnrm/xWBJLaPIgV1/sydCZuuCTmtSD1vqgWBmGpoxmgDaB
	hQkic5egnfmdGDa0Nz2WE0RTf
X-Received: by 2002:a05:6122:520b:10b0:5c5:f164:b3ff with SMTP id 71dfb90a1353d-5c5ff7b3acemr3109772e0c.2.1787581014746;
        Mon, 24 Aug 2026 07:16:54 -0700 (PDT)
X-Received: by 2002:a05:6122:520b:10b0:5c5:f164:b3ff with SMTP id 71dfb90a1353d-5c5ff7b3acemr3109753e0c.2.1787581014362;
        Mon, 24 Aug 2026 07:16:54 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm10832671a12.1.2026.08.24.07.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:16:53 -0700 (PDT)
Message-ID: <993a82a0-875b-4b1e-bbd8-05fcc576cfa8@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:16:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-6-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-6-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMCBTYWx0ZWRfXwFvCZ3u4hcPW
 ET059X/m+ZvpHlBfwUDUahHmcKWWq24Zchc84olLotT6ufi4VGKBCwK3iB2ewwjhpCLMo5rGa35
 VN7WGRktnST6UTlO5jjIpkDbvxCEbKg=
X-Proofpoint-ORIG-GUID: 43RRYz7Chr7V7ORrtU7UlgUOhK1YQNcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMCBTYWx0ZWRfX0PH5CKWJlOGJ
 iKkNyKSQLb9POhxP3Q5ZUku2sMpznbqt/B7WWaIgoRZt7NeSnRpZ8HVRRO09p2hcKbTgn8ObIvS
 HAbPzsX6++hT5zi6TU9OVrxY44No5Dtfu6Y+3WgfssMtDZoPb7Dn/cG+FV5O6J6Py+SXAyW82LW
 MM0bNtQItONkV+W44BVz21kkD7BdNhn90vnxN4Smo913SXwsZptul2kO1huEJJvkk2fhmcRO0au
 wPn0vryhBQYxx+mJ/ogl1WBZpgZB9PjUoyLA7zWhEBI+Q/6lm6/DFO9z8uJlCdEfVNjHzs8k0lb
 3IGhPAFymmC4LZt0FkDM0MFsEtqX/9eR1jPE0mdwe4YKANqtPCLy+jnDM27i3BvaU7+wcvLNcKi
 pe/ooedDDbGTDuGthhsHRGqAAnOiGM261fBTtIQm6CcRY9jZMmr1rMUl3KfdJNuABXYg6OTcOT5
 ACAQCeQZbjuYHMAAP2w==
X-Proofpoint-GUID: 43RRYz7Chr7V7ORrtU7UlgUOhK1YQNcw
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8c5257 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GSCxQli8HqGggX-HJQ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240120

On 8/9/26 2:29 PM, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in lemans.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 105°C.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

> @@ -8760,7 +8765,7 @@ nsp-0-0-0-thermal {

P.S. kodiak has polling-delay-passive = 100, lemans has = 10,
any reason for either value?

Konrad
