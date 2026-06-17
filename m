Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBB3BFE25
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690094; cv=pass; b=EicS+oG5OnHZMPjCA5cGcYTaCTX+ZHhW5ULT8iM8BZn4e3nFJwglFsXN2oT28V7whOb8ZZQDHSYLkMBJrjtWyms//w/Ev0n0yO0Ezm4q1LhuwqH5HIZVByaPfzXlMpyJvCMOOxiiBEjFhBn6uaF4CoMvxGpHbGX03Mmx3fyqc/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690094; c=relaxed/simple;
	bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfAc89YiWD+dlw2hip2oL9dSAgfv5ZZPfYe7rQlR7t75B5jLsD0cmS0FfuiOo3KldtMqNmutG7Ye3jfsn/md1qzZJt4kIFqWlaodKagbTGFoudim8693KutzXaXP5llG/mRwSWMducPO3oiX9aFB7lfScsn9a2FNOfnmp2MTggE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5uxNMeG; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5uxNMeG"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2998654f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 02:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690090; cv=none;
        d=google.com; s=arc-20240605;
        b=ebIOG8UFGuzMYVy1MBTwvokUPtcIgDIFMkGkFCu4vIuQV9TX4035EfYsUH1Z74GH3p
         iEkySYIIq3pRFZCwS666VdfVNyym7B73ARCdkk//ndmWVUkxqEztuwxJSYqxguMY2NBp
         RBolGAxK3aRWt6kU5f9aI4Wu8URR7tHpIkLPFrrRR9oLpXZMmNvx5nL4kwL/vNqc6cWJ
         +KaWaXoktSugpYHTc6HQgqpDTLTZ8VJn0sJCNX9xm6f408uEEq9QOs3bS6At/FVAJQem
         HVXvtIXizhFMK4GGscbI17+fY4kaDZ3edm4/2h+tKQAGqkTUjYZpmz60UfcfopgMPKz4
         zaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        fh=XhTPx98u/WGsQkUjlCIu1cZWQDZRGT62D7ATFbyTIlg=;
        b=huWZlKOqeU8b3ZohXQWsmMQAMMaRez2+5nVaR/se9Qj9KN/ZOR0FsLraNFWVA+6+B2
         ut5RGLcvg9iSTEauYYe2Zv5rsMVrh0jSUbLNdijKM4FBaKEq5DINt34T/ElKDvh/da7Y
         a0wZ1F8bqcTsZCz7nFb9KLSwHz62O3+PuSX2ZeQpdlsvKqHILWtsXMSUI6ivUh9iQb/Q
         Z9xLRGoD+aaetx6R+no+rnjk7RYZ9H6xTEH7lExvRntNPNdax1uMUfUFTfasjT3GyfhL
         dPIBELZeBnBvTxu/0ZMeM0bElGv3ozncNhAZKRs8/i69Ezza0CdtgLYSLQHmRKwIuOZe
         B+vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781690090; x=1782294890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=P5uxNMeGcDIN8llkO0LerOZseMvI0xoedivCJ9FZTvVkZQDpB2XH0vEThBBsXiWG9u
         sffI4uZumgWiX1nzBNMDek3/+k765xSl2pY7u/w/2RicT1DEfhmO3fV0tSyaaYwcGcUW
         sDIXq7Nca7LlV1xIEunZuyJ9m1LZ+oEW7N8dbZE1czoJgFmOXyNTjsG/v55Westq675s
         acUzZoCXnMYEzFXbS8+neVOK/fnhKQe+EzbGYwDbJeOrcvNmrqkC4agNzuQkCHFs6iTV
         ZeHsur1G/4T4lhO749KNW2vcfZXCrVawQX8QPjkJVWTDVb+5i/q9LvGGwrB4P6paWDbi
         4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690090; x=1782294890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=pW9yXNIxNgTOAkkjJHyWJpkiis7ahCgE9pezahKb+1em2pGGS135F8+cdm76xeWMep
         +fcsJm+DYNkQfsr8KGRUsV6HTO3X0TEqd5QaLPUzHN+1VpMi553nCRA/V0AT6+JbTkei
         Y6xrOvYCRTkVtNchOvlB1t+Es+Hoz4nEk7vRDOmxCK/RreRuCXeu6AUli7EUe+6Ggp28
         0LN7v2y8s67vh9Xx92MzVRKGEw+sJPEqXYcwmofNTr3Y8jQl0/h1ENxT8qcwVL4C3grI
         Zunz2r9MRRN8fhj09flJBR7aeVfVEsDfl9OC6kYa1uSs162erxLJf6uaMkjnjAr6ZllW
         87SA==
X-Forwarded-Encrypted: i=1; AFNElJ9V4RRt8+rO8zALIYZ7OglrRHzaV5iRiVKqNOhH7F9KCM3rrRuGpUNwYbsLhSaxv/PxBJryAGtBRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydWyyE7SQtjeCiMKIY9rEX5X3dH393FZKlfUKxGDPbDYliv1yy
	I2842b4wyIBPg+wfoByfZfcO3/TYP41hSMtvTklOGepV0HFve115r1GocdPGxu+LVBPNOpCL+B1
	/1w7Uro8Tp/qxR6SAQQ4csi+dXym0OX5rA++jICpw
X-Gm-Gg: AfdE7cm3ED3ZR01PaD5EWed68AMn4m3cjw1YJgKy1HJpEe2xJBfpwtL2oHeaHZ7F6ak
	hcsHLyP5yDFn1UOmpVoC6yTbDF1mSUDhFoExZNz5mNSHBe2Z9qSsVsijXGuk0GlwYUgjw0xcPqq
	lWSjTseate3Yrn9zcugXbO4WmBKE748fQ7Kopf5Ts5y2qBQvlxMRKJoN+DRY9mCWpbOzGl6mawN
	yuvxe6Y3Fe06eJo7TK6SmoNY1xvDalTuhb609b7Ph81qlDQDBmlvg8zBkeJnDWB6PRli91AXdHO
	S8eBe7HVjzm60aGNZxqggVjnKbZQwZNYz+REGO9qRMAGzbhzeWSOQwIEgv0=
X-Received: by 2002:a5d:4a91:0:b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-462376a4df0mr4361735f8f.19.1781690089839; Wed, 17 Jun 2026
 02:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Jun 2026 11:54:37 +0200
X-Gm-Features: AVVi8CfPlpZsDlv9ciJ6wpjG8CPXMs720UTUcxwfh8qgpqFIXUpU1m_9T99wYrA
Message-ID: <CAH5fLgggdf0CM0o4Oa1VbY+y8gQxrU0VU5z_yB4GWCxnbqsFuQ@mail.gmail.com>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This will not compile unless Rust Binder is also updated.

Alice
