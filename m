Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B523BE627
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801840; cv=none; b=tTRq3s0DXzAgRa0wWMVBvzwU6JOw4+MMuFClXLo9PMykiH+ck9zhtwuRK5Z1NG5DbnVq333f8smMjjBn9KNdtYkKdWXhv8+trhTjTjOqUS3g/7+bK0HHEvJz4dnI/Yff5v8hgrN6nCTZxw3jYQUNAh5Hm89+aaVV5hcSBO5xr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801840; c=relaxed/simple;
	bh=BNdsjpIcrl2SvMv2g05d3FRuaOWoOiHQZm5siBmAQPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQKqR5uWoJxzULw8gRTALddvBu+Cr0yVtvF+ICfnpJoayIIqSZyDAI1l89BwrTiJe7AgNwI70aqFpeA96fvBAK+mKJwOP293QhzwfTP9w2KNqQsD/2BYJ7vl4fFUEgai3FKz6XkjOyBYDrPjm3XhLfnFP5JEtyArFvuqA4gSc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SNLoHXUT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i8ooR6nV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SNLoHXUT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8ooR6nV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8KmGP1439241
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 10:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dNk1oee1aO8oZn2gGB7+4wyF
	LBZMDyUH14s2FZUuI/I=; b=SNLoHXUTbWKSGXvlPd8V7i5MH2+YdLK/EVxUhfFO
	kPgXexU17bpswyHymlFb2GIMVMKhkxrcGIgebMRmii692mZclyxeJX0SgQQ3q8D+
	4whq/8SBv4zjGsx0/dGPHMOcj3i/+g79tQ7lPmGiiVjHqSyR7O2bIK1cdoxMMAUA
	nrSvx3RvAQwxuDardNiRfSsgR8P0LXzOUubCAcFg8tkX7pE0onh88sMuMZeEple0
	vIuXYQy4c9mPFNoFJamPceKv7PxOcPAbwmpcSe3Llw/eKG0ZWXCpFaI7Sqggb7Vk
	e3xnDBg5ZWr5+YM3uvBFX1V4Vesw6Y7a3XUsf76qIew0TQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkhnjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 10:43:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f75c1219so28114705ad.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791801836; x=1792406636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNk1oee1aO8oZn2gGB7+4wyFLBZMDyUH14s2FZUuI/I=;
        b=i8ooR6nVS495+wuPSU5AnTLbDAlGSnXa1/p0unowW5EplHmpT6VjKPekW3kY+vybHA
         UsKb3QA+GHnTR+XwOlgwu19zF0iOYkvJGJvERgQrXpWuWx8+YS1mGBrZC/vDDa/Ur5ID
         7o7MGuYf2MUVU4R4QvvZw2Azv5Rveur5LSbHToznetDoaSLKKenUj8emFLO3X1EZI7le
         eV4jqIaWeUTI68rtB13Jj+11c+SidNlPqK8tzric1ajpnWeQz89W1CSsNKlpXxrK2BNC
         vGW+KEaWVwzTo+jGuaXl5Z4YmxB7CNpf4rFysL6szzJiZfq+9tRilOjA41vceYvNJW0T
         QR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791801836; x=1792406636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNk1oee1aO8oZn2gGB7+4wyFLBZMDyUH14s2FZUuI/I=;
        b=LKFRXxDQO91Cb0QA5k+rGmyiteOk/0VnupYSD8ky9rFpJAaY9npzgzDFVys6D6ga4B
         qtGJsand9KJJcnqbHuiCZdl6j/VNlhyYWaAOJLZBah75NzJqZmkv7/u2r18nl7aTq3J9
         A7fHFPYy965WbNeXkKDrKGoLl1uO4mMkaXrh+sLOtdvQ+4xT53ZW4zqdEOa8blsQC0XU
         vXKZW1+J0mAZvIniTTdyaxSz9fcQI5yS2JUiCsFLS46S5t4e96Zje7BcbEX7wmmIpjFH
         lRTxMLWcxKcXxM2Sz6YPMycg5Gt48K7VsLfAHVqrel+vUsZAmDvfxj5zj4Nzzhg+CUPQ
         9j7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwS02NK7OZwmCZgBll9eFLuK3MBzhEnUQj216P76lQQstPZQPFPLlCRUUx53xPFvgl4U5CF+sjgIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLJnnyH0JaccpdISVpk4phWKQsAlawZ/ANEmu/7+D3pJVVRjsFa
	GV2tlVmeOTgBELhbjGS/9smSCvhHfB4C2s3eEuUEQK/Y4eIvELxwe9UUhHDaOLS1bhdLherpMgt
	CZfTjNhxHYmiQNGCty9cRUBUdpf1uA3+IL9qQip0H9+m+HYpkZ3vWOJawUkFwDyxAZR6vDQ==
X-Gm-Gg: AYBFou0tN5N9bCpRykSFOzUIPoaCf4C6T07outNZo3QETgZUpslCSxZgJvnfxwjhld7
	lzsozrkZIz0vxNwoQ79XGtd/91XLnKvJv4h7KsCVHxwW9BQAiZNWIzbSUFoOGpDyX63dms2L3Zq
	bzovdyYNodMzFTaPitc0TheI4lnsGRWk2EZM3wXIxb7QxqXrsusmIs2a38KR3oCqUlOijaB5C+p
	X3fGnBJXTxlbYbeGdI97/39TgGNWHfhueFxxGDaJrd0EZFlwhncrEDGUTq3AfKxUji6j4gbr37s
	nnaOyTAo01MTgluKONQ6jjvj6FSUon8VLrBRyzWCOq+vrjS1Qc1cgXc/skbfurjkb6HLvalyJPb
	WRZBQVws5vASN+kL6BJQZ/h2q1+2Q
X-Received: by 2002:a17:903:1d1:b0:2e6:2868:e57d with SMTP id d9443c01a7336-2e842f319b1mr86209465ad.49.1791801836338;
        Mon, 12 Oct 2026 03:43:56 -0700 (PDT)
X-Received: by 2002:a17:903:1d1:b0:2e6:2868:e57d with SMTP id d9443c01a7336-2e842f319b1mr86209215ad.49.1791801835817;
        Mon, 12 Oct 2026 03:43:55 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8c6esm39841945ad.61.2026.10.12.03.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:43:55 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:13:50 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: sre@kernel.org, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: report the USB type from
 USB_ADAP_TYPE
Message-ID: <ifk6e5oefouaw52ms6rngezuvazbdoagak7sxpziwazifwvwdt@lonlpjntuq7y>
References: <20261007123932.1664-1-26rote@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007123932.1664-1-26rote@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX+hlEdJwJUk2E
 vlPX7ccRM9WXuntNPLU7nT5gt/4C3WlfCL8zQuTFK5vGsfW6J8aK00KKnSkeF3FjpTL1NrzUy3O
 b39bmaGy7RhASU3xQBXX6eOADcZdE6szVPxBJDdmftmAfXaBmUGUS7O83vwwoY8nMsk4Dda1rCN
 Z+YnUhUxTDM7Id/FeaI3A5V59YlsSnGMgWgAt/rTuV95bySLTPauGp951en4W8nZ9+T1jTXoRuO
 UE/hr3dCrnl6ShU3qYqK17xm0GH1QqkRCaTc1cOvnCoRwrd60DH4nt/2HLCqQH9h9Ij3ZMZ5kCh
 zkJB9S+4wbG08NvEIKFGEhEJbw2ZGacLQ1LUfG3TYfQlFOyjlbPAi1fIqMDqbhp2ZwJWisBZPSF
 yOpl4cpazBgxLtZprCnmk5v6GUdKtggbl8Ek+sqUND0nuaEWa9uqxRAuEBTUOar73nIO36g/TFl
 T7TiuCuHDQqhE0x82Xg==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6accb9ed cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=sRrwSrtRdHjplqK8FsoA:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX8XD0KGgCA2ET
 kr/H2+KYjWw+gvIWKJ0f8lwqpJwaqf++X6EwPpvLJw7d6/3TrY/D33oJPLbXAWLU4w5Y5P8MhfL
 GKgY1HJSY3MNCVVToNP8f2ndu2cOpT4=
X-Proofpoint-ORIG-GUID: LIs3R8YiY9-J_cV5Q-XiX7jsC_TgURRS
X-Proofpoint-GUID: LIs3R8YiY9-J_cV5Q-XiX7jsC_TgURRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120042

On Wed, Oct 07, 2026 at 09:39:32PM +0900, Joonhoe Kim wrote:
> On SM8350 and SM8550 class firmware the USB power supply reads its
> usb_type from the USB_TYPE property. On a Kaanapali (SM8850) tablet that
> property is 1 (SDP) whatever is plugged in, while USB_ADAP_TYPE reports
> the adapter, using the same numbering as POWER_SUPPLY_USB_TYPE_*:
> 
>   PC port                  USB_TYPE 1   USB_ADAP_TYPE 1 (SDP) USB-C dock, 5 V
>   PD       USB_TYPE 1   USB_ADAP_TYPE 6 (PD) 65 W PPS charger
>   USB_TYPE 1   USB_ADAP_TYPE 8 (PD_PPS)
> 
> Qualcomm's downstream qti_battery_charger driver also maps
> USB_ADAP_TYPE to POWER_SUPPLY_PROP_USB_TYPE.
> 
> Request USB_ADAP_TYPE for POWER_SUPPLY_PROP_USB_TYPE instead.
> 
> Tested on a Lenovo Legion Tab Y700 gen 5 (qcom,kaanapali-pmic-glink,
> which uses the SM8550 path). Only tested on this device; the SM8350
> variant shares the property map and was not tested.
> 
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>

Add fixes tag, with that i think it should be good to go.

Reviewed-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

> --- The downstream qti_battery_charger in SM8350, SM8450, SM8550, SM8650 and
> SM7635 vendor kernels uses the same property ids, maps USB_ADAP_TYPE to
> POWER_SUPPLY_PROP_USB_TYPE and reads it on every USB change, so the firmware
> of this family should implement it. Like downstream, values outside the enum
> (QC chargers, 0x80 and up there) are passed through.
> 
> Not tested with a plain DCP or a QC charger. Once, when the USB gadget
> did not connect to the PC after plugging, USB_ADAP_TYPE read 4 (ACA)
> until the cable was plugged again; when the gadget connects, the PC
> port reads 1 (SDP).
> 
> Kamal Wadhwa's multi-port series makes the same switch for X1E80100
> (a new x1e80100_usb_prop_map) [1]; this patch is for the shared SM8350/
> SM8550 map, which that series leaves on USB_TYPE.
> 
> [1] https://lore.kernel.org/all/20260806-b4-battmgr-multiport-usb-v2-1-1a6dd1e06cc2@oss.qualcomm.com/
> 
>  drivers/power/supply/qcom_battmgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 7716eb9e1aff..b24860d2ded2 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -975,7 +975,7 @@ static const u8 sm8350_usb_prop_map[] = {
>  	[POWER_SUPPLY_PROP_CURRENT_NOW] = USB_CURR_NOW,
>  	[POWER_SUPPLY_PROP_CURRENT_MAX] = USB_CURR_MAX,
>  	[POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT] = USB_INPUT_CURR_LIMIT,
> -	[POWER_SUPPLY_PROP_USB_TYPE] = USB_TYPE,
> +	[POWER_SUPPLY_PROP_USB_TYPE] = USB_ADAP_TYPE,
>  };
>  
>  static int qcom_battmgr_usb_sm8350_update(struct qcom_battmgr *battmgr,
> @@ -1513,7 +1513,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>  		case USB_INPUT_CURR_LIMIT:
>  			battmgr->usb.current_limit = le32_to_cpu(resp->intval.value);
>  			break;
> -		case USB_TYPE:
> +		case USB_ADAP_TYPE:
>  			battmgr->usb.usb_type = le32_to_cpu(resp->intval.value);
>  			break;
>  		default:
> -- 
> 2.43.0
> 
