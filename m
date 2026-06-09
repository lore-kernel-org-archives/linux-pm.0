Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16795327C13
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014276; cv=pass; b=uUg+k6Ry8lukNhQtHCMRoaeBwbrSr0q4Xv86ImvGVU+xtW/+G0gyUG10g7p3B+jXSFnFfjdfOWzdO594d//h5y6n12Yb0GEO93bxI36xCS1/a3Vn4u+OIRNr/PUiTJDCD7maRpXv64X3oE7UeVYvUBysdJKPN4ZAo4Dd8FqkffI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014276; c=relaxed/simple;
	bh=O7/vXOHmBuDEN6iYoEcXZX9SQVUOxuFM9K3LUsWI6j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIcn2G9x/RP+cJTydHerC33qcXMZPz583ccjkspcxoe7wOAtyN3kFg1/Mw2yRM/CKZHMVMz1hlPZIlI67E7Z5hc+yOsAgNGPNedA+gXc4rDtvk0ZXhpbGgkLLgHAliRiHzB0eZZEbyUYuTiG2gcX1gZTVixq5qUf4YtOFahV4Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pO6mb/Mj; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO6mb/Mj"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3042a99f0ceso652505eec.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 07:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014274; cv=none;
        d=google.com; s=arc-20240605;
        b=KEK0Ob8lUCbjYL4w+e2PcAI61F5/TW64pIaVdbEqYO/21F5wdkwG9s2VISb2rLP55p
         Zry8mMydFEUwGicC0qeoOXlodifviFO22zG4y4ra7GPz9ZIW6KcoFxH8Moj4/1yhq3Ze
         OdzaqaeRRgItM5nuebMeonsOYZRaZ44+3V0//JD/pMVeTPKQcLcayZtS8iOSRCKK/py8
         ra87DCjB+W+6mtyXh5iMXqwG/7UBFy6m5a3t75mq0526b/bhWIpWQq5qkVpQN/NQTQ0t
         CYxLxOMeDRtzkKuAy0Vd1ibzN7keUu7rAyw+07hannOBsz4CxDpwHXZv3O3JZbf7z5Fu
         ywfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        fh=Kwi67TUoPlq57dIgX930qkZMGzdbqOPFsVMCdnFArfA=;
        b=Yma5DM7VQSKVlmVd/0ZDBkTcoAolqLfU/wo57saNFNvkUSZzRVisgT6bfRNqPAuy5q
         Tfj04h1EJtZpsf6HBRsab0dgTHwcKBFZzj4WwHQpbQ3jmpWKeoYVpzW7npiM4rW0ypor
         ooOa5hIVynl7n7P70b2FBksoCPpaQViNwTVLFyNysB+jyBQ7gQjYiH3iISHa89IxJNo4
         3DUomyIG3upVHP/J4trshvVV4VkHKabwS7MeBsFpeKXWy1KgxMcy4OHLj03T0pIps37K
         0P89BgOyVzcn31k0nAW35ybUt0j3wuL7hEcWoONOA1q/YGLFAAolg9c9HZ+S6JSuFdm9
         76Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781014274; x=1781619074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=pO6mb/MjV7+9Lyoy7qKEe8jyrmAVmp1sVk9ZAQekGJY/qcYqRSPwEAedKazW1YDjAo
         daWkJzVnMyQBtO7fmggjHQ1cPEQGXHlt3VIr6I1Kj1CO/2HtnymY1aGpvzlRB8OH+ilA
         890WtpQyksZUJj37x9K37O3XCrrKWsg/O8Y8q+MGEolHuY3O9nF+Mz46OcSl6XEeAyYn
         PpKFuaWCdq+j/LCZ8xHOrMCCjyi8dyUYIO1ZCC3Qs9hwAGz+a0asgrLpY7oQ6QrXmnr+
         SzEi2Ndcvrsr6lg0pp6Uccf0k7gE8QI2hRsXCNfmZx5mer8km0ZAI5cl8BunKE5GWZwg
         VvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014274; x=1781619074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhjDW0OszKJAGtPcPLD3bV8YMBm1E7bkkVTPi52pFmI=;
        b=EJaFY8GSn331N4aIMWLow91/b/Rq9vOgfPwvaBZfcvtcHDxICGBMixRkYGny3akM9Y
         0xVGxJPn3sV5+ZMnRQhE4kQmwabQRd6Kmmf/g7V6pOZ0F+AJ9SNQJBhWaC5TyTUDNH0T
         Pis6ktsHHlybmpT3HogkbgKWGJIZJO2fZluBTORM2NEXu4AnUReKwnR2vFVLbE8gbRPe
         OqKSCu3prudSYynsyCcO9UlhuUdlvhMhPRaf4XLLLpXcSMjAEctziIKXnMkPtrgX63p3
         PrJqqcdZ9F1Q1p4Zv2jZGk1tjoe6GPcBlIN0/U8Z4LhkkcVwNFzuWEb/gYA8PWlS36u0
         AWxA==
X-Forwarded-Encrypted: i=1; AFNElJ/WctSWmhMMlQI8X9wGXxlSOYfgE17HUayj35J/Tb1ygNaBOlusWIcPFLEunuBFyUFa39eS871hcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1s0VMe23eTwNL/b0W1CQYpRdJ6wzcpE/9ZjOa7b7398eo5zaj
	9YoPolXqRQceAOEFevO8iJXDIRgBl1UOw2VmyuPZn6tgfhuHVeqU5RmdjdoHNSA5u20LoWtOD9V
	mCRBtHDLXk4ogop6mnjx5AeQBX5JAB88=
X-Gm-Gg: Acq92OEE9DGq8OSirqYoDsrfuVb9vTM/azensqeLFDaI1mFV+JpyhMy2Y7FTjexSnRT
	E0ceSbaAJG/xwsmVinWRy10kSuqS8e2Km5+DdiaTOyyG7Edw/BBSedzdzrqI5MiXT8EFoweoBwQ
	o6bkvhVmiIhTWtYs0eostNeGzrfR+n1mq2GaY742Z4D1nFq43BOtlCCTKbwa0QxhF8CdWoeiZPL
	ylo1rbFEZ16K3JCtk/Bq/ccMyWT8O8Zy8DYoDLyGCU3tNkl+j4Nzp/HR+fBD1KLjZi+lZ4TquNU
	1iOVWSo2Rrv9aRJC6sV43As4XYgBdQh4+PrRSNzWURWV3kjtppbMy/ld8KSdna2SajEw/heVXMu
	c4SHvqQWKj6E1muVR1pmYEdaZ7/nH6dfvTQ==
X-Received: by 2002:a05:693c:3749:b0:304:8860:74d6 with SMTP id
 5a478bee46e88-3077b21ea10mr6213247eec.1.1781014274135; Tue, 09 Jun 2026
 07:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 16:11:01 +0200
X-Gm-Features: AVVi8CfNPwpEZxw0N5nqXBfBlOCze0ATuinL6YIsUVP51KJlhLB9xVsEvEDqHhw
Message-ID: <CANiq72nkYJnztntLzB5jNwi_oRY+V7UMpf6AuKM07aGH9FwPdg@mail.gmail.com>
Subject: Re: [PATCH v17 00/10] rust: add `Ownable` trait and `Owned` type
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
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
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
>       rust: page: update formatting of `use` statements
>       rust: aref: update formatting of use statements

Applied these to `rust-next` to get them out of the way already since
I have another similar one for `str` I am applying too -- thanks!

    [ Picked from larger series and reworded. - Miguel ]

Cheers,
Miguel
