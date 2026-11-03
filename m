Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726847;
	b=gMix2GSKXac9Xsgxt9v00eDA68Ys8k0+jDo8TFMAQvjPFXa1Qedah9PYK2GpyuWokgdf
	 L7ZqjUVAWX0Fm2cE7ydTB1KDnxBBGiLAb48jjNuI3wdghbWgQGNZcgffEaiSyLnIetw4s
	 Ndk6W+s5ijNcA8vohhCQ6kTlkk/F2Ey/AVtPhpY4SI17EdFsRUr9JihFgl4X3Weij5JQr
	 qyb2+kz6kjC6CSaFM2tpmQu24pSTrUWJJktJZcaCtGiSIxLs23YYnQlgGo+sWr3hl39w8
	 5xg9WytPzbjmd02cujmEg/6NPiUzXbeDg8zYgfCgai3r/euq/VOchEdBfrzLAwX+KQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726847;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=BkLS2SIqa26DAJvyYtdAAEyEslt+DE9rIsGIX6d4NyU=;
	b=xCI1EoJMOaXDC6nZmJbrjzLMqrVePGMmT0NKmjcedzWk98lTRay0L9Jb0ck7ufEXKtM6
	 Hw0xitxZqpNcsceVSEJZKyij8Va5mnBNuNqiJheLu/SrggUdbE5ZmLn3skvxCTtG0pOMT
	 y/WfPB4TgHXh9IkxeAB7ehzxCkPV3thfrnHY4EKC8J2VDRbMhHQNP85Ba+v80GbPW2ZzX
	 scce14enktoUKIP/1DWphf0HUxe2Imdtz3dGjWhME50rTd537gWY7TnIzTA65AY3gUF9P
	 44P5/+pGgXvWbhi+2j+T2VtQa9uKTyl+a3NQKa5oHEI2NxjCyKSuUytfbQVxa5RqGwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=efault@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=IODDDNN5;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304B606A31B;
	Tue,  3 Nov 2026 17:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1304B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=efault@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=IODDDNN5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793726837; x=1794331637; i=efault@gmx.de;
	bh=BkLS2SIqa26DAJvyYtdAAEyEslt+DE9rIsGIX6d4NyU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IODDDNN5hmPeMiOHiowQgFUuyXyGvpez1jS7N5ygl5ywCckOoAYZlVhsxL/yAXXe
	 82CUYbPLRAtkxkmJ4y1OBlqTze+To41N8fZa9rRQNaORdhZyMbnVOPht0Z7OPRuas
	 +dRvXDZitb/8wUJEqX0aEtJvR50tnAuJ0ICDNGkEXthEdnk9L5d3qC5YgAsHvYixP
	 EVF+V9O+danb9Bwfe+ivIBd/hug3u1RZ9M6piPGQ0eHH1NE0xsNAPSXqygNZleMlp
	 x32t8R2DeBHFgJOtVOwiaTOjf1o0qk4BgwTBIMC4EPGiiHJH3ocoobaAgGicJtK/3
	 DEfpmYPb1enBWY8VOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU5b-1wtLJn3ueR-00pa8E; Tue, 03
 Nov 2026 18:27:17 +0100
Message-ID: <25edb6cd36cb77b82b40826b97232438f1443516.camel@gmx.de>
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms
 behind another task on the preferred CPU while allowed CPUs are idle
From: Mike Galbraith <efault@gmx.de>
To: Francesco Nigro <nigro.fra@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider	
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>,
 linux-kernel@vger.kernel.org, 	linux-pm@vger.kernel.org
Date: Tue, 03 Nov 2026 18:27:15 +0100
In-Reply-To: <20261103154603.1893325-1-nigro.fra@gmail.com>
References: <20261103154603.1893325-1-nigro.fra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Provags-ID: V03:K1:4qfENnZx78nekm7mnwvFWvli+JAlpFg63YBG7IRCS1GCb410/qs
 ES3lAuyr/Na/Lpa1olY1qqF5rzpVwp6DP7lXzgfJIJpbBP/ujuMflGpc9ovdLWaIM3y4Yx6
 IKjCwOut+1OTS+hilY3FaqNaFHAJmf5Sh7OsP+pJr550kJJ+5FAGLxqohlY29ppby9JwhF9
 iU8eFxK96U2ckZJ0D+GbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fWufWYc+UxA=;sgTucUChyaPOMmSf86/F2KwrcBm
 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
 a8FTv8Jucb1kWVhk

On Tue, 2026-11-03 at 16:46 +0100, Francesco Nigro wrote:
>=20
> Related, not tested here
>=20
> =C2=A0 - Mike Galbraith, "sched/fair: Dequeue sched_delayed tasks when wa=
king
> =C2=A0=C2=A0=C2=A0 to a busy CPU" (tip sched/urgent, 2024-11-11; not in 7=
.1.13 or
> =C2=A0=C2=A0=C2=A0 7.4-rc1) and its V2 thread:
> =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/all/bf4f50886c462ee1f33cc40484=
3944fea4817616.camel@gmx.de/

Mmm, that's a be careful what you wish for thing.  I flushed that one
down the toilet because while lowest possible service latency always
sounds super sexy, it has down sides. Rabid migration does not do great
things for throughput, for instance, that patch slagged the throughput
gain for tbench that put DELAY_DEQUEUE equipped kernels back on par
with pre-EEVDF kernels.  Not a keeper.

	-Mike
