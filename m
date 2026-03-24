Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55C42AA6
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316851; cv=pass; b=UZKgcJDDcvVm3CwWSc0i8QZuDGx66xFW+N1HBOdlcmr4kJeerzEqoknixzyFzxcWKWOrnTkmlOhbCjmFFVz1W3cR3JRA+8HTRiaDf+pdN3KxUEyLyivPuT9rlgXM1XukLX0NWDl7O10LJmKtM9UGAHoVzN+7o1gFgNcY/axE0HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316851; c=relaxed/simple;
	bh=MUfi36ea7f/nz/pbaSwAf4o+ALXT/+r3vcfoR6Zt4jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dnd7EkvOx4jLfTthaS5m/rzm5Y3rT/Jlo6OqbWJBPWoONjWlL8KmIKzMkhdPujihg2VF2QjEkIpZM5DVRAxZcz93rHvQWWDjvGqRC2913S3p2JwHhjoIzs35LHMbyXm65SMWhxLsWL/lhW60OQv999zoPK+1PILzeD9u+fCY9/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2Ra53+w; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2Ra53+w"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b6d9c981so3265278f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 18:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316847; cv=none;
        d=google.com; s=arc-20240605;
        b=jes7OI+nU1yQLECcv9ksOZiCkKUSdhaSEZEmYNJONxptmVJogmmTQLAXS8uQoNGbDP
         JCiUIs/W+B78w8MDAl1tE4Hojaxjg73vUdRWMvwljPQrQ+ngIKMeHyZG4YLaqC3Ay/Si
         izk7Bdgq6K7a9gNagzKdn/Cy+Uxb/kWtHKxN296Qmh7ctmkuf35WTMykDHjqCRvyU3ny
         q8J4Nsx79WEgin/wLuCwnKTWpHJBkzNxWVJmXADvnukYE5DWwDbGtAzfM/YUHQkUaY6g
         CkOHQpab/q1gnKzM2D/27YNTH+JUdVMA3osFKRs7qZk5tZPXiPthJLsmFdFy1esICZ7i
         0H8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        fh=cwTevik6Hl/7EASeQxPzCgClDvELvj8qgdnu0dfYNhs=;
        b=FRK7TgygL2vg4HZSL0I23mOrZirZWSzZbv0TkqKw4L204tCZ7ruRv+ac4sZQmcX3Vg
         H8Wzj3FwW2UQ/bYkdtrqh4TxlT59NhWlBZD3+F0gLU9leCHhh2VNrzvJadiN+rmSnBa6
         zcuKdpR5TtHN/h5oeBl7L1hlo62lkwliJKpGJurY5tn1tK9a4zsLqEZkta+YY4QkPLxX
         7H62huacSmmuz9uf4eIx2+1VIGZrDBlphg4ORZ8qSdNpyZ2yP9kFVRtjDt+d4LKnaLbs
         XuIqjardv19ZKugtOCKjNFmqFk9/CEgXf9QaeySruT/O6aKCLcCpAaZDoG1AFDxK89w9
         voBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316847; x=1774921647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        b=R2Ra53+wTqe4fKM0YowcYvj30AagsiIUCnlyrF/Byb9Z7ZfYIYs1cOyvsTQT9KtaBe
         F29JEmIo0dGfEC7ePCHm+PQ4vd5ldCNJcs83CyZxvRRNHOjFUDm6mNIEG+kGrPN80ZYo
         H6JKZBXZhk9U7DUdGSNIZmEAu3gRAItOfACzkPfXwh6U9SAWZMeYejoOrM0cfSAyALfD
         vKbkSp9hkqQfn7X6YRR2++cVG88E2eotlNTmD+owYMGDwBl0aoXfDhomZZUjGgsOPoew
         s/B/SeMJL12hyK31kgSqu8WBOjnMmZl+zIDXL5f1gLFgdwX0Dr0xhVWDH4PqAo8nSRrT
         5nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316847; x=1774921647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        b=nqe3R3NZDAYQ8OwVQ1iVZXK7j35jtazOh6JzgbRPPWh/t87ELax0U4WSd1KwL8D/+4
         IWnCvd73YQOhxkcOBXvBwt+ajPpvnNGOK4Vt86g7DIQfF8iinxLVXXIQdonnMFMA3vh3
         A9r3yPBNp9RJwDT+1GkoqHEj4N4V1kZpiWfgLd0NTElzLoJgFnAJlHtXcKbgXOnhZnMC
         i4Z/3l8FP64XfPqPru9u7xG26YZVX6qUZ0EZL+DkefErNolc3pXvN1a37hyLOP7oqVoK
         dx+QLx8lW/XxGngAPiw1iJ3HnPne3JTUJFI83nZYElC/o/qEQxpTnSyzcdtEN5EDZFt6
         mGtw==
X-Forwarded-Encrypted: i=1; AJvYcCWviOznpEwy5waW9xUF/sp51INfnrFoEA3Px0pBqalszm+ko81unk5rprvAoiRawZKFo3aW0RzW0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLeVPdIwBpmIOdWvtNggUDPrML1WTTSlGzVZ06si1BK5iQsHQ
	l5QOurY8JNrBSMmDVFFych4PQOkEQgJhry/ws1Ya/E9/SvvuyyS+9jqb1N0y0h9uYfik8qA3oHi
	hOf+Abx1VYn38Ig/xP/xzp8rD7pXfVc8=
X-Gm-Gg: ATEYQzyPmHO3pZIPPHKsm79NvgmBS9kwD21+IqBKJhzFkqmaXJg8I2gco5nphIMx0Jl
	2QRvWFHdBtrhYpwL+8YKMSUTH9Q7tFQ/gx90MXzTPoaUwR8RJwmym6liHpRX62A4z+RE0v0YHj7
	OYeBd1r6HtrA+edVeec5yJrV3GYRhlrK5g5W7/D1KY64Zg4DNCowGowEvRJiqGlo8BdBYkYGTud
	hSvpr6AF1q8En5iRo1rqW+by6pvCPVIA9R9OGkw37raydBCYBlKjdr2P1ryCJj1kzrYlPySKcc8
	mz4m1u9k26c7i/5gXr8nMJdY0iosGMLmg5z17kuNepDZzgyywF+zMLEps7A=
X-Received: by 2002:a05:6000:5c8:b0:43b:4951:6b37 with SMTP id
 ffacd0b85a97d-43b80592328mr2021634f8f.15.1774316846771; Mon, 23 Mar 2026
 18:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-11-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-11-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:46:50 +0100
X-Gm-Features: AQROBzDT8zHTe-cnXwc3ToHi1r8Z06VC2JgJudU67Ap-gCTlXPytLAmMbqYbD7w
Message-ID: <CAP01T77qL1SF_-FFjbT4wJaYAe8g3XRNO0pyPs9c54qdcN5MGQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/12] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, rdunlap@infradead.org, 
	david.laight.linux@gmail.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> Switch out the conditional load interfaces used by rqspinlock
> to smp_cond_read_acquire_timeout() and its wrapper,
> atomic_cond_read_acquire_timeout().
>
> Both these handle the timeout and amortize as needed, so use the
> non-amortized RES_CHECK_TIMEOUT.
>
> RES_CHECK_TIMEOUT does double duty here -- presenting the current
> clock value, the timeout/deadlock error from clock_deadlock() to
> the cond-load and, returning the error value via ret.
>
> For correctness, we need to ensure that the error case of the
> cond-load interface always agrees with that in clock_deadlock().
>
> For the most part, this is fine because there's no independent clock,
> or double reads from the clock in cond-load -- either of which could
> lead to its internal state going out of sync from that of
> clock_deadlock().
>
> There is, however, an edge case where clock_deadlock() checks for:
>
>         if (time > ts->timeout_end)
>                 return -ETIMEDOUT;
>
> while smp_cond_load_acquire_timeout() checks for:
>
>         __time_now = (time_expr_ns);
>         if (__time_now <= 0 || __time_now >= __time_end) {
>                 VAL = READ_ONCE(*__PTR);
>                 break;
>         }
>
> This runs into a problem when (__time_now == __time_end) since
> clock_deadlock() does not treat it as a timeout condition but
> the second clause in the conditional above does.
> So, add an equality check in clock_deadlock().
>
> Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
> the spin-count used in the amortized version. We only do this for
> non-arm64 as that uses a waiting implementation.
>
> Cc: bpf@vger.kernel.org
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
