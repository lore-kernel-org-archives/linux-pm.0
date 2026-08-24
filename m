Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DAD40F735
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571398; cv=pass; b=sx+s9UcbT5ZTMiYsriaHDQvSsBYYWI/8YLa5DEnPNlFSfwvg2S5vdHtCEozaZTuBYxXozN/599eWuKI8riD7/SqNcrTuPvl8V5GRBOpCI/ok7Gzmtp91z7Cnq8NuDxp7XmaguSOrgfKTiSIe130JK6WS3YdDu/r3cZ1nlhLy0+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571398; c=relaxed/simple;
	bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T01Wj1Fd+gSGubz3WlKxMMwx41I7+tI/fQAPzhpD6zIq7HTaU33lJHAp3jSvtH0rDeHonFAsbZsOZvv/t41BJrBwCmcw0EFfaIO231CqIY9ob291sZ5c5jHidbWMi0tcqOG6NhKF5wIZBG5iaxl4MDYQTV17cf4UDgL1gWF0U7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFt7WRk9; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt7WRk9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d30c22b1eeso2420785ad.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571396; cv=none;
        d=google.com; s=arc-20260327;
        b=rGZrQHjOfdu7x3GomIp0rmgu6vxfZjlBSVTQF4PxGWCYzIxJJ/i+cl2jimg2jBZAus
         YLQZBRtZ3GhjevMDPYAR6x2cy/I7PWGxfHDV+7DNQHX54F8WlCIdc96F9ENBfCpi42Xf
         8X2ClGmWTJweWpZQdG2HkKMx+PkZrtj1rL1svK77gVh4YDEJ5Dh3v9aDbXi6lRBCPY7R
         kutCZJlssZ5zTNZmSS1W+MCbT6zrB5j4H+9tSw55UVJkmXhrfY0nMPQupbbVcIBYdhxb
         L4BMpWom8eXvaZYsCtdoj9MldK3UL4KHWibnZKIlbql9nqyr8f73MMzvMM1uHQ2AJz6S
         AV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        fh=8pTr2bNPdbYycWLE9FSZA4GdCNPeGqdt5w4s6nIIKsE=;
        b=CXSK4AFK1+AleSBTQS4j/zFEIg9kStHB+xB20JG2QfrQFBJoYI5OzYqgCUWzzVV7YO
         WWEbwydOVdb4WNNdixYWkMrMFyXD7xR5/wWW+dbncf/z9k/h93HNAKKZL1VvEiBY/frN
         bIw+9O4fTcAe1MOITPM0cmn8am75UZ5GKeAL8YnlrSOIVI+8HZE6VLzv3NC9c64XmdO7
         cR+GABHMzBMuFQJnxmuIxFIPhP2NXnyYNYQMhO8aGCm44cQo2zgkl6gaoJXh4D04sVH3
         +qHBLdD6lXuzCEcoguOCTovpf9e49IwMfMhk50wuPMj7sPgpQRF7tpOfffN6c9UaZibz
         6a+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571396; x=1788176196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=YFt7WRk9Nw5n+i/byMsiEaa4pUCFMwIOshTiaBYfmARkFAcX/qqf8idooFji7JpJ4V
         8I34V5VPE/KG8FVWrMOwRcHp0UY7rjPa7LnUR+B2rG5woJ3E9vuC/Eh2yg/2usdoBvp/
         sgDBOYdtWrBqrUWgwPwBFa0oDvKfFJLzefi2in5uq4x8w4fS8H4cBSKU8F9Y2M+WR8RF
         QkcAvfYl7OjkWvMO/Tb3tcOzaneE014I+i3hMlZOBVF9dLsLPSrerORIU6H1VrLq3Jh1
         krdI/j7GbiJT+hC7CSjdD2Uv42ryCAzdRaCZFoOZqJ9FlvCJBlxcPbPAHtRNv4k09cv3
         hG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571396; x=1788176196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=dlqYVkZP4/z/Ribg5DZBY2AIpeXgoFCyPSnTC9Nkl7JGhtyhx7j94PQeIZ9f6zWuRT
         p2M9USag9Kz8o0W3NkFNAZBubhKrtLfiaTq+QXjzx7Gzi6obE1jXHaF3QriAkgBA436g
         RQVrnD8DsN3gVV4AqJN94QobPi51shyjqAQFR5OxNbGZ8G3ZRZYsixbUQIB+ETSBVgx3
         dm1uruUx0xUc3yHZwaOChtOStrwuPWHvytfcUxXPmRcvtaEgSoZCH9U8IcH57+l4Ukkc
         0fry6yhgLoYEDDTCn75sFGyZI0YT0q6V64Iv5tkg6aft5Q0gVel9acn/VM2mKfi4Abxp
         mJSA==
X-Forwarded-Encrypted: i=1; AHgh+RoBPyXX2YYJlpSBQM/Dgb6OkwZRbJA6kCq3Q59gBNpuyv8/B3vXmtQOa1BYyNcsrlGIiW7GG6h8CQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nN3O+jrICgd1Iq6qbNj9trYI8A1maDjbljyOLk/ORZFEINPEKf
	Yi0heVYjMWs4vrnukaGyR47tHCzUvyacbyqE68A2jmcfg8VT7/rOWaaG/Eey+Nl5/WiJSEba4SW
	GFqxSd4VFEFsPCIz+5c/kz2veGjjdwx0=
X-Gm-Gg: AR+sD10/WCSV7tx2KaaaJ1DcUoYWsxuythnAsrEsI9s2Rlu2kClC4TM1e2j7eihVpDw
	3gOhNrMieMj5Y2U6olE6sXP+Ul8WgIyTFLUi2jyQetJ2lwhvx4Hbm3lqpxID2z7f+fbIEOOeeJ7
	eqvo3p42WVKkN+J+YoJz+TFECvuWtRkIm7q/w23VAQnfV+eWilris/14DfWThRCPr/rlESco+Z7
	AiKH56ISvCGqybm0ZAy/DeEZF/rohAOPVfIGM2vRKPifpURLvBrTYDjjf3C2QzRJoF6pQ+kzygb
	BNmnbLZ3ksJZeqoHWzCRySgJ50qkF9kOt59s4oJPtoykqHPyzDoRzsJO8CzowXUM/iEedphL5e8
	KgMvkXUMKWcubf0qJFbRjZkfUk2JJ9g3IDNcQNmTPNFdWkw8906dCQuaFC3t6D5WAAsAZwJY=
X-Received: by 2002:a17:902:fc4d:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d64a9a668bmr222250785ad.0.1787571396025; Mon, 24 Aug 2026
 04:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org> <20260824-unique-ref-v20-6-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:36:22 +0200
X-Gm-Features: AcwNN1XvVB-Mna-bMRr_-WAakhrdmhTEWRag6uYdZi5jKauuC-nwA9j0nxkTDxw
Message-ID: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Thanks!

Cheers,
Miguel
