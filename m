Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CFC379991
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615843; cv=pass; b=MpLXJkjnVTgnqARbrb2UIQK9M9x+KgNV+zZea6hDCl6EHl8tzBfeLmMdLTSGXKZSSWqmbBRhIBttVG/LACtGYupTyolASQlCCwWvTS8OmQ2hvdaHkrLSdfpXcXn7zs9hoR0xpERv47QO6kJd4qTsqUU6VpZvepQ6H7L4hkhLDoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615843; c=relaxed/simple;
	bh=UyqntIiPxC/vJFVio3C1PXsVCPlN47xjv622T7oLz7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1zrTYpoBiJwenvXHfv9fRzFz5ggzkV5uD+ssF30v3MfwKOHsVMLqdUT04Ozru9O3rpxBY2btRyjUPGEWLmijkEPx6mIYoHIuiz6R6ndrnYUX4wEOYkuxY1SSMkKY68uwyadsxLdXDshv1c2HiV9aIhMLksZXEYSEr8fq7nlQBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdlq+bpe; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdlq+bpe"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff23d81eso2777835ad.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 10:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615841; cv=none;
        d=google.com; s=arc-20260327;
        b=mspbzb4qwSoIfkUAC7mQsC5Ls43eYUdT/YrRicEyJIIavSwC4YYh+nFmTbMPnDL47W
         gQeLTmI3aP+34E10GfaBm/z8A1Cr+CwZ/OiDOjYl4IEzIDbBcGs8LelW50CcQr9nQMj6
         +BTmIeDwEcio6VgwAFm3nS3hj4rgbMzlcroBiep9vsIkNLg9E04/SkeaICy5lUwllzoO
         pNNVSKb+4Kg6holNV6cNEBRLpsQsz3wZ1HtV/3W/CcX7DKJNRz/VjzLqbinFsqO1F0NZ
         25EyY3BvNt2MSB1mAgkXkFxKHXD7SRdatLdNfscJYQZf1iwxdnnE0l/R9Py+jj5TOdL1
         JAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UyqntIiPxC/vJFVio3C1PXsVCPlN47xjv622T7oLz7k=;
        fh=tVBKQDrpcvxuA+rxzwytufTdFwSKUpFBxkz35KSL0ig=;
        b=Gl5B4JUTpIr8xXYTdQv+dbEvvFqCdK4kHXn2/dVFaqg/jGb7MIe2TiBBzgq0t+nQgf
         2hhcOw9xHUx5yLZEJqjmsbFsfQ0Ku4L9wbjWJWk/uP1pWWeMg5Z14/YZdskYMIT/1AvQ
         tlbqd2Da3P2aA//q+YVWQD3e6ja0JanQNXA0I1is9NxXYzul9v57D6o7TPXIg+oA1wLK
         zTx8CRKjQAulTG67YGhHLLeTe2dhWxKN1qYPThUo4Xw+r6BOMBuMUbgiFDHBJrIDwqy5
         I4DDddFvJGjU0P1ptGPh7okLShPLczIBRnlt5VtGJ0I+1JBJCO2+pHkavAJKI1cqqLot
         yP1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615841; x=1791220641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UyqntIiPxC/vJFVio3C1PXsVCPlN47xjv622T7oLz7k=;
        b=Zdlq+bpeL+kRHts1FA6LBO9vO6RxDaEwHIGmOpHPWL3l2+EuzQwzRSocuwCHg4BfPJ
         MrRM3yq+HfPcaCIN+cbpWLMNKHFB5ZoFwoCLuc08/xk7Nx8oiIL2E80964/A8hzTMczz
         +O+HpCjbB17ecFv+VEx5gu3QznWMkJvC7dw/b/54qseP7BKXxrTN4WjQjIgP6KQV/ugK
         0inB95S5ds9ga3Zifkz6V8JgT2i2gBoCIpPWfTIsJjtnVh3snE1we+84DssT1rz4y8AI
         dB6yNa6qOX1nEkTvfAxs9Q/G8lRTf3JKahUbN8WYreXFKOeQpcbypL3sPlVNXR0Jxm0X
         CeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615841; x=1791220641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyqntIiPxC/vJFVio3C1PXsVCPlN47xjv622T7oLz7k=;
        b=P/tba9ERnIFifuJttkM2WcUz54/pg4RDmEIQNf878QmsS6APfJ3FH3/ZCZeD1+O9dK
         Fyxvkix60y6Y2Z19Vu7YWOGgQBmZSBY/YxF/tcIiyQ2IMRiXmKQcPII2vEMZJDBquynB
         572MtrKZMwC5HF6n9uu1BSzEL+7OpJx8GYpiy/DLPuqFoHWoxQSbW9lLLYRfOTz/2JUZ
         wLolpm2aerEqkkJhUEfrCJ2q0vKIswCVcCQpPdWfQp5WV+Un1ppvwYsUM4D0z8Pi/Qxv
         X8AMh9lEobIvXwxUWZrzBAwKBpL/isn7WzjezVjUXErj37t8RZaAbE1jN89Oynebycp7
         ttQw==
X-Forwarded-Encrypted: i=1; AKwUvByZpGyDRb2kcH85ewL4uD6Foe2BuXvw7obG3c9yogXSwCjxoPQB3W6+uv1gf+2G6BgzEWMZgeBLqQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL9ANRsr2zGZZ2iRgmmcO3IHQmAQsq+eh+/pI37jqBs0qtBuIxu
	/POnqgUz+IL97cJNFn56XeIS8L7Iio4Ep83BqjsiqvlLWcV1EeEbIjX+HsKRZtGe70H2jq/U5BL
	yNQAbuMjbggWLZYHpID73XzFAaU0mYMo=
X-Gm-Gg: AYBFou2yLydJkfi7EjcAG+hdZ8OhcfEvwHf6yJ01JQTCEdzKhiKHqLHVcXDD+K2kuuj
	epFLEWeD/Dac0fQArIQOhNkwF3lvp338bZ5W9hBK4ZLSftuqT4drYKbT9oNrGapAuezOqLbEx5m
	fAqPmcRM5nrVWyGo57T1Jj2q8O2K23R0Q4BzW1nzyFnd62yVq9Or8jtRbTmw/5gQFm8Ftj7tc9g
	X853sSnJPUAYIQjWjNNzRKe9Tjm3Nd3L5AXjNzJuYXkeGDw3QgdbtMbsg6+ManZdHwgqZdzaQQz
	H+likuGTn4yIpAtv+02mpiAXt8EseOoahRjv9+Jll4hTY6rvIwxXLOFVkoTrNiOAZJmaWUQKbJ1
	ezCbE01cVUvHTvI7gDiCw+ft3tAHBTyrIugwtnuT4Hoc8PSTJgqNYXtq2oH6w/z4YIrTNSxMxOe
	c3JlbglkblxSAV/6Z/vgh4ktUAkEQZrxLL4TQH2xwI/qS8T3ivhj0=
X-Received: by 2002:a17:903:32cc:b0:2d8:f4d4:7044 with SMTP id
 d9443c01a7336-2df7deaa2femr181005175ad.3.1790615840841; Mon, 28 Sep 2026
 10:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829161013.102967-1-mehmet.mkoseoglu@gmail.com> <20260928162214.487564-1-xuyiwen14@gmail.com>
In-Reply-To: <20260928162214.487564-1-xuyiwen14@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 28 Sep 2026 19:17:08 +0200
X-Gm-Features: AclHuK9Oi3HYdpfBssBZXi59FnPj8n8w5d4DbZjLEM1vQmIq2zJQWHOZwy-yEls
Message-ID: <CANiq72ki8M1KmxhO4vSkMUfLcuqOMvZtuTNdDpS-UcJy8rqWpA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: cpufreq: reject NULL from cpufreq_cpu_get()
To: spidermana <xuyiwen14@gmail.com>
Cc: mehmet.mkoseoglu@gmail.com, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lossin@kernel.org, 
	ojeda@kernel.org, rafael@kernel.org, rust-for-linux@vger.kernel.org, 
	tamird@kernel.org, tmgross@umich.edu, viresh.kumar@linaro.org, 
	work@onurozkan.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:22=E2=80=AFPM spidermana <xuyiwen14@gmail.com> wr=
ote:
>
> Either way, looks good to me.
> FWIW, I hit this too and have a reproducer [1].
> [1] https://github.com/Rust-for-Linux/linux/issues/1258
>
> Reviewed-by: Elowen Xu <malanalyzing@gmail.com>

Thanks for taking the time to send the tag! :)

The From: doesn't seem to match the email of the tag, is that intended?

Cheers,
Miguel
