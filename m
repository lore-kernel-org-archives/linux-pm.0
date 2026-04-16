Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DB35BDAA
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366948; cv=none; b=gLNofO8Je6iGUnivq2Thg8ha1lr16xPodB57bTXD/UyERq8ZUQXUiRP8Fvv4LzwPWopCjrflxJ37/wC8q7Pq3HlNX7N80FAyZUkpqNIaosj3O6hrzcjZh67gQ6l5ZVJ+673CkWBfaczr77v0F/AK3Z5kGFxBmu/gnmy/iIFSS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366948; c=relaxed/simple;
	bh=OJeI+3mV9W6ncnLD1OqQ+pA6ULnbFdUSlKq0JT7njbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnizFMH3ge9vhFDgW4VuyuFBfDIOnUlxBbXFPcOHdTzY/cokbpAN5XYDrWhIVUAe/49BA1FOZuBJ5l3yL7DGaPqX3P5oeSUXySFNZUJkOQtsFg5EpRREnKKEm5LV/Vcw4R9RSMjA04uHtgvNs1IrslsQv6XPXIGBB+rSQ/DJXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY8Id/xC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY8Id/xC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0046078so81765765e9.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776366942; x=1776971742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI2dSkxrwqhQpR5uFXP6GxtJ/asEeAYI1RS8A1ZzV9c=;
        b=QY8Id/xCkNSDyRp/6Ia+IhGODB81KC4sCUqlBNfTsAhr60CKClN3QAh6bbWUbx9w0F
         bowURat77zHN+ZHlfvOuP63DWSZJLS9CB67JIgVAKCi6+vwdDnB0WCbS+mhqXyCZvNgH
         3LgovKTZOOZSrowianOqjoxUQU00rBtvbO969KTtzDkyjg4GJlw/bqQS1tjsfKG/nQPm
         ogEfTFcSlOlyCQukZYVXoZ8VBq3hePPIvwrDjEotzfkKEEGQrm4PF/3sJRfFVVsqc4hv
         U3krfzau87CZFEd4MdPgtiuytDHml1jLJtOQsqDYRuR1b6pukPY/ROgrGM7JVAH/3WFp
         ckmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776366942; x=1776971742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI2dSkxrwqhQpR5uFXP6GxtJ/asEeAYI1RS8A1ZzV9c=;
        b=tICd/64Rd8aW3pStufyErZAFEYFHLirAtDRtNr5+wFULF7sLLWEoZZzTMHmZfEfPzD
         mDH93gnO6UQK/cTdM41jKusf9+q0EfW0U8fCIcA6Te7qMBei3LjAHjiExpfR2CzI1d3w
         Eh5HvJa9FUR9Uwu6P+VD32QNLdhNPJxMCQ3wdrrc05BDs6hehmJQVYzQRchRUYDh6SvG
         QP+i8vx+7YC93WB5PScG+yrA0J2kebFMRkpVT6XeLiBVL8S+L80Ul0cpXXKn2v1lNxPj
         GxK3FrAggnW3M6x19F2RrxUHtf1/4Kyg8FG3xR6/XsvMmTOBhKmPYKU4PBuyvsRa/oiM
         JoSA==
X-Forwarded-Encrypted: i=1; AFNElJ9r0Qvrm3QoO89da6YEI7cKO8Mna/ipKWdET7UAGbNvaBQseXENAepkbWDQt4TKjWcZ9ZZnVoD35A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5aOI9kvwYJafpqJ4GSuSoQIEe9HmPHy0I4gC5hP4szu6w36U
	VjVaOE57zxc030Ii4eUPkcLVbvmrnpbt8p+hvGkZi5apVK4pTvyVUs+G
X-Gm-Gg: AeBDieuc5QQPexS75Wnu7gb/jshkQWo6WMFXnxZUNYsE5Y424cTM6qSUniyfw0dJlUB
	BJe8c491Ecgx346e4mEHL8GcmgEXisDLiAabPEbFj4akudxOPFozeAM5osHnt+S4VZ+8Fr7W7m+
	YT6oaOvPjoTYFKGfA2kacZFf1MU/5stjmfsvPHaOWUf+ky95Xkw6PQo0kg+5dVeJZQH+4ixXUMQ
	dSuR5iCPv+NbDf5Qc/jDo+M9LJQoMTnwfXzYdnXyA2quJpWvfew8kv1xUKf7Qb8Uo0msaNAp+IC
	B2putYTgWX1Pg93T/JseVFHOMxGILbld62iqm9Qc8QLiSgxlxno1wvr/4sEvm2lyvkaO7SdrQqk
	qUqJ1IDps2HSWi45qT/xQi8ehVXcqoIL9LWAAAzmPJUPeQMMLlfiyt1HvwxXEK9rD4Wu5Nq/jTV
	vhR0zVqIt2UOc+Vd3dy+xeuMA/hD+HN1sBVJBJjw4xI8ceC4xLOgwrTqXbaZgZ0gwKoF0vOK6cl
	6w=
X-Received: by 2002:a05:600c:a415:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-488fb26d43fmr1783635e9.1.1776366941546;
        Thu, 16 Apr 2026 12:15:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm16561608f8f.17.2026.04.16.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:15:41 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:15:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: chensong_2000@189.cn, rafael@kernel.org, lenb@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, viresh.kumar@linaro.org,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 bmarzins@redhat.com, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, jason.wessel@windriver.com, danielt@kernel.org,
 dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
 petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
 joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list
 with double-linked list for reverse traversal
Message-ID: <20260416201539.2cee3b99@pumpkin>
In-Reply-To: <aeD4H8P1DiPQoM8V@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
	<20260416133004.07bd2886@pumpkin>
	<aeD4H8P1DiPQoM8V@pathway.suse.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Apr 2026 16:54:23 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Thu 2026-04-16 13:30:04, David Laight wrote:
> > On Wed, 15 Apr 2026 15:01:37 +0800
> > chensong_2000@189.cn wrote:
> >   
> > > From: Song Chen <chensong_2000@189.cn>
> > > 
> > > The current notifier chain implementation uses a single-linked list
> > > (struct notifier_block *next), which only supports forward traversal
> > > in priority order. This makes it difficult to handle cleanup/teardown
> > > scenarios that require notifiers to be called in reverse priority order.  
> > 
> > If it is only cleanup/teardown then the list can be order-reversed
> > as part of that process at the same time as the list is deleted.  
> 
> Interesting idea. But it won't work in all situations.

It is useful for things like locklessy queuing a request to be processed later.
Items can be added with a cmpxchg and the list grabbed by xchg of NULL.
The only downside is that reversing a list isn't cache friendly.
Thinks... although that may not be any worse than accessing the current 'tail'
to add to the end of a doubly linked (or singly linked with a tail ptr) list.

	David

> 
> Note that the motivation for this update are the module loader
> notifiers which are called several times for each loaded/removed module.
> 
> Best Regards,
> Petr
> 

