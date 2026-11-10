Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794317538;
	b=sQYZ8/OBRPBD8B8ZutK4Csh1S3pY149hIBUZnyzFptfAOK3kzcZsCmOEoOgS6xuchYCh
	 2kpexPqZiX65GCg39YdNJ/dz6GHMkkSATXGxBrvM8UjDXK1Wcngp1IiqQFAJUY9k2pJe8
	 Zi9wNp3IT1LPU8EM6OFq2Um0POHHuvXvxooX8JxSVVUYxt82BUPoGbUE4lfaXwgRDBk4f
	 08z4FZ+FaBrwtYrTv8iBycIiI8F9kJFzd4sk/Bz8XeCLK6N5HsFjianeU3TxsHxircDc4
	 NOQgLsZsiB3kB0Sa2Jlnn+ckES62XeD6YAAOK908YarJgoLXV5qM/IkhgSrOsMA2PHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Pj4rH1eXEm9TWaNRKej2G25c6TaNFuIIDHh9BKw0CNc=;
	b=xmbTgPYbMEjZuU5bMb7vIWjhBQaF/aH1rrsS/gwm1lJIuud/dvjs4fCrSljuq0UqYrHv
	 2cFzRY/HW2q81MHYJ49UJBB2CoOM+PnY+KIcsgTFvMIXjJhw5jB7OJ79IPY2YeDpwBCuR
	 2ajL6+F1dqrd2mPDlmICFLY1rhh03YPIv9d8ZNHIjMTqLOdfIr/zXcze8EPFtm03wqyQh
	 Gh9lTaU5sEqloQD24h4WY3zS7X32uNbvFnwu/T9ktB5j7q+mWqJM3xvMuSkUL/TkHyTHA
	 gpM90CtHLn9oixbzNSoGgQqr4nqtp6oNdkEvOFsU7rccIcL/kN172OCp/mRPitmPybQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AOSlpnfj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61782606ACDC
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 13:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61782606ACDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AOSlpnfj
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b244fb7fffso2492590c88.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 05:32:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794317537; cv=none;
        d=google.com; s=arc-20260327;
        b=MaujHNnvXs92xhl0e8UqQMDxaNqq3bgkvGfJsY3nmzs1gxDnJtbUf4mEEssEfUhMj3
         sw6IssTAEAe7KCYDJoL0LR0SXSTh+l6Ws4S2DNsMGrF+XFQ0fTeI8CCExDRhkw9y2mTc
         NJfH7MmtB7soj66jlsFCMjaRheWGLgawStkbY62QsyqE97vnSUkjKYiSY4VOwATOfIUh
         PBOBP55YL7O8ssolfLoAWtfxwQZNxlXYCZGlXo9NkKOfwcFq/d8FxIKKFQ9MO9vpDvsY
         y/wqZMk+DeVlu5ZNHwtv1njzS+M4trjyf1ZXSijwmlyNXSOKyUaobJkFRDYwKzedHaNQ
         wfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pj4rH1eXEm9TWaNRKej2G25c6TaNFuIIDHh9BKw0CNc=;
        fh=m4lidOJJWHBT6sldgzPZaOIPmNM2r7iOM9qWGYrzuI0=;
        b=P1owf8glDvIPxt3Oc3++SVA1+hzr/inz2CEfOZaOeLogMPSY31+TAirb2ui2Av+F5D
         OtaQL+o1HTuXqDY0G3OuJbN4bRPAplRC8CaG5OvZv7LBUAKkoPBesXNR4mrWkkqf1JYV
         24P8/AV1IUiM1zXaluk2xtNEkIf23cfg/GQfl3TrBu4RTAFY0QnTqQKPD/uWGD5iLDQN
         3VgKVuS9JaTl5f3YtF5Lceu1c96WiTAbmU/hRQ5B+ZoPfREpn6rapg2tdS9eUAWLDLVI
         4xnzLDodB7e/5q2Rn2Uv+mQ0L15nwjyrUq1ee1dBq79jueSURhe5l/6cGyu7C9xzX18X
         fGJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794317537; x=1794922337; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pj4rH1eXEm9TWaNRKej2G25c6TaNFuIIDHh9BKw0CNc=;
        b=AOSlpnfjZLSdTii0+zDJrGn3cSjSlOKo01Bh6g/kFMKvSJ+DKq4x1l7SMLbeXpk79l
         3XWUq4INy0Oo9JBLC1491DiVPdhcxFeF9kQ+sBxrZD/39kaERAbhLvmdoP/LoT9jPERI
         +MYoqnOeqbXh/BRaZ93A+LPLN/1Ir7kG3cM/Xrvm5w/5y3OMagRaHGRW8VYyu+Xt2Hkd
         UVeiqRhVft42tCfpLwX1Q0L22lXby+7lchvA/nmYlPb1V04ePyu3dxYu2PpAzuHZCoS7
         aYnAcDdDkRF9cZDwn1D6moy7tDRvGM8p9KIdGPxR66oTIo3P1w8w5GMR0WKNi/mf4mA9
         F4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317537; x=1794922337;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pj4rH1eXEm9TWaNRKej2G25c6TaNFuIIDHh9BKw0CNc=;
        b=XBEJHUupDyVUo3Q43kntHPijBvwcnRx6YTq+L/Yl/+BgLV4mb0nPh2iAE+ZTDj8Lfa
         oH2pACKCTgv7ZnY84VXWEnkTWSlGgy2VtJBYh+BcpnsOOzFr5gBT1KrHcjjGntux7vmr
         sMkEbYQBzrgHrpyEy+MYpQvWQMAR0H/b+Wj2O3V5PaH50g2oEp0ht/9v2XwI9hYcdZtt
         fT4QvObOJtmRcRZkn8Mx+PIgFiT8cTmTqIjWw+XBgFtSncUe7jw23TqkQsAPWRWYd8BX
         W5NUPkkdyvuFvcPchVwiedw6Q9dCuxMqzOkdAvmQv2Df/2b378gsThFeKQgr/muEphLu
         CGmw==
X-Forwarded-Encrypted: i=1; AL+hErE/mELXqxdUA88CcfS3kTqQLe+zO+EWNakT3NdqT8RmkB4R3Y0rcSJ3MdNHL9cJ3apNqe3+cfUh5A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9zlHEh4qoH5evdOHYdHdf1oqeuQ2yoNZ1xvWYcGz3rq54WODBl
	mzFnlzbvNjIjhTCl7V1BJ25/UYqe9UUz63/cGwPM8yeY6FbCXZQmndEo4+SDY98Sj+wIj6ovZXo
	7R/tea67V5QZqQHjlf5GDG3q0F1KeqmOA72KXvgOPJA==
X-Gm-Gg: AYBFou1OdVlYld7grW2e9KZVwpsbHIJvtgs+7xNxlYsmyJafDHzK5Zm/z3ifnCp+cuM
	imOeH2aWcWk1/xuJJbMi1gZwhoIQniXKs9hzjSkisb+lcFm/yyw/QW1em1vug7t37IYcMM7XM+8
	X07zDJCNOuEkUBd9Z0FotVPoWjZs1VrgXiP1xcxBXhW1Ayx6HLhoGjK4zHEs+xVEREtTCfgK8nW
	2Kr+LGx1JUT5Wpg41sPZ/EV3eT/u22WqP0tX+PgoodpGWHR5a5lvz6NZviy+9NVsCusjSQh8vJ6
	iTTjyWzElTDjG4YeG9Gxss0tigW/SRk4Gx/zjaviQYDu/44Dx1GL7Pc+qXvJAs+bKJCTQJGo1EK
	XxhhwSUFjR8w40hx5AA5YEKDr5dNuZfT95LCX/cU6/WdT9YhNaU7b5tB4pjO2PkPqi7rwVw==
X-Received: by 2002:a05:7022:7f01:b0:1b2:43ac:d3a3 with SMTP id
 a92af1059eb24-1b3b5fee2aamr3361789c88.24.1794317537291; Tue, 10 Nov 2026
 05:32:17 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org> <au7SabL5pfbsApyB@scheduler.schedules>
 <CAKfTPtBfXOcAd=5RkYepRn15Hg=id9FQ3jh1tQoewOtUSrsjHw@mail.gmail.com> <avIh4MZjVyQuF6Yo@scheduler.schedules>
In-Reply-To: <avIh4MZjVyQuF6Yo@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 10 Nov 2026 14:32:01 +0100
X-Gm-Features: AclHuK_-u2urQ3RFkBLSdBCNdaeJlRcvSlcfMQXUBnI1scU56PsAWcpbh6wLOOg
Message-ID: <CAKfTPtALwo_aQ_31nF631_7hs1YfYzNUXdY1zC=jUB7P7_QRmw@mail.gmail.com>
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting CPU
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 20:56, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Mon, Nov 09, 2026 at 04:55:23PM +0100, Vincent Guittot wrote:
> > On Sat, 7 Nov 2026 at 09:57, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > >
> > >
> > > Hi Vincent,
> > >
> > >
> > > Sashiko reviewed this one so I'll just put here my own concerns instead
> > > of repeating.
> >
> > Regarding sashiko's feedback about cpu state ranking, I chose this
> > ranking on purpose.
> > For !SMT :
> > - 7 CPU is idle and fully fits (i.e. return immediately)
> > - 6 CPU fully fits and is not idle but we can preempt current because
> > of slice so the task will run on the best CPU immediately
> > - 5 CPU is idle but doesn't fit uclamp min. On such a CPU, the task
> > can easily miss its deadline
> > - 4 CPU is idle but doesn't fit at all. This is even worse
> >
> > For SMT
> > - 7:CPU is idle and fully fits (i.e. return immediately)
> > - 6: CPU is busy and fully fits. Although CPU is not idle, task can
> > preempt current because of its slice and run immediately on a CPU.
> > This is similar to an idle CPU (and maybe even better). While writing
> > this, I realize that I should probably check the lag too
> > - 5: CPU is idle but doesn't fit uclamp min. On such a CPU, the task
> > can easily miss its deadline
> > - 4: CPU is idle but doesn't fit at all. This is even worse than -5
> > - 3: CPU is idle and fits for task but sibling is busy
> > - 2: CPU and sibling are busy and fits for task and like-6 task will
> > run immediately
> > - 1: CPU is idle and doesn't fit uclamp and sibling is busy
> >   0: CPU is idle but doesn't fit at all, and sibling is busy.
> >
> > Note that with the push mecanism we could look for another CPU for the
> > task that will be preempted
> >
>
> Thanks for the great explanation! My only concern is on 6 and 2, as I
> explained in my first message, below.
>
> Sashiko also pointed out other concerns, it would be good to check them
> all out.

Yeah, will fix the set_idle_cores too

>
> > >
> > >
> > > Look here:
> > >
> > > CPU1: CPU2:
> > > FA    RA
> > >       FC
> > >
> > > CPU2 has 1 RT and 1 Fair tasks named RA and FC.
> > > Let's say RA is running on CPU2 and FC's slice is 10 ms.
> > >
> > > And let's say FA has 8 ms slice, and a fair task named TC is waking up
> > > with 9 ms slice:
> > >
> > > * We look to CPU1, 9 < 8 is false so we return false
> > >
> > > * We look to CPU2, 9 < 10 is true so we return it.
> > >
> > > But the problem is, CPU2 has a RT task running and we are going to
> > > compete with the RT task. In that case it can be worse than CPU1.
> > >
>
>
> Thanks,
>
> Kayra
