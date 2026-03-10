Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7D1643B
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773116982; cv=none; b=J9Q01fW94NyIG3CjzH+K8jjUJy77xutClIAiyz7/Y+1zeHgCQ6uBIuG7uD7IoQSIJavYXv/SCUQDbrftnZ1JN9F9hIg/tZt4sNX3FyHJOeDfP+a6i7xiXLgB5rTmcMkk5pvrPx8M1bVspykHTzlTTyrJ3hKfqo0klBo3TKzZsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773116982; c=relaxed/simple;
	bh=K/BkjtyNpVW8vXG5BodEMr/tm7aMbNRCZ5OxUuSgEnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju63rKdf6idhZ/IHdHPLDOHHdG7T6dmEIxazJI+XJ/CWpXco1qmjK48hklGX9PW8fJDAkaVRVMDhmj/lbstxbGzc1+wg2LvieyVuHhI3NoFUnOnyV0OspheDGEIeIKLiH3PFAG1RoHMQlR9HSYNILXDWJgTEx0VUbZbsALMQUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gaYAvlDM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaYAvlDM"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358ed696623so5161422a91.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773116981; x=1773721781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gK2ggWUoERp4+vAbA34lSIBolpX/3BD10+4pqyX4HcQ=;
        b=gaYAvlDMpmdt1nE9WWn3RdRoUVBeUyat+10bYwTUBvY3qRwv2MeA5IwQ1LgIGYpyTc
         +JSLCTgsrA8yW4Y4/XF1szgZAWo7Yb1x18re+9B0TwNMjJxVA00/ynwLDHetV/uo55J3
         H9i8BXAQz09SB3TLMv+vNYJo1Mv/6EQEeRcDMKoQf/2+tdiKg090T/dkh68ga5+nTehK
         x5JIOHzgCIl/mgmT9aJxRJouSo13qpSnKyTPBOhcS9sSA+UUbMeqa+Mjt/QIfT8GLQdz
         sZ9qe/1t+rU0C1DkXzVYch91xzcTFXO7uFU5IaCSSwGiNEK/pBEOeG+JVKU17FmCP+U+
         3Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773116981; x=1773721781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK2ggWUoERp4+vAbA34lSIBolpX/3BD10+4pqyX4HcQ=;
        b=g1B0hDdL7OMF7g70YdQrqu5ZKtTbfrSW7h+GLcI7cD+090iyyV7qPAbBEBWWCPBdLb
         4uTADfdLTGsNWU36XMKuZ0Ly4d2E9WkQcgnvvB+rARGlM4v64gd85gcDHRQ5b6LARkol
         2mPUokHSvDJLsxdE9Kr3anX3OxApuIf75AP+yXq9ir3hj8l7qqH6VUqOBGsUg93dkI3b
         Vd+xn8ykcE/uZOjfURPJZ45AkwypTSxFFgxH6GTAKMfjnG+WcoO15KcebzqOdzIz692J
         8eQ4gR/h6fuu7aPi7hc8KjuvyvtyN+ZOGOdvqbpSsnz4AXerj7cY2C4BocAnFYHHkqD3
         2wAw==
X-Forwarded-Encrypted: i=1; AJvYcCXKeKtYsCGyyZtvAWxRDqviEQMLo/KPoeaA6o68INzVwn5QMfdDgcNDu3FDxHFJsCVbsViHgecixQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzncUnfkZbhHfhS7xDpY0tz/Gk/oIx6/mEPaOe9vLFx/6IAELBm
	2xUhk5tFnWMeAkqVxapprh4G7paMoTpnp24nG9xwc16E3/hNXk7In5os60gMf0coAFo=
X-Gm-Gg: ATEYQzydf9OJJ/wMuZKbgRrAy5KDLIBzi2eCNlDgaoQ7S6HlqiviTvQWocCcn3RBnPd
	KeC9n7x4vWSRT+5eL1VgYWavkuk3vxvpkPd4AXujBRywogvUf0ArMrF4pnRDQ+M90oRm5f1z244
	oOw06xY3avpWvw1L9wSLhqn8JEfjHyd/Bov9XN6yRwbU19WGwOFH8F62gHO/HlZ3PmH24CnaxQS
	ZIaGYasTEGk7opal8sQgGbBFpihpXQe5rjom5mPT53c1xvs8mdWrfYe7EWN22+Rdw16sfPlvysQ
	cQcPFU1h5n4GgSxRgFgKVnAgslH8maScBRSNPPHK/fQKXwjq4sxPfWn4RIVQ2XC5yW3Gfq3Mc1Y
	AMKdCdViRFxIppGHKO5HJvif7c2rcijfkQYNrQmTmPM91VXjK21by48K/zXlhxdTw2/j/+rqGmQ
	3xxNhxNfPeOXF0o5iVePhe83r/
X-Received: by 2002:a17:90a:da8d:b0:359:8e5e:43de with SMTP id 98e67ed59e1d1-359be3475c1mr12767124a91.22.1773116980346;
        Mon, 09 Mar 2026 21:29:40 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f088e4b0sm1300316a91.10.2026.03.09.21.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 21:29:39 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:59:36 +0530
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
Message-ID: <utvxk3rn6icadx4llmzfu32auqk4ql7rckh7kxtgdgmtoyovqz@vo2lmhip5vk7>
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
 <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
 <d21b9ad3-72d9-44b2-b194-4e2a24077eab@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21b9ad3-72d9-44b2-b194-4e2a24077eab@huawei.com>

On 10-03-26, 10:22, zhenglifeng (A) wrote:
> In the example I showed above, policy->cur will become 1GHz when someone
> query cpuinfo_cur_freq, because the real freq is 500MHz. After that,
> conservative governor has to take some time to get to the max freq again
> step by step in your code.

The problem is that your platform is doing some tricky stuff (by
changing the frequency for some reason) and it expects the governor to
still work the same. The software is trying to get a target frequency
based on an algorithm and you are ending up breaking it. If this is
software controlled (instead of hardware), I think a better solution
is to play with QoS requests and limit the policy->max frequency, so
the cpufreq core remains in sync instead of reducing the underlying
frequency without informing the software. All cpufreq core can do now
is go adjust based on what you are doing. Yes, conservative governor
will start again from scratch here but this is what you are doing
anyways. Either, don't change the underlying freq or use a different
governor. I don't know how this can be fixed otherwise.

> I still believe using policy->cur to update target in
> cpufreq_policy_apply_limits() is not very reasonable, because OS never
> knows what the platform will do to affect the final frequency.

The software is doing the right thing by using the cached current
frequency (best known to it).

We are using policy->cur at too many places and we will not be able to
change all of them assuming the hardware is not in sync with the
request made earlier. The change you propose may fix your issue for
time being, but it is just a band-aid which I don't want to apply.
When the hardware changes underlying freq, there are far too many
things broken elsewhere too.

-- 
viresh
