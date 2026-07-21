Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846C386450
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656900; cv=none; b=fjEN/Om/o1x4O92BFdtvr5Cg+DgP3/YMAILgsBoW26m7F/qvRtrC/U+bZH1XtsQ3ntxQUP/xmfbMKU9yJn7PcolTQYgKy7uRoraG5FQBG8Y53lBH+x25zrw8XB8f7Lz/H+j3LQa/N8vQg81t3nyckdA6998biRE+M0eS3zJeqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656900; c=relaxed/simple;
	bh=aqq0bZT/hXwWx8UmLFddb1dgw0fuBz0WtdUMce/GDRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twRSztPEjeiL1t8HuMNI+ieaRcjH3Ib4tIRhPnVCcZUQVvkW4lNOde+4bor6T90cTzI7ngvfRSLN00/FIeKJgu3NsQz45JX+9iZPdfqrhGAiJoehChGsYruFEkRR9lD02EPsLHjHlZOuaHJEmBLQLHjYhUOVKaCvMOC4DezuCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLQXOczG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PS5qXv9h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLQXOczG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PS5qXv9h"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHPVOi2115734
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 18:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/6k5png2EebTSIaZVxRWm8CM
	pbRPFtbdYVyNuYkr3Bc=; b=mLQXOczGSWLql6CaoiBRiSt2MSd/PEkDyEOCPiO9
	Qi2BBfj7JoMKyL6h7LFo2V3JMxJQTywe2i1oTTKpzKC9q3Hz0Njq4d7bboprE6CC
	iWSW2bW74uDvso864zQ938lON6ywA1pYuTMVm+IFAkpOCmlACRB9zQr5GOBmYv5x
	ZHwK8NP5yC53S4a5Rh3FROK/zOlBOd+7aG9uvZUGdN5id6Fg2J4uf/UObCKn02uS
	MYcrAKzMTPI6qrUhjWk8Bzwd/Hv+HHbJZS93p75EG9f9+0fwl5H7ytjhh55AXjQU
	M1MKKRM4Pa+Bf38JL7Z/TsQk/dh9Z5EsdNXwda7M7jaDyQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e05nn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 18:01:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc640dfde3so95506145ad.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784656898; x=1785261698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6k5png2EebTSIaZVxRWm8CMpbRPFtbdYVyNuYkr3Bc=;
        b=PS5qXv9hMkOFX4L30BIpQz8bjeLdJYIO0IgV4YchIxiMxKBIlX5ZtHmMZi2jv95cz/
         9Kn8whWr7BRMV/yjsiT1VqocUBhfg/htviIKhLUWrIeP6SllMhGoHKX/A6PKZoRlb1XF
         OV1O6Afdh7a6pgMah821zYYf463Uf3wAkYVLrxK4g97aDCCaAElHyNHSiLUzMP6o6rO4
         6MtZMiW1WyZgB8qFny3mUwhCeVAHEJK0A6iVgNIiy1YADDgZOi3fYjN4aPFZTWqoeEDP
         +aqXSs5bLCfTHMUta2v5iQryIHqJG/tCF5gDkVkAbvcugmBzKikwBjVgy60y1VCXc1XK
         QKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656898; x=1785261698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6k5png2EebTSIaZVxRWm8CMpbRPFtbdYVyNuYkr3Bc=;
        b=CBx2bWobQjBi2AmRof357RZoxO9GtNH7ZUtGAFtxyf23lyVTiUAKXJkEzzWM4EEYW4
         jL55BsnQ+DQeuK1qU03q1LJ9A/k3WLaH9p4GDdjZq4qFLOq/UvVad6s1LYTp90JtM4op
         6N99TXVvF+FKQfGHmZiNoNMTNFz7tsOWgk7KAK4ZhlysyfBIUeXVe0CGd2cRylG94Sgk
         BTgrKD9Iik8+FAtcndIwYORMNUMWT4TDSa1sIMM2BisvblUWwyS56BCC1qg5PX2KG4yE
         RQC0UPRTkh+n+25+qfdAYZnl8dllIDPiL7EBTO+wqjwYiEltp63COwHi5e6D3dgc7Hgx
         cpdQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3Kocs027/wiyxeC7F+jeeqCQu2hwWIvRAdsEU8p0hcaR1bGSuT3VV7dFMbBhb2DIeMI0H+7dWow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/95rqFTIGmSO6F6fFFSzEWEdRtSJdXWfIeEd9JtO52Auud+Sw
	0iPH8jVpPmzXRpvnwenpAOreVr9GYXJQaRXh4ABRkH7TLyDHLUshRfi9QITzsyr7HnN27FlDjod
	ktgbUuUqL53ESuYYf5A/3xbjMiWi1a2GfameSSblA/oDJbHiNG7nKWmr+6/oPvw==
X-Gm-Gg: AR+sD10VCSe7pdHW5uUgvmvkRT6MIoVmInJMPl5vSou6h/KL3gxM1/A2E2ycrxu9f2a
	YwgXg3wRXMH5BUXaoeYI3dsTTbTmdfhqDJKAfG8MLL9OEG+HGg7guleR+3Ho/TnAuo37iTJqBzO
	DrmIwlgh811WIPdPasICgamgAHWjwhXhbyr0kJufzlIvgvvZr7fcVomkP2QaAV+rDUNaz2G6Nbz
	hcC8+3c4GHAfD99AXFv66uI3VwNkfGJ2boA82SrNd/5ddGhbQD4KiH4i+7rwozaRN6N9gOHq1Oq
	+7l47iDgGoTTOkixbvf553PtxOA6VhztfzcT3WWfCNqWv/Qbqfj3Qn1VGx3dufT9E5n8pP8QzTU
	rPMLWyU6842wyzxvJ64fccRPTRAS8fkROqg==
X-Received: by 2002:a17:903:15cf:b0:2ca:be8:62d with SMTP id d9443c01a7336-2cf349b5923mr205347505ad.32.1784656897487;
        Tue, 21 Jul 2026 11:01:37 -0700 (PDT)
X-Received: by 2002:a17:903:15cf:b0:2ca:be8:62d with SMTP id d9443c01a7336-2cf349b5923mr205346725ad.32.1784656896901;
        Tue, 21 Jul 2026 11:01:36 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc61637sm1021861eec.8.2026.07.21.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:01:35 -0700 (PDT)
Date: Tue, 21 Jul 2026 23:30:59 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v23 01/13] power: reset: reboot-mode: Remove devres based
 allocations
Message-ID: <ac030bd2-6b14-4b55-b277-422514da5f32@quicinc.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-1-e7453c548c21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-1-e7453c548c21@oss.qualcomm.com>
X-Proofpoint-GUID: zu58J3fO7ewVsAN71mZ0EiSO-W-J-_xX
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a5fb402 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=GxRVn01Nmxo37F9Fo38A:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: zu58J3fO7ewVsAN71mZ0EiSO-W-J-_xX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5MCBTYWx0ZWRfX/rBwwatGRBLu
 93uZhFKtpn2zyJKVhjZjMvxhYWIzaOhFErLswjq+RCUp5cxc8bnh1sE9r6s3rQiRBWJNVYN83I/
 FwFS1iClURAH8hQ3grPh+sRvhlPFKw7hm/aD+GVmLD132yctLv5x811TWyLGFG9TlmU8gSQ5kQB
 1+M98gjNFpJCMTsd0DRRYQ+nPLKKtAZdLaT2rbKxhY1a3qe/4ghrRKr+DHIbpMSrCx/umtnjgKw
 YqIM62iGfdeH3GYmoiZ4jtYME5BYlqFFpn4xK10pWaLs7rAGI00YuWB/vtmo4e9trDWhTkDj6sO
 Etwwim+DcjSvEMM7LSQeC8wWJq0LNvR4QleZ8Q1MZb3FEBcyqyzVbzupQSbPg6PVhQPzXsiVSes
 QKhn3UYimYKorSv5Mv8sDL0Anj3t1KYywkDtSji6JAAUtcrJ00xp8FVHvn46FR6KqUHjh6nDZrv
 srh0cklJqAiF74+CCsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5MCBTYWx0ZWRfX6hcwg/n1Q1aK
 qdjI6Ox9l/zO+POUbUufiEZ87xmWHhtLCR02fLUfQzrcr3elOtO9h0+kEFssRr6e5I+5r0ttD6E
 FGwo6jALmRZw7OyPccQ1mT5n1L5o3MU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210190

On Tue, Jul 14, 2026 at 10:46:29PM +0530, Shivendra Pratap wrote:
> Devres APIs are intended for use in drivers, where the managed lifetime
> of resources is tied directly to the driver attach/detach cycle. In
> shared subsystem code, there is no guarantee that the subsystem
> functions will only be called after a driver has been attached, nor that

You mentioned driver may not be attached.

reboot_mode_register()->reboot_mode_create_device() is using
`reboot->dev->driver->name` directly for creating the reboot class
device? 

> they will not be referenced after the managed resources have been
> released during driver detach.
> 
> To ensure correct lifetime handling, avoid using devres-based
> allocations in the reboot-mode and explicitly handle allocation and
> cleanup of resources.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index d20e44db0532..7a74f72a8313 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -3,6 +3,8 @@
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   */
>  
> +#define pr_fmt(fmt)	"reboot-mode: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -10,6 +12,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
>  #include <linux/slab.h>
> @@ -168,10 +171,11 @@ static int reboot_mode_create_device(struct reboot_mode_driver *reboot)
>   */
>  int reboot_mode_register(struct reboot_mode_driver *reboot)
>  {
> -	struct mode_info *info;
> +	struct mode_info *info = NULL;
>  	struct property *prop;
>  	struct device_node *np = reboot->dev->of_node;
>  	size_t len = strlen(PREFIX);
> +	u32 magic;
>  	int ret;
>  
>  	INIT_LIST_HEAD(&reboot->head);
> @@ -180,19 +184,18 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>  		if (strncmp(prop->name, PREFIX, len))
>  			continue;
>  
> -		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> +		if (device_property_read_u32(reboot->dev, prop->name, &magic)) {
> +			pr_debug("reboot mode %s without magic number\n", prop->name);

Any reason for converting dev_xxx to pr_xxx here and below?

> +			continue;
> +		}
> +
> +		info = kzalloc(sizeof(*info), GFP_KERNEL);

The recent commits to this driver adopted kzalloc_obj().

Thanks,
Pavan
