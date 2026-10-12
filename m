Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D045D927
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794897; cv=none; b=IKBqU4vvLODUyI8kOsn6v1Q3G2IE7HZYbrn1iKc1nxFX3a28xS2ewRAEDaEWgA+gJGX4oUzUAInRsNudY+ZCXXrPG7N4sORFkyawgt15LEDB2bx4mVuVq9UuMSPUUYbvFRwF/vc1D6K/QovjxoCT7Wbrtw0E164nR8ntgVdjNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794897; c=relaxed/simple;
	bh=w7r2svvWZl17n1VZIdfuMLsZzqmBQZqB6TJKXudUmGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0MCsosLeAXxV+BUfK820RdwFtBNKAZVenELFw+7vzemEDEXLCyt9G2gF1QFK/6cudvSIzQ91Y9RMIMFCqdeFllXsGiYkEFvfhlT+Iv8TqDZ1rrp6VoxstmOEug3nH99zslTVMyzmwEslYqbg2p9fEkR4xH70S6i74VE/ytDQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YmZiRkPV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jwT9P5rk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YmZiRkPV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwT9P5rk"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8Ko1W1439329
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 08:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D+PwqydQSMK0RfY9WDLxxuX/FrSgdWszK9rNSdMn3W0=; b=YmZiRkPVKRbbhwwH
	JPMPAief4Er4v12OGm6y3ox0KmODjuQv8WO5KpTpvYNUQRgKLT77FAqZxe8uRCB+
	uSrx5jQ+HC9Pxkme0AcRoh6uQ7w7skuI/KqN+aOG7q5XprDu/7ct677noLINQq7o
	vuqDeOM4D0dPzq5h4IA/JOvuA+2hP7R5jwyz5KaXyOlYnWwbL0wV//SucmdSyBQk
	QLLngJuoxy4OnMe33tJ/RroxWTzyDWE6PmaDpKTQ5h8GrTJKGAuP0AIvzOXDFKB/
	9HkUskNeTiY2oLZ6pJvDaL8Gs7KyNFxIrsiSnOeajjYJ6aHocAenHOMNhdrSrr28
	40qLWg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkh56j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 08:48:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so2569681b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791794893; x=1792399693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+PwqydQSMK0RfY9WDLxxuX/FrSgdWszK9rNSdMn3W0=;
        b=jwT9P5rkEvQmU0S4wDQA13D2yrxLiyhjyvcg30WGA8P6V++6bJl08dd9EJ7+R1bJhc
         gfcn+naqwcJElahemDVYxvAoJxGT2bk27mAcfzTHZ8gq4E4yhr8KSqmfEJ7cdv1EON0g
         1oJhW6NCI6WmJJN3uC9paZassqptJAv/GUdWfyLYqB2fkmij6YdABjhoijA/6gqSZ0Yt
         kQTzyxP+kw+pTc5mxUsYI0YSR3wmY/6R6SJN2B887j58dQdBneliH5mLhxOp36BxVraM
         lNC/UkZHTEEK6MMWBtzZ7OE4dXdCLG4R3LhsDi7BVlyF+c4uZiuMgxLaE7mdWk6VXzmr
         3GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791794893; x=1792399693;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+PwqydQSMK0RfY9WDLxxuX/FrSgdWszK9rNSdMn3W0=;
        b=FXx/iEgfLSAXVAr/rU3KPz5l+kQZFrFrufLCXRfnoJXZ0TF+59wz7r28EmXbe6P8Pd
         OvBadfN5LBCeGR0Xcj0RWIz1o4yrr8XQJyo1VTf3fOIQ/ZP+eZdgmndr2bTIypMsYJIi
         dsc0KV5ZV0crWyAJW3uRa1IQNefiU0CwB8oxYAFdSpotbLEZLlfCo8MQ9QrOQhl1mINR
         RzY7NvG7FkhggwQswpVzjrlRWC1n3RHaOYXUqxSd4FTjCZ1PH8WqJ3dybWdh4QK04kAg
         591LJM7d3+9JGEXSnbgY4mEYs6hPeNSAroyKcdBOpSQhGcZTZflSc5S06tM5d9ecphDI
         xb4Q==
X-Forwarded-Encrypted: i=1; AKwUvByL3gETp0jj3bu/f2AN/w2PVqqJ9tbHD/0JcAYkp3tjdBTh+rfZTcFWUOEXfwVNTLci5i2tdiz6Tg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4EMP9nurl4Ec8eDmSsMw3XjIhuQN7+cxfeEqlehxjFtYEahB4
	fMArve4zG6f+HKbmVOJlXrIu8PQr8YEcEJ395XHsJNZUl9y8c7PYMPHd0MvWiF2DwGm/9hBpxw4
	6opYCycU8RUE7i8pabmu09AqOLOEnW+s37aED9yUOv20P7YCwUMyuzWRTpEj/sw==
X-Gm-Gg: AYBFou2g97or49QDvSuf8p4LqyHIsfvNufktZZf4sQkGZT1znt4a/4sxgGX0oOKATyD
	tDRQ3+wo8xqRTvYdiyjSONiYbzdvhT73BjHLiRD3AMpECETkUr4pMgTolQH/yPeSTA6fJWSLChd
	8u7j4BQo0CoR1bteIxjzANqrUzK49wncfcV1BLkOfcOu1dsEZRdKezZEo+yREeFIkPoPsDGQ3Xe
	++5x3BIjLt2bAXrWFFqLGWZ7TuNwSY/sRgHB7/0rQAj5GV8WY0tvzPW+C8AEmWTLqkHmxUAbqwT
	aUKbZbPxhwZVgogCf4KX+W668QSib3RIYJzCeQ/AjC9+/VbSmdRMJ9vW16ODxtKcbKSjNMCwqD7
	doESobZJNC9Jt8ggRZfXukYmHbH1i4j3D
X-Received: by 2002:a05:6a00:c1c4:10b0:899:5117:2ac with SMTP id d2e1a72fcca58-899511703bamr2681162b3a.46.1791794893196;
        Mon, 12 Oct 2026 01:48:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:c1c4:10b0:899:5117:2ac with SMTP id d2e1a72fcca58-899511703bamr2681147b3a.46.1791794892529;
        Mon, 12 Oct 2026 01:48:12 -0700 (PDT)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3cc80b0sm3717202b3a.29.2026.10.12.01.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 01:48:12 -0700 (PDT)
Message-ID: <305cf7a9-7ec0-49a1-a990-101536beaae8@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 14:18:07 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PCI: dwc: Power the controller down when hibernating
To: Birk Skyum <birk.skyum@pm.me>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <179157746908.73485.2343672865542690797@pm.me>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <179157746908.73485.2343672865542690797@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX4N465AWFcx7I
 Z5j8uU4UB+3bNTp7j8PzxTtD96QBrwpIctm3p+WDk3e4V6wlcoHvcBcRJK0JpGtVdO2cg9t9HOJ
 ovVwxfbL/KLrhtF4PGfNuABrOfq/GipGNeZReKaX9UvrgXgv2rrLOFgm7VRFPdfX0qn8d0zHLUb
 gEaUkJnCenG2aapbgQhzqvDASzM8iOLl4AdkBfC0Sf6a7QLJQsrDqaNWDW5NY90DPzhDUjHQA+x
 yk/4gquv3Fo+hPb+VcmezKNi2DL96XpezcCa7xIjciom2xP4vohcRMDFddY+mwyIJPDjefAvHnC
 DSt9o8Mvjiy5fkmoz3XvlVHAf+saBsfGmW/FHH1e7WQkb5grus9MpA2fcflmCKU2OH3YlOkgxgN
 sH9fi/Ut+TUPCZm2I0ls4llGq0mGTmA0JSFybLciMpczNCgEitl7iu1TxV1nid/xLYGKFxOPimF
 YOEGX6GGAbXrF/h8n5w==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acc9ecf cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zA2YdQmmiT9HswpVmB0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfXyqteHJg2NqqE
 cGvkc/ZguqwswNKrbyzsAVY0OpVg5x2EuWXVkI0VtxH+l436DJtYX2am5XPuUOi0gcXz4bX+kds
 jLoCseqVN8hlygKrBMSh7zu4EzVrGVo=
X-Proofpoint-ORIG-GUID: MFjqcCubm_1y8fEHHzFDzOS7sapb5uG4
X-Proofpoint-GUID: MFjqcCubm_1y8fEHHzFDzOS7sapb5uG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120034



On 10/10/2026 1:54 AM, Birk Skyum wrote:
> dw_pcie_suspend_noirq() leaves the controller powered, with
> pci->suspended false, when a device below it cannot go to D3cold.
> dw_pcie_resume_noirq() then returns early and the driver carries on
> with the controller as it was.
>
> That is fine for suspend. Drivers use the same two functions for
> hibernation, where they run as freeze_noirq and restore_noirq. Devices
> are normally still in D0 at freeze, so a controller with a device
> behind it is left powered and the image records it as running. That
> image is resumed after a power cycle, by a kernel that may never have
> brought the controller up.
>
> On a Lenovo Yoga Slim 7x (X1E80100) this resets the machine on every
> resume from hibernation. The Wi-Fi card is behind pcie4, whose link
> only comes up once the power sequencing drivers have been loaded from
> the root file system. The kernel that loads the image resumes before
> that, so it never powers pcie4, and the restored kernel then reads the
> DBI registers of that controller:
>
>   qcom_pcie_resume_noirq()
>     qcom_pcie_icc_opp_update()
>       dw_pcie_find_capability()
>         dw_pcie_read_dbi()
>
> The machine resets at that read. pcie6a, which holds the NVMe drive and
> is brought up by both kernels, gets through the same path.
>
> Take the shortcut only while a suspend is in progress. A hibernation
> image then always holds a controller that is down, and thaw and restore
> bring it up through dw_pcie_resume_noirq(), like after any other loss
> of power.
>
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>
> ---
> RFC because this changes the freeze path of every driver that uses
> dw_pcie_suspend_noirq(), and I can only test qcom. If you would rather
> have it in pcie-qcom alone, or solved on the restore side, I am happy
> to redo it.
>
> Tested on a Lenovo Yoga Slim 7x with Arch Linux ARM's v7.2 kernel plus
> this patch, booted both for the image and for the resume.
> dw_pcie_suspend_noirq() is the same in v7.3-rc6 and in pci/next, which
> this is based on.
>
> - A hibernation with a real power-off resumes (one run). Before, every
>   attempt reset the machine.
> - pm_test=core and test_resume pass.
> - pcie4 and pcie6a both go down at freeze and their links come back at
>   thaw and at restore. NVMe and Wi-Fi work afterwards.
> - A suspend (deep) and wake still works, and neither link is retrained
>   across it.
>
> Two things to know about the test:
>
> - I unloaded ath12k and the Bluetooth UART driver for the hibernation.
>   With the Bluetooth UART open the resume stops later, in the GENI
>   serial driver, and the remote processors do not come back after a
>   resume either. Both are separate from this and still open.
> - With ath12k unloaded the Wi-Fi card is in D0 at freeze, and the wait
>   for L2 times out on pcie4 ("Timeout waiting for L2 entry! LTSSM:
>   0x11"). pcie6a does not show that.
>
> Nothing survives the reset, so to find the read a test module wrote
> each step of the restored kernel to an EFI variable before it ran. The
> last record is the entry into dw_pcie_read() for pcie4, after
> gdsc_enable() and icc_enable() had returned.
>
>  drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 77aa79ef0..458e4c6e7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -19,6 +19,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
> +#include <linux/suspend.h>
>  
>  #include "../pci-host-common.h"
>  #include "../../pci.h"
> @@ -1231,7 +1232,14 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (!dw_pcie_link_up(pci))
>  		goto stop_link;
>  
> -	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
> +	/*
> +	 * Leaving the controller powered is only safe if it keeps its state
> +	 * until resume. A hibernation image is resumed after a power cycle, by
> +	 * a kernel that may not have brought this controller up, so only a
> +	 * suspend may leave it powered.
> +	 */
> +	if (pm_suspend_in_progress() &&
> +	    !pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
>  		return 0;

Birk Skyum,

can you add freeze_noirq and restore_noirq instead of reusing the suspend_noirq & resume_noirq. After adding them you can force d3cold similar to this patch[1]

[1] [PATCH v6 3/3] PCI: qcom: Implement shutdown() callback - Krishna Chaitanya
Chundru <https://lore.kernel.org/all/20260909-shutdown-v6-3-62b7bd123236@oss.qualcomm.com/>

- Krishna Chaitanya.

>  
>  	if (pci->pp.ops->pme_turn_off) {
>
> base-commit: 591d89f23a7cbc668579521513c7f53b0968754c

