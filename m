Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD0238D52
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381957; cv=none; b=AkMlplVOp8cT2e9MAAqwVXc/NaZ9r8sbsCpCfckQR2L6ieIjIU5s6mKHhHgIIhDGEo2s+kIhj//e+CU+mk/BHQPoFxORfwhW44sLGYcpmc4euDb6nP8mrqgqBGywaJvMU717kt2LH9UmENw68ORwjpnKFvsk1FJQG4+Co8/thww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381957; c=relaxed/simple;
	bh=y1/7oP/ovxI+VzxharFTN+r/aEH+d+Q9pXzaQpFlmQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pfw9FH3WroZTGvbLmXcapCsfsDTbCfrPcv//x5aCd8T5KV4pRih8ErtzNcILmpPJ6FYDoeMVWQjDPbtUnXuI940lgj5ph2sZ+FSXUKVkl5Vzm72EY1qQFEIRjJhTWJZ/j4KYGRE48ciJ7ez53OmCUOkdC4WslWxQiFAAI2F6sWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MotLXT8q; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MotLXT8q"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35a1c6081a5so467229a91.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 23:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773381956; x=1773986756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hC09S5sDnZdHvn3a7hnWkfl+l3DBqPPVMlT1wRmE1I=;
        b=MotLXT8qZH1YETgPLsFZyuM04jGN6IQoh4ESFgwSNYYY+zABA+FpB6+ftULOObJnQE
         qL2nM+4W44iU3iKg0vPi38H39i069pii9EhmEYgvWlF3fWEkjr8Vnt73zaA9eS5bKT2F
         I6ilzSc5gK2HcJKnZyK+3t3lGECnSpXKHolizht5MjGmjdlBorQWWkpxeR2lSmqcPtbV
         fqCZ6SK4tYARxEDO6lcJf7P+H7fdGaWP1IqpyUisRMAV16BpggaVDK+QaJo48SRAlGro
         Yx/hTRJjFSrt/XSmT3RpdC7ozLrjvvcvi3Yk+0L0qbgg4oVFuFYZsVtoxKbLeRDB62aT
         mc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381956; x=1773986756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hC09S5sDnZdHvn3a7hnWkfl+l3DBqPPVMlT1wRmE1I=;
        b=QH4XHAsREzgXGTXdQhJmjrph5sOB0C7ZSkoIYaMizCz2I3onCD7pasv8syQadipUA1
         i1hAZU+9kMyGHELKMk9Pg1T/72cxhCo3zo2C2bjNKdNGoEF4zZq1sWFJUUSJO2TKzTB4
         mYGYarsKJHOJ2p+m9sTlOjp6CJogIR8ME4zaeQGl1gFltJg6FXlgZdW/sl/kIeuJc0Pm
         /UaqpW+/S/eulacMiVfXa19oYYAsPP0GTTmAJRe05z46RArnC4Z+9//543OoYC1CbYmy
         NQcxKYZ1z7kW6x0QVuAlanRwn9yLL1Bio7pPZWIhU9WVfBAuByFDAQbBeYVVWCwvAw+n
         7QeA==
X-Forwarded-Encrypted: i=1; AJvYcCWorTp/PkA9vAEvYPwBK6Lywc2HL6nBxQb9lZG5uh0NCb5G58vBiFskLl7OQkrpXG8Tqy6LDibngQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMduGEM2RQuIPAjqGSLKqvRgIDXsOXxlHmVEoGFXwGU3KowSf
	HBd2FQeewohEWO8oIoB5NPX7fuKeie7wuUPk3Szj7lQtf+6fmlQ8ct0FCNr4z1UImqc=
X-Gm-Gg: ATEYQzwuQJE5u8m/vBaGLEIHwhnH5fWnhr8NDJSAe6EHsdIGF8Ss0UI8czfZPybOn5C
	vV+yAG81jERU+dj9y8NPhZedDHIhcK/+VM/4FXtZRVqQf9+Ege/BNxeIyO99nsR8IkSbZB7U5Oo
	tDKavXQulwGONfsI/0tdKpCu7bJbW924EyL5z+jZoJ8l1A9nekt9EDtB6XvnVrPhuBPYobYgpnx
	vz8a3GUKCnyiEphmtdRDvehzWaW6kxu7iWBxOfeYO3mCbeuoGg/n1f6AwnMBrXwM6fozYPYPJBN
	91Ms2fi8hN64PluAPs2sDfqVOO0dmBpGnvxVRp68pOwmIRpnH04XrdRqiZFHFnHTqaz2vnEZGZt
	ZOTesBXvIeZLqM+/zxNcQy7gdP63VpqMltJwb+jAG0gCSfHM0Nbla7ZXAuTAF5rpLwIVF8CJsEz
	a5DEIgrtkgmCGtQpVolRCa4veB
X-Received: by 2002:a17:90b:3d4b:b0:35a:117:9521 with SMTP id 98e67ed59e1d1-35a21fdb67bmr1469582a91.10.1773381955934;
        Thu, 12 Mar 2026 23:05:55 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24acecadsm538089a91.2.2026.03.12.23.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:05:55 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:35:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com, 
	wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
Message-ID: <swdjuguqfniecaqxgdjwihjieiwdzxjv3vq2agq5sbd5kcftuz@qwzhr43ydzxy>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
 <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
 <d21b9ad3-72d9-44b2-b194-4e2a24077eab@huawei.com>
 <utvxk3rn6icadx4llmzfu32auqk4ql7rckh7kxtgdgmtoyovqz@vo2lmhip5vk7>
 <b7d3819f-168a-48f7-99f2-2ba04dec77e6@huawei.com>
 <dqyn4dv3ecbzzmqr4l3jxfctuxpehstjhean5gi2iqfllwso4g@i4nodkyrhwpb>
 <8f29a0ce-4cbd-4c47-b866-b4f015f0792b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f29a0ce-4cbd-4c47-b866-b4f015f0792b@huawei.com>

On 13-03-26, 11:51, zhenglifeng (A) wrote:
> When querying cpuinfo_cur_freq, based on the following call chain, the
> target frequency will eventually be updated if policy->cur is out of
> limits:
> 
> show_cpuinfo_cur_freq()
>   __cpufreq_get()
>     cpufreq_verify_current_freq()
>       handle_update()
>         refresh_frequency_limits()
>           cpufreq_set_policy()
>             cpufreq_governor_limits()
>               cpufreq_dbs_governor_limits()
>                 cpufreq_policy_apply_limits()
>                   __cpufreq_driver_target()
> 
> At least to me, it's strange that querying frequency would cause the
> target frequency to be updated.

Yeah, that is an optimization and not a feature. Normally checking the frequency
shouldn't lead to anything, but cpufreq core needs to fix itself and it actually
thinks that this won't happen. The hardware (yours) doing something secretly
isn't right and breaks the design to be honest. One way to fix all this mess is
to make your platform not do this and instead play with policy->min/max like
everyone else, instead of making a hard change secretly.

-- 
viresh
