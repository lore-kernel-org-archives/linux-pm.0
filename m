Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45D3E0257
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351269; cv=none; b=dgxAPciiVyvZC27Glu8VoF7pyC7ur1snE7VIpugU2JU2jKmNYaPe2BKgWpM1dPifXe3FSfoCp1efXxDZ7LEBnudcHF0UNy5lsoCBjk549U7p5urMDTWgXNp/0eLkzdlVj6MikDeRCuCCsbgI3OIwluoyN1VaT76L+Df3dW1AVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351269; c=relaxed/simple;
	bh=EPHRfB7I5uH7xIWit20L1zYnCi9wOT2o59aqll9Yfh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMvcPZ6nLj2e2wxPPY91GdfYFCNCFxSwiUuITuBgl9FdkJzaWs3dQ2Ay12E6c//3QZWB0J6XuVR3dvCQaK0uR0w+09pJW7K/Dw1iN10ISH8C1qIgN/EAOBnG3p83BMA7PsmsUnsHBmM1iLjnwNHXPyciZubr8iq6aReIUA3xon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AxvLgQs0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AxvLgQs0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so78365625e9.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776351266; x=1776956066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUk9+5ugjhG90uPs8bskXfY1v/H6BYvalTyZQcNSMUA=;
        b=AxvLgQs0aTfo5aAuCATMtxqRRyrWZscAlPsA/t41RJ+9AHIVNMbCmUsIeVQrkPCx+c
         w6usVFoGLtuyL6ix3ExuPLMCE2wXopuILo7/owj/aeMHFfikW3URlwtyVLrBFDMGmC9R
         oriTluTZb8rpNneBcFfL6C9opqoTySGkMuV66LC6WpwfOpNLO3JZwFkHqLleCS4QYWsv
         7xNDCB+p2+IISzNFUXDt5Pq74+TRIkbYatSvjOFQ/jusNKjpBs6kIWj/kmd646CZan1f
         vOyVERub8RMzJxxLAGz5S3gV5TaQz7ehlGQp3Jm1jNc58JUIwHLYqgbcY3wChskeG4uz
         ABXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776351266; x=1776956066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUk9+5ugjhG90uPs8bskXfY1v/H6BYvalTyZQcNSMUA=;
        b=kF0By0FobuZgOOURY//jB9qPTAzlQ8iNEr6/Ahf/lQ5waQXnchUIRK6sQeOTyyGTh5
         iN9oC/Zpulrv/tAyl8kvpDehHAjKIFH0XhhdcBZ4d/F/7RyRelNAoQVS3pBnLF5HbS6g
         xhNE1wSgiqd4hqjoj2ftjmc9WhQl4oUfyUib+ARek3Ekz1tD2yWPx7n8uFILYmx0c5s/
         a+7mFEEKJ0vsTCBxX4bsLNWWk1fEFBzcs7RrOdnDU29ofYlssJ2+/CKzNuicA7GN6hTH
         wKCSozYMEmoSQ1F/15j7/x0U6ZhuNN52/UO1pBoFOke3VCFUBdh/2NOqsdMH/gTr7xpk
         h0tw==
X-Forwarded-Encrypted: i=1; AFNElJ/19dzhOzlmhNLIAalQ67pzET2v0F8wQUMmBhrd6CU1BoeC3hMv3bi1W7715kV5rm97ruWD5zImXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmJ0bghaO61pPpmpAtXaXk1iMbGQeDu8tQmZjjOltsEh8U+UP
	f7r6NAKxdKqz5WPdUMXe3XDwbEVlkBYotzp7H9m0qVu6LXEe5NoEsnWMJmYAQbSF294=
X-Gm-Gg: AeBDiet0/kC0Pa3QlBuh72XizXkavQaalZ6wv3h3supDtpoT/eOMy3hRswT7pl4VYuH
	lfnb5VmlUknLJRaGINnKW2u0MEsune4zqD5YL+aruyY6OHwMr6JyIYRjJDl8xesu8vf5fKkK5ky
	OcsdPDObEjYp2+T7M3mUCnlHlPwz/s4y+tA6Pk976KmyHlVl31zoTYWbRi/2Eumur1wnADzhU3P
	swyZg0EnYtFNSeQLd1mZQ1YpLHQWigkoVhDxAdOGJEseflJLgp+0d/kXcus/b2n4kOjc8bSc0Om
	llRM5gU4skME4i5nKZzIjH8nQqUcOnmnFaxUIFDJ/BpQ67ptC/S3pfe0Ev3Mpn7zOaPxVIa8WfO
	Lz1JqYtLhMz76g74bjLiIEcfiPR6HgbgBiOuTItfsLESUfhazSb4UhE5t+XGIXiDVvh/onv840u
	Qc7WPX1eq+a4POutArCCGw5GJ1sA==
X-Received: by 2002:a05:600d:4:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488d68ab2bfmr302762205e9.24.1776351266415;
        Thu, 16 Apr 2026 07:54:26 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead2decafsm12915427f8f.0.2026.04.16.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:54:26 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:54:23 +0200
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: chensong_2000@189.cn, rafael@kernel.org, lenb@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, viresh.kumar@linaro.org,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	bmarzins@redhat.com, song@kernel.org, yukuai@fnnas.com,
	linan122@huawei.com, jason.wessel@windriver.com, danielt@kernel.org,
	dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, joe.lawrence@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, live-patching@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list with
 double-linked list for reverse traversal
Message-ID: <aeD4H8P1DiPQoM8V@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
 <20260416133004.07bd2886@pumpkin>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416133004.07bd2886@pumpkin>

On Thu 2026-04-16 13:30:04, David Laight wrote:
> On Wed, 15 Apr 2026 15:01:37 +0800
> chensong_2000@189.cn wrote:
> 
> > From: Song Chen <chensong_2000@189.cn>
> > 
> > The current notifier chain implementation uses a single-linked list
> > (struct notifier_block *next), which only supports forward traversal
> > in priority order. This makes it difficult to handle cleanup/teardown
> > scenarios that require notifiers to be called in reverse priority order.
> 
> If it is only cleanup/teardown then the list can be order-reversed
> as part of that process at the same time as the list is deleted.

Interesting idea. But it won't work in all situations.

Note that the motivation for this update are the module loader
notifiers which are called several times for each loaded/removed module.

Best Regards,
Petr
