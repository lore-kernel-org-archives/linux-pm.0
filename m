Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5424B0C85
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442172; cv=pass; b=dFWgs3Iou3ASDgyYfw+zpUZ7T5sb2gKp/nY3LyY3iZNSP71BLEMYG1494UwdQr81xq/Ew7NnzYEmSGl/eyC/Ur4+BJ69BVyZaCwgNbrKUx5wHHLHvC5sFdHaBFg9Dl0eDCWCubRJu/jdCVOR9C3LMZcpZAj7VVQQQwdFSk6lJxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442172; c=relaxed/simple;
	bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOTUZ7YMOfw81cwaeoQy9OCCmjp9Ojl/ts/lVD1/7jWAscO5H9B58KabqbFFmFRTt2aQVfXcaIsFhknNjplkEx6RmWAqSPdArHaXpNb0t7huO5HvhjbZVUExJ4tU4bccNKBobICrKQMEpw8P1AJ4MRtLFRHNX7K/7OGgRUl9bTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QibOJQnk; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QibOJQnk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6fec3c1adso3626265ad.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 06:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788442137; cv=none;
        d=google.com; s=arc-20260327;
        b=CC+QE2Dd+wUN86Nf4JAcWu8Cf97EvFArxDxm7jeFrDV2BKsW2wz53vWP4FxSsfVb5g
         fI7FuWCJ0Dbj3qh/0SM1eQ5MaAiGHSedEXOxNRXyNMj0XeSYlZStzslzj84U91trxIO0
         GFivtbF16ZekNi2/MPgKEqt4VvZd4DT4vchGbesVYsx6VOjlg0AflWzQ0MVetFrfHuQq
         YMocS6nLTC7cIRdMTD5V3Gzbyd52imOftoTEQmkgDwdFntCX6KA4xEbzRk3dkHx5o2+s
         25fAcDL3CspcPyyOHY+zGo0XrQjitxAgl4bGVnXsvkXihCXzXTGYvJmFCXwl6tyt7Owh
         m4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        fh=qM65VKTo9ykrrH7G/pcUfPSp5b88uG+b5Dl6hvLOn+A=;
        b=pIxrKm9c07K/JkqUUesJAG4q+yA/tmFqJGZpMQljdFF6wh4zsugBdofvUhbQLnzqG2
         ZsFoGEkVKRdjwTmYN98vr7t0HrS17RjuCQeHd0E285GHRI8061ExB5dBRpCe4VW3n7Ac
         yMiOy2HGWeCjJ7HshmS1P7WX8TRFGX0A1CwOUnYfJyqI5PPpLd5ELcFrwqx23piCgGd+
         Itb3h2HGnczIXsktOe30COAbFeQGAu9WmyZQi82URjQIPxca4JSzdwu2luNQ9IJYTe6k
         m05NfDyfXq4vLYDfYpvWeae6LI7hn7Xc8Bmz2q1B5KyOmGluuGUYjD7swt/2Wpdaf2iP
         syug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788442137; x=1789046937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=QibOJQnk1IcJqAPts7niHKXB4MYd7rKKk/wudeEGKQp0iGQwDGwevv3JskZ75xdch6
         jfqm4L1dCpknWVRfoup0pgPVeoVkxrEgPBofP5UlvVojRvaPkpNXhQFo3YOpI5eUKzJ3
         oVIpCzNOrezqt2zVbyS0+jWle3e6IbhPsEo3ji4QqZhQGS8vqm75osJq5KNHbniSe7Cs
         7IMjXLKRAKNvoWjZP6f0QpU7q5nxhdS5rzzAAq7Cy/eRo92sBJSuU2C/89sY38/jJfVI
         jvANMBPDBxnLupAoA5f1OGYcmYjS1lAQ1aXvNLhVjMv0fKwt2U1nwuAN5oFlZ7SxOXAL
         4HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442137; x=1789046937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
        b=CKXni+fe5kDyPUoadjMiO/kzEkpKJJ+HcPT1vF3b07o67yDcy3IPTA0PhQhBxnmQgh
         K9j0uteyhK5KySRI5jIfJPFFJfWwzLDdIPvizHzRa1wpW7noqr015li3sF3/m3Oqes4a
         0zEX8CjwYYLfYiUu8oWBAql6XIVrh0CgVpLXbcLej3O4etT41V7Y0P0LISdLvC03i462
         52skGDvzFuOaOKMsV3t25FlNbpw1sd3xi4yT+6DPU9q8YBHz2mXPmGI0BaNAaH8vAnMp
         O9peGGody9bAkas+Ik8GtMYGipowd640SUtst4bw0Oygkx+BEgza3CHq7UxZbsM4gE0o
         NWoA==
X-Forwarded-Encrypted: i=1; AKwUvBwdrQQeM4fGEgalqq893JGvsR3SG5rWe9viMyiMx93ILgTZB5QwsT7rL0psBEzZEfEUFy9dIv8pmg==@vger.kernel.org
X-Gm-Message-State: AFuF++koNeSwszblNl8exjpWQYvsWAaUeIlc7ac1hXycNhrkQfeCiMqR
	Q2Ane6DxRJTLJzh0Ayo6EP90hkYw6F0f77NCRe0nXoIJYknYhsERnzEq+SDPehQ/sTPLQLJohOB
	73Zr7FOVnuz7Q/+rVWcQ6+dWgg9f0U0I=
X-Gm-Gg: AYBFou0zEcCFIR3Kl4TyE9aSKpE7JC/Tn/0LnOHiv/IDvstahgmSiBGbDPGRPUDfggO
	aGtIswAh759k5+dsu5qDsqsXvfZVKrHb7358gfFulhtoLRW52wZlOIsQb854l05LRLOxdUM18Nf
	ALFEB98d38QFzoPJsHpGzTutRkjbi7lFvCxPs+C+t83kWuHhUjDWjf3ebp1YxjZ1sG4iR5+dRYZ
	nWCTLzU30E4fhYLYfBbT4+aeO8tK38qLRFUBXM0TYzmXDtpbPJZT20rpdT0lVsgX5FZGdruUpk0
	qDxXf4LUxv+VxAfrOItGk5E1/XdE1y7Dd7YSqZ14cRTe+Mauv64G7kmJGMFpcUCRwOl+IpKrlue
	+JQ1gp3HVhOMPBJvsBLnbv4umxHbvQL4AGbJro6GM11xht+G62A1jWXWrgcF+
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr12609481a91.3.1788442136905; Thu, 03 Sep 2026
 06:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org> <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
 <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 15:28:43 +0200
X-Gm-Features: AcwNN1XsmuEPyO39jqyvRGfAMw_DGGPMkiDRHtfg1ZEoNlBhpVDCHnmjvBP_pa8
Message-ID: <CANiq72muo8SotJHJQhEe=2kiprbrQTvrEMqd1Uw_7yNSfA3Gpw@mail.gmail.com>
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

On Wed, Aug 26, 2026 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Do you want a link to this issue with a regular `Link:` tag?

Yeah, thanks!

Cheers,
Miguel
