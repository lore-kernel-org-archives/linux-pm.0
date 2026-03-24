Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E0373C0D
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316660; cv=pass; b=bXD2IhVYdDwhfHI2vmdvCqwfU1TNUWc6iM0d3mqLuEvAH9eN1P6C1W3krnTw9Ld9kDGnGhbWsGgJYMP7ECsS8YJfvm9uUAGCWP9gRwENO7joyJFVKzQU44LRlAlk3soIy4tqyQ7c79RodVUrARMjaxDSJrvJGTJ49U63fuNGi+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316660; c=relaxed/simple;
	bh=eN9OIG5xOOm08psjunbqUmZwhSjm3/YrUhUY73RH+vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyY6h5S/zAOOdKIEly5+WjTe5zjtxVemV2aPFWx6dBr4XA+HtA5gCu6t2Zaz3/cbrONOWrnvOTvT/vKvyp4gUnK73Z4pXKRmob3EXQzZMMlvVVhOjpJ8704UIQBH9tGU5s798WIFQS4Yx6lDSxGF3os6drg9CB/0vbDLplRfE18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPb4eVII; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPb4eVII"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-486507134e4so8444205e9.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 18:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316658; cv=none;
        d=google.com; s=arc-20240605;
        b=JxTduZR3BUBKN1IxNNAnI+1YnIkTB5MOP+p+V+FaahLCBYGVzcmA+98A6qyC52Apc8
         kX6ooTrNQfhOxySZRQyOg0pdZ/C1P1523TcvV3gN003u0WO6njSsLpzdGN+eeRqFEyMy
         2UMUrXsXDFRtksm/ousXIdc4IKczdzJ3UkMdXc48UPvsA/Fa3Cnc7e6MOJOVLCWLOx2b
         GG7TO+x00uxmgVsfdYX4n7lf3XazZ2J2h0NpjnjQi7ZLCKr+5sQ0XMBuaXUUN7YaXEZp
         tXQoFvC4TEPL9s+4YucIjegYEJ/z1YcXR7CT7ocd9fmeDQv3CYWA79WoHdTCjRYXewus
         aO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        fh=y23fjeljXQMEvIijbHN53ysdnUruDKgTlFrbekDbV0w=;
        b=kKvLX533nEJa3EAh/xGmjMtvSuzWK63oAof/j+a8dstAowsA12lCgaOVX3fKTVUDOu
         uPDqCaFbAa+0cVgJRDeeAxdeaWWxzIXac7ofuOLxiM/vobohAbhaQfKnCqTbTCeI+bkL
         6UoMAMofp6cAMaVgUxfE54998Y4gevUusuJJgUGzMSS3h9kdbWCaNEDbI3MTOMky4kv8
         uLpkeLLj4zgIso88RLGemj62SDEWhYG/GgWYqGuQXbez959EaTeiPMXVlbJrGM3oBf8l
         c08NsE5yzvyV7sHV1MsPHXuhqrfoPAt4JcOc3VrI2kg5+Ivpb1pxAJn1KhMpFNQO6lFv
         uXHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316658; x=1774921458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        b=jPb4eVIIHRjE9jzQDGBueykIWAA9HXpF4HGgKP2q1MMiPx7xyajGSko3S+C8DucWls
         RqW3SYLm0yE3Gyrzx9Qw3ert3hXL6JE7KpWpFmxONN5ojo/46Dpg4aGbRGHDZpgxk00C
         YutgLpox23Nxm9XuRP/cmF9PIt7sBekAEuX6IbgBOsZX4sO2em8TX6bhKkivkg+evviR
         m2lKnrJm+7d6GXvn3Ry4bs6pF3NjxYNg1JXaKIZiwTE9Jdaz4ayQKMhOck2dO+40Bwei
         bZ+0iqW/mNgXU0sBKOI4Gqc4dy69+pOORiWiaoTg+PB5yVX56r097PjAdoI64zMquA9E
         aXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316658; x=1774921458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        b=GvyIljwN2iQNPz0WIo6EvxkTK+6VhlaQCSGt+fPkl70lilm984Pv78xQR7cSGlEe2J
         AzGM7Ua1MzgXtG+A5Ugiv6XI/ZXmiyGtsOb0QITd2ma5cp5Bma4HmXuvkImDHRWOVQpY
         x/LYtoB1P3NQv6MHQaSH6ajVjmnBuUQ7UV193HggnOA7S1N5BAZw/2nKgWRu1C1WdxZ2
         ndmJWxZSnU2BckqGBFzr4r5zmrS63fes5261p9nZRc1CuT9x6FuoC3VVJmYLgM93h0eF
         4qxXR3euLqfjK2Y2wVLQthnf0P0rRt1q2ICaxtinIAHi4Vcidcz9z5KqdLNquUEluShn
         VNbA==
X-Forwarded-Encrypted: i=1; AJvYcCV8XMPPO5CJfKJixZ/IiRkFyLEmJo3ohfhb9QTcvSpJ1JNikPJVMToXNnKA+iMyL88elpMdY8NYYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZlbzvCJ95L3FeGxRjVbXjR8+UnIu1Sw7EzJRlScq8gcD7PHC
	/CxThytrNtc0WsDNTP7TpsY5qQpsOJtNM/yg4+MSVoafW/W0rqhayaods6IQw5ZAqsbf/RJ0KoQ
	myzPLt2PqkEMKApR1BaXt9s8e4FOyURU=
X-Gm-Gg: ATEYQzzS9R2ywH6YeTUnFOfHmLPpovno+mvrRq7Aq5RIExLHEMLtI8WD3DyTD8Yd3Wb
	QrpVlY2xHAEbJGyWhLiWp/SteK4/vEhZoIcnRSNc1X5GzP9K6FCZDcRuOkIJr/pynvBXS6LjqfS
	nQsrs6WwZWpIiFDVLqENNEIBVHRRa++hIur0AMJ1OzU54+dESMkcA8dJXAJWthZiu8HmcT4UUHI
	tZ1lysK+AIpbnbZi+NsWdmoRrB39ZidtNDy/cc5HA5kTTnCnMxGHppIyP8Gw37u7uz/JuEq3RTC
	E2wncdbXWBP6pBBbZ4bGa/fDSSWLVPrZL/tNcj9Dx4Eo97dIyJK4AeMxRlc=
X-Received: by 2002:a05:600c:3554:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-486ff01cc5bmr205204065e9.27.1774316657635; Mon, 23 Mar 2026
 18:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-10-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-10-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:43:41 +0100
X-Gm-Features: AQROBzB_vyabm8gMFgwrt-FFA5yFnsEMVMsPubU3mf_XijBG48EgQr58mCqMhFo
Message-ID: <CAP01T76iJAtfovOAhm+9-QwtbVJRbiQgUPWLBZZXYFozLFK=uw@mail.gmail.com>
Subject: Re: [PATCH v10 09/12] bpf/rqspinlock: switch check_timeout() to a
 clock interface
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
> check_timeout() gets the current time value and depending on how
> much time has passed, checks for deadlock or times out, returning 0
> or -errno on deadlock or timeout.
>
> Switch this out to a clock style interface, where it functions as a
> clock in the "lock-domain", returning the current time until a
> deadlock or timeout occurs. Once a deadlock or timeout has occurred,
> it stops functioning as a clock and returns error.
>
> Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
> when updating the explicit return status.
>
> Cc: bpf@vger.kernel.org
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> --

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
>
