Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2B36F91D
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069514; cv=none; b=LW4reqylYRsmPKLXO3vT2snUlDfTfwOe50YvSWYagolHWBr2dr5cU2l+msM+5UV/zhrrwEnehDO2hUsK6xzZb20fcvtpZz8f3XvLMb0ImypuWmrpgb3o7oScnpaC6+QGcaECzqr0x38k0NJMCs6FOpmMybf4m1UStLNNxoJIaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069514; c=relaxed/simple;
	bh=8jBKMNYB0eUETlc8evzGy3eZ9r0JV0X/gI3eEmEgJws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NoONCpkr52hs79HXamLDE5LDz/N0RmV0a0DkiEhTGi3f0ZEuidM7gTpM1jNZLZnkn0ROPmufWo9bgyLm8SIutrBZsUT2r0SCegdKy63Dgk7CfHVlXuw73L5SD3K2OGCpBvTseG7t0lRvHnlqJvP04JKxILt1zad4z+X2DrUuaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GeNbwbjO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ddO5uYPr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GeNbwbjO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ddO5uYPr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770GjbT3477083
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 02:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sME6dxu+lP6XRSMrnAXeehDIBxuMJDmF4YYzKVgdqY8=; b=GeNbwbjO1fbnzb5t
	aR2/MyUqbNyATdthNed42sBhG2Tjl5Ie8RzmWkY5rKqcw+7O2hoo7zJjiIpscMEF
	w7Eej5wjbVLP6QHh4MiYOPDX2RrIeyuz4dznxS4OWBtOYeOwi6DwZJkObJK2NE62
	8PogpSC2dRM+2SJp13jUINMPPHCWw7UtB+gz9ndEzy/PLF3VtiqjNagm291VA6gL
	VccoHR2TlXOxZBRsvJmGBEAxtB1kpstoZo9tfOBRXpsCibRi3hdx7J6GJzwEGijm
	nqiXoCABnCWoKYgVfDsjgBb3Pe3Nd5gLjmcZVXe/vV8OKZQYlZ+llynFxTgcs8gx
	cPmmCg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6h9udv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 02:25:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bec738909so28762561cf.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 19:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786069512; x=1786674312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sME6dxu+lP6XRSMrnAXeehDIBxuMJDmF4YYzKVgdqY8=;
        b=ddO5uYPrRFdO5FtyI1WdQyQyaFCLDz8jDSABl0HwzOEhymjoUGqi98cuVGLM37k+kB
         4RTapu9YHxHhtDoBpDKuyCFr1le3bXqTH8i5bYCPPCbKYnSwVRZyBNbeN7CHtjPNxZjv
         cHGEc3/hn23BM3Ey4yk4Nde5tYZ+GMP+m7UCd9VUNVxXLOQG2nH+RaEkeuJYChFUNnvO
         tluIi+TRcIqgd+VPkNPHuZnAKq8NT7Wj3t8K4NkQ5nAWcsP2UpR/nWIDcQdHkmOomBv9
         sms8hKIWe5cklexn14ZY8MI8LdyxIKiZKENATrleoSICz2KyNGT0ZxYoft8i7RavIOk1
         BoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786069512; x=1786674312;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sME6dxu+lP6XRSMrnAXeehDIBxuMJDmF4YYzKVgdqY8=;
        b=hUqNkUl3VS2D+YwUUXLe6gPPWEmLMQggqaeQLZmFJF5lGX/SkI0KxDJAfK6OH7Bxce
         wVaCkI7wm4UifRt60Ly4MQKeD0+i1xI9Wgm+yWyn5GzGMzMHBCuix+7lBLcRkTTI+2hr
         ViRgLkYIHBTlWj2oRJmes9dr+eXE4AwrewRdh3m61Wftk+NvlWj1pUI7waFY0aY/sjjA
         rp2HX0+30K39XUkmNglCj5y71MhYA/y2ap+3tqwGEbiIH4BYHV+shX/UBInZa+Q37xVf
         MwxcxnvGuYOXMzn1zBVvcEl1696Ve4hP2Adqtc3M5XcNSbIlmYOv6sj8hZ5IT2Byzj6+
         87/g==
X-Forwarded-Encrypted: i=1; AHgh+RqKokyzS8oRtBpBLRLldPzpelYbWAb5hnIlDbjLjg7dxTuss32b8tWYORs7fksRF4v01qSQVYCMww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EE2fzF+p1n5ebnnKxMTd3+gjnWMfo0+TJ/aNgBqlikteGFED
	whuqNr5cZ/FFuwwi8SNs+6hmK6pXZYiQyQC9A5NhaptSSgGlCvZP4fg3DoZTxaPwnK/oB3Nwbsq
	1qM1Ar/JPG3I6E4zD/YJ13TJGgqPfawIobFxxvFMMgwDRWGISVodwfZL+D27fvQ==
X-Gm-Gg: AR+sD13G1di2ArIOVbQd8kBGFxRBTNTIM9z5CM5xkxobfKf93J0eYz+uPFC8PkzxMH5
	mpEdvmuU5mXHnQpE8tLT5wCjv6Gcay3eGAWrGSJg2idBqnSB0b/bjGl6Ro9E2Njlm2zInp/wLfR
	78+1sgZZ+9Nbi6pd8MUSHI/EUVB5CZg2TA6PBnTK26wPJwUeNWylXm0U0G/Jg+dWegelPr7u5+k
	N7ho4c7XM1Z36ZXbu6c3iwvcwxa3WRU/4IY0I/Wemum7Zd05+gPLd+rlOLzGk1+1j+PyU5tu/nN
	GJlzMF9bY2pP59yfDj1rHNGZKahadIh+WTFq91pG5bd178xkN7FWf1dRd5GZjFNlpuSGNLk6YG6
	dIWMefnsgCoVjXBlsxWtMADs/d4lwJbRwHqMBrw5SefcUzg==
X-Received: by 2002:ac8:7f85:0:b0:51c:1967:5091 with SMTP id d75a77b69052e-52ce6200bcbmr210648541cf.41.1786069511706;
        Thu, 06 Aug 2026 19:25:11 -0700 (PDT)
X-Received: by 2002:ac8:7f85:0:b0:51c:1967:5091 with SMTP id d75a77b69052e-52ce6200bcbmr210648191cf.41.1786069511316;
        Thu, 06 Aug 2026 19:25:11 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm108881935e9.3.2026.08.06.19.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 19:25:10 -0700 (PDT)
Message-ID: <0f8f7fb1-1138-42fd-b949-19e32e61917a@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 04:25:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: spacemit: k1: add shutdown action and reorder
 registration order
To: Pei Xiao <xiaopei01@kylinos.cn>, shuwei.wu@mailbox.org,
        troy.mitchell@linux.spacemit.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
        dlan@kernel.org, daniel.lezcano@kernel.org
References: <1967d2bcc8fede6fbd25fc8eee07f2873fb41472.1784184867.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <1967d2bcc8fede6fbd25fc8eee07f2873fb41472.1784184867.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EQY5tppE9--bME1LzpQpx4gH645zTV3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDAxNCBTYWx0ZWRfX9ZrhPO8N+xoK
 kxhz1GrOsnN9EciRMpem+uTqiAKP34TpKZzk2mOhn6s2UsaTAjKNO0CiDIFOrjjuJMS6YAx81bu
 hIlQXe2Ocb+r9ynSNyzWZxGhzSs69vYTtfKeYYeqeLIYfHarg8e2HNxIIM1rXyo6WVIglUbZvZe
 eBhP8lwmsfDPLlp4zUi833qToTsaO9JbB4YtqeVa7NOQ2l+9DXdOfm4EbM6l8LRfpZUusN5wg7r
 duztTzW+70CGLKmsxNmCxhe8l5zzeAcKdPpgolgvAED5cczLX1Ey+IkrpD2WHitIvhrUiiCbvUl
 IKKAg9aJaX/dB41Idpi+Kd2XMpjq5R9iAfRPBPT9sGgktK0e9n5uMtty6/Inc88PIXk9WJ/Rhsw
 km5ESpqMLCWDNgQ3M/rDPYhXYP3xJ29kY2GeewP0uZf+HKiT4/u3xzeNsT7kUsq6j38qPtHF5b8
 +pH3z/kyIuHUd+j8+yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDAxNCBTYWx0ZWRfX50O+tlbX/RUe
 h3iGji9ELVpYI0TP3i06MQCI1msKei7mZF+c7sDmmmArQ1W4XoR/pXuQHFDwvDv+lI4NjgUm04s
 xUrcMbJb9Rn28YeLi6bnL54n8q/Ts9A=
X-Proofpoint-ORIG-GUID: EQY5tppE9--bME1LzpQpx4gH645zTV3k
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a754208 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=c8bhSAXnGUngXy6NwXgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070014

On 7/16/26 09:04, Pei Xiao wrote:
> Add a devm action to clean hardware interrupts, sampling, and control
> registers on driver unbind, mirroring what k1_tsensor_init() sets up.
> 
> Reorder the registration order within probe(): register the thermal
> zones first, then request the IRQ, and register the shutdown action
> last.  On removal, the hardware interrupt is disabled first, then the
> IRQ is released, and finally the thermal zones are released.  This
> avoids the IRQ thread accessing an already unregistered thermal zone
> during devres cleanup.
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---

Applied, thanks

