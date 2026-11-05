Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868109;
	b=NPNsy85nx3CCgjGGQjYr38XA5ekERewQ7Lp1Pyb7ITwB/34QWL4KDYMHdw2/5+5KvBrJ
	 pEMUCLxbgQUCfkPHfI43ST4yQNbN7tGKeLIIxdWNN9Wy3SW7etpQb+IyfoHuKqINaRpU7
	 wDPC1YQyK0W82bPyN74TuoAbrgGGEOMP7JSAxQHbbgjh5K7BIvHKEtEmVNTWMO/dPWHrA
	 QkS4gfmvb91fuN4lFfQgJ/xUs1MwVu/8miahgakoPIEtV7raUTvDsqivkXxP56OnIdZqi
	 2lN4qA4vxhE7w2nI6T/W7UiOEUVPM6Q7VTsEHfjptHlxwufiJwjydGixd2n2kF5SHJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868109;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m3UKyFsZezrC0ZQ+2C1mCsyxnFD+fA2IDV8sxtO8Aik=;
	b=n0056ASjY8En5iAkwUW+Z+D00SRJQLpSQOizXKHBDXbSfMpNrTLsn9Ymm+IYExkr2EeI
	 bVSVpX6Tbsn6ZvkqpZDIzhfq0Ep/FpClyOik0kjPOWwSK0rbSkC8xVls0ULWtiI5eFpGd
	 zaUyJUfkHqTMfO/09dOQj/Z64kQLi2bA4kZrpD4GELdbuUEg2N6hl0RAqwnEqhLs0gI7E
	 0R/XK3uca1iHfPK+QB/2GQ2S7I8g06Tw55d30zUYW2cxRanpTxKtB/TzxPLNQ2dBuo1zM
	 NEGIcs6N7qDF7DYYjhTxJcmaGGgPXTNtSAy+aqyesdQAYO2GnSH9FDMYK6s46EzOOFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A5cEaOjk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="cbeBoS2/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A0606A32E
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 08:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 019A0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A5cEaOjk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cbeBoS2/
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56V2gt2588239
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 08:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3UKyFsZezrC0ZQ+2C1mCsyxnFD+fA2IDV8sxtO8Aik=; b=A5cEaOjkZG6jeKoW
	iUiHCSTWhVprmAbUmI3yFaJ6LX38TxM9gQ/VzWGCt1sQgNvTvwvWoN7KG0kpwp/m
	trV5+jGDk7X69utliI84CwAx6EJbSsNGZYjavXf+O5ssfGsr5+VslBzFYpaU2TVR
	9DRxhVukkzqwB9CM2+qoH43D3Bu0JBgp5kZhxjFB3sh6fmoSZmD50iOYgtmEGgDT
	aaHYPkog0C2GwpiKx/spI7TrQYX5Nqo70eT758t2DQva8jrcc6OXVac61AkIJq9E
	QmSgDc8Q5c/zrJUBrbrdUoYuyo8CQPS57cmVnCTwR1zFsfxQFdomVdjxjN78M4Jv
	BuiHmg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr89sujdq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 08:41:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad91787a1aso1429365a91.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793868107; x=1794472907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3UKyFsZezrC0ZQ+2C1mCsyxnFD+fA2IDV8sxtO8Aik=;
        b=cbeBoS2/yZ1g9JbmZFj98awnPr8UaNlHWXc9YXhamUt6ivka0u3MGmlInJjKZ10+eC
         42LRaBqX0x/41ih33KFeS0RGAvB6pXhfVUme4CaUTerKJNPkMCMej4BGTaWWlbEuSfW0
         lRXX+i6D8Gty7GiSGkHU7VRLrBUNLdyYWjHYqaIZmZrgPqdva33P0lumiuL1laNnIvj9
         E22jCuHF5dqv26T/PSWdSMi+xTxnlO3TRODicOMznl0KFmspGQsBLv1EmfRWoMYppYjr
         dwORHVwdlMRTRgT94RwyMPaCpjP4HPFgHD+Qr93d4ntGUwN+DgiYAb+j7PR6E4s09MA8
         Fv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868107; x=1794472907;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m3UKyFsZezrC0ZQ+2C1mCsyxnFD+fA2IDV8sxtO8Aik=;
        b=K/kTjzNr0P2gSyl1Ceh6uCg9wEXFGQ5BLtw1MHAnANXYKYq1ritcDjpeBwhui2fAMB
         5z/5FwxXLREJOitbXeV3saqn6zxs/oBd/qWuEnovunTjAE+U+8E5E27J6OESk37BisDH
         NTyrEpkXYWlsBYe3NEiZC+RgztBPJ96HaVpDbCzQEYBawdliU5AAwwT029EVPId6ysMD
         BxKyrvhLpSbuqPvtgS5vOH0e1PMMvJZKXCeIVQ6GX4F23I4qykLwUUPhHZNptm2jIFil
         E8kbMINBd7TEDCcBMx8coOHY+2ROlxYz/0uxanZ7xyB4bvhL+6uOMAPxZLFT5RlOpFWT
         H4cQ==
X-Gm-Message-State: APuU4Z9VIAnN8zYR3DbWe3NKcQE5BSme4kEmR+40E9cfGTI4sdJHXhgY
	dl1nA93BT/Sglcc8WRbBvzzIarzj0uGkYJBd/qUSsRb612aZowNBZqIkc6/RQuyJteheiXPZSl7
	Hc/ypy00779riQ2WCuyvDK/X2bzYdVJn5418b1HsCc056YybX6zop7Z69KDHvFg==
X-Gm-Gg: AYBFou0NA+M4As9DO7jn1vp1PI5e+Jts/+fIdKDgq8n5S00j+Gwg/nk5mzpeZ2F0fbM
	3Wcn4LDEEzlBPSHGZa0c5Elqqby+bsWtVJX5vq1UESjgP5GU7oaLikrzq5NiFjnoy5m7Bd3HFIi
	I9Am6g2x7luBuPqZg7kvR2oExqSwxYbACaeRCWDY7dFwjm+wut+QGyFjyxydSd8p3ATYC4ennC9
	JnG/ZdnthK3upBZz6MaQcBuemEZ1zzONArstuYZ4FiET8zYlbaxnLR0oGQFWDYSJ2lqsD+JjATD
	+PFbih/l48QD6VeWHibXvsHIlo5Tn14bEZJDPegifr63fExm0aaQLJ6IClojiC0cLhWjuqsbA7X
	8hI8FIkY/Dv+8d25bJ8BxrmmyyMvLYkcHHTJauFz4W40I+UgUBbFtO0iqWBCGdj6TK0DlIgv16m
	3Xa5Hyz4yM3lAq1vhozXhAj3MqThIsBWyM7RUW33pYWENl
X-Received: by 2002:a17:90b:1a85:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3ae89736172mr15307621a91.21.1793868107155;
        Thu, 05 Nov 2026 00:41:47 -0800 (PST)
X-Received: by 2002:a17:90b:1a85:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3ae89736172mr15307600a91.21.1793868106642;
        Thu, 05 Nov 2026 00:41:46 -0800 (PST)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b312e45dsm3486678a91.3.2026.11.05.00.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:41:46 -0800 (PST)
Message-ID: <2291138c-0e2b-4625-b982-8d72a43c23be@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:41:41 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Preserve global boost state on failed updates
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sumit.gupta@nvidia.com, zhanjie9@hisilicon.com, superm1@kernel.org,
        zhangpengjie2@huawei.com, zhongqiu.han@oss.qualcomm.com
References: <20261104161657.546370-1-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261104161657.546370-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Mqypl36Vpsofeybe-uISTpAgQSUFSLlI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfXwpuj66wVLoFd
 ZRWVbtAB/MxGk9gtMOqIQKQmcC5fH4Hl44M9z3pfITRXd/cYB/w6qP+2TgWovIBHCnEfl0sgHnl
 ZeliaE5stX7OiiqK7Aj2wNbpXwZCyPFROd3/SMKd87tdzWMPug6tg/4afyzOB7/fwFJ78P527l7
 JnFDmMDFDarXxwDQMOTxfhdYJ8esyHy1xO4PHdYbXRMZ4AVrAyMo+wFIA68FNO+oac44iUzZlUA
 BaBekE3KBNEgUZejknjUEfMvWSkw+Fvf0A4hPbQeKTKIq2j4dkbEaVhSZfgf11rWzkJc41AhGOe
 ZeEcKM5hnJVYJ8mzTA3Zx3e7M4Ssj90UvFNinKhA4k9PQVWvojUw2n/ObzAd0jojscRytUDV8t5
 XENOpahWpXe9lMhIjp2IM2Aq5al1YnyNV3V/fYcI+QkxpF2mTE1kdvSekIZ492XWkFF5QNiuJ7E
 iMgTM6IzwkzOeeUgaQw==
X-Authority-Analysis: v=2.4 cv=N628hG9B c=1 sm=1 tr=0 ts=6aec414c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=pplq8beJeo5HEFBEY2cA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Mqypl36Vpsofeybe-uISTpAgQSUFSLlI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX2KkbR/e0pltU
 i+RPu/ODcIVFIM0Y38vZZ81MeDn9ymYTFDSRzjNe6m2GE/OYVyaCjuNUrr/pi7gSZ+qPHsadT9L
 AZfbj3jr1tukh17e8edwteg8SB+P2Y8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050034

On 11/5/2026 12:16 AM, Christian Loehle wrote:
> cpufreq_boost_trigger_state() restores the opposite of the requested
> state when updating policy boost state fails. For example, a failed
> write of 0 when global boost is already disabled enables the global
> flag without enabling any policies.
> 
> Save the original global boost state using a mutex and restore it on
> failure.
> 
> Fixes: 121baab7b88e ("cpufreq: Force sync policy boost with global boost on sysfs update")
> Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")

It seems the only appropriate Fixes tag here is 121baab7b88e ("cpufreq:
Force sync policy boost with global boost on sysfs update"). Commit
6f19efc0a1ca ("cpufreq: Add boost frequency support in core") did not
have this issue, since it returned early when the state was unchanged:

     if (cpufreq_driver->boost_enabled == state)
         return 0;

so restoring "!state" on failure was equivalent to restoring the old
value. 121baab7b88e removed that check, which is what introduced the
bug.

Also, is the new mutex meant to address a separate race between
concurrent sysfs writers? If so, it would be good to mention that in the
commit message or using separate patch?

> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> On a platform without boost_supported the unfixed behaviour is:
> # cat /sys/devices/system/cpu/cpufreq/boost
> 0
> # echo 1 > /sys/devices/system/cpu/cpufreq/boost
> echo: write error: invalid argument
> # cat /sys/devices/system/cpu/cpufreq/boost
> 0
> # echo 0 > /sys/devices/system/cpu/cpufreq/boost
> echo: write error: invalid argument
> # cat /sys/devices/system/cpu/cpufreq/boost
> 1
> 
>   drivers/cpufreq/cpufreq.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..d95c849f79c5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2810,18 +2810,24 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>   }
>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>   
> +static DEFINE_MUTEX(cpufreq_boost_mutex);
> +
>   static int cpufreq_boost_trigger_state(int state)
>   {
>   	struct cpufreq_policy *policy;
>   	unsigned long flags;
> +	bool boost_enabled;
>   	int ret = -EOPNOTSUPP;
>   
> +	guard(mutex)(&cpufreq_boost_mutex);
> +
>   	/*
>   	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
>   	 * make sure all policies are in sync with global boost flag.
>   	 */
>   
>   	write_lock_irqsave(&cpufreq_driver_lock, flags);
> +	boost_enabled = cpufreq_driver->boost_enabled;
>   	cpufreq_driver->boost_enabled = state;
>   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   
> @@ -2841,7 +2847,7 @@ static int cpufreq_boost_trigger_state(int state)
>   		return 0;
>   
>   	write_lock_irqsave(&cpufreq_driver_lock, flags);
> -	cpufreq_driver->boost_enabled = !state;
> +	cpufreq_driver->boost_enabled = boost_enabled;
>   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>   
>   	pr_err("%s: Cannot %s BOOST\n",


-- 
Thx and BRs,
Zhongqiu Han
