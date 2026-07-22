Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC149550B
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713852; cv=none; b=PHxoJKEZtTCRnOyAGC7LYIOWsuEmSO8Q7yYgeeuLT6hfV6gBgNp5yrzG3EioE+BawQuW9B1bv3BImWCPOcKBLtHjI7QzYirMzboveBae0YwiIzawHfbkUJlglw7JMuU001Oq+2gLcl09JP+PyF7WxsR8y6bPL9+8EaQYpHaTPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713852; c=relaxed/simple;
	bh=zr58osoMX0jqB7Ny+PyJro8uAgdhkpoQJr5hOMzDFy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQy5Ya9l5O6wjCc2JrfbZQRWQW9oYP6s63DLQuOXN1f65SRyL7ziCfQBSR9ZVsAD7T4E8J8Rh3sDl9vvXTNLhIgkVZwL8UBCMO9RI2WTieV3aEOFZBPtFyA9SVSeFtT4gfGEAAYv0lUVxt10TYknf2JMFhWEn31EVko0uMcwOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+yPaN4x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EvcXTpt8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+yPaN4x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EvcXTpt8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8xFRJ401390
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d2S3NyHe7JKxNxgaSFpKvPq/
	rKGPVUbh4HkCUkp0pt4=; b=T+yPaN4xCigNC5oa/en9SmTdTOMoSifsGS8W2UkB
	S9UcGQ4BfvtI1dqU4J1vYhxtYjmkXBon6Wh8WsvDM6L8iiljaN41GLL9HJDejAUc
	QyphX2mpDQ2VAkhaTMUy3+JKTmWhb/RuIu6sPTuPX+30bFm8iL/ae5jztVsNsFHa
	Km9E+BDObU9X9c+Micf3Gc94VPX6hNALZToMRBhL4drApev1Osf64XVrTJQRezLt
	D0hBBjtQo3F0f2wZDL1zSGFSWXTsXU72Ghnr+b/46fzpJlbJcvO3xHn4cGCh2zPA
	tKE4idNRgv5yFu0tuwOvbB+XQo6M4bSppba9LGW9PDqYtg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt798d61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:50:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf27789c79so78265575ad.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784713842; x=1785318642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d2S3NyHe7JKxNxgaSFpKvPq/rKGPVUbh4HkCUkp0pt4=;
        b=EvcXTpt8LhtN1KcEaLyWUHyrMGpFf57B6DVWgjejDjqsRtpKUfd/HeOb361PPGQ0Ko
         xNf6S3IyHYqDK3+koKYqUWP4NLukP8rQi5HGiGhXRNzOjW7Ssn+an1Ri+zwFGHUZZHoP
         kQsrkFe6nblIrBdGB0Gc/NWSR4fARHt1Rp4NVDNZY6m/ASLip9eUwY9AiHiN1W5DdSkK
         SBuXL4W5iVeLtAAY32y4ACrjEdTec7GpssY+oaPiHCIA5CrlpKhRQvOxEJlqIBFjqOgT
         DixN/UKyGEzHQGrIBLk+EJ4pO++nLWe9zhPrT73o5oHicHqjBuGUxtISABplQ8kHJO0s
         8lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713842; x=1785318642;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d2S3NyHe7JKxNxgaSFpKvPq/rKGPVUbh4HkCUkp0pt4=;
        b=nliaQ6cUZdX6m8yACrvsZn9oZyT4CBKprzIMryF/5Fz8FWvpLf/6vs7JiLMSTnD5rK
         yv9RKGAzZbj9hj21J78QeEyo4qLx0Rn0cf6/2RXsQRou1E5t/h6aKm9ObOGDUFOrFsvV
         84Ug+zHJ6aN/mZ5RqdEj8RuGStWKUtm5igoxqshW63oQcHbZtS/BzrljKtqrbUlsmZwH
         uV6y+ZP3qMS40d7WkvSD+4O2T+AdekD3lFQ39yOq4iP1ClVo+z8b1hzDKHRJ6UixyYwA
         8h0/jj3FqqPXLxUU+HlhDf0Sg1WysSNLmplKrejeEBV6oIRpNqVCkwuLDItA5qJhoInZ
         nmyw==
X-Forwarded-Encrypted: i=1; AHgh+RqibK9FHjj1kcQzrDqptUKfC+v1MbRSuw3a31I7j5Yv9oDiehChrLlnX9rgfLH/C/TQloYrxSstug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxrkcfLBFnE+3iBLBw+xclCBQuiiDXuukWLGkqWskSREXmq/z
	l6z4uA/bdwEHRWyffIpKcx5QzAtevv4q8OVW9brkNdTSudmXnLp02aI98js9icxk2MztHPScLIO
	VjrrgJJwnXXFzb1lIqWgeEmjSWW9S/rRO/rwjJ7n1Qflhr861zJGTWVT3qLc87g==
X-Gm-Gg: AR+sD11q1F1BhjQM1BXIn/H+zoPmRe6FQS6IQ4Xyzk6+Hgy5+YlwsE19No97h4sA2BH
	uV3BvH82ktkLCpYOBNPOaG5iBVc6AJF6rHCN7dJl9Fg5vKduwF5re1TmTRAZeIbRbnebLtBofNO
	j0wTtezTA0yMkpCf4qc8sfNOVK/otdxUrkN9fI7eJN+S4UC/xHN7t43fppsPhtxpWFDw+Hmnma3
	sAGC31sVt7hOV+zyt5U4aeUFGnAoMobVXtEkF4b79wuS389GNQ8EC+3nINkRdN0wdmYUM0yaL4R
	xpOKu0vj3dYnjVwW2ypxAhKsZ57xZDDOuYYV8GtMSSEn+dr8uPz5NpeLpyD32qOS8vrRJfen47B
	jS7c2Vo5UH+Ua0VGgpbDEHP0dpllI2sxKSg==
X-Received: by 2002:a17:903:15cf:b0:2ca:be8:62d with SMTP id d9443c01a7336-2cf349b5923mr232470685ad.32.1784713841750;
        Wed, 22 Jul 2026 02:50:41 -0700 (PDT)
X-Received: by 2002:a17:903:15cf:b0:2ca:be8:62d with SMTP id d9443c01a7336-2cf349b5923mr232470145ad.32.1784713841271;
        Wed, 22 Jul 2026 02:50:41 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc8b0cdsm7758862eec.11.2026.07.22.02.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:50:40 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:20:28 +0530
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
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v23 02/13] power: reset: reboot-mode: Support up to 3
 magic values per mode
Message-ID: <38115586-9913-4d6e-9447-e82aee811dd1@quicinc.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-2-e7453c548c21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-2-e7453c548c21@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a609272 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2zDJ_gd8kjYVRJQFbS0A:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: HxvvG-Nzq9Arjaz0beyzh2RjcdZXziML
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5MiBTYWx0ZWRfX4Vbc2w3OyyQm
 WeOvSHVmCFh5N09cxFj5FcjPTATFrjB9zr6USnbf9MpomHRXZ3S5XKNdRxAxGFyXNGP5ylStO/t
 LrsGOVLOZVQ/gpfJZPe1pKv8qPwOaGJd/a5t6zk7mvZKPA2iq5ig5z21b5Ain1m4F5ohWJcTpF8
 6hRU0+nP0mRDT0Ew0c/IQlsrlNRhU9ocNnlTUTvxTwU2il/6dH9uCP+azuf1VetWj5t1hMBZvo2
 0hW0y/Ku74611GS9elhtqORomTDiLnYJoePd161Bw9fuDmNh7xt9iwaSvE36jrpvBsuhS5wewYW
 G7zM9LxGNqucaCcQGDMnfUpA4+wsQiHBV0+5oC7MS5JNJXi+MLqkygmgaYzUcZWYEwTVy1S6x24
 lEuF6JwRq9dS/nZCQsG4URhKs1NqmStmnNnhxu3isBoFNLN5eIfLkK5nglixehmXRL1Jf7uxBDH
 D/Q/hcwnkX1+3gXBj8Q==
X-Proofpoint-GUID: HxvvG-Nzq9Arjaz0beyzh2RjcdZXziML
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5MiBTYWx0ZWRfXwW1/xUmOCxjf
 fo/vqMn3PycBYoKuWd850z/qW1RclLjyObNgmHWzgfDITXQJ30S3htVtHMTzN+gFdKuuuPAo3wi
 iESy0bX6yf/ElDak4GFr+rM0xIlBv+c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220092

On Tue, Jul 14, 2026 at 10:46:30PM +0530, Shivendra Pratap wrote:
> ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
> cookie as arguments. This cannot be implemented via the reboot-mode
> framework, which supports a single 32-bit argument as magic value.
> 
> Extend the reboot-mode framework to support up to three 32-bit arguments
> as magic, per reboot-mode.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/nvmem-reboot-mode.c  | 10 ++++----
>  drivers/power/reset/qcom-pon.c           |  8 ++++---
>  drivers/power/reset/reboot-mode.c        | 41 +++++++++++++++++++++-----------
>  drivers/power/reset/syscon-reboot-mode.c |  8 ++++---
>  include/linux/reboot-mode.h              |  4 +++-
>  5 files changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
> index d260715fccf6..ac69b5f39fb4 100644
> --- a/drivers/power/reset/nvmem-reboot-mode.c
> +++ b/drivers/power/reset/nvmem-reboot-mode.c
> @@ -17,14 +17,16 @@ struct nvmem_reboot_mode {
>  	struct nvmem_cell *cell;
>  };
>  
> -static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
> -				    unsigned int magic)
> +static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u32 *magic, int count)
>  {
>  	struct nvmem_reboot_mode *nvmem_rbm;
>  	size_t buf_len;
>  	void *buf;
>  	int ret;
>  
> +	if (count != 1)
> +		return -EINVAL;
> +

The count can be different per mode. Because `struct mode_info` has
`count` member. This single `count` check across all modes may not be
useful.

Either drivers need to use count passed to them or drivers needs to
receive `struct mode_info` in the callabck.

Thanks,
Pavan
