Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1047CC63
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994518; cv=none; b=jHei4VS87FNdp0Z4YEZ0zvxbMyFUd94XHNcLwZH/+bjycC8qYcRwczB7HKDvr4bMBTyULy4ipxIYBxcyXADb9+pqXsIHH5yXC7PnS5pSzYeERyB+pwKwVkEZqPkdxUyN0aUuxcxuwpamVGWrUxTOpW/8NfZ+hI7xL96TYNCOp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994518; c=relaxed/simple;
	bh=3MllCn5BW2jrVs3X10aZDREK9qNt2/q4oENR3SMY8Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjhIiQCp12lOuT0Sj28awS7ckmz8O3/MiN/JvS5miQlSd5Bfl9MhSXAKjr8fjqSiW/J/mkBGo7JbV9VOwsIomhd5J0j3ZTI2mru6fIOpuDvqOnqHvj/6Pi5OMNksVbZha6AIZ/wbJf19pxvv0J9YCmkJDuH/yjlTPk+5zs381lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UlTzxC5j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZmY3dknn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UlTzxC5j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmY3dknn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662C3d9k389775
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 12:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VDGgtPcQYtpiwnqPVv2kEVYa
	FPC5xtBpVIXV+o0dHpE=; b=UlTzxC5jRcDHV4OgshrD3hyQkpLBL93a6jgb/d3q
	Bf97kKBx8jxKZ30pm6uEUUoN0Boi+eE93hmGy2deef58KLPO96uHzJvw/FGnil89
	71F5yijgnZxZtd5nUxwGGekWPdYUaj9CHaFbXUHCpxLSKsDnZQ8WgxNyRt+71omd
	nEIoUPteLadDEFUXCurmxDWW+hmho1icFKly5EBePvmFiaIUxVZ0FWht7TlgWczt
	uO8TBRuShIneYDrf37slY5a0AMiSDuh7Kyu8E2x41YphnNSYLbIHj96xoKpWYfUt
	3/gOHAykmG94PWkZvBn0bgTzIxYDQ1NDr7mujtHnnV9oBw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnp81pq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 12:15:15 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bd83569844so1954022e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994515; x=1783599315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDGgtPcQYtpiwnqPVv2kEVYaFPC5xtBpVIXV+o0dHpE=;
        b=ZmY3dknnwbqNJBBk8KChpKRnJm10tst7ygGIWIrRSbWIAtyy8zMeNiPO+C5PvBGs8r
         es2s2tfU7K/9wtz2lKvVBso3CavxPl5LvMdb1u1dgJRxF2HU0Eq7jTRE38fG5TMmlyza
         TwlgeTF/m1gQyBg/p6yaV+A32qq5IvxTKUFRc2AWmrmcByPrpnMrjK/3+yyUDFO0sROl
         /h/dEDI58Xl9iZqoztBal/lY3zAbLOP3m7tMwsdu5fJG/6E6IMm2NqILv9LbQHwrKguE
         CgRY/+8AszPuOy/xWpYPULtnsbW1Jvzgt8UdraPJzVRUogH8J0mjqWMzKtd5ZblA4rHR
         xIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994515; x=1783599315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDGgtPcQYtpiwnqPVv2kEVYaFPC5xtBpVIXV+o0dHpE=;
        b=IK6YBHNZYoUcHuWj7o3PPSk9Dn/YW+EWHGskse3mQmVG9fwcxZd0JyBbD5q6O4cxix
         i95ATL8i+ccWiuKmOk8lOtlMMXew73dJybOmZ3OXsln5y2jqQabWTCSk2h9RkI3UpvIG
         7oT0ex/m7A4u1ePG9M0GHptsmFPpSn/KaCm3zXhQ/JIyuicKUPfgZXKsaTkI3m8748QM
         YXbXm/AyCV0czTobV5pAko8z+kibbCFHzDdjkVtP9bo7KEfKnFi/kg28HTTjF2snPXDa
         U84E6pZ5hqAZmnmG5Y3NUBWwXqCNdr0NdrqWXrui/XpJqQSeB1JE4xx6vOPQ4Fh27g9i
         7YGg==
X-Forwarded-Encrypted: i=1; AHgh+RrWGKLIfuy3kTV2L2LXviHolGOrADbwnlTqu3viGOQ15QYss8e0elnpj30X9nEJ+cM2zAx0aVZoQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWQ2+iqRjaXi/3l7e7HpGn7cpRedsGbn7g6VpV5f0g5wdxJfc
	jMGy99QlqKTIcWfBzmcSk5b72QFBskgAeTzjAAYtFLfOicaYynm5YTgNXbY1QqNKkdaEi+0ygOk
	HtJs+tw/CB3rU9wbhXWT3TcJHO8f3cCZxxQjPjdYz4chUooLTiZSIeqDVxXnQqA==
X-Gm-Gg: AfdE7cnCSqpFAEy33mfhtWJXFLjqTL4F0jFyEOPMaTsHIYSdazc8GWab9kiRkQgp015
	odbFDsYj9EhLk1reCtrgYYe025B6hEnKV4fcDrkwRRjVJlGxhBN9N7dJHgRZac0+4mEV9/YoHH2
	/0Z0usIEoSYeyiAqvHBLqhmLtV53gPB8zxn18R3wHZorizOFcpWo95XqabiBBrs079RgchohvV6
	zYqEI7iYZoHwxFPQvp/PQBA+fLB6AMCTc6/zq1zvAu/Ipywz8hiwfvZPRQovzJdn+1CxqNEFKvE
	BikzURkgRmR6//D5Sgh3kvrwoEU1lZIqKODTP687GwVY2i3nDGlClBuREHvACM7CzkjDx5BDTc2
	rX/Iu858nn9BJWjnEzj9u42f4SWyACzoYsRF6OQP2Uad4G6asW19uAG6YAhgS/OTXEngSQdT2hE
	/qXFrbaQBL8jXrFTI7TANlV0jB
X-Received: by 2002:a05:6123:2c5:b0:5bd:89bd:354c with SMTP id 71dfb90a1353d-5bddf6a3077mr2355566e0c.11.1782994515140;
        Thu, 02 Jul 2026 05:15:15 -0700 (PDT)
X-Received: by 2002:a05:6123:2c5:b0:5bd:89bd:354c with SMTP id 71dfb90a1353d-5bddf6a3077mr2355549e0c.11.1782994514536;
        Thu, 02 Jul 2026 05:15:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89e25e8sm647776e87.72.2026.07.02.05.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:15:13 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:15:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Message-ID: <kojnsrskuifjqsrq4xsm4inz7xr6hhfvugy3vz5ogddcu5y2ia@olrsxmnevu6c>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-4-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-4-7b56e2a6a6d4@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX5YH1NaYZeHOF
 USN4GVxbwENjRq2e2/OiMkA8cqtRb5yrp8M8uHC8Nk3b2IBdtjRHUSH4Zu+kqT0xIvz7UEH+srZ
 fCWXj1W6ykkLpOHwuCEoTQwNT/l/BTI=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a465653 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=STQ2a8oQ04ts6E9hehUA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX/JelGThLF9DY
 WnYDFJ9YxBgAQgwSfdBy3Y6rbe+QIpyBUbg1DZubsSVR0SorNkb5vePI3ssA/lQ70e03Qft+csh
 bphkfB4ZQWCE0pM7rwx6zAKvJ3ZkwVljRD3+p/Hd+CpGM2dJjyQCUhQZQXPYpkqvXSzIyLDBuGE
 SvEcNXFgDsSml2hkOFMf6J4UQx4WGFhJNtnlvMA/BvhgO8aOfAm9iugbqCumvr49YUxUxz2NlDy
 Ifail7XWxg1QOaf0Fa1eNXU59ZiU/9yCvM+Rsy8UtdV4/RB8LVvVKFi1DDrF4L1VppHchDObrHF
 ob8OS1gR42Bhccx9Lmo7N9YvyxQsQuCbrCDGTOJQQ4VM3UXrNqzY3AcxYuwEFv57vHCHobEvyQW
 VeSOAxXwGsTkgFgp5Ohkn0zYdj4ztYlZR6+LLpEpmCszwrjXuUSLTMkqxCjft1fjK9Mnp7mKYY6
 5W0WWuJM8OfzVW8JE+A==
X-Proofpoint-ORIG-GUID: YoCSDbw1zpfsYYqP56M9qQVFXQmjmKyB
X-Proofpoint-GUID: YoCSDbw1zpfsYYqP56M9qQVFXQmjmKyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020128

On Thu, Jul 02, 2026 at 12:46:16PM +0200, Loic Poulain wrote:
> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> Arduino VENTUNO Q board. The module is interfaced via LGA and is
> compatible with the M.2 Key E.
> 
> Add wireless-lga-connector node using pcie-m2-e-connector binding,
> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> the Bluetooth interface.
> 
> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> the pci-pwrctrl driver can acquire the power sequencer and enable
> the M.2 slot before PCIe enumeration.
> 
> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> (gpio56/gpio55) used by the power sequencer.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
