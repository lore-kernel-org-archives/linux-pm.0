Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400867;
	b=XS6fQRfaLgxuJ+nSaag9kmgkCqci9mATkjML0uCFwmBJAq1k/tS1yfDI+X5lD2GpjFjs
	 OdZVL9TtyucVEa9UTlYdW52x2uxHtzx2JLKhE0GvkH0Y2tu/Cqd1cXO9VZ8wcfaPosRN2
	 5u17S7TVylH/Hd97lUp1xCV+ugVHbqDnA9lEfuZdN0hRlRLVSNLTSY+cN19K0YI2efOFr
	 6+QI2sNjovYBFvz6emw1joeVESmFbiReGZOD8V8p/H7ET/1TBaZA3NmgFRYvPNugvAfq9
	 JShnTaLh99ekY6Lu3UtSbVsgZpXtewEHQqk5wwjLoCvAyM+11DacSQAw5bYbmFdC3dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400867;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oH38Jafz0ZaNJOgaWYZ1k8w8ZBYMYy4KFfN8ngQnhnQ=;
	b=KP5Zkj3W+zebfhwuyoFlu6KbUhHcvks5O9UBNhk+KuAhbVHd125vQI0vnhI8Hg+FEqQY
	 wqc6vyjrNEDDkrZMn8NFHTe8yBv5UkDUywsNEd+Fo42pb9EuVauCFo7XhJ3pR3gSITR3v
	 a2DB9b3XnAQRjSB9bRtLnYmXiKryPdMafdCvjV+zfav6wpcJn6I5xLQrgd39VY1DfXb0Y
	 whQtPc24QvWzDybIpb9kNHeaXq7CQPFJsiT3airRPkubcFiaatz+E0EIsoW+cMRrdGed4
	 Cmq43iCvqtnETPSg8c9a6L9y3u7o3Zv5ryg04zcWxtN7+0FmHjy3MJrVYmAGSotNNAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="J/eBWQFz";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKmfPkZL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7D606A324
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA7D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J/eBWQFz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKmfPkZL
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYwhh2356537
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oH38Jafz0ZaNJOgaWYZ1k8w8
	ZBYMYy4KFfN8ngQnhnQ=; b=J/eBWQFzvFkzMIXvLOyiH+n5pKlRYQFLvIr3gmXw
	6BoYv7eiT9pOnEQIWPLp9WUkHUzMI4+MDjSpL74YNhzWS91ICDyF0VAj8AYFtXWs
	KXbXbIhjlilam5m7aEjXiWyvND5I7Tq6OebfGSN+rR65GO8sMv7F0YqMSAm6+SVk
	FED2pl9fMU83eO3/GLB4seQjhNqMLXwIp5wuwa9PaF3tNxfFPJIkmLq+Vbt8Skdi
	sBT7Y0b/Aj9Tgp3Py8XJErGa/LHLHTwYztJAWeWE39/UbP5xp8vt5DdOOW8EISDQ
	0cxOAu8204JiPWGScUgrqFa7wxiScykBrgRxS4TR9zszew==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdhufw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:41:06 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a2b6fab7a6so871771c88.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794400865; x=1795005665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oH38Jafz0ZaNJOgaWYZ1k8w8ZBYMYy4KFfN8ngQnhnQ=;
        b=FKmfPkZLwklIt9JKxlrwqYafqu+HfUhLWePMuW9ZIsq0nSX2A8A1xR62J2m9ZRcLO5
         tuQBZB6AG1IV3XSWfd6bAsjSzkH487PdoUvoNnTxlj07MZ+2IT+fZwELeGFjaiemzyRu
         EY0R5vXjrf1+cwrFaIENGHbyLu8Vf+7y0O6M2pNSKgIVACp1mUhtTSzPMXSLEQNSPTkg
         hVzGF7hMcxhulcbm95u1Orc8nZ2E9IkG3iVTy8EdqKDJB30/gHUE8DlPodK74iqG8lBw
         hLR4VZ1+4bYbrBEYPBecRCP2rV84zWxh2I0Whza5U0b0d49dVzTD6Hu3jYcMAtwZ3UbH
         EHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400865; x=1795005665;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oH38Jafz0ZaNJOgaWYZ1k8w8ZBYMYy4KFfN8ngQnhnQ=;
        b=Rt/G0+/R2OxcLYCcx2tNLFmzwIdcD/60kVZOwdWX3cwnQLFULcKoPJykeTYS92Y96J
         /z8/VJiX/YnkPRt1xgPnNIsQv874IsIwK9rhIxMa3l+lXJ40e2gTCFlz+jHJoTp/+LJA
         NiwpusNqdKKu4uUUy8n0FjU/wua7eQcoBtLE1qKeBJbgwQn237ueKPgdtEyBOSAtXYAF
         ycVbN4z7XYzgZ7iVEa2AyxS+olM6jSZSYTe3YGY739qeD4Wu1z0ZLcjuBsoALly7Uvwl
         +IIWfyS9YnWMIxw59QVtcvuUIKvUVhR6jg0jWhp6FY5cokDF6YnEloH2F2JxaUP2Q60i
         AZTg==
X-Forwarded-Encrypted: i=1; AL+hErGk9jQg0KhmQzKWbEIdkxg720j+xNzjYQ0vm7P5zOnFGUlldW96m/e2y5a5ty2NxHc/Qk3MKKynEw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9csEWS4S77ngqTzNnkhrutd3K4iVzu5iTPqCnkXJ/0/orH5yOo
	vEUIsH71Nh6q3x/lEayWSOAykR8joGuBiq4S+zqTiyn5jwf847KaEg/c4gbkyRcMHA4j7uFwMC6
	s0oQwEYokLJ9n68101FR3VFJKToFt0Jhp0h6kX0JFT+rR6DG36DkY/b2eCUzDKFZ5vTbqlg==
X-Gm-Gg: AYBFou1jz1OcFbWjUt7FnY0uX/fqkHIcrcGvH+AwEMeeJcV01WJiylTRBBurbChuJjT
	uyH1oEpmiAi47uQBIBqi9rq29qn82YHbp8RfLmFSyp5vhixNSWcy2Yfl0kY5eugNt8bSWPmXxEz
	OI3epxbqSp+V1AAs433Y/7hiI1p3QIieN9jDTaFBJZYgZEbWASu/mHBaffusS/PVRtMTtjcT6F4
	ghE4JIZG0YlG7ZP5G3b+zNaADgFGE6zihQNOGB+6lQrWcDQQ2LfdHLk0WF/cUZ3/I4CbO8DSx3F
	DklbZKHpAhhcf06tV9OOzgC+/2OrxAYjweEbEC4tEsvm5dkrQXJbE8wt3Ey/4wlzXO4BCx1G6za
	OW5V463DN5gr7R5YkaKEveHJ2oFgYoCBwJh7ngsKTMdp2cLolsg5rlug952NUUxjv0bpiQKEPvL
	tHDNmm9KpygcJRRveHZ30ARLnTmhqu/WpOtGdTbGw+XVcglUblqkG3PI+xOUaVDS0w
X-Received: by 2002:a05:701b:42cd:10b0:1b2:de00:9bc2 with SMTP id a92af1059eb24-1b3bef25cb9mr3045474c88.12.1794400865260;
        Wed, 11 Nov 2026 04:41:05 -0800 (PST)
X-Received: by 2002:a05:701b:42cd:10b0:1b2:de00:9bc2 with SMTP id a92af1059eb24-1b3bef25cb9mr3045449c88.12.1794400864710;
        Wed, 11 Nov 2026 04:41:04 -0800 (PST)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b56c4e88sm14309487c88.0.2026.11.11.04.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:41:04 -0800 (PST)
Date: Wed, 11 Nov 2026 18:10:58 +0530
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oleg Keri <okerixx@gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to
 non-boost freq on boost disable
Message-ID: <avRiWsxCEAuBouBZ@hu-anancv-blr.qualcomm.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
 <auhMD2-5FD4BqImG@vireshk-B250M-D3H>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auhMD2-5FD4BqImG@vireshk-B250M-D3H>
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af46262 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=z0i6psv0inyxDjA-2G0A:9 a=CjuIK1q_8ugA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: vFU1m5jzHTM-1sv-ZYuJeaNG9Un5zyHV
X-Proofpoint-GUID: vFU1m5jzHTM-1sv-ZYuJeaNG9Un5zyHV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfX88cCexEuyp5t
 N23uWC3CPL+30IsKzfTx12ydrSZvgvcY0aUlDrL/5GdGo4F6SxNbnEj9AT2YVE/eX578kFIxDw8
 mzBaM2oFdUdtFYcSC+2qB0f4qEchuQW3uoSTKnQZrC5u/cpgt1GzQ7E0dIlFA6tzHt3U9rhm8wu
 JIlDB09mNwV/ouJpJyHL3dSJFYRKWxk2FL1mlzTY5+XxKENS/p05doOT7d7Y3gZKl4jD6wLVeiE
 zSaUUZLsFL21X7qjy8Bs6/AoV5Dv355XTEOLJw+7IEUulTQnYNOVU2AuArk6gw7wGt7dCtkPPsh
 PsA9q16JWt7uRB4WAvUt5Dbs12QPqmpAUeSb5RMUEQY0wDDjQJoLFi2NCsCt/H9ftzqnAjJ129P
 VgXf4BaJJWsFJ24V5CIl/SrsDLsoFd2VdWBOYQaKoaeGzenunAJjBWfLYGH/ueyK3PGBd7Hd75b
 lBYFOXCYoKGTYJAi+Hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfX53HUZxil1tJX
 hxPw1LT2mRfdUhUjzcQqU/qkgcu83NR2s9iGI5/P5KSoj85zgGuKIqIsO0+1KfK+uwfh+9hrRuI
 8CaWw+Yc+j/agDkxiYLyTYyBen+Km/o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110050

Hi Viresh,

On Mon, Nov 02, 2026 at 02:08:39PM +0530, Viresh Kumar wrote:
> Hi,
> 
> On 29-09-26, 17:08, Ananthu C V wrote:
> > Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if
> > max boost is known") introduced a guard for cpuinfo max updates to only
> > increase, to preserve driver-set values above the freq table maximum.
> > Later commit db80ad776cd2 ("cpufreq: Remove driver default policy->min/max
> > init") dropped the 'policy->max = max_freq' assignment from
> > cpufreq_frequency_table_cpuinfo, leaving that one-way-guard to be the only
> > path for cpuinfo max and consequently policy max to be updated, causing
> > both values to be stuck at boost frequency even when boost is disabled.
> > 
> > Unconditionally track the highest non-boost frequency (max_base_freq)
> > in the freq table. If boost frequencies are available, use the highest
> > frequency from the table/max_base_freq instead of cpuinfo->max_freq to
> > control boost values, so the value can decrease again when boost is
> > disabled.
> 
> If this is a fix, it should be submitted separately so we can get this merged
> independently.

After thinking more about this, this should be the way to go about it. This
issue is currently harmless because boost values cannot be actually utilized
and hence the value getting stuck in boost is a no-op. But once the fix to
the initial problem is applied, this will become an actual problem that causes
the active frequency to be stuck at boost. So I guess this will need an
independent fix that comes first in the series.

> > Fixes: db80ad776cd2 ("cpufreq: Remove driver default policy->min/max init")
> 
> I am not able to understand the current problem though. I see from the sequence
> of events mentioned in your cover-letter that scaling_max_freq doesn't return
> back, but why ?

cpuinfo.max_freq value is currently updated with a conditional guard, which is:

if (policy->cpuinfo.max_freq < max_freq)

This means the value only goes up, and never comes down.

> And does a simple revert of the above commit (just freq_table.c) fixes it ?

I gave this a try, and the simple answer is yes. The diff would be:

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index ea994647abc8..5b364d8da4f9 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -49,15 +49,16 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
                        max_freq = freq;
        }

-       policy->cpuinfo.min_freq = min_freq;
+       policy->min = policy->cpuinfo.min_freq = min_freq;
+       policy->max = max_freq;
        /*
         * If the driver has set its own cpuinfo.max_freq above max_freq, leave
         * it as is.
         */
        if (policy->cpuinfo.max_freq < max_freq)
-               policy->cpuinfo.max_freq = max_freq;
+               policy->max = policy->cpuinfo.max_freq = max_freq;

-       if (min_freq == ~0)
+       if (policy->min == ~0)
                return -EINVAL;
        else
                return 0;

I am pretty sure we can maintain the policy->min status quo and only touch the
policy->max updation; which from a passing glance simply seems inconsequential.
Potential side effects, if any, aside, this would at least fix the issue at
hand, which is the frequency getting stuck on a higher value without being able
to come down. What do you think about this?

Best,
Ananthu
