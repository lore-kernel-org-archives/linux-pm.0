Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC64F85D0
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977350; cv=pass; b=NV8zc/KPt3KlKxxFOWelkbsm5L4AWiksaJFph4ToLLhYZWSkz1aXoC3ajEqu1eNrmrPLLbpKOXZ9rRw3XFLWhpMQLalDBpNBhF2l+eUlAePBrqN74ga5rnLFkFmpUtYM1JU1+dZv2tJz168jyhX1jQxmqJTxBoQiP+A/i4wq+jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977350; c=relaxed/simple;
	bh=Bm8IXeZCCjjHRHqufoiH0uSm7tIaA4fZ4x02DGLBDgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNLC6ReR1O5O4XtSoKpg0aKEKDX851ovlymhTDZqSBmijfZktP6EnG2PXR+rTrHKxFUv71BMl+iaeeGdzoo5T+WP0Y0s42TXJNMCeMngINkYd8ZtNV2uBEXP+hhjRHH9zqR78uZ64L92AjpRhmZQoQfGz3iPkPvumYTDAqKSILM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkAqllS7; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkAqllS7"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35179d0747fso306965eec.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
        d=google.com; s=arc-20260327;
        b=L9NbpvIK7B0W2mroUtfQSA9jh99zGpMbanYvFXA54VfidCRXBAc3ZHvLlA9El6Ze8d
         9+c7n33eY/arZyoBqfcEJDWpt2kY/uK6G4GQqhnXXq1MRJuHVZpQBc+3hUWZQxAXsQfB
         pkw7k6kv7szsTvWgBEa92jwFaGcQ3Bl/eRR08dkvoPP4B/+s+oMeSYN1PRtQU2QcKFiH
         JESHUEXtS4cbglu7CYeZkuWXajuIe/e1kBq53okvpK10OrwxbnxKQfjLSxdm/H+quiKS
         hO/fGFVXdWbQbqsxf6+VAddwRuFnhkDu9vur+SWzuIcn07t4jBiTC94mdaky7FHuYaYK
         3YzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        fh=0WZvzihiyYSXLs5iZoA6vp/FE0v9/eDiqIGWKBIf4+Q=;
        b=L/ZaY8TzwuH92k6dRnIdUGy2JvtVT9kpHBDgoJ6n6EUD8NadybLCZ74CLpHEA8dxqr
         Eyp6M/VWJus/+n6NSiookELHodU5f+WYmH2NO/DvF6oGvmyaXBELtIiLX8jrt6G7spEB
         romXWW73y/QioLMePSvZr2sNYZ1TT4E4yEe2580HaMhwxhZOcg1uxnyQl1GWSw0bKrNc
         moMPaTwXTs5bOPEuXW+a+FyZHGsPfoo3cPT8ARgV09Yo0eju+UcXg5PDlFwU4hXWHsHg
         EouoEtKdkpBXR7iclPnBfGt97c/f5FqWiJXknMTXXNltzNygifn6H7ktFnYco8fkoaxk
         J94g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=EkAqllS7uOOZxDGJ4I1yKdIi3WQSBbyUhPsWLoVzgJERDBlfP0X9cEpWzjyHAR90JC
         Z1zW2YqVc7X46XPiuAerNf9mNnAJ0uUF6PLz0rzePzi7U1lf5J9vz/gZr1IuRwk27MI/
         4/D886vhZESIUjDPJZRvHbQYWiiMvCS3NjhX5siJV1JzVFlBVMBE4d5Q1ZOlRDw5uGo0
         qEQHzjWEYvo+agj8c1xw4Nkq2SVQg9Ys3jvU8s3NkIQ4fYLQcX3kMyght8wz2N51o7tV
         AXXBZTinlSID6wvgzNqIrr0dJv5ZGB14N23uEZXq5jf7doeVho73k08XFK/CJX/hTW5i
         pPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977348; x=1792582148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=gasglLz+jvd/lj2AWTcH4dpTpspC8i/shjuLvS4qlOk83adit2wBZRZk+KhdbvcSsC
         oU4WU133utN11jFwE/uCm8a0j1FTTEb3fLIyBjytGb2VJ6216jxORfQ5ABNrNzYEX0Lt
         Yq8JKgQzuNSdLhigAC4weEpNPkMyUAISmfkfu0osW/DulR81Hk/Dto/X9OQZa8d7ujuS
         I3dIWhcqG2aCn6k7Rs+jMiB7HzyeHqLpVgZ9cb/LCvq+ioaewLNP8k/LHmMxqS2OCs5W
         6We9wZ1rMCZpedRJnCldCWGocalBLEvVVtKARglFyGgaKOATx5YNa5tvfWZhigdZRaNs
         2bsg==
X-Forwarded-Encrypted: i=1; AKwUvByaGD1vYIMy6Wtebl+P0UpJNjFwjp7oHbSVoG602PHwPlAaEoZLvVkeIsvszQSjyzl9E8RVo3y+/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLsRAaOpb+TYfppPf2ocBLs3Ab75WdXtJJkbL9kLaxlum3MPki5
	6umyidjQkJbDF1mTnNQF4t/tVfzubBws598jb9nD0U7l6cYr6Mif2hw4OqHLy+AFYW6gZTHvVmJ
	tFQO5hm0ED7KWHvVwFfS/Wi5w+BWCKSU=
X-Gm-Gg: AYBFou14Z11yEhI2m8reZXKF6j7dyXfvtFJPM2O+iWaADRaLnjNKbMVyrpJFYprM1sx
	Bldnk9R2zToScRAtVU7J/gEDDpiiypEbBOsnCAzU5rbfBDk6bqAitVihE7xK27Hi+K0JxljEkND
	gPd8bvYBd8KI3h+PnBcUX0DpQKYDWKIbGbkeTXOZ0/r3RK4n3MY0LEYWm17kyBlGNG0i6/hpVJm
	X4U6N8Sj5amFJng8a3LwM/dpRoD8S6gZn6sUUa2mrUX8fr4jUPXozV6BQrTYQobdFUWT5nWHi78
	02vkDUrSXMvs6dp1E/jo7tU5hvYnKUCj64/NRME6QFAczqs9TR28gE3P6Hu6ACc21uMBqxbVBFP
	47X45O4vhEOfV0kHprWB9qc6wMIAvYpUEjrcE/ioLegrIa4E2bmOfMf2zNVa3oJvSaW0hDfaTQc
	j85jZPAaNsmsfDGE5VS+Bm+F5qWbO+8VDWHgLpEV0kPze7Y/8b6Xg=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
