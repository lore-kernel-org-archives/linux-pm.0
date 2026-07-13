Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296553E2740
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935819; cv=none; b=b1DrNE48i3gomxYptQ7w6Z4nY7b/IBZK4Bz/WkT7h4EZUnmP/nhdvCAJoQKmV2l/7fbHtxsCwVM7LWF/oWmMhZfKWQU6s6nprWYGSjb84QrgLo0xii69hDkXgkgg63Zjjlanv4CJ14Yw6mnAmv7HLk+jn2TS3KVh4P0VoaViyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935819; c=relaxed/simple;
	bh=1d1gIgKd/rxGakwIfoQkZDJqlQDsvXgB5BX3doT1Uzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLS+7UEKrpMzr93oyG2EZPe1S4pgI9yfaiqG9any6AyTxAoGIppKS7YL+P9/lZXJw00roOT/SoyNPFQnIm8PIBhXjB7X8ORxheA2MdRjW8QoUopGMQhkTGVa54DZpaD6mppRd2AJOjmkJSgrJFMR6aVaF4OoHFgio0SdQUEz7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y8Vpn6+X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRaJNsRw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y8Vpn6+X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRaJNsRw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NkIW668639
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E09LB8FttLtJXfseyW8i4L083+99GbXlC7bLX0eDPNY=; b=Y8Vpn6+XDg1v3UVs
	ifJVSOVnJCK9iNSdhYFo/MtAVTPoxOgcZc8sfLmOylqkBIRGMnO2w46/2H81dmQq
	UI5wdNAZCI5EVeNea6H1A2HBb+e3nUomuojBiODBpWEvoBqrG12i8U96KeN5d3PD
	xe/9fKq9TIgoG8hxGNzf1lDDC6x9OtoDdnLC9pNDAxpvVECVmS0I6p1wpS/8nROZ
	5Wy40eKFg/ULSV8scDUj9VDslMpsukGcgTDHK3jbd81GDMnAJPi5ZRUS6Lez4RRf
	s1R8wuSuVhm7V+wYIobJ/mpCy2QsgIKS700mKTfWLqAuDOlZbiaYJaU7nDzx3oha
	PJdreg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm1wtc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:43:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc0eee75dso724743a91.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783935817; x=1784540617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E09LB8FttLtJXfseyW8i4L083+99GbXlC7bLX0eDPNY=;
        b=ZRaJNsRwW/zguBharFpaG5zTDNpxrabdFaafPy3fGn/I4V3XQgemDSjSiAF6Ofq/rl
         aSOAitvcPzXeyUMJHGACQXgHoqa52+a73tMQxvQmQ95pk4l4LBWeO1mHsCgZ6rRTLzio
         FPqOC2raoJEulmm+GuvwQpBtFfBr5Bj3YC7TsrrudcK2cvioOVZXlLWLd8/byKZ3dD52
         sSj9L0h2kxokLnECV5Z+t/lPT4NosZ2zOv+Xq/IFo1Ju/KI/4pntt45s7/OAe+EaNJX5
         5VUAq5WdzndpegCstXYXMzR2JOsnkAUTA39zUJsA1HXf+d/MjKMllh7FUmhCheLDLzfr
         VgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783935817; x=1784540617;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E09LB8FttLtJXfseyW8i4L083+99GbXlC7bLX0eDPNY=;
        b=XHTLlCS5wXUhJ5WQZUKqT93u/j/PP+sG/WYuq94wy1TKkxi9+lWllFMoxWGcgL0kID
         dUBFsdf7x0iSgY4b+8lhgBUbdLC4bkBeZ5Z0529zPj12azO0rdanpGrZHVyB7I2i0vWw
         Be/b9Q/SUMmuEuy+yimCvRWBSDL0G3xtN0fVd3JOIZs5ZZWI7Ha9T1Fn3+ksEADDRGd+
         +kxOzSDG5GIa+tu1PZLgVCaDQM6QVwTXQsZSL3yrcWoYwYvth9BGfNEHCyIAnXNY0BXN
         YVvvxaOae7qe8C88JLL65KTZM4VtobVOA9Lspu4d27H+QLsZfGRNwH8blGsVqruJo3y0
         8E9w==
X-Forwarded-Encrypted: i=1; AHgh+Rq4+0B0FUvd0PhSagBJUMBxznZ0wpe90XWcNWPtDuFbJzvmX9mBps8m32JQ8rHHCiefnu1seakeIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLP7FOmBZh1Qb0+DAutM7Kzd8ThjpGaU9th2xVmAigoavtTi8F
	QIBsq8hTI+/VWLP0zIwyO2u1NxxMZGhDZkTipQr8GkuTXQN2t7YEHm4ku7RL8y1OSi2ofT6aiuf
	1KFb1CouvHqqyeEtZv/V0Kh4bZfIxg2Pyjl78bOAO+lVpEteYmXDBTLhJypGC3A==
X-Gm-Gg: AfdE7ckop3nFX3Su6qzlTSQ7OO41/+ZH95T+qDCx5WSKjBTsuJn+H6pIjO0YC9RIAIk
	ZcJDH/cAEgGRdNfstzrYHurDd8IPkFoaH5mTa9cKhySKL4TFoLztECr2bzEYv+bwqZ6mJD6kgfT
	WvlBDMFjFcLaqTbCMjStXqa2OlMcCU0r87XI0o4Gq92Wpq3teuh2F+SNT+TceGy/fVG3f+j4mPj
	bXMzpFgK7OJm8q/DPaZHDRS9+Tk2xdIufcOx3EmLi9aUCWGX3QuD7IMnxbLs6lZBU77SNyrpFc0
	kOQisPtoyj1ZHsmsnMBJLpHQBU7VrOL+zCjcH+Cb0z0uBM7xcZdeAAprLtAM1yVrE/B+zOX/s49
	3mrnurd5ZKiQGDZ4nGATjLjuHF65tB/9y2B+qKzgSmuSa6E77lEP/L7UNWL5qRg==
X-Received: by 2002:a17:90b:2b4b:b0:37f:fc3a:382d with SMTP id 98e67ed59e1d1-38dc7b7063dmr6317598a91.6.1783935816626;
        Mon, 13 Jul 2026 02:43:36 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4b:b0:37f:fc3a:382d with SMTP id 98e67ed59e1d1-38dc7b7063dmr6317583a91.6.1783935816051;
        Mon, 13 Jul 2026 02:43:36 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313af819732sm37848388eec.16.2026.07.13.02.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:43:35 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mengshi.wu@oss.qualcomm.com, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com
Subject: Re: [PATCH v4 12/14] power: sequencing: pcie-m2: Add usb and sdio targets for E-key connector
Date: Mon, 13 Jul 2026 15:13:29 +0530
Message-Id: <20260713094329.4105208-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709095726.704448-13-wenst@chromium.org>
References: <20260709095726.704448-13-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mkRIOELwpGH0yQCy-B3KUnrKlKYX43ld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwMSBTYWx0ZWRfXyHheeKQm1TrZ
 A9Lx32RzaPNpX77SQ5iGEGHaLzZ3nQNyTp4paEnwXpWMFQW6pVpQqTtBFj84mShz1dSohGoi29A
 X/VtniaH9MrTYhZU7kNwixVO8dcV7c3VVyI1GWTu2Fd7tGQhStMbzwk8Tzp53cQctx44epmGUxf
 PybbGUqZtnUgIXOjzcSI70iFXZl+h5O1emX8seoOdfZcnjoOJvxYQjRXQu9mirz3FII+1qyIIdp
 h6wHrfmXFly8hXCrEr+OVGB1yEJFyRfrEca+Wec4uGy+pxlbsZKS8LaFxtiLfwf3pKpMYA19JTG
 sugM8/oC7Kblj0SEz2c8ZoPhgPAjn82hWJO0VWT4hBRiEBTOn/DPhAyeVt8jHglaMs/+13JQQme
 Etop6L+lzoqW4nnTjx3YNx7XQe0yaTk6BfYuMp9mhi4RQRkW+/gMg1NyvR4mYddA3Z8bZUc/6Ya
 OcGv3GaRX4Cd5jBSHSg==
X-Proofpoint-GUID: mkRIOELwpGH0yQCy-B3KUnrKlKYX43ld
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54b349 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=AJ_gLjkuB4Bcd2vTZOEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwMSBTYWx0ZWRfXwY2JZ+DglYAv
 3ds/WPccPzRQSKOBmaXTgCSx51BGCQstyPEQKBJS7YdgcVs7Kj6Wc4n/G4R7cZAHRn4IajjxJzR
 fqY09hgIk9x8VZ6b/ZMFBklFL5jslzs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130101

On Thu, 9 Jul 2026, Chen-Yu Tsai wrote:
> The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB or
> UART for BT. Currently the driver only supports PCIe and UART.
> 
> Add power sequencing targets for SDIO and USB. To avoid adding a
> complicated dependency tree, rename the existing power sequencing units
> "pcie" and "uart" to "wifi" and "bt". The existing target names are left
> untouched. The new "sdio" and "usb" targets just point to the renamed
> "wifi" and "bt" units.
> 
> The "unit" names are internal to the power sequencing framework, and
> should be confined to a single provider. The names are only
> informational. Dependencies are tracked with pointers to other units.
> 
> The "target" names are the strings that the consumer uses to acquire a
> descriptor with. As these remain the same, existing users will continue
> to work.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Expand commit message
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 41 +++++++++++++++--------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 

Hi Chen-Yu,

We tested this series on the Qualcomm Hamoa IoT EVK with both USB BT
and UART BT M.2 cards and found an issue with UART BT power cycling
when the USB hub is active.

The "uart" and "usb" targets in this patch share the same bt_unit_data.
The USB hub acquires the "usb" target in hub_activate() and never releases
it, so the bt_unit enable_count never reaches zero when hci_qca calls
pwrseq_power_off("uart"). As a result bt_disable() is never called,
W_DISABLE2# stays deasserted, and the BT chip cannot be properly reset.

Observed on Hamoa with a UART BT card (WCN6855, sub 0xe105):

  With your patches:
    lsmod: pwrseq_pcie_m2 ... 3   (provider + uart + usb)
    btmgmt power off -> GPIO116 stays HIGH (bt_unit ref 2->1, no callback)
    btmgmt power on  -> "hci0: command 0xfc00 tx timeout" -> failed

  Without your patches:
    lsmod: pwrseq_pcie_m2 ... 2   (provider + uart only)
    btmgmt power off -> GPIO116 goes LOW  ✓
    btmgmt power on  -> hci0 UP RUNNING  ✓

USB BT card (WCN6855, sub 0x3374) tested separately works correctly with
your patches.

The testing was done with the following Hamoa-specific patches on top of
this series:
  [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
    https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-1-5e725091266a@oss.qualcomm.com/
  [PATCH 2/3] power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
    https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com/

The fix we verified is to give "usb" its own independent unit so its
enable_count is tracked separately from "uart":

  static const struct pwrseq_unit_data pwrseq_pcie_m2_e_usb_bt_unit_data = {
  	.name = "usb-bt-enable",
  	.deps = pwrseq_pcie_m2_unit_deps,
  	.enable = pwrseq_pci_m2_e_bt_enable,
  	.disable = pwrseq_pci_m2_e_bt_disable,
  };

  /* change usb target to point to the independent unit */
  static const struct pwrseq_target_data pwrseq_pcie_m2_e_usb_target_data = {
  	.name = "usb",
  	.unit = &pwrseq_pcie_m2_e_usb_bt_unit_data,
  };

With this change, uart_bt_unit reaches ref=0 on UART BT power_off and
bt_disable() is called correctly. Since a M.2 slot can only carry one
card variant at a time, the two units do not interfere in practice.

Would this be an acceptable fix, or do you have a better approach in mind?

-- 
Best Regards,
Wei Deng
