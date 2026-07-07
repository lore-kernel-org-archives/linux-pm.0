Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC41C84AB
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429502; cv=pass; b=IlhAiLWfRYT4uG9Vn4H4Gs0GdYWTvTzcHoEWQqdD1lQwVsIuBV5PCi42/EsiD/8M9SwkwWkmmyK8IvUi0zoyGVetBnHyFjGaRA4/0ZVXz5nug/uMWLpUnuW9bPJQCVbUEsl+Fu4Ni7cn9F6rzE7miXK4ob0lCZMU+wA0ndRxbkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429502; c=relaxed/simple;
	bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpdtiIvRd/j6QlxJUT6lt+qcp+RoOkzoalricvsnVJUKjpGLif8+pONoQFEvch11t/nI5/P5+iB9eeeIEnSfrqwo2DB6jly+iga34ZcFLzikRHc7E5lZnFb15INWHYLNDNmYGB8Y2o19s3Lwp9EZPpNRvIzxXCw5OIsyvau2WVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFuoGDO1; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFuoGDO1"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b966dd74so14365615e9.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 06:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429500; cv=none;
        d=google.com; s=arc-20260327;
        b=qNVyOAJqAMX0TkRpldzZD/Oby6cdnZLBWA30sKckwBtEYmjZZS2JZpbeomw6MUCSuQ
         ofi9INOwg/26DBgrxEwCuk11Pl3DC2OAd+Op7kRJd+Ul6n/l7wdQCIyrM8lm0ymRbnT7
         iBSEj0rqgxtkZox0ah9m9IuOSofo9AXyPa5qVlVh7S0AxMsTcrVTNaLx/ntbEvts/Ed+
         I3q8+TCIV95t9fzUMH4qoK0I2lSyd5nYm/rWmRKfvOdKOYAhXxxNySNwpCxQfKGJ+5NX
         rOYPCkJPZ77zFlLtM7b0dLP5K6GGmAhenJ8RVSaXABTgdNnnOZzwdZLZaxbKZZmNvV4Q
         v4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        fh=fzOFGV/FEbG4xHxH8zJoi7VgzNrTSyZ+xeiaAFZsMiw=;
        b=hlb5WOWfEocaDtBJtR9uJnNGaNWjRsKhoyDjPR2l2ZGvAv2dZNeORV/cFInA+b7st9
         spRo9TDByBNc3SzqV68tA2V5t7gPICyXq06V5EjPmmiCJMBxXm833dKTky/Bye9fha0z
         CySQA4KGQBN53Du++BOFFQZbGau87+tR+TlBXOBTI12pMv2v2eQrp5OFA7lBoKvvo+6D
         HAKHuZJ53vLscXvHryQDJ14Gqg0L9hgk4PXkGuHIzHPXE+ZJSrXszrIom/jBwxpnRcDr
         VSSRbJ/YLfHa78yslLJ6epQlgq0kwPolKbN0RVKwp1NbDNr/D8hQSPxjWq6eRsh9qlzM
         xLbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429500; x=1784034300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=nFuoGDO1XVGBMA2elJau60FW1YO9XoQWxecIiAhwpEOINYiWTEOvFYt9hryXEB1WFp
         +QpoHqW9prtXfUsoH9gorM2w2zbESlVhTgBwWgFdBoQW9ffxpI9Ftbj6KmIlr2kWa6Jt
         NEPjLGQmB/DlSSegsKGXACj8uniH8D+auFU3m9gfLKcnrWuuR7QuZ805cCIl2qBjA3h8
         4/C46UWq7/jViq9R3oxUB2NVe67Bo4SZB+0PtDp/OKTiKwcSYsSFdJgFbeUvRSF49jgc
         HgxxGmEIvlQrVRqPxxghfaYKwpTlJqLnq5f9qbYOax8CC466Yf8yNEGgUn06r4R/wM8g
         nqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429500; x=1784034300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=fb5TKGOXbCAc7cqmxDRnwtlva7mCSq+J5YTKTCUsdYTPG4oDDA7/1rLPD1kpS9k3DX
         gOfS+ziLwBWLpwN935eqY3O/QLqq2iuJYYsu2AP/pOzm1tD6/UphnXqm6xVO4pBPOUTM
         biT161xUQ1zNV5ESA849CBuJfcmIVNDcW2EsDjTBAkSwjXPs9Jb86tnqVm8iWxrmLn8v
         e4qJvrW3kHGz5Ze9FjwmIv4WCGJUDuMX4Whlk/d8UnVViAtGLVZsyUD/6/UWVS1zFpdY
         B9uFjLAtmNMCqfjqdXvhoFpwTM60r0FVnKuPKiPYyUEcYjQB3KKohEdSlG1gwMsR3RwH
         4ZxA==
X-Forwarded-Encrypted: i=1; AHgh+RrHUkZjoObTlNBth2whhkkWgpwNbAfU1MQTEAyZ9ydVs/Xudpa7WZrBbjzQhVMOfk8dxL7bWodG4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL6iDG8uwoFFhsyHhfWw/VD5zLK7LZZGGaLIByTVv9x7JUSsFm
	TvDeuEZYpQ2QBW5RhCoihCVBQnLawttyVg27RZ1CVOjeKT5/VnSe6QY+yT8jokGCPDkyIDLvlk9
	kZNUu0hO9GyU7cw5MXJeCa0xdHVVebbRIEdO1h8Ia
X-Gm-Gg: AfdE7cmfIHmG/eoF85esJ7T95O+wxTCNzOpd4aodE+WJVV8B9vruG0A/XqUljid18WO
	sguHwJ5vFWxsEBe4vhFCh5w6dwz98a5dI2htDu2hEjMSeQKLQb/V1bMV153BFZ9h7DsdbZ01K3E
	tOKdkvxD6IIKkwdlRtHbrWKQjKuJ7/bTkfKZLSe7DPB2FTanf1KmJTfSbYftWBHCc9a2VBGfiJj
	VbVTnXvWrXOatl5DP0Byn2Ic9Ci2Mm5iCgex7+0tVDlHakz3FCjJ1PtdPWZDcpjBbenkii6Q6EP
	YA0lsNIXTjCdmKi3FnduTFUs/uM=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493df06e943mr52096855e9.25.1783429497735; Tue, 07 Jul 2026
 06:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:45 +0200
X-Gm-Features: AVVi8Cd8GrEsrkEwxzhRkanTcpbMUA7MU6OpTudOnt7DIfIGqhosSlF_BI7LYTM
Message-ID: <CAH5fLggMeHUgXj7JGYSJejUrR2PdWymOOb+3E1VmHokzcox4hg@mail.gmail.com>
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:55=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
