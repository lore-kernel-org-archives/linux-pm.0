Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33233F5B4
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409915; cv=none; b=hgj+3aXcjn4x9k9Q2RcqDBQ9nMV9nuRT/arCcjWDwtxqhSp9xYArXtIo/88BuFXzaVT4valbO8Lg0rFq1/+yN11INmiGXpNP9mkRiMLLFj8wNc7fesQxPWUCRRbnJPOu50S3Dx4JGH2yqnzCckOdv9+YZ8RoXV9WmS3DynHFplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409915; c=relaxed/simple;
	bh=pErCnijODy4fEgUHDnc72g3nTdTWc7uPAXgFC+YdY2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+GbiwnY9mAdKJvGg7I63+3/rDs/OpSSrIGB47NqyiMpHP8IBvv5aIbfDNH+nExcHtQQrzfCL3ZGS4VzaRQ4iqJzJ1DTR61lWHp3Ug5PZj4pXAKzgwrlLot+VXNW9DTO6GH+XfxvJkgQwEvsMqPVmgI4gzjTxPVmy7ChEJq8Dkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cu5PUPsN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jp4PjF4d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cu5PUPsN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jp4PjF4d"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMprlr3552900
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 00:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pkBx6g0ZwIllK7kPvgkzwBWW
	DwY+Y8f971ch+fkJ02g=; b=Cu5PUPsNJ2vv5nMJOVn/TWvRx3ePaKRMbudwcJwg
	+Po/S6NdQAo12XAgFqZQyZ8jrVsF5SIQdezznxr2ocljEFLhDDUA3yJIoK1FOGta
	VByxyKdnG61FbeAmaN9DRFUmu+zUEwx5AhHNIVMANEeYaVLDQJgmyied/jmizJ/n
	GzE5JItvcFnKK47Vs0dfcbRSBeRjUAVcdAtYoGWWjjliJOJnkHBx6pWHXOcRb7wM
	uCDX7yakeTXgDmy9SX5KJcJhm/wSFE6gEc+ygg2x/Zpz7Dlcyzkd+5MIM96OyOXO
	N+ran2TizBy+XC03fa66psVMpXdAT83CJb8gi+KSSH5RyA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyqmk0c3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 00:58:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so46044381cf.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 17:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786409910; x=1787014710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pkBx6g0ZwIllK7kPvgkzwBWWDwY+Y8f971ch+fkJ02g=;
        b=Jp4PjF4dPaL39MdU+R6rfFKkRdoiYGnr1M90Kk9RGWHWd/IcBWiN2+iaaag9+2wKZR
         8IBHxUttz5GbMWzjtrmhLkwF9Um2HSz1PSBQEa+ox6CUuJyOhOnJRnpvBeaaT1DmmAtp
         DlBLkxSiPkV1CRI7sQtYX+EsIuiAf2e8aqaAhCbshR2bqCNF/p8vfDtwBmYIetcXMCu0
         ckpn5XB0VGWG80hyGt2RCvKWSgVmnOec4uvnVnK+z8agd3bQl7h9VZlS9JnJyVqkVmJx
         KL3J0dUyzsw/2FT10XG+H/XR5ov0bz10XDT65G3wwGmkzWCbdaL+WyKcM1R0GTkMH7P5
         lmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786409910; x=1787014710;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkBx6g0ZwIllK7kPvgkzwBWWDwY+Y8f971ch+fkJ02g=;
        b=LURFFPpCYI0SNf1rPAjqFMFm3wovRgESIOqbZj8eQ5rtZXSisuofJBxv8V9YoQBpO8
         lLwgLKKIK/GLxaa+qxqS27YUChGRk2riqMFzOaimeima0tYVQHbbGQXEKLFUc+uAD3Sd
         ZqOy06sYyTkHj0NLO4Zy+NIG5CL8Z/B+udUepiRX7fUFT+dfMNmGCAIWx0C3LuCxZxdp
         Bs1lHbio9W8gd+ZZ+a/6agw/usee0dabV/OKHwPwM0iD07nngeyqE1xrUZDa36lUWJ8Q
         xHPIdOf/N549InMMZsLYXhynopF+3c7LfevoFbExVJYLAAI1DN83dSFzK8/qObT0Th4K
         0tGg==
X-Forwarded-Encrypted: i=1; AHgh+RqCUhGjFeIcAYR4thIVnWl3SfDdjNCONKvLsQPg+nT6kKdU/55+7UZw2W2EpCiw8dCmdQX0/6LgYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3pdpij9Z2Z/vfS9noA8J1RtoZWNN6sBm3ujUJjub4F1h2ouN
	0tp7LYehnx6LKcblvTM7bAJ/x4a8QaXfqGp8n/+u56WMQolH4k0B+IBIQbDLhCkia2ZgmhcVBgx
	eWDwVsvkLfbx/Ej//eEDWtAh9D0ohRDt27MTUPMS+ADyOHRPNE55ZeOcZzFOCrg==
X-Gm-Gg: AR+sD11Q+tj97Hlst6FHMlAd5DGIclUKhkudkX359lxJ9vgoHziwr/O7tpKBzHBToQc
	ys3MjpqO6sahLQ7So2d4nJIbfxMw1Ttdqw5drV03+6xLR1Io544hMK30Nj+hyobT8oEtd2KLaLb
	25fTAbmyNoqffQR3K6cuF44KMQUbS67EO+v2FyYJtwStlr0jE6WC2DDewnFCtr71W6cWWhxlFwJ
	1dF8nHA6PadxXMCEnvrQSRENbKrltO/Y7VMOScVutszigpSnN2WqoO2GLsH0JZDawxAa3UsZfH6
	oVL/LXbQ5qq2ELoykXQ0QYZRkXRA7grMzKHj8j0iy+AsHGGXlKbWhzp5M7DxDNnPi/rRpIfz5KN
	lO5Ugs2TiYU6UC2+q5hRvGrrfe4PRYW6v6K+J1lgnGl/Vkf/b7Ark8dCPi4+NIMYe7u3KvBcx8e
	Df3U2R/nqsBEpHOQ==
X-Received: by 2002:a05:622a:2595:b0:51c:2068:a9f8 with SMTP id d75a77b69052e-52d0b00401emr409830981cf.5.1786409910286;
        Mon, 10 Aug 2026 17:58:30 -0700 (PDT)
X-Received: by 2002:a05:622a:2595:b0:51c:2068:a9f8 with SMTP id d75a77b69052e-52d0b00401emr409830621cf.5.1786409909933;
        Mon, 10 Aug 2026 17:58:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055e9752sm2279876e87.59.2026.08.10.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:58:28 -0700 (PDT)
Date: Tue, 11 Aug 2026 03:58:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 05/15] clk: qcom: clk-rpmh: Add support for Kuno RPMh
 clocks
Message-ID: <4ovnsghrryj5gxvggztpw5qst3t2qwrxu4p54iyhm5tf2twcd6@stuooi7j4jo3>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
 <20260809-kuno-soc-support-v1-5-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-kuno-soc-support-v1-5-5e0ede4a0c72@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAwNSBTYWx0ZWRfX3zw8nMFK1FNX
 nOvWi2uzVYGSnRS/5JqjRe22//sQU1valNBcpcn6xS+tM7oNjW+AW9YAHyevEPvxr+N0b7bWVyo
 +Bb82e/Xxw9GkA7Sk1aPNck/aW5LlJOjvuFaf0YkgGflndttxdAEBFtKcnAJsAzb78gdpB4zYqT
 jlYVo7kfE0+ZPMTjtD5fDKgRcE+n2oZ/gbLL3VnvkdM8w6vp9Mr0X0+8hK4QXlWU5+RxlGcx0Ck
 raI5BezurIjfffwWfKihYtaP3+oRXi6MpxdvoA/+CUirHCjpkZ695eHLXtkyaW09HfCzAg42orF
 oOywj+ZVtn1wV483LS1H4VG64bj56sXdnWzHG8v8m9Vk0gz9YihifRmarN2IrNJbgAlMHm42JBx
 54Sh9dHnZo1Oat8eMHgXfEzZencc/V+yK1iXLTQTvf0XGsC1FsyYi1AQC7bbnUcC5m+BgHhGgrv
 57FZEr9sb6Wjqfj4Wjg==
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a7a73b7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=-YGGs88sVoTMC7_f4VAA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAwNSBTYWx0ZWRfXzMlQjQItUBDb
 z6TNuG+4zWeXUUiFl5ApnSXnAzdNjx0FpiRnlifl3R0bSTyyTVcYXRSlI6G6Bjj8dLO1ySuX1No
 puoCh5e3YBJLiZt1WyNrjIaVjQxmx+o=
X-Proofpoint-GUID: q9YkuyO2V9N93tz9xeK9QHPICTGNoYP2
X-Proofpoint-ORIG-GUID: q9YkuyO2V9N93tz9xeK9QHPICTGNoYP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110005

On Sun, Aug 09, 2026 at 12:57:04PM +0530, Hardeep Sharma wrote:
> Add the RPMh clock description for the Qualcomm Kuno SoC so the
> qcom,kuno-rpmh-clk compatible can provide the RPMh-managed clocks to
> consumers: the CXO div-2 (and always-on variant), RF clock 1 (and
> always-on variant), the QPIC BCM clock and the IPA clock.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
