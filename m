Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B9238D54
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296166; cv=none; b=gOvwKeYers34c63z2AlQ16adgLwfWlAsLiD27/kHXpLkpRtcBf6g1HE2zHw2HOSaVpoxz2h7gzFrV9WbqhlC3Vj/FHN3Cm+SktEwF+BoZnCAM1GLKpv1iWMyM0mSEDzGJqrY1s2gDSHVYP5oUiYj+wGNPyIxEdXGjqoEfyzlKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296166; c=relaxed/simple;
	bh=ZWbAx2KHSKmHn7nF1/nawKIbLe1chB1vOtyDsnRU5F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFZ1XqJAktzuNJJ36yEVTFBTRIGlzDXMthUjxZqbMPpROJq1wiohKFAOMNSLFqQ5uVjzcneAxtbfPwn1WAc1HpKM4Y8fC1y8nd0MkYubSOxYw5TSkae796BiYvD259xgRl2cc/1viZ1kxfcEtFF76JuehCc3t9Eae0+8t1NI72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNICT/44; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNICT/44"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c738fecf349so657879a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 23:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773296164; x=1773900964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HzKw6/yVq/gHZlCWPT+wXsGdn+6VywTNwhTWXlYTYM=;
        b=RNICT/44FTHCDzTXJJk/wdxQGJ7Gx/eKVc6tFwPhC4X0TvOpaN9gMjxdzvaX2ZCuS3
         ibeUQKFdn8se+SQzOVpTSyZ2+qQ39gZuxAVMXLei8nVzSsr6y+0oi/vfOfXnGMpeZKPF
         ouy24/ibMbI135XvnOkatHji0i+nlR3+r/98jihVOJW/Al0jhvELuqQDlvB3XvNWmBmJ
         ojRfMa/W2ytNFJllBQoL4pYp1r2wKpbokQJ/CKrHL3cCzx6VOLKTErgmoEc5al9wFtnl
         OjHQjAfq3xRn9mg/szDlCTfATLJHylHE9c4F/SIY9Ej+/GozH6apJdyds8ooPHjHU/9L
         5QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296164; x=1773900964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HzKw6/yVq/gHZlCWPT+wXsGdn+6VywTNwhTWXlYTYM=;
        b=HAnCBflSvpr1dAojCndCUTtagDhtR+F8ogdj+HhCLkHfTUsrXSmhiA9ArVxF+GlDe5
         34NDQOCg5njbUrxo2WGVT0YeL9OP5tWGOvnAtNj47CDH71cKOG7o6eyJRe+kFEgVJj2U
         tG2LrCbWrxpxTv8Jjk/Z2BCzBNHl/wSJs52y++GrJ1psI2wUMP+J3tE9Uh8O8q6qwe5d
         M/Z/6xZf1XoqOII9jOyW66ytNstvJJFlwEPfGVdOZUBEj6NEMcREDI2Vjz4fdwtLo5lf
         GcEgN7f5pJKSxW0OD4Va8JghMK1j6D6jmRgfAzy4h6FZ+YS5i7a61bnI5CB7bitScrMM
         L1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqZju6gQ++PH3yvY3lAogg03jlLFFEN8FLsWcrQWI7pzg+0T1me2bjxCHiBBeJoRlthtkQf5TVGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRJjP9cOnwfvsU0OqTn/N7fCN6kWydBubupEC/aNiwTWO43Dg
	0xUmVUCPudiq2adBGH8dmF7UBgefO6Iz+cYkF+rz0G7w4Dac+ifamvw7EnHCB18q4bY=
X-Gm-Gg: ATEYQzyWmCdMJ7f2PWABdD16+7oT7x90V7JiZaWNbqRyP55S5hiB5B11D8xB5X3UzHd
	znQvx8cxJU5BjvL0eV+yVYQcRj4RrbeTIzk5wrT+LHanZ+45urYoE0Nfr38zJET/21tuzC3F7J/
	41sRiMzetGt40c+uF8ILWuAP5frZrzU9RF1u+yQZFAE+w21rKH7B/vB/N1BC972pRJDEu39i3Yc
	b67zSklUSG9933X8nneuIdG83HJyIhiQbJhftcgBONl3/5ept9sTyLKNkvvf2gOoFDbpwRCAjN2
	ZLptPLm0e2Hz/K1m3+VZsGZUQ4qGWOoBF9MxBm4ztIGm+QITknlTES4gkZzeT/KfDrEix+EwwRi
	UvhA0wqXEK5KEbZMIK9wEzdKW1yPjjVkuOSALFcFcRmxcYSd8Be9bG6lGR4DahiEYvrjmoUCEFy
	eBozfZa+a2EFz0OGq4es1iMSy3
X-Received: by 2002:a05:6a21:1f84:b0:398:87a9:fe2 with SMTP id adf61e73a8af0-398d78c5773mr1879375637.25.1773296164119;
        Wed, 11 Mar 2026 23:16:04 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0734199csm1647640b3a.36.2026.03.11.23.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 23:16:03 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:46:00 +0530
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
Message-ID: <dqyn4dv3ecbzzmqr4l3jxfctuxpehstjhean5gi2iqfllwso4g@i4nodkyrhwpb>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
 <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
 <d21b9ad3-72d9-44b2-b194-4e2a24077eab@huawei.com>
 <utvxk3rn6icadx4llmzfu32auqk4ql7rckh7kxtgdgmtoyovqz@vo2lmhip5vk7>
 <b7d3819f-168a-48f7-99f2-2ba04dec77e6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d3819f-168a-48f7-99f2-2ba04dec77e6@huawei.com>

On 10-03-26, 21:11, zhenglifeng (A) wrote:
> I basically agree with what you said. But I have a little question. Do you
> think the target freq should be updated when querying cpuinfo_cur_freq? I
> think it should only be updated by governor or when limits changed.

I am not sure I understand the question. Where are we updating
target-freq ? As far as cpuinfo_cur_freq goes, there is no need to
make any changes when that is queried but..
- cpufreq core caches the currently known freq as policy->cur and uses
  it everywhere.
- When cpuinfo_cur_freq is queried, we go and check with the hardware,
  what the frequency is.
- If a difference is found, we align policy->cur with that, given it
  is still withing policy limits. That's all.

-- 
viresh
