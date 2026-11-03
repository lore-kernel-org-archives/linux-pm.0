Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703817;
	b=4p177roV9nQTXJUeizQBxjQgstOMzSfXuYw3t4T0U+9KPjGzS6iNbL6POAgZxLX0H287
	 KU8LwwUP8sTSc2b5q4wf6Ei9k417gAuyA6XyStZ41lekVV8yWhttOp1IZOxjzjvUUH05B
	 Uivt5PE4Jek0M4/7b1/aV3yn/nNN9HijrDNYW09jye1TEFffRU7fnqKIKzdmdpgKTOgB+
	 TuWksbg27HUVViTSZSYAKCpPfmc3ptnoW6BjV1E6lg+p3DOTuOm/kXrdWaOxVDVEYQdY2
	 oeaI0jWqWxEbBS6gUgezQWs+A3BA6Kdf0uXrqlyloMGalLlC0JndPP+Ugid1doHWZuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703817;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/n6gV8AtpPSEkhX1MtVWQEBb23l1sFXc5N1c+sSjlD8=;
	b=pUW3UWfJLszihj8jFzHXo/QvFlm05cxWN+Q7QMrwZ9Ds1MbnyUIF5fsi/4g93vNWzNWN
	 Sj+FyFfiKX6xQ2oj83shXETqkx/xe1JJ4E7xQbS65al82TKWQNUIKayHZ9mScsCb3+0iD
	 3j/2hUbYffabpcJTiDXtRgR6vQpaFjKVKTDy1EcAAgb3CrpxIjYjFVie217/ebCLNpysH
	 u8ukdR4SvqiysesOR3dTyd+QQN5mMip7Dj+y3lo3D+q3OCeW1Ai+/YNIkPYwEleWjIwVS
	 /XwPY0CqyPIjZkg77jjb4XtpaE3bO8L+qpvbOw2Ea1SENKvHkjzvccwJF3RraF/4aBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqZNru7p;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="B771Dbn/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C8606B13F
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 11:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D9C8606B13F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqZNru7p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B771Dbn/
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AACc03161603
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 11:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/n6gV8AtpPSEkhX1MtVWQEBb23l1sFXc5N1c+sSjlD8=; b=PqZNru7pEkfHhYmW
	2svlI2nhvGeicSKRH0dLXDFheB7TUm+R7ppefKaCWHiPbn0hSWDTcW+AX14E3rTY
	cUG1Px+6MqvIyhHtf6Zwnh7zAB/JR3TKnvlk7Hi4uxeqtYu3ruxBds4Poh5HIztt
	ZcbuxZcOFo+wbKaALYGzWEnU94DlWqDlE6Fij5Q9IDFniILZEA/mQTYwj280tKAt
	Vkl50wf93+axqGZ1Py2Kmmoz6je+4LpZRh3j9KxXBqADDbv1tAUarzrI/hOUP+uK
	adRi379DMiUt9wfrOVC7x+oxgu9XMBr89BNkPLi9PbVqy2/NLSlVx9W4OBp8BUuT
	aVyd+g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m99w8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 11:03:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aed1b64104so1770981a91.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 03:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793703814; x=1794308614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/n6gV8AtpPSEkhX1MtVWQEBb23l1sFXc5N1c+sSjlD8=;
        b=B771Dbn/F8hQOVRM/K3LdPz5lvd6FZk2Iyx3LcFMFRFazXJ9FH0W/oK+krzqQ8PyQK
         gwvenWdzj+aMLX3eQ9aMHZdOYtc5++P4AOA8qMWsy5T26WLspzQTM7fWJHrvwOeDniRQ
         A8zfMIBAofGZ2jHCiWM9E1vwXBB2uXWLATVltcYWn0Z+fIxTOzQbNFtVOKfKAtHjEK5v
         tz6ZehwTg0Uy/Hpi29D141JdDT6QlsYn7IGTQIcTQ+Db0MevQ7UlZfMAOK4wFKz/irdf
         dCklMbsLoyc6eWYQZL3Mg52WesBTl3tk89Zv0tNca6j0rb4knpM9SePw/svVdfhA08ZN
         Wauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703814; x=1794308614;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/n6gV8AtpPSEkhX1MtVWQEBb23l1sFXc5N1c+sSjlD8=;
        b=OTgQ9AGTg4vXzaHJUOWKFu3F5cOYEv1ixPbYClZ8AV/Af91vAQscnL/h5jDpquA2MV
         59zEXDGFFYjS/T1zIdWqUM1fwS9WmP4Fh3qU6DfnUoeAxJ6DlNhzQSob19xmXRbEwkOf
         mBtdqB8Sop1KB1fiLDI6OAAxm2DNv+HmPTkYjQ0uDSz7HFDx332K157JU07S2dK0AT7i
         MTplV1h8PoHCrUzGwOtAyEzhrleZsMmXIIKpK8IHU9gXCHDUMPVoORNgMs7lQ8zRoO6b
         8MQBOVGrKEec00K1iGYqqYpJb9ZWTQiqWxO4AYHuwHxz5AIaZEm3M38BWn3IbzBqo5RZ
         snpw==
X-Forwarded-Encrypted: i=1; AKwUvBxz0WziunI2be5jY2zZNAYEiQ8JhfJ+Wu2pjpfZIMCO+WkF9QHGMQWwcxXvssNd7qIzC8+R+NOS5Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9KL/9Mm1dg2+gMcf/QHF3TOVNwWjXq+kq6fcByxVJ9jpG5BXp0
	esqN84gvkKSCNZBDVTFl0vGBBgAfuEcP3N7/U9/dOehTWRyaVJyOu2JGQWoUh6mXlj6QsuwZdPn
	b9Ifb+DWug9jV/YyiB3tengoKY39AMD/u4zV4qzH955Oc8gxVaVCCw1hq9m2BHQ==
X-Gm-Gg: AYBFou08d3XMeaqpdgtrnKfJhsYSA3sx7qL54xmGAPZehJsJe+nZWnAJPvahjFxTAmM
	AUC4Sby0hu+UhQopCHahXGsN89ZALjZ9rJiyTa4eqCipPfO87QedPk3YAw48upcSQ8iFy+EPlEK
	xfzd/U6L/1XfEdF82Xh5STO1MBT8nnUA/np3+2iDdBtgsPcKxud2c889zzHKg5WKeU4uR0R/3NA
	6bdUsDGKSX85Z3C5/lJQVhfu1Hxv9dLShkuGV05i9T4Ss1z7NSv//YyBeqFmrG9abXfIqLgqBcG
	mMtvKy8d9+OdLLJtj4ebOkStOdAsP4Bz7PVN1LXuLbJECx8Ughk8Sm3PmRLeL0foFL++cZqx5Sj
	wK22BogiXKkM+11/3BXGVuS/FJXjpcRA+T4NnWihIRwqpHFuwEUlN4RgjO8MU0yKMgkXndHblSD
	b7Zzv8BsGREJUTXwiQomn1s8XI8jCQl9Lr2nRRUbWeKQ==
X-Received: by 2002:a17:90b:448c:b0:3ac:a7ee:6766 with SMTP id 98e67ed59e1d1-3ae8980ed36mr10463308a91.36.1793703814285;
        Tue, 03 Nov 2026 03:03:34 -0800 (PST)
X-Received: by 2002:a17:90b:448c:b0:3ac:a7ee:6766 with SMTP id 98e67ed59e1d1-3ae8980ed36mr10463289a91.36.1793703813766;
        Tue, 03 Nov 2026 03:03:33 -0800 (PST)
Received: from [10.133.33.72] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b08759344dsm1781409a91.13.2026.11.03.03.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:03:33 -0800 (PST)
Message-ID: <78af4d6d-7465-4980-9d8b-e832db76a08e@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 19:03:29 +0800
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
Subject: Re: [PATCH] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is
 disabled
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, thnkslprpt@gmail.com
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com,
        zhongqiu.han@oss.qualcomm.com
References: <20261103061557.1235129-1-thnkslprpt@gmail.com>
 <20261103071729.1556217-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261103071729.1556217-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rPFP-0WonTGGZqFDHe8nK5g3RsD8TVIn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0MyBTYWx0ZWRfX5u571DFHNwpE
 WOWCW4WXTtrrv4IEcM9bBAqONKB874L+7miq7R4xayp/DmqPWwu6+TB5rPt/oAeiZAPxw7XzKch
 daxRigs1vYZX/tGfC680pzKnHTJHpQs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0MyBTYWx0ZWRfX3qPRqm1Y8/sZ
 nrSlUbAay7fUe32iRfeW9BxPPME0qYD3+VBYdgABDXHuBhi32hfBhdSOkwWtNnneU8FsVjhQmzu
 EVN+xTm3qXqBwoNwgFM9D6SIM1E7zeU5SJ4dzdmMROnoNPyYuT9m4yHqSxpn8JngEZWdRzqJtJn
 yUmBa7E7/76LbEObNtxmH6IAvbZsoa+/kQEouDOHyNw6YiOzHliV29Q+bfr6w5MxMd9mEsBsZrr
 0l3rsff1OXXUIm9LF6uMy3A56r6rUxfBxKvNQ1Vk67L/5cbplth6HJavvsyVDJh4BHN+mM0OGYz
 JCdWHAmw/F8xndBqSBlGg6AVLIpiGeMWirNipd5cumFmVe8TQ9/OWA5Gb14oJoqIa8E6HH0Xrt1
 Nm2ykpwiBsLC7GkHKFVl2mZWxa/Lb/dOpT2eBR66MkOhMbLbjOL2HafIq5bOqz5r5N5a866GZ5o
 lLfskPW99mFFQG3CPYg==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9bf87 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=N_xNfM-kO2YFn_PJ3jEA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: rPFP-0WonTGGZqFDHe8nK5g3RsD8TVIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030043

On 11/3/2026 3:17 PM, Zhan Xusheng wrote:
> Hi Avi,
> 
> On Tue, Nov 03, 2026 at 08:15:57AM +0200, Avi Weiss wrote:
>> +	if (!tick_nohz_enabled)
>> +		return false;
> 
> idle_calls also never moves when nohz is enabled but was never
> activated, because tick_check_oneshot_change() found no oneshot clock
> event device or no clocksource valid for high resolution. TS_FLAG_NOHZ
> then stays clear, as with nohz=off. tick_nohz_is_active() covers both:
> 
> 	if (!tick_nohz_is_active())
> 		return false;

Agree with Xusheng, tick_nohz_is_active() is one more reasonable check,
it also covers NOHZ never getting activated. Besides please Cc: stable,
and Cc the scheduler maintainers (scripts/get_maintainer.pl).

Note that this still leaves the nohz_full timekeeping CPU and idle=poll,
where NOHZ is active but idle_calls never moves either. That's a deeper
issue with using a tick-stop counter as an "idle recently" signal and
it may be addressed separately.

> 
> Thanks,
> Zhan Xusheng
> 


-- 
Thx and BRs,
Zhongqiu Han
