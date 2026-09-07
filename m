Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD33AAF71
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815123; cv=none; b=N4WJ1wQVTH2q6lfkgaTsfaclg9iJop3VP+QNDe7Lme6YkVxZizetcpFNe/NejJ0ZPh6mzCjzd1ERdtWnIpKBlaHWsCqjujiacQIhF9Q4Rme0hCu3C0wXDE0NsJRGPNU+cj3oqQ79F6ZTDWTYSg6mrJCZC/E/EzJMVxk9QMmX+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815123; c=relaxed/simple;
	bh=UJGiGn2L6JlGWKi00NV6I86Kya9Dh8i6c/d0ym4ux+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjnONJOF8f21pzUwcnWSC1CmkEjuFBUV7v1bzSusTn5Yo0rhpmELVWDJDtFHl6HQ+qdSdgEuyZS60HnvbfFYC4p79RHbP6ANyn3dzBkeqmArXauFib1GU1ISXLXtuiZYRcDGywKfLSOLLZ9pkKsFLZzoCT1uWu4BHfcJf8YA8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cwfRj0Eu; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cwfRj0Eu"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-939b8a5584eso35735385a.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788815120; x=1789419920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jr5pTyJqXfvpszR/f6xdIiW4q3ltvvAQPTAcZR/VHKM=;
        b=cwfRj0EuGT8r0csM3DJky7VB9De0Icu2GDXtIvRlZqxLdmvO7mCHZRG5fQbndYJ4oO
         J43XMFZlpeBwItWjZhxc4pdb6mvqQoAAFpPSTlVOdbACto/BIrOcs5jxFZQQnWqgK1hQ
         ocf/erDEK2Xnnw9DctkL/hHH0xi7KGn8bE5SMh02lnmzrtlF711Fl5/2PATJ409jKaMj
         O03gUkpUsoz/Ji6+mn6cRlnTJfEfzElDQPpN82DY4cSq/0XMvxracxiL1DKLVn1zC8/a
         WstEOPvR3b3Y8Dd0nW4ywk6a1VNSWUccBRenO/gnpOABPhyKse8qGBQO0VuJpAXTg6EM
         oa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788815120; x=1789419920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jr5pTyJqXfvpszR/f6xdIiW4q3ltvvAQPTAcZR/VHKM=;
        b=hqBNBeTgqT+A8vGLxYv4qGta2PCgVekDYcfOkn+TXohJq0dh/JfKgMnGUtFnNGSUNd
         HKchk1LH6780uyDYGNARmPalfCYugpl6YXWfMOhyn5JoK9dgpHLVxpIfDBBlFMRBWdil
         v79Qg6K31D+PEGrXXL0GaozqBi0lhrLh3ftY35Q7B6N+MOi6NntrAO84YqYUBubGVzWn
         stFWTu/L/kmo0kLpDTM6hsY6546RbZuTIBQpmvboycnuOR+xCYmc7E9WJdXzI4h0l9+Q
         5zNUk3keHoG6m67HbwaZX7a/FA8FkqGSmJJUUAIzc9tsKMfPQABGR/xBXyjdd0x/tGEo
         tbBw==
X-Forwarded-Encrypted: i=1; AKwUvBx04Sk0p58rWi7FwSABlzMFEFPhUKXtJX5z3Tj0H4CRy5ozH+70pE0mTQ9a1mqww1CQvoxPNGYNzA==@vger.kernel.org
X-Gm-Message-State: AFuF++nnQb+zliX596goFEKyMPR58Up1/Qwfnu+mtlNh+LV7NM79fW5q
	itiwHlkQq+0ef3T7FwNjRC/xaHQIO41QmjGs7TQixp+i+r1jPPPUTraqBAuzZxPHaeA=
X-Gm-Gg: AYBFou355W+ei1cJRAvjn6CXpJc8oB8A2MnhyDwrGmNt/xTLXy5Oe6Y/D71J9xTzI1G
	1uC/jPSXD6GSPsR3B756G5tRVK5QdOSnM90rrUgPC0UQMcN7KxJuvFX3n1ASRgwJFVqVIDRSAT1
	jkNA7GGAlAfIj9GSOauiEYD2QVSg4qW6OrajnTz5fmx0XbcpixsgbYkXgGvAEB2i/wuXQShVvLF
	1MUTj4Y3CdjAnZq6Z+oCzVeHO3f9WdzFESJ+1WiSE/4W5bjPm4oRAQ4MRbtzT35qr8v9YDfLYto
	LZue2cdJlk/oFl9uT8rgVvPfYgChmlm+i6pO9n+9uhLG2JZ5wKk+Y+C/CCVBgYOxOh25PLN8kHx
	m34l3BAacFBWjVhgdu4iP/GX+Fep9cybqJ0rar0GVvHkV+e3Z/PkvpB0c0p23td6nlsVjqVIDli
	WIRBWDi/1DQZ2dm0of564/Lt92yj/KgIRlxpXk/xPeVDCIC/zsR8Z6YOEX96wN9oV29nVZYs3C4
	BrcNe6vAGFwrIQR0692vgcZPPZfFn0cuLAcGrJskzm6c2d0BJ97Mxk=
X-Received: by 2002:a05:620a:404c:b0:939:df5:977c with SMTP id af79cd13be357-93980361c84mr2678122285a.19.1788815119859;
        Mon, 07 Sep 2026 14:05:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399429b97esm677101585a.29.2026.09.07.14.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:05:19 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:05:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ye Liu <ye.liu@linux.dev>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, 
	Michal Hocko <mhocko@suse.com>, mic@digikod.net, david@kernel.org, linmiaohe@huawei.com, 
	nao.horiguchi@gmail.com, gnoack3000@gmail.com, ljs@kernel.org, sj@kernel.org, 
	rientjes@google.com, shakeel.butt@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
Message-ID: <ap8mgnpE7D4TTrno@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F>
 <ap76-0-hN6CAcYXX@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap76-0-hN6CAcYXX@redhat.com>

On Mon, Sep 07, 2026 at 07:57:15PM +0200, Oleg Nesterov wrote:
> On 09/07, Gregory Price wrote:
> >
> > On Mon, Sep 07, 2026 at 04:13:31PM +0800, Ye Liu wrote:
> > > --- a/kernel/hung_task.c
> > > +++ b/kernel/hung_task.c
> > > @@ -315,13 +315,12 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> > >  		return;
> > >
> > >  	this_round_count = 0;
> > > -	rcu_read_lock();
> > > -	for_each_process_thread(g, t) {
> > > +	for_each_process_thread_rculock(g, t) {
> > >  		if (!max_count--)
> > > -			goto unlock;
> > > +			goto out;
> > ... snip ...
> > > - unlock:
> > > -	rcu_read_unlock();
> > > -
> > > +out:
> > >  	if (!this_round_count)
> > >  		return;
> > >
> >
> > The sunken rcu_read_lock()/unlock() + scoped_guard usage makes this goto
> > at a minimum very confusing, if not actually broken.
> 
> I am afraid I misunderstood you concerns...
>

This might be my - admittedly shallow - understanding of scoped_guard,
but does scoped guard handle goto correctly?

On the surface it looks like it would skip the unlock entirely.

That is what i mean by "at a minimum very confusing, if not broken"
and why it's generally discouraged to mix cleanup.h and goto.

~Gregory
