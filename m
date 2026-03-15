Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D602571DA
	for <linux-pm@vger.kernel.org>; Sun, 15 Mar 2026 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773609770; cv=pass; b=rw/rStnTa7pH9l8y8E7Rl0EBexjwqBqEopCKEbl/2lno5bT05ZdZXscakJbIEdpk3zZEH13rC6OwI4WktPMmZYYGW3BO5Oe1CF0gpOTL0tBfwIgDRKYEomkBDwzKvRLhOTcWIyzXwt1ktRPhxYuL2wfBhr2zO/uzvW50vTfMbng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773609770; c=relaxed/simple;
	bh=kSDFhyU3+XacTSQQkN7fKJ39pcLSb9VyjW1OzdgSjVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEo19JC5mU5n1+Bh0xAuz9wNWFYqNoEu2tv+5x5IEhCgm2kKAs9bJWKRvO0OSFsymP8PgfDfdBT7FAqzB+0nZCi4Owjkly6W8Sg47vPziJR08i1+6MBmVKRu0tSMB6xnRKjX91gT7+UFe22GmIxk061em9JdWCREq+GtyyR8noc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/huJ/Ki; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/huJ/Ki"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128d600ad25so184953c88.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Mar 2026 14:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773609769; cv=none;
        d=google.com; s=arc-20240605;
        b=Ci86QiCBRkTiXz1CFXRrhBMrA1qlQ+AdLlBD9bixC+EbGUwy2LwCvl4xx6sQa3WaZJ
         6N34+Z/GH7M1mPAhwJPTu76/T2/9kiUAnkTGsOEenwoPFCkE8gj1T9M5FUt7OPlLLXJA
         a8yfzKfZVb5nykZe5SkNrG7Fr7jXnWTpJP9MlWum49ZkwgpYIeLaHsshzpVFLkbqN9Yn
         fxveqeleGbO6Qxo0twdM4J9UFJgsN/FUxFRbuOQKlAv/PLiGaMuf2XmgMQezClu/Mrkm
         HnUQPUy1JvC2K04itu7ui23yv/rph/a57+tYKRPEdjFiYE+Xr4HMp6HNnOqGieJ5Rb4b
         3HgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kSDFhyU3+XacTSQQkN7fKJ39pcLSb9VyjW1OzdgSjVA=;
        fh=N9id0pApBlVO5dV76p3C9FQoLY8aKM3VgCZqAbfXh4w=;
        b=er1i0IttFlKVJjiT9s7QNMJTklRIEvtZGs9F7WYKbaCqgeAwtX+EL0P/KhOg34bLIh
         f4Jfvqy3rXeExXejrOrYIV65E+f/bq6N6OVDtjxIIY9Jc1LTK0bk+2oB9pLGaMw7X8aT
         fgqLXfM4/WVETfZLjEM6BsBEnI9tNmLrzzoJ14gh31WQGu8Jzql5rlpI4S8vS+lOBZvU
         KMF+IWnXU9HRzC90UBI3s2y/CwcjuUDbLTAIiOgHaW7j6C2YA4JzQgGNelyXIcvs4rZp
         j70BpRMkxD5XEpRglJed9+M6Jt+F0lCaQ2oPGzqB0QWgam6L1hX+BzncmW/DWkM6UrZ4
         GYJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773609769; x=1774214569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSDFhyU3+XacTSQQkN7fKJ39pcLSb9VyjW1OzdgSjVA=;
        b=Q/huJ/KiOdJ751cjDDRy7U6TBUcfFqoBVzQpVRCCwX2fKry2+8A1EOONg5aKulI5WM
         GYocyUvbeu2yuyWNDN4Kmk7ts7/jmoVAUguIfQbw3TDA7LRTpXiTeR02Lhw2o1pa5NB/
         obWigZu6J03oQHKyxLbaGai80z9ve3qYfcXwkIxwc2eVLCUCbGw6Qjrcd+KBNLkiu+oE
         lyLay7NJMQY3685dqNkc7xZ96ZB6Jpdj3nRaW9ts9tpLozVA321sEXi+nyzveTea45bP
         htL4uUZKhgScwijjIwLu6hTO9N6z5U54iWw3KXJLutIZ3WH/FpzTPiSGTGsnzCLM218X
         ks2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773609769; x=1774214569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSDFhyU3+XacTSQQkN7fKJ39pcLSb9VyjW1OzdgSjVA=;
        b=muYZmvOFBVkKC8B7/RS3HFoiIVZcPG6dK6W2JHqtnQKb2PY5Y6EzXi5GJa/8Bq6DKT
         QPXjLpSx7bka+1FFJY9s2UbvvGabK+PDW0o0/nZ+WxSf7vFEPtpsvbvDDGQaLyf8jyvc
         4jIyhw1clspNSaq53ftL78omegzgwn+WGgxD1Fy4qNbBAMV+OjGsaaGRYEUl6aCXvjkg
         6cP3Q42r/SZuK/d15zOQW40e5mTAJMNoofpmDW/6UoWz7cLJ6XaAekmk1dEF14xCguVW
         3EsuysvaT/EYeD3omuyfWijamazd1FSn7WV557WYM3u63MIYd24w/ZF1zyZg833ssXcH
         Rm0g==
X-Forwarded-Encrypted: i=1; AJvYcCVhvgH+hpC6SGgZoaEzeUfEEfi1TCcWSdpq73J81iGgXzs550pXBGH3Gs9itx9U33Q/0CiEwdoagQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxStLJCVmwLt8poqO40Q1T9iXW36wfk52IQmM8gNim5kyVBzez5
	oSQ5HJeAYo0o9MIVBDuK4Uwd15reM4OjsO7855Z3NLscK80p7rDI1BJVstbdN96PBgpRuVhwNOo
	x9SiixOiwe/kYN/7c+6WoKfaB769A/gI=
X-Gm-Gg: ATEYQzx7lozJvUyGzr3r8EPsmsLQTHes2snDLRhKG5i+kZqCZ3Y266Z2QjpyAIKzYRj
	88zTTG7DLS29qZAvRyDvGJEnbhM6NTIgP/eWZIXvEKSIuymfqYwNdbExMDgCNWfC+31vWRUfUm3
	qYo71EiDufEmwRw6CKpH3d3XlhL69vAej+mL6cG9fjMpc2cergjQpfWSHhFXpBgwKbusDU1cuyR
	bdsWS0gTh+lPUZEBkh3I2Q/HMM60RrcgeTk3L8z8ZYncvUZA3x6OUEMW5FWCVukMbGAAqfqCqtg
	XIPbRGjdavH+0F2DpMOFQDHXn/VAQJHTVaP4plRP41EgOuTahXDoQykh1L8SYC0dRwPkzUJn+QF
	gwoRCgDpGkyfrTTlw5kndKsc=
X-Received: by 2002:a05:7300:e887:b0:2b7:e929:856b with SMTP id
 5a478bee46e88-2bea5590920mr2510000eec.5.1773609768815; Sun, 15 Mar 2026
 14:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
 <20260307170929.153892-1-ojeda@kernel.org> <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com>
In-Reply-To: <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Mar 2026 22:22:36 +0100
X-Gm-Features: AaiRm52WZuU_9qvGI6K7_I3dVWa7hrbA1AfH9ApfWZiXnxNTtXGlv6pDXlVsoyg
Message-ID: <CANiq72kvxvTh1_8U+1aFCXRNxDY_HQUzkhzjoo+8vTrkCSWoNQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: kbuild: support global per-version flags
To: Miguel Ojeda <ojeda@kernel.org>
Cc: a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
	boqun@kernel.org, dakr@kernel.org, gary@garyguo.net, jhubbard@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lossin@kernel.org, 
	rafael@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	viresh.kumar@linaro.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 10:21=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> plus `clippy::double_parens` for 1.92.0).

I mean < 1.92.0.

Cheers,
Miguel
