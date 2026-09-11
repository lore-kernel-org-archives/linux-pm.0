Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342A47DFB0
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134213; cv=pass; b=RiSS+riFiNxJOjDs+PnRWf2uczXkDOOZzh5JaNStxtDfXn75eL5EM4la7yk93EpXKprBJRp8B2+WD5qIrV1oDTOFWERAucBWz+ErEoEopt/JI+zRJoGG8qj77QpDX1z/0il/yZTVYL8EXmDtHKYkxAvvJga9PjjA6lELZ+AhEUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134213; c=relaxed/simple;
	bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTKzp99AJBvLVC5U3WuPWhm9K27gfT4+rwSM7lSrJdwc/11vToIc+44MfOfopEgmtHhYfoPQW9mR5r37rMze4P9u1tGe7a78QYe9Be0DaK2PD5guPgyMIcxj9EyzI1oZ3ayNJFIr6imgBhOSoNWhhkloz2p0DYj8uF45v1VxtK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehf9dS9K; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehf9dS9K"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso11540415e9.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789134210; cv=none;
        d=google.com; s=arc-20260327;
        b=CRRQ7K6DpMpinqufXJeCv6cERpQAZhmrko4jcOcdon4yY6+FWTbyJD13ngypH5XSkH
         7Z89qN3EoHbl46jExt9I3S9+OVWg63OA7P4Ze4bAV0epDTPKWHoNFKUzCXh65V8+2h3P
         hhmpQrAJ09EW6OV+VoudxJQuJOZZnkjb1WDNcDFKBIi085SRMV/qKCl7UoNi1T3XUR5Z
         Vb77FrBQZsH9AxkblWMwdAQaKg0heJZ1IeR1biZxPaKHdApVQUEEFLKT57eE86jkqPJX
         vcbGmkKAnYiYh9mEa9Fb4z4OwCg2VzMChorR/MLKH8bc28rzy9Vc8/nqml55ZBzD8hVz
         yZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        fh=I9Hisag/q9wkKB0GHACUDOC4nV8AYWmAq8bxS0Epcvw=;
        b=L/mpbRQjdJI5n5yR9fI7MOyj2IcM+WJ7mfz8k41rRfwGgUxCcX3HczVNGMHK+SU8HI
         vxFKDNwEKIDGpwzr/G3H6TuXJ5hffVTYYBqMnfwCuevQe0nZr1d/kRKNyI9H9FGE19x6
         yenEYOQEBcxumTt5lpt9Zm6CEp4+9rv0nx8g/2BRv6o3ffcimgOzKcLti2CYg8jsEses
         rB8Xkowjk0q52wQnR0eFRR5l9BdRTAbtnmsrcUrb02e8l4tREdaCUPjQmJ3ll3ItAAbY
         JUlEtvS8aumimJdjUogMMlG9trM2zpxzpakS5aU7VLuLyJLAXw+iPhi7Sn46QSWEpqQl
         pA1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134210; x=1789739010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=ehf9dS9KBtz8dLPV1eOtxc8kmJv+fOyIVW2ZdO06596kBMMRx/tyUK2lDgVQgI5M/c
         SSpBMb7uUs4G1u34797nfCD7P+9zLvxXZxAHnuR56Buv7tbMHFhU+KXC31bwb8LxfuHW
         8rSFo0UCiOxET6/EGYFoQmdn13E7BSnpGDUmtBh5eTd4sQzXsa+4KMiX2L2pwFInQmBd
         XbtYZ8PflSCvO08pB5VAXZaYQ3wTj5HZ2Hp+yRGmtaYxRkpKM8QUHwvM09P+tJQDQK9v
         QG0xK00MrU/0875Gy+xMQiBhNe3qdsPJOLSKMbDDhT7ODGKOfLVFvcBzJ0WilrEwQq0E
         IdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134210; x=1789739010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=Wk1yM9/TSf5dBS/pSJgpdB1rDu2L81xgvaIt7eA22Qxt7fCfaSn09I15BAyPSlc2Tr
         nOgOn3LpMLQBQ+O5Pf1LnysGxjKGL2lKNfIg7W48QGShmHeO3fOZyXH2WXVfm8p4ZPHb
         SV65oHxZkbXmTn9DCgfzmVJ7XA8Ja1U93AzHpxK8W4umElQ0OAniIs7yr007Na17LwbZ
         /4H4oXlHMvcOU/W2uc6vED405bu5NbCNfUG80VzCuXzWYo2oSukhqcUTo9kts2pWqIuq
         jhxkgGDKZsaV2oJeamREHxY9QH1vKRFL10zC97Cy+Hn9oa8StQbxivu+wg+LxlouBBod
         cCjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwY3pzJ8BdYzD8FKtj+Ai6dEUFgqttTfSrJzKuYT01ZIysi2BEYvVfXUViHMhNWBy/arcQlYcpSeA==@vger.kernel.org
X-Gm-Message-State: AFuF++l2ev53QJFPDdozKB0UANfOuOIdKW7XhVmh2JKlicRgl6uJ8YX9
	1922Q/Y8ANOUcdPHwMKZlgW/NgHHS3oUVxrvlHbVMi99fxOD9QrZCxUn9VcRjiDktip2w1kcK/e
	bgcUcQxFANaA1jdI6GQ/yRI6WD9GtCgU4Bh93sM7G
X-Gm-Gg: AYBFou0rmRssadFPBqhomIEZxPEXKSa+1UijhLGSVl/XrppAFQuVKYEq4J00E7Xroz9
	SfNtE+AZTpJakpNw2mfFZ7Pyb3jFWS3EKfaBI00rgCOIZCWQ9gUYKOUpfcb4TWRV4c427IAyjLE
	iaeb1vDPZCxc6rVZiTQd7bW5WEniCM/Sb+XjCb2w4eyXHDmOY4eenf0cUOhNFu6n1pW88QjmnBS
	bdvmvCR2eHNihhHeRByr3btDfd1Qb/pK4GzkRihWvxZY9TrKIH2X8OTY+te7ghwUGn3+94W968o
	HbGkCGmldgTKYe502dr8WxSUmxO5HZCExdtLShjFLp/Q1+vZrZi2jhsfckTkrb62seqPPdS2Ynr
	1C4LcNcqoyubp+K9AQaPiFeyvjEw0i5PAABXzbUgmwDqEsezYzlMp
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr36939915e9.12.1789134209249; Fri, 11 Sep 2026
 06:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-7-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-7-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 15:43:16 +0200
X-Gm-Features: AcwNN1UlYe5vy_4Ph8n7W5xph6nzuuUOW4o-tvYKznIiNAx0UgbfO_rFNfVUhuY
Message-ID: <CAH5fLghC2qRh8qNmMHMWQXiWW9FAPdd-O4z-O-17FFDB3hy=+A@mail.gmail.com>
Subject: Re: [PATCH v21 7/9] rust: page: convert to `AlwaysRefCounted`
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
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> `struct page` is managed by a native reference count, and kernel C
> code routinely takes its own references to pages, for example when a
> page is inserted into a VMA with `vm_insert_page()`.
>
> Thus, implement `RefCounted` for `Page`, backed by `get_page()` and
> `put_page()`, mark it `AlwaysRefCounted`, and return `ARef<Page>` from
> `Page::alloc_page()`. The page is freed when the last reference to it is
> dropped; for the order-0 pages allocated here, this is equivalent to
> `__free_pages()`.
>
> This also allows `Page` references to be returned as borrowed
> references without owning the `struct page`. Remove `BorrowedPage`
> and update users to use `&Page` and `ARef<Page>`.
>
> Assisted-by: LLM
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
