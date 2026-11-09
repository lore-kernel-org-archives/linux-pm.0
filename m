Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239149;
	b=1CQ6S/LUIo4yueoRfV/JJ4QSSQBXv/7AfnGkScWS8t07NF+HGmP9K3YpeY8cKI358men
	 LvIF0w9xVo0EzFPcLki6Efx/yMbzbXsWng29DERxnIIRicpuMJ6nXgQVQl/05scWkY3Qk
	 BkblG6ywOyK9XbZzFsIZPTOekma3T78pUfM3hwj7VkgWLOzeVMQh29YglIOMS76zLzIAY
	 /wu3QVq9gzt5CxHvNLLBPiVjkcS59pgAQ4jruop57UBjhb/3oQGF4dZUWFeTh7fEMFEfS
	 mhaN2GpwfPfOIsXeI6Nn6kw4hvbDkAS9oIoI1otG1cCuixSSHIRrK1Pt3pKOee1OtoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239149;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9Q+7RmGiXiMjZGRgbB4DLZQo/PrtHeW7nZ+vrrlEwbs=;
	b=DKffXfz2PByq3wUqPzVnTpPx2sdThCWoum09w7zYjcgkk99sBAhKNi3AyqhvEyrnqNGi
	 EXixCxeji6f+rYZf856FssG/YrrcVKfX+QYXgPxldXwLZ8BK5h5u44VFyY/lpD5bUKfqM
	 hwTMs0LL8jT5RvY8nrdjlLhX9yuZMzKpNKtFMsT+ZX5kfOIoS5ws2QoVpSrQtiLyI9QSJ
	 ciBSMRVX/brky0MxekIFfA0/UQjthoQFaPW+jzQZ07+njJrMzcF7iqrILZmUnbCCdcyRn
	 pToL+grdfN4Fx/C6e5Q42f6lngPDdrDFVIDzTPROrZkiTWWhAc0KYmMvBg7E96UJ7ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=V+586NAv;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82698606A336;
	Mon,  9 Nov 2026 15:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82698606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=V+586NAv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9Q+7RmGiXiMjZGRgbB4DLZQo/PrtHeW7nZ+vrrlEwbs=; b=V+586NAvw1i5hM4ViF1nQH9Z2H
	64twHzsJNk3IHZBrWoUXQiwDt5YK51Yl2YRB26u8iC0TwIJFvKdzvrW7lXTdbg09fM6oxd5vzX3xz
	stg1z8N+YyWiR3Fp+NvVqzreEOi0x0U8CUSyP9UJ25U3DVoZeusM3VgfcZqQrwvyxhkvGwbfO/YG8
	1jeJFZmSpzMc3XczDenhjezDVMVPzIcWuqYT60CfnGjHgBsrFN0i0iBBXA+21TGWt9V9AghkwHUdG
	MlOxGZkJ5JvBG6a3HJ1vOsNR3cpX8gwTeGo8D5gjPJQ843sDIFjekqIZJ6wx/h41Z0xoJsnqLJKZo
	WYhXXnsA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQRYw-00000006teL-3Mit;
	Mon, 09 Nov 2026 15:45:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 873B230057E; Mon, 09 Nov 2026 16:45:36 +0100 (CET)
Date: Mon, 9 Nov 2026 16:45:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Kayra Cizmeci <kayracizmeci@gmail.com>, mingo@redhat.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, qyousef@layalina.io,
	christian.loehle@arm.com, pierre.gondois@arm.com,
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
Message-ID: <20261109154536.GK1779021@noisy.programming.kicks-ass.net>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-3-vincent.guittot@linaro.org>
 <au38gSTzmvPKmqWT@scheduler.schedules>
 <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com>
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
In-Reply-To: <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com>

On Mon, Nov 09, 2026 at 04:27:14PM +0100, Vincent Guittot wrote:
> On Fri, 6 Nov 2026 at 17:22, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> > On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> > > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> > >
> > >       dequeue_hierarchy(p, flags);
> > >
> > > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> > > +             cfs_rq->idle_seq++;
> >
> > This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().
> 
> I hesistated to make it WRITE_ONCE but i concluded that it was not
> strictly necessary because the READ_ONCE is only used to compare the
> value but not use it for any computation or sync so if the compiler
> wants to do any kind of optimization what we really care is : is it
> equal or not ? so any intermediate value that we would read would be
> ok

Right, so without WRITE_ONCE() the compiler is allowed to write the word
in random order byte writes. When comparing only cares about equality,
any intermediate messed up state is not equal. And since we were
incrementing, we're not supposed to be equal to any previous snapshot.

Therefore all is well.

That said; we should either document the above reasoning, or just do
WRITE_ONCE() and get all the sanitizers off our back, because I'm
certain that KCSAN is going to complain about this.
