Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145A3ED3C3
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779230; cv=pass; b=OiSpC63ixUsDEBeBEp3DDe3PikyYRJjzILawBXMvaNbotmcbFc9DIb2Oa/3HO0riXYM1aFox1zrtuwppwtNaT5vsDUo6kVlHoIi7CkiGeUQTjoqxuoeUFD6iTO5x8X/jJxamsD+n4mWDV4mc60NqrvyFc5r3qPUWdEIDeLeyMCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779230; c=relaxed/simple;
	bh=yhUtjbZV53eJ33+I5WWMx1PK7EZ98q+cI9GUW0pweEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNFLKNs1NDJr0F7/cbmCqliBqG/HWYCd844HjxtNg9KDLPz7a2Qqa9qGy5G4/DQLny0qvZ74niWp3PXTVJ2HWoe6fRMYjElgCfRmqDIAlcCGVDYTwwwuEFYnpcb68MxZQj4U4eErHCYP1ycgNJTARoBBApWWgejn3ZlxHuj+S3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDW4jrkf; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDW4jrkf"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bda2cb796so49097eec.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 03:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779227; cv=none;
        d=google.com; s=arc-20240605;
        b=fq/0iMVxhfi/vJ0tV6CUWwkO8gHYE3DMcwfIBKDDytvjcJmvPMK1iM0EhkktiDeMUY
         p1JB3G5RlL0dy+cYXJjiQ+zR3x6SHpyD7wl3V9VCXD/LJ2zkJtR6ot/vCiptYO8+1mrW
         AgLTqUKFnP7L1HZgyJJMv4fkZ0jE5yDvWHAGKTEO/updyUPEpb0bfE94c0RHpms7+0X1
         mYXS2FeIXhvYPBpeOpt2MeFZ5NpERFdFcMxKBBhOh0NZz6yWe1xXB0+Au6I6+anpd2tV
         /PdpEoL88FrOwsrVGUyAd0Mw0JTOUNQd8CpDcXR4Urq5kBKXYmibcRMnyG0OjtcorNx8
         wYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        fh=sgHJn7sGIpC6So94tXp9NKFK9sI2sT/1hYQVB2cDx/U=;
        b=BeKULiI1C3sGoUZRlvBjYny/doMHUGDrcKzCqn28UgN0PdZU4Bi25lb64346BDtovu
         05txveupJ1xkHjh7kX24VBNShisBXcc9s5uOWWRAKVLOVOv864Ze9JDwgPAOUt3Q5L53
         HYdnCCu3pxgD5FU1NnZbRgmsJ7Obiv7BKSfAfDB+w/HBJT24UXIUEU4S8q9VLTgYd3jR
         IaOOCx/IfXpl0IQJzibvMgnuH2sIpgOeW1/X0BnOZ0c+vwu5eei1mF7EMlnGftHWpnZe
         zaOjZOZwQKpbMD96jlejsTf4zAq84yClZg/AG+3TWOVNb6MNcJtcLt4RmnaqQpsANLxe
         VAWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781779227; x=1782384027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        b=ZDW4jrkfk3387CIo4fAM4NOExN7ZA+JSUepXfBLmjVA+9FSYPSR+jjJ6jViBSqlURM
         S9V6LCLaqgcwgr9YDdt1Mgl6rSrPgLi8WYmsdwGZtGJJHr8fYYLDPOoydPJz4Ej2woKa
         VGi8nER7rddQjktBGGDNpeu/TaA3SWCVmWzCouZBHU0fSB6Sdk7+0DOLfMz5Xd9t+1tq
         4PPNM8eij0R9Mi9C35+amzk2T60DWvpon7MBlHRKPr54i4XVSTz2ulaIiuYX181sHbxm
         yTzCEmnhvbEtgMB/vBKfM7I3+8rtXvucGfl2SYuH7oSYFK02IzPvqvDmqj2hgddxeFNX
         K+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779227; x=1782384027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        b=jNsEyufSTVtBz80n5/j8iHaAGkHJWwA8emH5KHMzOuRZ4GHBOIzOx3YRNBIZe39O8t
         FGJsKLwio8W+U3uIgSNkAxEYonRb+C+PXxqWnep+6ewrdQmXYvHBfRDHcdxrO+RBu07Z
         Y66o8xPqVGz7e4DXwI4GBQ9lG7UJsoeqoHzJ2kgCNXorO9zny1J3QSN/0x0zCRhcHpkl
         s8mr1vtd6xOhoMfn/Vzq5rEGZkoAVX9mKYpUknNOeHkX/B1mK/ljYcJeJaIjhoFMzR3p
         zjKcPh2kcStQW7EZgDd1lGBHeiQ9eySHjDQpZo+UI87f7Yd6HBiQIHQUg6UM6TFXaeOZ
         MG4g==
X-Forwarded-Encrypted: i=1; AFNElJ8B3olH5PGo7/sh0wup4KO1R33/pg6JJhvPFuybM3j6O2XmOWqHMeMxQJiPcFHWBwTb1T2pyrsfVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlO6bR+a5pfwamkEJgDiuLRAdswFAVo1JThBvryexcjEEBFYTf
	xDbu3YCZAiDLnHNWk675U39JAsExWJFs3NP/mSo1rCeFQZ/4eVevFI8khBLoATTsRXGP94YVYql
	tbQnni1X0paN+LK0d1M04JU20aNC1YBI=
X-Gm-Gg: AfdE7cmU8w6AazV7AFf8AS/c0JBWT6nF408wpPGvLT9/k4lIXf+lXZgZb0Lk0SJ3v9l
	mgdojRNEy8vn04wFyKBI3lnMQtbQKnZY1vsJhwtjR9hdARCBgeEhIAHV5AeABENh0jzQzRAZF2J
	eVRoMIbNSKFUWhRWkEnVuU8oHSVJlDwgbsqmsjJ8h+nAWr4hPQmArx7M13xv0SuWU5wUmn9srhy
	pwAAIcIxGOoe8a7CiKW12Y94nMrnzDVk+cngasLzNv9eKRL9XFl0g/jxortOJXjWhWpdQnULvIh
	C3A1n3WSqLMdM1ln+jDFwg4jePlf/uTvDhzH4l+r6TrxLw35WmFNCsCO8jdEAMT9UTXptbNO/wm
	VXQIM6ToV67K/
X-Received: by 2002:a05:7300:ed85:b0:30b:c021:5045 with SMTP id
 5a478bee46e88-30bf09c4416mr1020403eec.5.1781779227291; Thu, 18 Jun 2026
 03:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com> <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
In-Reply-To: <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 18 Jun 2026 12:40:14 +0200
X-Gm-Features: AVVi8CcKkRQ8t8MfiUD4gXtI1Y4DMiQAI7JLxiiYKqJ_3SsG98lF2VyIrlJ2k1o
Message-ID: <CANiq72myoVT9npyaB0pVvbJ1v9ELzw68uAvSoAkdJJX2MJQ=kA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: clk: use 'kernel vertical style' for imports
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Brian Masney <bmasney@redhat.com>, Boqun Feng <boqun@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:48=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> +            Result, //

Since you import the prelude, I think you can take the change to
remove e.g. this one.

>          /// use kernel::error::Result;

>      /// use kernel::error::Result;

>      /// use kernel::error::Result;

>          /// use kernel::error::Result;

Similarly, the prelude is imported in doctests by default.

Cheers,
Miguel
