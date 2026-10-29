Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269454;
	b=hKsmts9SIhevOUKc8Lhd4n+hMOg7g26bgTpv0Bt2xQizAOk2y6/DsvFRJ/b+ACQk8rBf
	 OT64AtsnOn4b+ZrgN9AFGMlWztA5/aq+0TcmYM1DLEBVXEkwgjZTaJOXefly6CaSKOhTR
	 kaYNg4gahYJIEQW1RJWB97lT/1ips+oZ71IgbbjuNbp6CoW7Tbwy71v0Mg/SSFwiUkJC4
	 g7L07DqxMnVrJACOIng+lBt/ddzn+0oEodmacykeFiB4X+5i2fQIEdkPVTUN+O9VP8AVc
	 cuYsrWG/pUhjdK4T/xTB4XsP4WF0BBhuL2zBrB4vrXuKXPKxosXN6VeSA1vZSnxIQog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269454;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LNrIEX2HLFZvWx0hb7/TeOZv8vO2qpCvpN+LqCQcSDk=;
	b=RgSwZQTsTZBTt9jNtoDnuqy8R5Vnu+9DwqpzzpmfY0ku/FjcznteVIYwAX2ZjF0Zb6Z1
	 qSLjO45zlMzRzAq0M/Um8eXuXwSriaFgTbrEcBj2eIXbswE/CWlWnQ6f/A1Zy46hNPLTy
	 oj6rZ/+TF1GoWAsVjcwedVnYoH9QFgJ05WEkHKyFQhMjRzYSpWpavduwe9juRnruTZkj/
	 zAOM/zo/uN4Zcl1RWRjxfEkuT7jKDNqtXeZNoTVNJ3R51+K4cfB5c82CJQBvj0qf9vttm
	 bVVleyDdwdtiPRhgnnJA5HKfUtS3ZiFD+PJiSMJGiEHo0zzm7Ic3CJtmLTw28qMzPsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WPyC5VYU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZgziJLqa;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A33606A31A
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A33606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WPyC5VYU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZgziJLqa
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8v7Xg119866
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LNrIEX2HLFZvWx0hb7/TeOZv
	8vO2qpCvpN+LqCQcSDk=; b=WPyC5VYUubHpQEMXJRE9GWJ4zuY3zgsVgzNb8E6s
	2QBuhmjbM/EwxQwjBIwlxBLTmcyjHDs0t0tj5gjrRlsZqze/e2zv9bBHjz5ShGR7
	76WiMTlgF9K+WCPlXMxch1M6wO2v9jJfHrMwsOOWR9x+8aZvX161iNZR0it5dGNS
	Kxizbnl6tsmkCpFawBuqr1OBezAsFhwELNfWSaSWdmIxTWUD2r+taCfqcJ6PZ6cM
	S1u5E56GL5O/2iEm80fPjTQvZu5bTCcf32sz7tT+cUfC2FrJNhHwmEOb8IGbqbBD
	kgjgO8ejkBGLLM4o3ixxeJIQ6vsYzt5h4W6eAuJPbwmkEA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmpa5y4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:24:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e92aad34aso361914985a.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793269452; x=1793874252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LNrIEX2HLFZvWx0hb7/TeOZv8vO2qpCvpN+LqCQcSDk=;
        b=ZgziJLqaAY6DHyANE4hvLejnsK0xeaSDJfOT4PALWPvLLhvGfoXmn+GKZ2cbM4zbOt
         5Uzg5OSAaFj9XCpBc5bUgc2plC7Jlv8MY7yk1eX1o1fOkp9HTnu/DhDwmnKS6pU97JlT
         q6el2t4YIo5mb1UfeaRn4xH09QBCYHE4JzhbSJ4iGM7b239ldTzxKaMZHz9vcHwHRgLT
         nDiqfH6VW65vytZa6mo088SlNt+UPBbVvZf7h9Oh1R1r5oVfAtkIBcIbqWfVppAKPNaM
         6Vrz9GodQIBH0YdnTeL1yTr4kFlXub0A0+tkz1ypjCJ9utV+6j+l03CaohOA68XZDDVw
         vK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269452; x=1793874252;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LNrIEX2HLFZvWx0hb7/TeOZv8vO2qpCvpN+LqCQcSDk=;
        b=y+i81jF9tldkjKHyDoeNWWAhcy30OPMo1a5cLk2mdWN7udW1bZskYszH2xY1qZsaq3
         eU91wHQxYVKedMXUzQcPVXBGTHkIwcYOgBpRDLzqy6edNd1iFlQ4MG8YXDgsP5GjgWvS
         G+ZFFbccjLq8bDYGAr+/WdBy3ZG72AMMaV0flzbYS9tjEAxxUEeG02Xmh4zFEtsthc1e
         YljGrJaD7m51gv6/aFcQHNSY5+QuCfiwqFOQF1xMxH2k9E/tZNjM4LuP6brviuRkahMk
         AZJ8wOhVrkbywAu1HqjfAHD714ajC/Y1fJcQO78JCAFDExhNSyh8M4GJjEha4nKtejqR
         wBxA==
X-Forwarded-Encrypted: i=1; AKwUvBzu+ZYci0g9RCuxvMScZD+Za7/p9jfuQ3G/DoscmumLM2bSkDBX6K6OmVNDFgpW1dvgnw86QYLdFg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJODFGV4ktMgW0KhtiQEUzFxXtKHCgpx+WZrGKYj+PR0Gy5GHQL
	nUcCGOmIbIgUVvRtWK+h6M8iIjKxaJj203rvgS7rJ9hg7c6AUD6Tk+gytEHw1MNVbj2PLdMEadD
	8jmgD0F73D4YSegGGgLPBlOaa6satk1SfbX6p8uLxF9vH1e7lwaIL7M68ALC2WQ==
X-Gm-Gg: AYBFou2zUVdwyaoGTwq5i3eUfr/s2lz+c75COf2wQeiWmhZYUhXDzMinDiJ/7BJBP6u
	eauJn5uT5hYhInf2xuRmTqt8/dJYPu3O7EzcFI/qPHqp/2nVYi55f2IVwuQxMy4g79w4bXIUDlS
	szs5yL520iayfI+nQ6/Y/atZD8X44j1Hc4B0pbD2Ibvjafx0fCxFUurete0aVCM3OhFIVCPdrHS
	+kZJg2zLymz9mPxQhKvCPCLwJnaxd17wHV1eaxRY57X7SPOVkfAWzMDgl2C7pzUOZsUxAq4/MN4
	xkdmdS/ughIQCq2jkN8aLlBaSOYKVufAUAmeOZvNW6zoEjlX6ITY0++Cuoz1nLcmUerjMPhn/es
	Iiq5m7XojwgSPa26SirK5sbtQxCbd780wTcqtqrmoITn7zNWw/XAyeWKiSprhziJU
X-Received: by 2002:a05:620a:3703:b0:93e:fc4e:c490 with SMTP id af79cd13be357-94408a6ab94mr766985785a.15.1793269452283;
        Thu, 29 Oct 2026 03:24:12 -0700 (PDT)
X-Received: by 2002:a05:620a:3703:b0:93e:fc4e:c490 with SMTP id af79cd13be357-94408a6ab94mr766979685a.15.1793269451464;
        Thu, 29 Oct 2026 03:24:11 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm33789347f8f.25.2026.10.29.03.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:24:10 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:24:08 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v27 09/10] arm64: dts: qcom: Add psci reboot-modes for
 monaco boards
Message-ID: <f7rue5rri4gyfs3ltczakyonvejyubjbocwabpffez4wnjolf7@b2hnrwwp6mil>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-9-fa4b3ff1359b@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-9-fa4b3ff1359b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX40hZ7xw7Ol3B
 B5MmxwxYQ2/9J8F/PG9b9fyCxkuS/2/7WVqNNclWDngHrPDPR2z1qXJ5c9KOGsrQoUkbpF+j9Kv
 V2gTb0nGHz87AsvypqBXConk0kyNIO+R8zlJSb8j9f8+MekVUtx3L1jNI+2r1dHbug6XExspJv2
 qUUw/WDbciWd8s2SIO1oEy/k9AwTSSG5G/xHwTmNwUhIaKCX8KrZaGl0jVRts5MhmDPauQ+h9sM
 RepYmg7R1TgB8JWhdExWk0JX6nsigQfZU36w6glN0PHdUprRuHLqMDPw8ifxURMiuTVd0HUxTi/
 WE7D6jb7+52LHUSBZwsXIk8SsyeZfruhTuKdhz1YnEHsf1tQ4PRPaJc7+Bd9c1HYW3oR+gzzInP
 NOAqAVMdCHlg9URx1QzhZ2DLDNSFvvLaSru9vbNf7tiPxE94Kme/mcjK9JXSujGeeGUjhmTo+Af
 1h+7TpR2kynQSsTUylQ==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae31ecd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=DZmtaFOGBJufDib-chMA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX8NuYUpYiIXUk
 ZLr6SnLLgOWSw43I5KMXiBhvqnVYBjz7+YssGIiOKdPH8sEXIOiO8SVN+6oCszscZ9r5ue8ZDjk
 NmOFAHbmOoY4pSeNWM88pczoQ2Vry3A=
X-Proofpoint-GUID: LW6d7Zss2qaVdqK8Wcsi5IxXQ5Fnyn1_
X-Proofpoint-ORIG-GUID: LW6d7Zss2qaVdqK8Wcsi5IxXQ5Fnyn1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290040

On 26-10-29 14:31:03, Shivendra Pratap wrote:
> Add PSCI SYSTEM_RESET2 reboot-modes for monaco-evk and
> qcs8300-ride for use by the psci-reboot-mode driver.
> 
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via
>   the Firehose protocol.
> 
> Support for these modes is firmware dependent.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
