Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400049;
	b=exBvVEo7ZwNQ2iZk4nfORcLztzzoquq80ekqZGN2f8BhMkEgMyXRqngy8NvpRjCV34ax
	 eI9vGjeOLeeohrfQ1l9dWdCldGIFwF2siFtu7S9vNzH/lIJwPZ/oETfDH1nRvqQYHfAde
	 DLbdjUygIu6EanE0T4DpASUuh6ffASw/gZAgTtS8qU9k5aL8Ldf2mtvhIrh2+oKg0myPE
	 8pIOw4RGut0dgE1Kmv9hLo0dATTTeY1Iau87f6ZzsnWalz+WCCrnQxkWOpTypKB5pXdKR
	 k9EpBf3cxV8tB3VDQGGRU8vCPUONJcBqTs2tcs0VgS2Q4GwUBkhmq0ydn6W4QUnfbuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400049;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=svc0vgDYFwBl6hVKJjHTfBuPN1VEmv+TcUmZfTB8SLw=;
	b=UckIFo8e+BpbB9GcvBxDp+Uh0DX2qY7PHO2hxkIQ29ARpbGzKVPKG279KkAzOUsV2TEU
	 U79rQ6M4zykBQ2WbunnUSdJvh72okMELnvNvJvqPbpeYPTn+lnh09YhTTbXX8cMPHl9Fc
	 sk/4Xi3MgqechPob77aKsX0vBtgFY7ALIW/jgvW8nsiacdAb7kZ3Lpgvn14Rmpbiz5PUZ
	 7x4KTY0G0jg8tHm8gB/agtpsLP8yi4FCXcUIvK3v8/Wlg8/8MzsuMi9xNXsWT6Jgz4qTo
	 TH9Ihl7GxfBykoKzxb1S3hDJFXiVbSS+htTwKQbySguoTcsZTmOPnDAUYQPlysHQ/Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oLJJPizK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JRMEQPkP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15913606A31C
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15913606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oLJJPizK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JRMEQPkP
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCQ4XR2317541
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=svc0vgDYFwBl6hVKJjHTfBuP
	N1VEmv+TcUmZfTB8SLw=; b=oLJJPizKWuoveTH+O48KXBTXUn6nPwdC+PcZb6af
	2MIm/MSSCiV2Z7cQVVFtunwvcEdr6K/hzA20MNrH2YIWYrIWOpLfNOW1faslZqtY
	sPg1xVZG+xjHPpoyJfG3/XkoPaKP2vhMXLY1VJyYB2aOlpKqCN/oC3c9+6J24r7K
	c4QTWMLg9jEHmRw14dAxUj0iawoTcFsrkHcd5FBApgLe8BeKs/mHzKfDpuWNJ299
	+cfCvBgXLMArH0BywroWC00xK7ybV4NkZZZ8ZrFOX0OSF+w5tSJv9wJ+p1ZZUs+l
	D4mYtrUIbLH8O593Nv+wEjGGvb+4bHuawmH6RRFZCJo3UQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnmajd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:27:27 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-37628596fc9so1479237eec.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794400047; x=1795004847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=svc0vgDYFwBl6hVKJjHTfBuPN1VEmv+TcUmZfTB8SLw=;
        b=JRMEQPkPTfTog7fWMXYVgDVHQxqR4RXPnYOLwDR2FDnPIOEYyfSS6ixuDsBj1wWHGL
         rudH9KQ+YUlGLh2n45voJ8T6gl43svmXHqJ/s+so8tg7/sMCaFsBoe/NxuXhlfo3niDU
         dHgZyeJa3hgCM7RtbXAlW8kFeVX/iD7WdBKdGbvyRYCRi/Ggh5jI/jO4FjI+sMMQkNLp
         HTupJcS7Q/RdLCMPK2iNE11VWydiQHJl5dmo7oORbshLHYNtpvhDj8Ql3vHjRJ+6r6sV
         L7WLyygbP5MFVIi3DgVNs6Eqpxuq6F+kEhL9UtTqUwU4GP/FIipngZ+l9H3vP9gRSFT4
         VdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400047; x=1795004847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svc0vgDYFwBl6hVKJjHTfBuPN1VEmv+TcUmZfTB8SLw=;
        b=l/AwkYg2noya5B0cKm2V/VKFgzB/mU++UI3eA1d8EO1vz2sGdmPiGp3s4qsEOKWdov
         YQrsj13Zc8JhnDoIBIMI97B+pZHWCVmKKDMwBp7zfxdnbeOUNbLn4Nb3ZPjrZcnRQdek
         9gx1tGzYMFCVYaJIOqx/WgcJSuf5qvP8uR/WqpqvSdzVBO8gPBEgwvVQ2t0BQpfFrFek
         h8ATo8iy1+Ykay103btRadKt9Q3/yL38a9QjQk/jEbZ0p/HmUBPs2i1Ao3vS+se0a/uc
         AWuoeITH2rTVn053qRi8YrUxDu9p1scyT2H82QUsikqLK1M7T1Wks7AVpJoGlfBpuOe3
         jrcQ==
X-Forwarded-Encrypted: i=1; AL+hErGPbVq7Y1D8AeOS/D5GLuXjZLzZkoa7LNqacPTirb0a/n34OP3N9jzCbMzm6s3LeMLo8WwmnqHVUg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kTuhLbmj/1znLLrG8K2Z18eLal+KPxx0FRI6mYuYLj8De/Zbz
	sSXZkxGG3zRAhMDSh8WNfaPf5yZytV2B5JsTInaTAYP5XulcRgQYnaDSiG31blQLon1ncDq3EPw
	tNc85zn5Q3IsrHvE5DF9uVZykJs9f0OhinceB0i+J+g3xLBZdmrlzYezisqFURw==
X-Gm-Gg: AYBFou1MbGcZDYNjadPpmOskbIaS8ZEmzV6+3Yzds1ZBuRaHuhpgQN+iO6QrCnIx8P1
	2rgRnLjWlkY2w1mRa9Ek2d+H2r/9Axb3tstKWwKj16QUO/n4HATVyBlDTXfuCqGi2/V+m9uMiJg
	OhG7fQSRkgoA6vx3AvE9Xj4HsaQSXRxsaXd0CCmopvmfuji9woERvmwLRKvSQV2MuEf9Ba0+cWp
	MV0KUNVYzohip80pOrYeKcL9stSXRT5cGuNbOlqK0sJJ2trYPQwVyPH0sb+Ugdb7efqYQUU34ZU
	iDGluu8NOz8rPAsAHJ3VswP4Ow5IFokE5OzgOqBELOIOb/g5dnCErKkYnd5pSs4WHvQYkY2KXcW
	kUvg83YQ8vw7UEAuEKkL0e8jeda/gmUzvQ+bf05XSqpJ/mx2/G2zuzAU/UZa+gLtKiwVwmEGNeJ
	IVMFPxcYM2RAvDS7jtLzEl3Jf3iEiSTkeruLRoPKBwvUXYZRZXtn+2RKd9VePTj/Dn
X-Received: by 2002:a05:693c:41da:20b0:36a:79e7:2fd with SMTP id 5a478bee46e88-3768721410bmr2952379eec.40.1794400046640;
        Wed, 11 Nov 2026 04:27:26 -0800 (PST)
X-Received: by 2002:a05:693c:41da:20b0:36a:79e7:2fd with SMTP id 5a478bee46e88-3768721410bmr2952343eec.40.1794400045893;
        Wed, 11 Nov 2026 04:27:25 -0800 (PST)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3766146551asm7902709eec.1.2026.11.11.04.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:27:25 -0800 (PST)
Date: Wed, 11 Nov 2026 17:57:19 +0530
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oleg Keri <okerixx@gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to
 non-boost freq on boost disable
Message-ID: <avRfJ8ikcDJsfrqO@hu-anancv-blr.qualcomm.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
 <33d9cbb5-d4fb-4f16-b63e-5ae89051952a@arm.com>
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
In-Reply-To: <33d9cbb5-d4fb-4f16-b63e-5ae89051952a@arm.com>
X-Proofpoint-ORIG-GUID: hCIrPUA-GTlmtt5SGzGMawVKwS5YGJBr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0OSBTYWx0ZWRfXwzU8GVJ/DRVX
 6/UO3gTmU12/iDCm8d/om1AH2Al7LoWJ6gQTMFVje+PNLiPjtfPYHt+lHFtr+tcWH6YN3ZVeXXP
 XNQUyNHJ9abQ+x3kU8KoU9ql7oVZ06k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0OSBTYWx0ZWRfX4ZeQ4ddgjMTB
 06+DW7iQV86DDB2V3KkhmnrgteTthTz99DmpdEX55hh/LOZCgju1Sob/jBNKH8L3xF+IMNN0dYo
 N8S8IzCD89m8UEQ874ciuhV8cfJtNDBb/NEo93apvwA5CTZP0RSqBlZMjFBEerVuy0i1WMSO2xJ
 QHTPc/D0pTo4+0GU4SM5t7q1EOUZM9ZfIKmCgODowfXGQG55lU8wtym5HjvtlLi/A3jFja/HE/a
 bxm+UrzV7aVeFrt1+laoi0Iq+mvDOFunrDMhDqOos5tV9NTAjGgEb5Gn/RxF8LX2G92p/CdO0tr
 MEy/XSL3OtSrlHz+V15do9SYwnUj/T1hPg4AiyV+K6nVfp1vuJ3BS3NNmGwZ5593buBrovNlb9z
 XRLp3xrRvOheEPGJvhN6ZLXt87fmyEa9bJOIb5sdg6VfJ59vNSkrNX7MV6SPu2cbcY0UiqMSYaB
 sdX8AsHPeuiZVtBM85A==
X-Proofpoint-GUID: hCIrPUA-GTlmtt5SGzGMawVKwS5YGJBr
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af45f2f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=z0i6psv0inyxDjA-2G0A:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110049

Hi Dietmar,

On Mon, Oct 12, 2026 at 01:42:39AM +0200, Dietmar Eggemann wrote:
> On 29.09.26 13:38, Ananthu C V wrote:
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
> > 
> > Fixes: db80ad776cd2 ("cpufreq: Remove driver default policy->min/max init")
> > Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c    | 16 +++++++++++++++-
> >  drivers/cpufreq/freq_table.c |  9 ++++++++-
> >  include/linux/cpufreq.h      |  3 +++
> >  3 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 96515880b4ac..5e6afb6f8826 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -574,6 +574,8 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
> >  
> >  static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
> >  {
> > +	unsigned int max_freq;
> > +	unsigned int max_table_freq;
> >  	int ret;
> >  
> >  	if (policy->boost_enabled == enable)
> > @@ -587,7 +589,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
> >  		return ret;
> >  	}
> >  
> > -	ret = freq_qos_update_request(&policy->boost_freq_req, policy->cpuinfo.max_freq);
> > +	max_table_freq = cpufreq_frequency_table_max(policy);
> > +
> > +	if (policy_has_boost_freq(policy)) {
> > +		max_freq = enable ? max_table_freq : policy->cpuinfo.max_base_freq;
> > +
> > +		if (!max_freq)
> > +			/* when the freq table contains only boost frequencies */
> > +			max_freq = max_table_freq;
> > +	} else {
> > +		max_freq = policy->cpuinfo.max_freq;
> > +	}
> > +
> > +	ret = freq_qos_update_request(&policy->boost_freq_req, max_freq);
> 
> This looks pretty convoluted. You have to find the correct freq argument
> for freq_qos_update_request() for freq_table drivers but work around
> this for e.g. the CPPC driver.

We do need quite a bit of wrangling to account for every case, which is why I
didn't like the idea of having to deal with all of this in core to begin with.
My initial idea (revision 1) was to simply drop the one way guard from core
and have the drivers deal with it in some way, but we wanted to keep it,
I suppose. I am open for suggestions, but my guess is that if we have to keep
implementing these fixes in core itself, it will be convoluted in one way or
other.

Best,
Ananthu
