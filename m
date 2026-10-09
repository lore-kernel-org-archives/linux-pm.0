Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10294CC261
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544601; cv=none; b=KGF+EGPyPEbyesUCkLUIIg1DOr1m59gmARU3dRVhYjquichTCVmoCKvXjsBqsK0KMLNMEFTwEd3NnZzzAF6TBi9xAVcZt4h3Q8Bk0MGH6ld6ROq4SfYTTv5HM4hoSzMG10Cbs46bcMXS4bSjtd7mqYgux5WHS24ohXZcr+BBnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544601; c=relaxed/simple;
	bh=7oNXmCayF+uoWO7ThUQwKuLtcd+yuCMSaHRdecbZ64U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDMSXLwBNyG9s3dI2dUS9ew+xV8p/t5CMwM4I2DqX/og2wUGa3mj6eoCDmtII3TacR7y3ds2Zo842jW1M9wk8eZ1ToK6yd/eqkrMuwYdmC6d08Wq3eBFvVJ/RB0HVvH3jr8Bhxd0eCHz2HNLKBoBq8jisKH6JbfDDQ5bes4mddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+Q1/ak5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+Q1/ak5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a172da1049so1181105e9.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791544591; x=1792149391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itsLuONkjBfdmzhzJnq5Bn90MLJfbhblfMvMLn4gNLU=;
        b=Q+Q1/ak5hbNySeXthchK2E4p3/T4ydsNIRERjftg2rzflPU0dh3dqGmBvXtXTzJaD0
         ogf5wTRcFcw7xIhKfw/Qkj18b+IDhGGBU9LmzytJDffL3oI5P7/rJ0UF2g1ZDhJ8Y8/r
         8Rr1Yqr3bKAFJTBA4ckqAflyYWm4FQatA94+PhVIBeDVy76niPrDofC/ThJLFRnHDVX4
         oWY6SnLQEYCRtxpSvx231TGlT9FulUTiVPLfm8O84vo/5vTIz7j1gdWlIHdHg3tAB8iJ
         GLkeU3cfYV3xzJQ33Btk9t2HmmDMlHQObhelVtOHKHo2AsMMhmwneQTAwxetpJXUFXgW
         vJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544591; x=1792149391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=itsLuONkjBfdmzhzJnq5Bn90MLJfbhblfMvMLn4gNLU=;
        b=Wpqh0QeRDj80+VjAmjqAO7OqL8ZncQ5SqcVFPc3ryAA2LnncAVymfgnJbO7nB8EF0W
         NUvhSxe8EiOrO0uck2BXLu7crBFb9PCSnYJkydafNyfoWpff8TFx93E0t5ZWRJyYNS8w
         xKpNBGxfEuiaZTFBTMSKOF6FMroU5o1QkyozBs6WiDaXE9Yf23TgsQp6Kd1MC3DehMQm
         eBJ4vd4dlEO3bhOEo7fpKkrQN88xOck825GtakHbQLdYHJbPCawd/i+1HMN8gM4RCBAg
         vcVN19DowswQlmzDD5rix1jVEjiZCo/ALqc/7NMWPiSkqteoMAaqCCvyX/8pS6tCoyo2
         CeiA==
X-Forwarded-Encrypted: i=1; AKwUvBx2492TNTY9gkZxI/mxkAR0F9ZYlt3cautVZpGQWUPYZIy2PxUXugpnDkh5/iVGNK8hscXCRdxT2A==@vger.kernel.org
X-Gm-Message-State: AFuF++nggfT8YEFv5N2D5F75/v6tLRMmUeinBim3EGiD8wZC90ns57wF
	vMKdew6tnAmLsZUxxaapX/MrSOBJepGOslipK/Bjd1mQgpv/LoB3JQ+6
X-Gm-Gg: AYBFou3vxHA+4UWvkewc7RFZF4loL88oewhsHttuvqSNozOVDy7Ou55SFRVzY9B++4Q
	QCilMPE9SdSJm6upe6zbwx+6c+7heczktewKmrKnuEyiD2i5I6RNu6/VVJyoWzRKYYgcFf/ErPL
	KLuloRGCzVAcDMemqAa/UYnbfuRm8X1rqHveaYanAKac/oltcTTuVpLDP5YFwiQT3uLlSJBwIZV
	8jm1GCaiITAbo7GUSsmTyEPAL1CDpCFFjsf7DK4mbybYMegVF816AHKasS/gURVP7e7MRjymssM
	wvtQ0MSI1xJf5+HpxaaW52C41rzzSjN8/uyxEu/ZIv3xbd9uZLi2w769NKkYM+FwKa/WPg+i7N4
	TkI1yJYk3pKRFDyocdYjb9A5/cSonST8kPXnvsADmkKTrwjIkOQ/r7Gyd4jwI6uq/s3xbwicem+
	2BRWXeGgRAfy4C/OKT9XocwaDv28l+Fn1eodELoaEhY3S2OXuXal77jvF0CcfKIM9LTv4sF5r5A
	XPSZDDEzkWTl9OqXzD95PP3v/gP21M=
X-Received: by 2002:a05:600c:8b02:b0:4a0:1973:f05a with SMTP id 5b1f17b1804b1-4a18e47e19fmr31556705e9.2.1791544590796;
        Fri, 09 Oct 2026 04:16:30 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18f3b43efsm46733545e9.1.2026.10.09.04.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:16:30 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 14/18 v2] sched/fair: Enable push task for preempt short
Date: Fri,  9 Oct 2026 14:16:26 +0300
Message-ID: <20261009111627.4861-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-15-vincent.guittot@linaro.org>
References: <20261002154415.2270586-15-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Enable push mecanism for the preempt short feature which is the
> 1st feature using it.

IDK typo count of 'mecanism'. It would be cool if I counted the typos I found in this thread.
They're so important. But, I didn't counted them

> @@ -3475,6 +3475,9 @@ static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new
>  	sched_energy_set(has_eas);
>  #endif
>  
> +	if (sched_feat(PREEMPT_SHORT))
> +		static_branch_inc_cpuslocked(&sched_push_task);
> +

Well, as I checked it seems like first user of the push 'mecanism' can't be disabled.
This could be the correct behavior too tho? If we want to open it and do not let it
close even when PREEMPT_SHORT is false...

But I think you wanted to connect this to PREEMPT_SHORT, no?
Well if no, then well I have no words. If yes, I have.

I done a quick test, adding this line to here:

        if (sched_feat(PREEMPT_SHORT))
                static_branch_inc_cpuslocked(&sched_push_task);
       pr_info("push key count=%d\n", static_key_count(&sched_push_task.key)); <--- This

And booting up the kernel. Playing with CPU1's online status and closing PREEMPT_SHORT.
And...

[    0.967146] push key count=1
0
1
[    0.967146] push key count=1
[   42.408439] push key count=2
[   42.475103] push key count=3
NO_PREEMPT_SHORT
0
1
[    0.967146] push key count=1
[   42.408439] push key count=2
[   42.475103] push key count=3
[   42.562426] push key count=3
[   42.619255] push key count=3

This is a bit messy since it's raw, but as you can see even when we
close PREEMPT_SHORT this not decreases. It just stays on and grows over time.

That's what I'll say, maybe I'm missing something.

Thanks,
Kayra
