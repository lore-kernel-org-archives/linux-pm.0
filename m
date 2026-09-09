Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067263BF68E
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992081; cv=none; b=MkD2ecTKPk5Rmp/eILuOF64tjpd0xMgMyi9ZRkXqEbi/5FjDhFS2FdwE3zPJxCM+0IBrlNz864YzVwq71xmh3uRzuv1soLilKA1f3Sbn1gxtpwmvc6tW9hbnZXyDT6nGn9tOFcBuW5Ay/DobywIrI3oTxMf4XO/LAu+/s1bcyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992081; c=relaxed/simple;
	bh=aQvz0ZYLQXdqqzd85lD3v43R3LA7HgRcKMR5C2XkRss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hzf7J929/2YPDgWg7lB03r0YNwu1ar74bs1rykj17dv0yPU3CBuSYKyebBno0P7N5rzZvyBwwklz/5vmgpLEvpSowXg69Q4MwzfOeBHmo52TebqnNMpgsfZY0TPau0yqECqoi/WF4WhcpDtRFyhz0ll/odNcrZE6vybVTur+sUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fnpdwSN4; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fnpdwSN4"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso9977336d6.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788992078; x=1789596878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5NkJw6oWjdsiphJVaybRhCdoPAeWbsi0cRS0OiEPYM=;
        b=fnpdwSN41Bd+nnSwZXD6W0gZ8eetbtEli2koOI5k6o2p/h7yS80w3XqZmsAcB0S7tC
         rlBEAKgyCm2vYnBGj1pW6sW9JZNN1TUVAXB1nw2NHkMJew3X+9bbwGs+8lNnznKSSrlO
         I327dzeyexcEYxFLf4xRuBu25dekSSqijcF8IvX31Zn+fbBi0w71OaADpEgR8fFiVeao
         RG42i7/xclhYVIYtPmE6evMDntSEZN6eOF2DBDdLkeGS/1heYbdXs26/V4GbzDo9UgM0
         eMxaYopC9+m5yXS87uifPq0UhH2vm6QtyBePAG0QqFe3/eA4t4jyjM06d+KiES0jsiGj
         iiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992078; x=1789596878;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5NkJw6oWjdsiphJVaybRhCdoPAeWbsi0cRS0OiEPYM=;
        b=CZhHkqWv5qgiY7OPV0pIbTl8UCyT21WjeZHSBL7nXmLXIgCqINtpXfUuvKVSBJbuI2
         DIT+opMp7PrX6pZhRSQyWatsTClRYdYfFcsNR+cqF3j/wiyM/vebgBqzGUy5AIf9xpHu
         Xe3PCEzH3NOdT8de3YLyWkD2A0df5n3HevgNJhVdraDPS0cEXvxyegW9K2BnlN0og5Ik
         HiadhkMbLBNNMJwicJXZvFizJ947XBb2X3VxIuYbBJaS+nysm1J/cuFFWppPEGan7ujF
         yiwIfNUzQbCbAH/94ldLpyVw2Wq2QPZbucyaTp0fvdzCUNbVSi1/RtRBJI/JHpo1RwHs
         wJYA==
X-Forwarded-Encrypted: i=1; AKwUvBz3nsTnYv8D6f08n16eyI8TnD2ewHDZkdI1Pizu9838vtyudpMfLFWs425giqoVa8ZGCEHvhE3daA==@vger.kernel.org
X-Gm-Message-State: AFuF++mOK2fBPokUc8TCgA32Mvb9xF/OegDTcYZFC6JGpRWTc7yD8lkJ
	+Hm9DKC0ZodXGptLSa4ruupEFEJQzo+K1v2CgtMQezaolVeo0jr7vodwlZINW00XTUE=
X-Gm-Gg: AYBFou0ikavRnG1/nyX8QOfG3ClEetwvyufCrvsQdguIi2FQ/T6g8uZWMZQ+6h8k3RN
	dCmEBMfllwcQ6ZIDcN2w9dcml8V6H7Dhw/iZSr94V+HD1slhaTJLpEweHGvC8FX9FJ/IjeRl4PR
	Ex0Rw85iLcNliHXx7HPg9rqryrocjbC1pL8XgGrxutE8xVYMtcEMb/gY0v5X1Fo33bAqv++nQ5w
	NNa1WMEsJOZ+jyWzVFDg5nQyjiVpGGku1HSCRJ3ee7LJSbRP9+5fGH0cA7M20omhaeh0uvM2VRO
	gkMo0rpBZWn38AwJcdN7Q0gcO9YHKg8n3aEqm5D6V9pWTh/zISj6KNyzrKbMSvatSw37tXIkp9d
	7aVW+6JiantQ5ESztUvVwY9+ywIE6egibONeS+D47Isq8eIhxbQLvO7oTSEvsc7VEdHKU799eus
	TRXEBGOm/HvtmwIRXXyVXXhiSf0n+pxLUxyKdLJO34KaOsBzuGR/tHjNsns3XKmO2Vzi80qcWd7
	U+0CU8BJd+b1enakpy8IiURa0B7syfl2htYMISV43TV9ct1+U7HGRs=
X-Received: by 2002:a05:6214:761:b0:8f2:fbb1:cec4 with SMTP id 6a1803df08f44-910d104c019mr49748076d6.19.1788992077664;
        Wed, 09 Sep 2026 15:14:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406475f5sm151951376d6.9.2026.09.09.15.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:14:36 -0700 (PDT)
Date: Wed, 9 Sep 2026 18:14:33 -0400
From: Gregory Price <gourry@gourry.net>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ye Liu <ye.liu@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	mic@digikod.net, david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, rientjes@google.com, 
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, 
	tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, lance.yang@linux.dev, 
	pmladek@suse.com, longman@redhat.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, mark.rutland@arm.com, 
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <aqHZ7lZQnugGJ0ig@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
 <ap76-0-hN6CAcYXX@redhat.com>
 <ap8mgnpE7D4TTrno@gourry-fedora-PF4VCD3F>
 <ap8yoW37GY17pHYS@redhat.com>
 <e618ace1-6a8b-42c5-8a97-44b39dd1a7c7@amd.com>
 <ap-spMNyMvYFga5k@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap-spMNyMvYFga5k@redhat.com>

On Tue, Sep 08, 2026 at 08:35:16AM +0200, Oleg Nesterov wrote:
> On 09/08, K Prateek Nayak wrote:
> >
> > On 9/8/2026 3:24 AM, Oleg Nesterov wrote:
> > >> This might be my - admittedly shallow - understanding of scoped_guard,
> > >> but does scoped guard handle goto correctly?
> > >
> > > Yes, it does,
> > >
> > >> and why it's generally discouraged to mix cleanup.h and goto.
> > >
> > > Hmm, why? I didn't know...
> >
> > Apparently older GCC would allow subtle bugs with cleanup + goto to slip
> > by but clang has always caught those bugs and refused to compile so as
> > long as clang builds are happy, things should be good.
> >
> > Here is an older explanation from Peter:
> > https://lore.kernel.org/lkml/20260327154136.GL3739106@noisy.programming.kicks-ass.net/
> 
> Ah, but in this case the code is buggy, "goto unregister" jumps
> into the scope of __free.
> 
> Anyway, I agree that mixing cleanup and goto can make the code
> confusing or buggy, but this particular case still looks fine
> to me...
> 

Seems jump-out is ok, thanks for the confirmation Peter.

I do agree the general improvement is nice, but maybe worth considering
taking cleanup.h all the way if we're going to use it - that's all.

The improvement is clearly welcome.

~Gregory
