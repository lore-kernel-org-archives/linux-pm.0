Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037552;
	b=WA2odiR/fFX3/3GF23WPhAmnAFlzZwC5bAtLWCBq97437cMr038Kd7Gs1wT0hoS7/a3m
	 R+xDblzz8CTnYkFWM40YBA+xZ+1hlibfsfHM2ZsQVMi2HkmMDBd6YrSEAB0byZhPcPmgC
	 Y5nJiYHS1X35D4dRw2Eo8gSzCrhWbkCOPFFJlAVHtNEAHDFkd4Joc7z0808PPvlDyKdpe
	 In2Wy0eb+vgzPtmHRxkY/GH88Im6bKI/rV56UEQyj6JnWGKpIRJQC5vPmAQABwaBdNIN7
	 hRNiocsdfoxzhcwi4yVSJMWIvuyJ5gyUZsSvsvyVvwFsumuApssmLdZA6TVkqa9EG5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=F2ljx2alcBFTo6QIXmQ3PZr1A9yTe7fXLFSuwRXwTto=;
	b=3oMKgB0zDRntsYUjPMrvneHxiK4JKQ5csD3Rf5Ug/C6BtC7gS2RdVow/+8r/k0xrV+g/
	 0rCiMoNL8ba5ZgG6It9HnRZXACXsg28tCZm62bj775bMrhL2IdiaOlD6U6Ra1Cjfw2KGG
	 IBcjYH6ldOs/K9L4e5TG3Zh5ssUc3WtRljchQvUf/o+wOJDNNRIKKNpwPA5UTArBrGUpC
	 cA/ZUuKIN3G6tIDH5PMcPOcTqWUy6q21BP5RcwP1RCU6RkxLBMDFzdeLhEtw//1lq/wfY
	 4OIdh409WdOpELRJkZ53vUCBdIFf3BtLSA7LuZsOqU5Kq0F1An3VNfHNG9Van8tj6uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XPg83Srk;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC5606A31E
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 17:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFCC5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XPg83Srk
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1931ff67a29so1420287c88.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793037551; x=1793642351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F2ljx2alcBFTo6QIXmQ3PZr1A9yTe7fXLFSuwRXwTto=;
        b=XPg83SrkdQHxiXw3yuZl1WwDqwjS/+7wNLUClFJaerBhuwBIdZ9u+y4krqfdH9ywCl
         R5a4pEVxDrJr0cfry368ztlZLV4egXfstqW9o0j9KwDhsQVKgGDmJHk0nB9uIQRMbSaJ
         WNuqog36pgJwHs680KLgimHuDP3YuFzGR3O9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793037551; x=1793642351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2ljx2alcBFTo6QIXmQ3PZr1A9yTe7fXLFSuwRXwTto=;
        b=HZCjMQvNMS6DhkUq8rYuz9pEGdOJ5vnN/tMXt4VsIV6luWq9cyWdA5uc7TyTveCeQS
         towHAwq9CVGy66x8U79L3ydNNz+ylUhwdrkSXmcUyMVuQUKxCtKA2/U0hqrINLOvOgZB
         MtuMfGCiuwinTxhKqnDxHS+9cXfYlXzDVYVU09JxeKEWLwuvA4pzS25fxrHS1vOSsTm8
         H/cqQ9S068cuy1iyNA0ptOFgnObNNUyXXfQmzKp7qszFhbdaBO6OwKXxHeh4J+SAyney
         CFIYRTrQz6rPYUpprbxmmwM4PQyPzPA87wz7oNmcUK8EtxxANuzp/kSmFRmEYUHlkrcx
         yBSQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6CCDXcKojH+tjNZXM+zRtL4sE9hAiqWEku1TogJPD+LIrkPcvXdRTy2/KYCuQB9D+lVTyU2e1Rw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKUC1OfRXmszLNMthec2WvAmIsHnPC7LRnyr5Nq5AC6ZHLvLPbC
	jL6nm4wlpzR/bMWi0HATW1YMjsPwXGD3RfgZD+3FCHOgabJwcpYc3VCewS4K6vf3Gw==
X-Gm-Gg: AYBFou2oZm7z8uBSRmHuk2y+IigjQRlG+2PZ476wZcZXV6aFQzJVND/IxAHbRoRJMzc
	JaR3t81/tDxeRsEo5veNSF6C+REq2rM126NCOLVVFH8ssd/+Dh/oYBXbSYspxu6xkI05Hm11sEO
	zsL0McGM6F6UIKMTyD6hLXCvk/dEfB4XPoQW2r9Mdsx7k49s+muQEuR6TkpFjJHSkfhoGP+kb4I
	kRDsy86QB74TmidrNMe6SjOiPpQkJztvi7IqFWWCi8vHUxUiIpK7ZUYxNxsGa2o3K7Ai0WI93DP
	Qs9ydIu8qhymKfOcK14bYTk5/OL+i+Cn4mutItlGstvVm/NZZLUPfbBSjpmyJMxEsNgavJNDJIS
	JKv/HK6BSb2blFPamg/HBd120a9gX15vSoPndjgKeZlv22X1SrIJvnsUAGEMKPpL9+lZ72wgHwB
	t8WP/IH3b5JuD9S1pggutfQuwBsDKorTMCminsJtjhP9GJKftGSybZSOb92TnFIsWlokr2JzEdd
	WFsQGDzhjk3O8/hpL+Sx5UfV1M4qCMmAcr6sdM93FtzzxtqmezwQ9NnWz2IWNBWn8n/Yi2Vy3sx
	qkGHTSKy4QcYH3WqwMfXNY+RLPjdsSAG1XthgEH7
X-Received: by 2002:a05:7022:b058:10b0:19a:dc0e:c20f with SMTP id a92af1059eb24-19adc0ec4e1mr9832825c88.44.1793037550837;
        Mon, 26 Oct 2026 10:59:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-198a0f83cedsm32565975c88.13.2026.10.26.10.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:59:10 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:59:08 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/17] iio: light: tsl2583: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <at-U7LvkoiNAJ6YM@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
 <20261021165858.v2.16.Ic3775fd68cac415d959c0456c4d4c36e9e5b95e5@changeid>
 <20261026005504.7482bf26@jic23-hlaptop>
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
In-Reply-To: <20261026005504.7482bf26@jic23-hlaptop>

On Mon, Oct 26, 2026 at 12:55:04AM +0000, Jonathan Cameron wrote:
> Note I'm putting these on my testing branch which I'll rebase
> after rc1 is out and then they should show up in linux-next.

Thanks. I can't seem to find them on any 'testing' branch [1]. Just FYI,
in case you were intending to publish the intermediate result. If that's
intentionally a local branch, that's fine -- I'll check back in later.

I also see you're trying to partially rework/expand/add to some of them.
I'll try to review those, based on my local combination of my patches an
your patches.

Regards,
Brian

[1] In any of these:

$ git ls-remote -b git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git | grep testing | wc -l
9
