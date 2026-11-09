Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254214;
	b=aXQj+LuHY0iarKMxAJWDH7daBJkBVXGnoGA/qTKLTkJcoQDYiKgXTtGuurG+xnONVsU4
	 i4+Cn4F71Im8s4COTNPZZESxj3yXxnosre6/hYwAlYT880VeVFZ3dM5qr4KqXvPVYsyx9
	 WQfVBmqORT/VBT1yfuoXk00RuZqVPNbTJwqpSKz+s+dqiaSoEtu+a3UtCEwepjnOouXUA
	 MdK4PfS6ANz09FhX29UMsTNFpUo1f6q7fbzDKhaDnST2tpoXUeFtkc5t9CaksxaVR+m0l
	 jfjDEuEpt8iEUit7Pr9JdPNEcq5q6umZkDwpWaT1i35oEk/wZ0vDTrXW4UnJpPFB1+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SXqdVx5FuRoJfcSZ0X9tPlMemMPV7a99j+mnsg7v/74=;
	b=UgXZMPfT1J2lGzFPcxCFeBHeGmp/DDrW6Jl0AI64S2pqPd6RuWLETD2RgyaqHwCJn9PR
	 SaAfRhcLIexsBzyBRozS2TqosWDDUnRxL8IAOi9ahA/unCy4pQSTr+pH0OUTNhA+5MlBb
	 NaL757Vd2BYhP/kiAnyVTnQU3EglBQMmVRXy8332TK8mHHptJ7HjZCHKWu3iHtuCLEUyX
	 uklsnxIEZOEozmeoA3xB1or+Q8pkIOyin+sXRjAa6SLmJAzPtquM/FToTWF0e8JMHuTF3
	 kfspKQm+ib+fN7GRiRMRd7gt9/i6X/b039s6Ij9JgQSl1GiSzlUFXHml0itDb1YWwPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="It/ZW3mi";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3B606A33D
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 19:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6B3B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=It/ZW3mi
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a59ffacb51so1465395e9.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 11:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794254212; x=1794859012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SXqdVx5FuRoJfcSZ0X9tPlMemMPV7a99j+mnsg7v/74=;
        b=It/ZW3mi1F849woevc8zv/gjFS2atQmWxScJA3uGW9yGhtBvqjkALgrODpr5oRCPEC
         MyUoDr+R/iIDfTcWKd9MdtvHwSZYj3B8R0a4xKC/1d3mfuUXI6iLh7YLk0DMBiIMNFFs
         PpozlMYb4m3ClOL2tDzFT15WS3LaTB8UenffAhUB5x9+MCz28wMFbnmYEOEgbADzNbID
         gzX3pFb5vPoPv7w0A+bQ/uefxJYvS2YvqU5+jxJpahWy54aYYo+zP9uahZIzxXUH+SzP
         7d97yb5yF1EY3MpCQbTdfThHGNwBNFEmkvQwFeiZU/Oe7kXlWgQsZgEscD89hwMRzs39
         3yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254212; x=1794859012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXqdVx5FuRoJfcSZ0X9tPlMemMPV7a99j+mnsg7v/74=;
        b=xBaS6goF8SUfOM3UnpV1OdqzI671198sYwpbdLTQ22ynw29evYg1iQloVT/uV9K71A
         kFHFyAxlfEDyAJtPL3X+PtVbDO94siX54XcUr9JjYuNpgw8cD6uhrHKkPpUZSvhi5V4v
         vxpDRMvqG5uMTG5C9Lp55+769FF63tg/fd7xWT0Se6AfmgMr8UkjCFXzVx+5CvsJwmJr
         0Myh+rhdyG2Jm+DtPVgne0cHwnOYSzRlciWrWQ+z4pEtnpkvF1tcG6/A7doroPJl4PAW
         oj+GakfcOx6VebdmVGy8NjXUBjqlJhBk18Bs5ccpkHD9KW384T+K8rWv9oPEzYpW+1lD
         8FAA==
X-Forwarded-Encrypted: i=1; AL+hErGqCQWAA7HRWgaOxEh2bw1bQ0AcfD8R4dQLULFLDvtY/uF5iwNqfZWYUQCZPZgeXBDKOdC58jF3Lw==@vger.kernel.org
X-Gm-Message-State: APuU4Z//HUD2f7YOjdfR9kwaaWfZ6vwd682RyZZsqS6FdaCCTgXWJEo8
	T6TAbSBZzMXBpfvaaBIWt7qgJRYOAh/+RMieq0NiE/j9A4zWQNKTQhD7
X-Gm-Gg: AYBFou11OnFH/j/rhYqPsEiBrLPlWmc3mHAXX9U/qUKUYtaJ5zW0vGQSVDPRHKqtApc
	YSHM+ScqvpIpL1x30Dgr3oGgwzREbIONThx7bQPz6kSS2B6zxigW6vSuFXoIcRoiwRCojG1At8L
	I6iXwQ/cU0JgJNPMPmqmWZgOR2AHZnBrZ55oCHV8accOkuyKfhF9kbSLGI0VtakPjMuil6rVWHM
	+C5u0T3Ro3eZJpIVOCimmaaHBquPKLml7Lvj2rAeEcprKP2Ps1pvlyvMyg0qXQEpOwSPbVYpkqe
	Dbk7WstpFo4Gb/AtVNyRMm+SupC7kWZeZKH3aJGnFib1kZjO/ma9TqFIBwZndUlA95FK3lWOerS
	A+Y5X/5qYt7GHFQM+vjATKmyy9QAFBtK1ijUDINSyE261lPF9zJLt602uKmfo7uCJ3uXkkISAaH
	xumeHE0fFb2lw9R4JSNJyhv+ql7gJDePQvIV1h+4i+Dp0BvNbc7MAHeGNr9DDNwkElSH3vOfX4g
	6PdO//sBPRaig3SkxkoQHhQvCaXtjGjgsaiO+WEQSZESPMHIuNmvX4xeOZRcwB1R3p6QfK7EOER
	hyoOPLhOuJrl6kgT3sAEwU+QqwDhjr4HyBA+9QIjkht1YwZLxfbRv6U=
X-Received: by 2002:a05:600c:4812:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4ba0233982cmr3105225e9.2.1794254212140;
        Mon, 09 Nov 2026 11:56:52 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm10595085e9.5.2026.11.09.11.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:56:51 -0800 (PST)
Date: Mon, 9 Nov 2026 22:56:47 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting
 CPU
Message-ID: <avIh4MZjVyQuF6Yo@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org>
 <au7SabL5pfbsApyB@scheduler.schedules>
 <CAKfTPtBfXOcAd=5RkYepRn15Hg=id9FQ3jh1tQoewOtUSrsjHw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBfXOcAd=5RkYepRn15Hg=id9FQ3jh1tQoewOtUSrsjHw@mail.gmail.com>

On Mon, Nov 09, 2026 at 04:55:23PM +0100, Vincent Guittot wrote:
> On Sat, 7 Nov 2026 at 09:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> >
> > Hi Vincent,
> >
> >
> > Sashiko reviewed this one so I'll just put here my own concerns instead
> > of repeating.
> 
> Regarding sashiko's feedback about cpu state ranking, I chose this
> ranking on purpose.
> For !SMT :
> - 7 CPU is idle and fully fits (i.e. return immediately)
> - 6 CPU fully fits and is not idle but we can preempt current because
> of slice so the task will run on the best CPU immediately
> - 5 CPU is idle but doesn't fit uclamp min. On such a CPU, the task
> can easily miss its deadline
> - 4 CPU is idle but doesn't fit at all. This is even worse
> 
> For SMT
> - 7:CPU is idle and fully fits (i.e. return immediately)
> - 6: CPU is busy and fully fits. Although CPU is not idle, task can
> preempt current because of its slice and run immediately on a CPU.
> This is similar to an idle CPU (and maybe even better). While writing
> this, I realize that I should probably check the lag too
> - 5: CPU is idle but doesn't fit uclamp min. On such a CPU, the task
> can easily miss its deadline
> - 4: CPU is idle but doesn't fit at all. This is even worse than -5
> - 3: CPU is idle and fits for task but sibling is busy
> - 2: CPU and sibling are busy and fits for task and like-6 task will
> run immediately
> - 1: CPU is idle and doesn't fit uclamp and sibling is busy
>   0: CPU is idle but doesn't fit at all, and sibling is busy.
> 
> Note that with the push mecanism we could look for another CPU for the
> task that will be preempted
> 

Thanks for the great explanation! My only concern is on 6 and 2, as I
explained in my first message, below.

Sashiko also pointed out other concerns, it would be good to check them
all out.

> >
> >
> > Look here:
> >
> > CPU1: CPU2:
> > FA    RA
> >       FC
> >
> > CPU2 has 1 RT and 1 Fair tasks named RA and FC.
> > Let's say RA is running on CPU2 and FC's slice is 10 ms.
> >
> > And let's say FA has 8 ms slice, and a fair task named TC is waking up
> > with 9 ms slice:
> >
> > * We look to CPU1, 9 < 8 is false so we return false
> >
> > * We look to CPU2, 9 < 10 is true so we return it.
> >
> > But the problem is, CPU2 has a RT task running and we are going to
> > compete with the RT task. In that case it can be worse than CPU1.
> >


Thanks,

Kayra
