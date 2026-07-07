Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DD194C96
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429471; cv=pass; b=ucAzfwQULEhNUZUM8r8HEqqafRA/1Kx5fCci/nd0iIhtAN6mvHkm4AG56v+bAybUInDZd3Kd0msxpzyh+Kq96dQrVoQezigeaYxEO62t/7in2gsIv5ZjyKm6Bk7CSWti+h20FT/w8Vy8OeH/kmJnAL/7ciZpQWKOZ52CIwYAX6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429471; c=relaxed/simple;
	bh=TmPGIYAzJvC80RsuDMRwEJ1EsP9UZtxlgsFYi2qUwwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jacQAMXrDoHLK1nHZh2htTtAHYpwd6/vtn0MuKns95mRyX5F0NXHghSG6gBDkFJejXYkBFUMvYQuTkBD44YT0oIoHwA1hv+NZ1BCSJnGWt0bOaN6OVi9pturSbeQC2+ajWm8e91FHKKubucduM2kpCl94hFrYTSGseP5K56wpc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNRNvkik; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNRNvkik"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso41401635e9.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 06:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429467; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhaXZkE2LXaY8Gf4myRhgIFyhMSu7yMSnq8i/twzckvSqYT6YrxSMunGYB9QenB93B
         JjZumBnnTsATV9E85xV39aEcJNHN3acm4gtWm7trQuYVuRv+ffrr2LUGynSF4n0mp8td
         7mLxGFV4MFFUCTNCS+aSA4+rJru2CGHqtdjMwUoeutERHr2V+s79BmIUB/FXU7IfDfVI
         3TmNiJr79qgzWeKhBaEdLA6r7F+T26vH28BWvO+3gsPqfZgH8a/nPHf4t/ezHEAbuhqe
         hnOCe/iePP0jY2cJsffG7r4gJ939G/NmXmF2Eg7kU+Wr5r4xKBTfm4zdgc8MjfE11m+l
         WLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        fh=9Pqer9r3qv0kcpuPTeAbValO1iv7jmkTcE5Wptxqlbc=;
        b=AnWow2QaggrZrVomGeUryNWAyzRtWBJWectNHaZdCK2RIhou20nyofYMyfYNq7uqBH
         MQo0/Hw6od7V3UoafRSlTtWsc8Brmp8QlQj1464gDwlUL88+989w7H/lSwuq8urivA8X
         y4RRCMptzBzowDEaOlZAmmGXt7czm1R1YZ0QQ+tThI3DXu2s6nFqxMhAe+WKleluZZiO
         LK+R3ye60Jty7dAZ+Yyee9GY54Vn6y322IJ6oeTAats11Muei59F1vimM6YXSTQDNv3h
         7hIZjF/+IDDKFQMK3uvByX2KNW/gEI9Q7Nf4rWSv/hHcTTShBY5WKiOaqOyKBq+3YQPz
         X7wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429467; x=1784034267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=dNRNvkikjxahImuUI1Drg6CXhxVxac7dmERU9WjMnbsmX5eHK8WY83RbZ6d8ZHmaOR
         obViGb56A87vfGXlOGE5CbAAs1hrc3UXO2XdohufG2m67EjQNWl3aM6kcmBgGlnhpXb0
         55N4uSy4UxvHsBdSOFUwN8a7Xi9ecmoWElcH41X7rtSVSWXt9PKW5oQc0sCPCWon1GQI
         UHzzE9kkhxCI83tNWa1pH1IKsm+3VVHfnK74tgTXhcNzcUaQuCRi71myU8x3J7bukLTo
         7OpG78s998Dgqd4mCuL/HwAzs93Lz6Hpr1UIbUvthgrkhpJuQ4eNyiuBinQ+gNC9MzBE
         pURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429467; x=1784034267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=kCVzAXdJ/Udz6WPEZnshIhqxVYPPCcIq3cfkENI8psP4deXoKQJH9AAaL2Rf+949wj
         NgUmbQVEIeG0OAW9kehe9H+JMCAeXQazURrcYPqEYtBsGEFj5U3+oQEtkAc9QKoUCH17
         wRfQaEcOMeNA92EbQPCpFM/QVj6XxVzIyC62CQLdTq7uylveJVHqe+/FkJy+Jw/ycUI0
         51j+LEn/r9aDExL/Umj3LDNvmhsoPym2dOWUO8Y7/0rRmBhcyR6by9mKgWEMLTNR9DAZ
         kUdin2Rl+29gX2vd4HTDVLrWj1ImNQQbQva7cQf9FSNlU37d7pIfC4ZgvxcQ7piT6G1x
         TNMA==
X-Forwarded-Encrypted: i=1; AHgh+RoTaV63bGr26lCUnQ0N030w0Z56YrbO7cLFUrs8i0+EQ/JbN2pGqmPsyOj2y6r4WHzklgNwDymUvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJCEJ3+qJzT1utxMyEfky2+htOn56EfI56q/RUC1rnveh22Vr
	FRr0v3Ut9lOLk7CWHX3ZYZtnGS4xD7dXSyQOnzXR/P1VW3tT3mbAi1nFiJlPu/Y5OMAUM0mHxGT
	HyUa3eEjqAhH94N+XBRXCCWju/UcjMHvo+dGDRRMY
X-Gm-Gg: AfdE7cl9HIKcCaoU7Ag2kmKVxH1aRwBPohpE5D7rOz1bi0gN+rk9HWODz+aBcHRx4Qk
	RhVMH9jGMvpQu/l+HOJVfMdpc1/cEdPqZ1UE2VRvV9CFshkhCWWyTAYw9TmemNf85dg+rNfdxQB
	7S4eVMvDsvGeSvUGrWT8clSqskkbi655EEXsgAYMoee0vYPJxKUTMBnql2MmVhwQOEJ50sFkyMN
	mDcLa99KXnkfUEAcWYue7JxfqgaBy/mxYOi2qNmRaXND/jnhslqkVVan+IOx58gTBGIbGbAMm0P
	Q5ESFZE10oBeRv79bJCZJ6zm5Lg=
X-Received: by 2002:a05:600c:3e14:b0:493:bc4a:e7d3 with SMTP id
 5b1f17b1804b1-493df0a08d1mr56240095e9.39.1783429465838; Tue, 07 Jul 2026
 06:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:13 +0200
X-Gm-Features: AVVi8CcTh9Rs6YX_7yLE2pYLhG0EOfuYJdmTfdwdI6hvKkhrcisIrByGWFuDPNk
Message-ID: <CAH5fLgguLAQG7mUwD1NPECYSsPdpPD_tLskU3NdwLZhKR1H=aQ@mail.gmail.com>
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
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
	linux-pwm@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:56=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
> -        self.page.as_ptr()
> +        Opaque::cast_into(&self.page)

cast_into() is mainly used when you have a raw pointer to opaque. When
you have a reference, you can just do self.page.get()

Alice
