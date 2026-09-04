Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9F4A8A17
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531269; cv=none; b=V36uC8zE7SEhmIFLe4CZiwlOHZ0iA7UISuRcJFpDljYFvJKsRWiF5oP0aWSeIObhQ31eNSyXq+2J+tLyVOGw3GR0YWDjzn1cpyg5704TANUnf2yJNFaqBL51nX+5KgMk18OdObSmOAkVVFarv6VnIHvsY21A4tHToE+TqolXZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531269; c=relaxed/simple;
	bh=Nwh6qKR0V+XnjPWwHnDPQggNun+470bR9FEfgGFIKDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttFYjjxYIzlBolT1eq2tmb/2uHtEwWVHKLKQlnBCIP3K6p+eYEML6ymvGfHibtQBl0461lNK6SkiqLYoox5Gajoog4Wn19aUVKsg9baj7mGpQh+u8TN5MrwRY+euAeU74mSRZQwYcl4ZWpNdB44L+gnHU/YKfwnScF+EUSTtI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojA3+U2v; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojA3+U2v"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so11871095e9.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788531266; x=1789136066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ci5sK1VA/AFzZLFsaPwTu74VZ2hcdCO7IieHuFxzFO8=;
        b=ojA3+U2vtBobsb0saxAsmVJOOvZ0tinQJcBN0YktONA64T/b7CefZwY4MdgDa3kyNp
         KzMbJ4/+bOvLJEC4Flqfd+1YI4qeKtorHab+rkbQhmODA70xCc/l6t18wBuwQtpblH8X
         wkS426Jyz17mqX9LXKqWcOcfSLScgA4dm94tRJmHdLZq2lnD0L9wZR5v0M91tqZVPG3w
         f4F0FcwaRnSsWTHUAJU7cL7l9fRjqH0JovlEL+S+6LPn8dFBG0ozl/jzUg0H7B13huK/
         8HdhJUNidMa7dSKcyMZqg3OY7b1tUIirVnJn0AmNvP7imn4jz3Z/KBb8u5MY0l+eTSVo
         gGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531266; x=1789136066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ci5sK1VA/AFzZLFsaPwTu74VZ2hcdCO7IieHuFxzFO8=;
        b=TlNLKY04imZ/iNv/pMDCwUSNHPX6qdl5gHXdM5Lyxzd9KFr5zLmKvSLVCeDqefePS0
         YZ5Kuz39i0ZYhGr9lgqxjTBBxkewz7NVAZyyGmcGzTnLWhYW1Mr2fNYVfk08Jeu/vrQQ
         ttsdneI1cUEgA7COqIhBjpFoQShWM4b41KAEwONeIMEustZWYtfwJsNy/MEeQVdRuYfr
         BTqgGf/cMc7g6v5Hh/FZEqWH3+g9DNotchCjojJDVnGreKRb5sAuQKt/pfwHIVFiClgU
         hJm4yY2GxhvhC+u8WI4vSgz047j0iD/C88NPiMOz/WRHwu7fcowdpzpY7pOTuZrPo1Lb
         YK7w==
X-Forwarded-Encrypted: i=1; AKwUvBzxOrqD8HIqoXQkY4xokPLTqEDoeu3+JimH+DkmpM84pzCJzUz1C38zs3lGKK4tfvnuqIjV1FQIzg==@vger.kernel.org
X-Gm-Message-State: AFuF++nMYWrdIRDAeGQlPtUn8sd8jcUpwgYt4FaYwHtfEBXoiT65lLHC
	AjdUxrUJ4opXO2TzQwrqDtWJ1siia/zQgobCVOYbO/YQquosj/cxDiPt
X-Gm-Gg: AYBFou3u8VIahilavNl4o/3AOcIWuOwak88hYbQOxOBo6iDU3lKdBLY73DepoBftT6L
	PJiOlBYVzt0Crw9F8V9VSdI90vpGBQaEeQEUd3zRWoeYQjCivycn8DFJZAhn0kJ8f4luQd17caS
	xq4XLog/OyChr43cmNvez4uL1/7+j6+b5XAD3ZiiI3o8d0Wjqk4mvKp/PsVm7rDpmSJ5F6KTqOV
	Rv6Rxpv8FdO4Nx36yumW/cOPlN5lwo5w5C79gLH2c9zu0Yz57a9l3pQizzNVjpsIylFiu3IJxMk
	pEOlTjZ3nvh4S59+5ie9zIYStZ+cBz4ZYxWgtkqWhVGXyqXOdXK1FTigLUwQrpwrdIBT/qBlGz8
	EUBidHtXLmg2iCdgijdiDpOokAx7m/MpB/eWaokapGRYlqgcfT6XR32lFkoBcd/WWKBlDv0kiNz
	BymBBJAi1lR+AxyIn14j65AnsBSr+yLTnOfBRs+N1Es7RE2fB+T6G3+ZP8O3gJ4EfCY3KvlBOLv
	Hpo/m8ybkY3sw==
X-Received: by 2002:a05:600c:138e:b0:49c:d818:8771 with SMTP id 5b1f17b1804b1-49cf8240ba5mr60011755e9.7.1788531265797;
        Fri, 04 Sep 2026 07:14:25 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00031c95sm263125e9.11.2026.09.04.07.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:14:25 -0700 (PDT)
Date: Fri, 4 Sep 2026 16:14:09 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>,
	Pavel Machek <pavel@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Petr Mladek <pmladek@suse.com>, Waiman Long <longman@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] kernel: convert process/thread iterators to
 for_each_*_rcu
Message-ID: <20260904.84b04948b1fc@gnoack.org>
References: <20260904083001.553587-1-ye.liu@linux.dev>
 <20260904083001.553587-6-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904083001.553587-6-ye.liu@linux.dev>

On Fri, Sep 04, 2026 at 04:29:57PM +0800, Ye Liu wrote:
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 6fcc94ce4ca9..76871f78497f 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -337,9 +336,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  			hung_task_info(t, timeout, this_round_count);
>  		}
>  	}
> - unlock:
> -	rcu_read_unlock();
> -
> +unlock:
>  	if (!this_round_count)
>  		return;

The label name "unlock" is misleading now.  There is no further unlock
happening after it any more.

–Günther
