Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645339FCC4
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762328; cv=none; b=njia9ihMLW1TmJiDQM/B1d/7EgkU6waANbZyUPNM3vyWud66K+NOsn6lPgHngeXy1TkXhNv4U8NSvBSoVN2mW+UH8Ti0rCJRbJ/tJqXj0YgQyUUYStaGP8Kefg1YT6dCqfW1TsbLi/bWoZqw97zF128MZFgsinmwugY6W1LjBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762328; c=relaxed/simple;
	bh=jNS11TxrGCzC/ayr6dWUKwMQYFcjJbkoMNjsM92foRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht0B4d+QI1/hHajtWBAA/scuasz2eMPJ8ZhyLNhMfsej9cjxqCpR9D0v5f0ZnVPTDLl91rWqVV1Jh1Vov6Cq76PG0FFYKuyhf0exKsytQ6v8kz8B8BKTnzaNQPL4amX2mxCPoJRcpwI3PwfT6cX6v2YojPfwpkq6wvnCfM8th7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xcc1CP1c; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xcc1CP1c"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d734223e4so2706090f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776762325; x=1777367125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq9QG9cvLvgk2UCX7BCWel9Xe8wLb+Jo7joT5Pt0764=;
        b=Xcc1CP1cnpjrdwUmB5v0J4Irq7DUhlBQD21ey2Ch8Kf6N2zXz11+vDy6TZgmIaAUJC
         +zoEz8FhqsnU8ZDeplIlW5qDu4M1jS604a2J+/T4WHykYlPpreT7WCgIS73DUOordZhU
         GSQpP79dJgdMCPtm+L0j6TbNe5PuLwUFNi+EpHD1QPWzLgzk5WJ2OJHQfvHv7r2ufHNM
         nX6nSDXwcL1hB+Q6aa5W7/7q/7STQTSZPxNsZMvv51vHikW+kMIXBLc6pQtRVKpk8XIr
         0PPbT4gMMmh5vdD5GsAgJgoWAemXJ+aXAnYSthNEwj6jZRtccCdx87/R/FK10xXMgnxj
         3nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762325; x=1777367125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq9QG9cvLvgk2UCX7BCWel9Xe8wLb+Jo7joT5Pt0764=;
        b=QHsHpuSH+ukaze5h2blXcO10jD9Y+0K7VOnSinViZkp4i6RqVJteqKupNaUlguY/Pc
         O5wGsHv+NTvnGYcIIDjrj/xI3dITeof+H7YICOsDeZXOthXRqsItgRdN3LDTo8A3ZS7e
         6LSMOKSoo/SBKJM1W85y1l8M/lwuakUZ55bUeR1R4XNV9y0TIwQhs2ksy2c2VXH8GQZb
         G40xXUzEALtWhSvuZ7+OKZmRcR2rdhf3Lb8RaAW6z9ahcXvDlCHVWX2D0Av15vicBhQJ
         DNU6tNmDxRQNRt2pgEZlAVVZctN6CK2Bx5mY3RMkHDqrAi3Ozx/0kik3iMgNAyBiXQLf
         vrsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FPoTg08Cu2sN4zXHp3OYvoU+EZ9F09ZZIy2Qxkuu7V6zlY5kkq/8crm550/EEC1HjFlhAYKvQjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08rV6OfLFAoqvMZod05iBXLw9f6/w0DCjQBiO+M0bys8Bvcdk
	1Epc4XtsLrvg3DvNKAsARz86J2skfHK7eRCyBAT50Mkyfnw4eCib6hOAhq+hXkdioew=
X-Gm-Gg: AeBDietDujsfK4DzWwOTbzkgPLYITmYpOpuAwFuFHgLD7Ce94LP0LMNx6nnGhkXJ1QR
	UQOCFUvh6sPblPgVZ9mgiAyoCVmKEOzeuzzDKlLmtky9LbdEukwhc124MGJuQekY7A2WxAXtV7o
	5cjqVQJg21eCDJIegxZehCjPNPr2fjFst3KBGEnhLyTVsgk/+LxVsSrclFIHzpOtF7tAvvMTVn2
	Pjcy0hStC7h35WUq/Votx3JtUCmKspPrc+uV36RYBR8/Wyhozg+4Q87rTIMYMCZfXnYWIQG5Dbd
	JMumlJuTry5WoYCbA67UkPNW8dx48YiWUwckRCn377uvexcxhS2eXk8jKg3mEuvjExBhWNvS+tr
	1c5BetPz5wkx5OTXfuyKXMhKrHEwK245EVKFaCQR9uyxREWvBMbicY3HFSYo6kaRvaTs0mXA2Ke
	C+aVp4h4DFAvn6I9aeN9NdV+5h4GhToQoSzPKpfDJF8juem/TLciw=
X-Received: by 2002:a5d:5c81:0:b0:43d:729e:f23a with SMTP id ffacd0b85a97d-43fe408dab9mr19081632f8f.22.1776762324596;
        Tue, 21 Apr 2026 02:05:24 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm39945351f8f.6.2026.04.21.02.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:05:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 11:05:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list with
 double-linked list for reverse traversal
Message-ID: <aec90caYZDHDAHgw@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
 <20260420144429.57b45f2beece690bceea96ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420144429.57b45f2beece690bceea96ec@kernel.org>

On Mon 2026-04-20 14:44:29, Masami Hiramatsu wrote:
> Hi Song,
> 
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
> What about introducing a new notification callback API that allows you
> to describe dependencies between callback functions?
> 
> For example, when registering a callback, you could register a string
> as an ID and specify whether to call it before or after that ID,
> or you could register a comparison function that is called when adding
> to a list. (I prefer @name and @depends fields so that it can be easily
> maintained.)

This looks too complex. It would make sense only
when this API has more users.

Also this won't be enough for the ftrace/livepatch callbacks.
They need to be ordered against against each other. But they
also need to be called before/after all other callbacks.
For example, when the module is loaded:

   + 1st frace
   + 2nd livepatch
   + then other notifiers

See the commit c1bf08ac26e92122 ("ftrace: Be first to run code
modification on modules").

> This would allow for better dependency building when adding to the list.
 
> > 
> > A concrete example is the ordering dependency between ftrace and
> > livepatch during module load/unload. see the detail here [1].
> 
> If this only concerns notification callback issues with the ftrace
> and livepatch modules, it's far more robust to simply call the
> necessary processing directly when the modules load and unload,
> rather than registering notification callbacks externally.
> 
> There are fprobe, kprobe and its trace-events, all of them are using
> ftrace as its fundation layer. In this case, I always needs to
> consider callback order when a module is unloaded.
> 
> If ftrace is working as a part of module callbacks, it will conflict
> with fprobe/kprobe module callback. Of course we can reorder it with
> modifying its priority. But this is ugly, because when we introduce
> a new other feature which depends on another layer, we need to
> reorder the callback's priority number on the list.
> 
> Based on the above, I don't think this can be resolved simply by
> changing the list of notification callbacks to a bidirectional list.

I agree. I would keep it as is (hardcoded).

Best Regards,
Petr
