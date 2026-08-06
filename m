Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041D389116
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018337; cv=none; b=FtfJOd0alClcuI/kVuOD7FoziZ4V8OKmzHGuXkcjlmajANnS1o0ABQ+OdpPZGH35U/FbCG/v3bajVEyGOPlohh7ZrkfUXZCLvwN49+tlprOWJW3EyOOK7D5g0HyS9vEGDvQ1dG82/a+wD4WRrc4KPYs632Bv0i5meovnSNrEnyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018337; c=relaxed/simple;
	bh=ZE6F4PkEnCZ4IqEJoL6825gTi4Sl2vvc1E5WdL+K74o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMybeLrpYWBI0j4ZMV4JeaXISvooTTHyuzyuLtvKsTPY3BpIFLpCYCCX835unyWXoaEb6MCwbA2JHWRGs3oaUMB3zeroKInwtAAvGmqmdL5USqqdvz3ih92oQukyid3nOchNq5eRc08bEKn68vfQFt5Qfa10i23E0gfhkmJAMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fHjfA3yB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FuoT8/hW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fHjfA3yB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FuoT8/hW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ncD11308825
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 12:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Yjw0+jatjn4wNbHf3k03xjWG
	BiN8UqnOOPCUOE3QcCI=; b=fHjfA3yBHitRhquvaR9LkaiJapnLZLC+DNcFFjeB
	J1qDuzfwYWuxgin6CZR/D2rZqwxBkkVYscywm42LaAkkLb7eboWUpUOxLrpuZM9e
	+1xPzTl7OEJH2DBGeXM8neWe5aPA6lmjl0eY2x09qNQUxMt+Qd2iEemgm6rKAPVP
	WXfIEuaSdzP152pbz4kI4+a5HDpw6cG/UrG1/aJyzSIC4iufcMZTL+3+B5Q4ZrrZ
	VBooSgoWNDZKqg8eIiAApxx4mXcJlqapI42cWLDrPsHPcqkzcxOyuR37UVoyPop1
	K+YsZSwnJiiehLRE7qXOBJTFq/BZnnSj2sehSP01/IFv6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvp7295j8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 12:12:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d30035dso16180631cf.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 05:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786018334; x=1786623134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yjw0+jatjn4wNbHf3k03xjWGBiN8UqnOOPCUOE3QcCI=;
        b=FuoT8/hW7AVVQCne8gjnwMuiznU8WQcJFfGqVuLSE5sbYN/m1AED6G+GD4zWugVoMP
         WG50TxLMBDSSxDaIGGJeo4BCg+bzz3rZAWiBj8S6wcRixnlRPVQMt1fxwDuf+qrNW36q
         6OR/6xGfYa483DiK8rBtcydleIpLYGu/gSUWarnBEFRMhTyFQt7KVVhuSf8Xkc/EVz7e
         /JP31QKz6BBr5i0oVumMEF09iXu2Sox2IeZAo9o0JbnCNVrl0BHB3TgolGx81sYZH7O9
         052Tfej1W4jQegEH87GtYWypWX34AgykfaEK5MWIumjRH8EsV1MnCzN2OTekEK4FqG9q
         so/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018334; x=1786623134;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yjw0+jatjn4wNbHf3k03xjWGBiN8UqnOOPCUOE3QcCI=;
        b=aZUFPp58l5DX0GTncy8g7z0CEsr/PcuCCFVMEP4j+aZv2JnGg+kGqlzMRTXy0kUyuo
         1+VoH6KVQetLhf8v30lLFysN+mluBIdKpIAIczfdFe/gPA85C1eCWC3wdlLo8bptzACs
         OX2ERI1d9aFQlvD8GqjGeWMXMIhz+beTs5Wm80KOD0OwPQ5s6ssXCHXqWFVAsdFWczpg
         MYnzXnlHFdMMdki+05hRHKcX+lnYp9iYR8dxZcily0dwMu2UIJzsem8z/WIA33mB60u7
         GwBCU8G2uqrq5pwf5E0KuX0hDm/y8t9kRSUz//o7UkqRFK4XAlChTT5f+3Q9ZCF9ykBG
         reFA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3koy90mvbIHdqzqiv0lupux0+aJggrCELLnKQJTLbxqsScpRNp+tygF+OW/iIpxDg1krBNgtsBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrITNM5oPMCk4BIykwJKMQG58ItRGzEP8zOWjfVjIkXXycKWZN
	olrHeRAHXB/tW8yE8m4sa1UgSy/ZSQIyfbGYNOgiUCMl+w2/wZymr5lISeOk6vk98miQHZh3sjy
	0aKuGk9o/6G07jrFqduAW6yaDk2gW0pA32bGfjMtm2PGaPB2iCfc2MDjggwiddA==
X-Gm-Gg: AR+sD10P33dKxqyWufNyrVrqFGVVVRaA63UA63AEMuEskREVHNd1T01k4Ni+u2i33Ap
	QDbwndmZvKeasEYp+Mb/kegn5WiiVvZSPZ7rqNH7xWbClsu2swhAKiB9fjgw1CnT/OLhmBWodrg
	NtTFRkxHImYEBW0sYZkcg7y1JliXaF5mO4RN9PQcEcdlkwsQxqOQmgamg0eldNTZnb9q/SWjjFg
	zBpDmwimaXaOSoxXq0HBVGGdr1WrEt03JXjycQrFk2nzdWpiP2RgKHQ7GmjdsUrqyao5zd1mI87
	tv+W4HRaU5WLmhqxJOMg+juSA/AVWuvu6tlk/ONIqL+Z0bDt3L8eVYfQ1/uNC0jDsMGRozDkRqY
	0S7VA2tldXWB1Tj8wz9byermZw1sZG7zM9SxpUO3+SOl8Agkqdaa09DzqHT8grVa7Ua8vLQllg2
	6JhM9Xiutgz1mKGw==
X-Received: by 2002:a05:622a:4812:b0:51b:fd82:22e0 with SMTP id d75a77b69052e-52ce5f8f760mr155276001cf.3.1786018334072;
        Thu, 06 Aug 2026 05:12:14 -0700 (PDT)
X-Received: by 2002:a05:622a:4812:b0:51b:fd82:22e0 with SMTP id d75a77b69052e-52ce5f8f760mr155275131cf.3.1786018333605;
        Thu, 06 Aug 2026 05:12:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2f6235e73sm673497e87.13.2026.08.06.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:12:12 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:12:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, linux-arm-msm@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: allow cpuinfo max to decrease when boost is
 disabled
Message-ID: <zg7bzwbv2svt7llwooeyhojqyjkmqjvjvxd37hjgeggnii4oa4@jaai4hnlpmlc>
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com>
 <20260806044230.909961-2-sibi.sankar@oss.qualcomm.com>
 <35it74zycctxhpnbsuvp6a6aazrjavarhq43fqgruafjv7xkt2@recuceutrqrn>
 <42d9370b-aa10-4382-b6a2-bc441fd2335a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d9370b-aa10-4382-b6a2-bc441fd2335a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: pxrHqiSUj5m51s5qDkk_qc-oFm6X1bOj
X-Authority-Analysis: v=2.4 cv=JYCMa0KV c=1 sm=1 tr=0 ts=6a747a1e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=HTVtXkSika-rxv7pNbYA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5NiBTYWx0ZWRfXz0/Qjo1XSvJl
 ebOuUjzpQHLPkqC61Younnjqo0ON8bYFOmAU1GdSD/N1BXUEdZ/JN0yiCGBAfqVu5SxMjldSM+a
 2mAoMKT9FurdMqHrO/7mIOLKOlnqnWPhzIgZ9rMMtlgXgABzxhY6WchHPoklRGqO6W3OBfTo2wp
 zOU4eSl1H8aFoAhRx5ED+o+SEr/DddKFI2PspuAk2GXxJw/iu/oU/aVh15bu0bxIRvqRsYwnMYb
 mqoI/anDhXmqPuaDgVv6jiPsCOxMW0d15yr4kKoJhgolY1wwkt6WTkcRqBLNHp9chZQS+7avwj1
 S3Joy093yKAdTznJsYilVUltM2UT8bSO6xM7ufcvhYcgHk4167aFVdmyieTEut6MWAWM/6qJ0ow
 owk8n0EvXq6Ys38BgoDBi+DsECOcM7EWn34WjkAiNGv0SKkuvrtcCyTQth45l6FiJNvcymsPD/i
 iKEu5kHy+s4j0by7XAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5NiBTYWx0ZWRfX4Ofc+8mILsEk
 4rt39/vUTjvTGr6uhoOKppJ9cVXnnhvTj4V2uCrTbawTen+MKwka+KCVgWrz4Ccg+P1fB9nZHV+
 ICsiaCp3STY79MtKOh4aMbo1Zld0O14=
X-Proofpoint-GUID: pxrHqiSUj5m51s5qDkk_qc-oFm6X1bOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060096

On Thu, Aug 06, 2026 at 03:41:45PM +0530, Sibi Sankar wrote:
> 
> On 8/6/2026 2:58 PM, Dmitry Baryshkov wrote:
> > On Thu, Aug 06, 2026 at 10:12:29AM +0530, Sibi Sankar wrote:
> > > From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > > 
> > > Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
> > > if max boost is known") guarded cpuinfo max updates to only allow
> > > increases, preserving values set directly by drivers above the freq
> > > table maximum. This prevents cpuinfo max from decreasing on boost
> > > disable, leaving policy max pinned at the boost ceiling.
> > Why is this bad?
> 
> Copy pasting logs shared from the cover letter:
> 
> # cd /sys/devices/system/cpu/cpufreq/
> # ls
> boost  policy0  policy12  policy6
> # cat boost
> 0
> # cat policy6/scaling_max_freq
> 4454400
> # echo 1 > boost
> # cat policy6/scaling_max_freq
> 4723200
> # echo 0 > boost
> # cat policy6/scaling_max_freq
> 4723200

How is this different from the maximum frequency being unavailable, for
example, because of the thermal pressure?

> 
> Currently disabling boost after enabling it is a NOP,
> scaling_max freq in this case would be pinned to turbo.
> It will be reachable through various govenors. Also policy
> specific boost flag is meaningless unless we have means to
> reduce the scaling_max_freq.
> 
> > 
> > > Remove the guard so cpuinfo max is always derived from the frequency
> > > table scan. Drivers that correctly flag boost entries are unaffected
> > > since the scan already excludes them when boost is off.
> > > 
> > > Fixes: 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known")
> > > Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > > Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> > > ---
> > >   drivers/cpufreq/freq_table.c | 7 +------
> > >   1 file changed, 1 insertion(+), 6 deletions(-)
> > > 

-- 
With best wishes
Dmitry
