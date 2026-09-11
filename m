Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84246AA99
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117717; cv=pass; b=NrDcA1/ztlio1+LrzZ4DAS/NcOdw5I+2ytPau2tmif8tL7ifVNRz1B/KBXLAJM95nQyBsDWLNSS+3EApWLilkJukcsQzgURduSBi1zAUg5MTIdIAdjmj3ehSPbGPshrUXZpKossv4WMoujARO30o3yteGVuaSx1gI6B5m/1rQEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117717; c=relaxed/simple;
	bh=9AitBb1GHyxUD8itXAfWQrOndn4vr+DMbiE1kW67HMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1RKS0H/1yOFpVuIlW7roDcp8rxEh/WQA4bXkQ0bJ/NanE+tgCpyLcpVpkX0VFDiVegcDaigC2x8La3FJaE1fX8bDvDOqJ15NL/kivvIWAaGrZP05JQMG8hENaH2HqPsFVTafkqsyYWVcnWOCVyWNtzYssQgH+XqC+gRsZJVwMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntc0+0D2; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntc0+0D2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48586861639so277445f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 02:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117711; cv=none;
        d=google.com; s=arc-20260327;
        b=EM9laNpac7asRpugVDqQ2loXvZzhoMnrq20t3e+iomgRTY+LMOoWxgSIK0zt8TKtDe
         jwvGsDZDqb/7Yt5XN7tfLhNsbDI2dhyStVt5DksXwI1X38fZyXJ9BhrVrf7MAu2688Zg
         wF+K4XmpcCoWsYdGuVvB/AHMcSM7VRHDKKRh41ckSROZhA3lNnzSbc6NXxyuCXOaIIeB
         rrF6lDiwgMNppEJIDOW2dlu6YIxwBnAV5F3oJZ7ezXIoDKdTnhi1KPr7vTeobjtOzjcI
         E5H0VSDd8yO0OvH0/VX9WeNM5sBW03nTclDZI3VUO0/liTDu1nIwirIemUKwev42Qzwh
         iWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        fh=sr67TvRxHruRIYOrITtsCkwkjHP2zzTjxApN6MRKmMw=;
        b=Bju5OY6cJmG7VsFDuXwkJvnFFo05KzpgRyUmb4sSp4lbSBWwZDpatUROwn/l6NZqC8
         6bAaI2EDnp2guLanFxPS3clU3uz2IaorjFrwNt5/kqvDq+zMYgKL3ioX2ohCfG4VKp5D
         k7D1kEW5I0F+0oYoc9tTtU9tpQWfKTnnYf0jtFWncf+gY20B7ZljOLquY1/4MiLzgUGK
         5CVOBYB8cbOKwhkhIv5l1QC6sDBeVgJUbV1HIAS7ZX1hSI2P/IlmS0TuyThD2ukhIj5S
         OFs3/9DNI4Ixs+gYL6FN1psVOW6uLf0qfydpldT+nlEzwmN/Md4IF8gx+b1tNatzFWfc
         rJpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117711; x=1789722511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=Ntc0+0D23+YujkzMEy4eJ6nXRpHFOnm4AtVkxEhi5vnpCexhU7KW4PmGmKyNMt+kZa
         TPGlSB3IBPA9MiD4PQN6ttGdFWT2WqMR0/+bikrH32dyf3RHlyaDpdo24c0XMpHO5GJU
         lDTJahlTxAMonEnDUsydvsqrYYCX0kfnhBDCQrNCn+atyDFTDkDtjvAsv2M6xPLh4eMe
         a/AWqeYbYlOAESo9Wgc1GsNr33dNbudqVttD6Sl4VuL4rsbQ/aL6gINrZx4FRE2ZMT3U
         4K5dculSYJThgW463pZtuOMCZuRhxZHA32PPtyLFovJ2VLCOKrv7CixBauixl/iB/3rB
         IKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117711; x=1789722511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=T3wCp/e10lx6sLvtOf8v1Tu1yZhoJVXbzsbzbtfRK18vN/v0VI08kFPyZhIELLXRZS
         SqBr5EkXvMffMSO+S/l8KOwvoXspfgSRN0g8jyozCKmrQp/U/gEflBButcVMKH+buZCe
         TCcf+VtzATzp9RtFykVS1vVnpbQidiLapogHF0J9Qa8RLaiDz6tZoJ16vy6uI01OvUNp
         zREceY4GItaUKzAlWSd6k9emJb0O0S/0swB6sL5U1E5KhKJiXnfeFLIvUh5H5a5RmZZ0
         pCW25C5aGxXz/cCSJrZe4PAOI953yBPwqFrPcP6NlYMog3KjcesEHkd3XB2fXX4x4BZD
         jOQA==
X-Forwarded-Encrypted: i=1; AKwUvBw5EVLqhAtO/vZE7QYofOLflub50o6voC8oDbiQcqpBTHNo0OsXZDxG4rb2V6yqt/K2M8RZpSgQjQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mWhamYDBFaBuKV1QGZ+3CzcTU7AkZqqnq2jeITbC+uepgAHD8W
	zujMYa4jL4R3GhiJrYZFPqUI5VkhgI/5iyNhc6cXpmwvXx5PrZuMR4KiHNFOPcFA9c79/3nC7LD
	kwgbG+raeL3rjIxXmDB5UPmlq8TpfBFwSo7DgMT6G
X-Gm-Gg: AYBFou2OjM++OavPwmpHaXJEa4bZqhWS5IekN3hbBSLNOrpWBBkFfiwz513D/aYaJdk
	NYifYPmugewNSN2WWJlLTjCuVgqkw3xXuKQyp+JMe/wvXITxXLZpOf4y/QOo7kC7PWGkE1lOfuV
	hMFwVSrKWADISX4y1EZqZ+D/AWIYCE7eKAgxAYrNkYPkSResWcOTiqwYBpCp9JZq0T+x20ycBJF
	KFMg/tpw+rdoNH3nuPY5EXc4Rrwzbbk+ly8UOsvOAEEzIVuWGoc6xbAGFG5TkFtb2pILIu8jtSf
	pssCAO6I5HoxV2M6oPYJup8VmgCbVS/ZWWc/RP32gKATcLKuY1oZfFivS/MVEpDPxA+MGj29lR7
	SRNf94CbnGKLSrrs5IINX8tPHOjGFUpqui3HjnOUll/G2nByDEaFP8lyIiVQL9gt7
X-Received: by 2002:a05:6000:46d0:b0:485:8226:c691 with SMTP id
 ffacd0b85a97d-486e0f6ce92mr8157059f8f.16.1789117710377; Fri, 11 Sep 2026
 02:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-4-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:08:18 +0200
X-Gm-Features: AcwNN1Wcpw91RcC64bgI4fLKPGdY59qIT8O1U-qjeWGvrNCV-tRUtkCYbazUk4w
Message-ID: <CAH5fLghUQW5urTfLCCDT4BhuqoFVoLUAG46TS-SxaS37bJcgWQ@mail.gmail.com>
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
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
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
>
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message and rebase on rust-next (7.2) ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This has a lot of safety comments of the form "This does not implement
Ownable, *therefore* it can implement AlwaysRefcounted". But I think
the safety comment should instead explain that it's okay to create an
ARef<_> from an &_ for this type. The fact that Ownable is not
implemented is not sufficient argument.

Alice
