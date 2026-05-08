Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFE280A5A
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244609; cv=none; b=ExWRQNFxd0SVwmINCTJO3ul2pnZEkmBYyDoQNVKWqPCK5uzfZsiJY1w1c+XNYnyKj5GFscsyUslNipe7+93UatOAzUFp7Dd7JFIoN1egw0ZAPJhDZ0nE5CcNUmQgsjgk4eBL2LlSTK9xIDTPbb0cyAwEeXhb+Vp+n4T9hC6G62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244609; c=relaxed/simple;
	bh=zw7g2Yy6gSTJR6AEXuh6Ij4LgD/Ye5RZbXDj40piSG0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dtacrr2cN3U7KtDSeoPNfV38GBrtMSg8bUTSilufcLkkmzOE00I/l0z/F/tnR6B4xR8fKzpv9lcp78CBXx7+/bFpDyQqXumm3yi2dLnlD6VkDNcQNfkI+YBxB73bZU0OlEQdY598FDQqGImkzNebClJFmw+Skoi48/KdUeVONWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEc5OrVj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EH81jZz9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEc5OrVj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EH81jZz9"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648CGmSh852136
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 12:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fgy0grFfJFOerAGbvrwoD3Um+wI6cGrkAGMGsBcSdPA=; b=AEc5OrVjL0wweDjV
	LM81Ei88lJb9V/aW+wrlAueL0bNYeUkLPYe0l+CJNzj/JElm7BvQz0XzV9DFrmIP
	GYDFojJHOv94qhRiJiTOT6yu4uI7y/fhkDg+aRCHSL2EW8IgnTZ/6QkVBntS1qoO
	lRTL7yYuDUhFCp5c/aju0VnEDEIDPJPIg2XI6YMadvqW+ErAoaxhtYq0pRyULRCD
	UzbSQFhNpMzl/Iy0nFpEG+rfwZbItzxywgVNAqH9uxxn0EIA7gEz0RNq3j27Kt1v
	qY7o3xM1aDIbqYysgh2U4hq0EcLR+vNt3jM6UBDUXyvWFkBmPGwrTS8jwgGUCLCL
	OoEH3w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1fptg3ws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:50:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f21cb36bbbso213706eec.3
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778244605; x=1778849405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fgy0grFfJFOerAGbvrwoD3Um+wI6cGrkAGMGsBcSdPA=;
        b=EH81jZz9IsVLBYf9LJWfMO13zjA1oujFo9pcI271Q6J42R2TdKUtzehiuMUGH8so+S
         eMnlOwWOW8dCR67DbyFJ/1znNQrNDy6Y/t4LVeIJJIeE2fTosEcn3JbR+FyQxSf/+B9n
         utYT5ZRIzK+sfyuQ4xSHA37SdHruhh8VPGUXOEpWq1q+ES6R+WZEPjmcH/m16y7NhdlN
         EulA/mnlaT3gzUJoTEbmm80v8KVnuKXNZv4er3tZJDXoef9nk1mKr77Okl81hLgxQU5W
         pfzSlKnDLoIlt3akPs/REhsIfz2goFrfsd3LTfXdZOFfi5um9cYvPFDk4z1cdHNYhu3/
         YlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244605; x=1778849405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgy0grFfJFOerAGbvrwoD3Um+wI6cGrkAGMGsBcSdPA=;
        b=En2xcn4qRgJ4UYxOgx5dyJAK7tQlXPkQZc+/lLOJ/G0igN384PBV6My1q8Gi48vt+S
         iPuB2KQjDJqi3RkslWjEJDp5LCrfxBnaA1FFxrzHEMlIHlgtAc8agB0dC/Bv4CiBxN/Q
         A1uohjbBqg7GywWnzS+zjCDSBk8mThpAex9y4vq3oCNVXh0pZVBE1vU1SR5ig2VkExtG
         EgUNhdR8J2bOVWIMys6obwlOwK89A3WezZErB9m4FKtqGYbKt2XqxltbEkca7OjLLAlE
         8F19j6yCcZ7AhbgYwEBPahIKnS3naKCU8uLKyAUgAwnnYxgT2K0/o6dG9z0gxV/afmGd
         4qBA==
X-Gm-Message-State: AOJu0YwDZOanZJPxWmmMBGRVYG0STvtoZVuD1LBTkw2BjYCjo5bt5Yql
	v6i1FllyF2eu+swBigkzhwsjLzQCnKlgzDCuk3KWaGVVAsSh3KOw3+VPbe+9b64vi5NdO1D/046
	53251XL1hFW/WEgeg2kZGMdFt3Nn+jzpxv7FQO0LPt0WwH6sgi3D+I0WtPtvn0w==
X-Gm-Gg: AeBDiesxr9DGphM/HETH2KMoaXcSjmkjYKM6LqGMuYalDrgW9u5kYwUQnLhbiFn/Ucv
	6T1PBTlmVmf++2j6nFeH/Z0KiZHRl/qO3RMzDf2TYy9PA3Imlg5L2tzWVvJYiONdw/imI1x03KA
	45gyC/7aodT4igRajYdi9N0ce4JqxhSsUAHuXVMz93HsbpQlf1wqdzaNiIivS8vLOLwZwvyLsp+
	PxBQ4Hf3VUlrfjv2B9TE0SFXXiaqDXLt7NZpwpAwbhlTx4qRphBQMEixwGJ4MpQ2RyTI1ZVTv0i
	L1Swo5rtwlcR0Jpd/ID+cPSA9YS+CB7ka7pXRmowrQOEJs3AUYUHPBKe+3N/zPS9Hhr8kl7hR0h
	0hfZQeSfJtpfhKPeJMk3KK9ukvpY8NX2OUS1CSTGAG4M=
X-Received: by 2002:a05:7022:68a9:b0:11b:ad6a:6e39 with SMTP id a92af1059eb24-1320b6fa279mr2355533c88.5.1778244605500;
        Fri, 08 May 2026 05:50:05 -0700 (PDT)
X-Received: by 2002:a05:7022:68a9:b0:11b:ad6a:6e39 with SMTP id a92af1059eb24-1320b6fa279mr2355521c88.5.1778244604928;
        Fri, 08 May 2026 05:50:04 -0700 (PDT)
Received: from [10.239.97.27] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm2635918c88.1.2026.05.08.05.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 05:50:04 -0700 (PDT)
Message-ID: <b66ea442-2c02-4662-b5de-f5482736ef7e@oss.qualcomm.com>
Date: Fri, 8 May 2026 20:49:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wei Deng <wei.deng@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/9] Fixes/improvements for the PCI M.2 power
 sequencing driver
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ImSxzokJ1sGLHDnvNMGdrAJMsqwzKpdw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzMiBTYWx0ZWRfXwFfIBgduoNIy
 hs9zz/ddC0FUwCeVhRXBjh5u7QXqjZGAeg53fa9SvJcmlKRkhmyrgAox6LizrBbDH8mkUOXjtj9
 OAp/atf5IL5/QqBpd14Js1g+QI9ZnT+hy1j/PGC2RjNcBgdz94T78wcYyUoGJ74XDctcfX9YM4C
 F/i2kuohx7T2H+HduaaHJ19zqjY+lnesumaYEYt37lPPhicBpcDE7an6QMnVbmlT/AeMsqrkYiD
 8cw//F/JxaG9xlUmYkLs6aylaAK059dqBDnoeOy30XG5+BsniO7uHoRTDTA4QmVCcvLojae81oW
 0yVyzH0ejzEr6efYd63SuaBuOijo4E3dnedbkczq3uNit/wdcMQAtrfZej1PRyCjnIJ1xxD+miV
 ItMHlKZmH8HCNF+V8gYKNCnrY3RucOfLL7hEniWuZnTN53HS2tMz6cc+wS2tZwLDG/MzBAeF6FD
 YJu303IWcGSnDAhQXMQ==
X-Proofpoint-GUID: ImSxzokJ1sGLHDnvNMGdrAJMsqwzKpdw
X-Authority-Analysis: v=2.4 cv=IYi3n2qa c=1 sm=1 tr=0 ts=69fddbfe cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=qRrKk6tSi6DhAyMAVQEA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080132

Hi Mani,

Tested with WCN685x on both M.2 card (pwrseq-pcie-m2) and direct attach
(pwrseq-qcom-wcn). BT works correctly in both cases.

Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>

On 5/8/2026 12:06 AM, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series has several key improvements and fixes to the M.2 power sequencing
> driver and also the BT HCI_QCA driver. Notably, this series allows the M.2 power
> sequencing driver to work with more M.2 cards, not just WCN7850. It also allows
> the BT HCI_QCA driver to detect whether it can control BT_EN (or W_DISABLE2#)
> signal on the connector and set the HCI_QUIRK_NON_PERSISTENT_SETUP quirk.
> 
> Testing
> =======
> 
> This series was tested on Lenovo Thinkpad T14s together with the below DTS
> patches:
> https://github.com/Mani-Sadhasivam/linux/commit/29534d15307551b2355eb254601dec511169f0aa
> https://github.com/Mani-Sadhasivam/linux/commit/f4eaacfe647674be200847092b43cdef2194fc55
> 
> Merge Strategy
> ==============
> 
> Since the BT HCI_QCA changes depend on the pwrseq changes, it would be good to
> merge the whole series through pwrseq tree or through an immutable branch.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v2:
> - Dropped the pwrseq_is_fixed() change in favor or exporting pwrseq device's dev
>   pointer and using it to check for the presence of W_DISABLE2# property
> - Dropped the BT_EN fix for the Qcom WCN devices since it will be handled
>   separately
> - Collected tags
> - Link to v1: https://patch.msgid.link/20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com
> 
> ---
> Manivannan Sadhasivam (9):
>       power: sequencing: pcie-m2: Fix inconsistent function prefixes
>       power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices
>       power: sequencing: pcie-m2: Improve PCI device ID check
>       power: sequencing: pcie-m2: Create serdev for PCI devices present before probe
>       power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table
>       Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
>       Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'
>       power: sequencing: Add an API to return the pwrseq device's 'dev' pointer
>       Bluetooth: hci_qca: Set 'bt_en_available' based on W_DISABLE2# presence in M.2 connector
> 
>  drivers/bluetooth/hci_qca.c               |  28 +++-
>  drivers/power/sequencing/core.c           |   9 ++
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 234 ++++++++++++++++++++++--------
>  include/linux/pwrseq/consumer.h           |   7 +
>  4 files changed, 217 insertions(+), 61 deletions(-)
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260422-pwrseq-m2-bt-abdaa71094eb
> 
> Best regards,
> --  
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

-- 
Best Regards,
Wei Deng

