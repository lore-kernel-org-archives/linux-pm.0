Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B646C855
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117799; cv=pass; b=aSc50AWcowptMgYk4mh9x82N7nQO0LduUkSiNphxnQ3mt8C9O/+t58Pry9KzdG1IURDgpclKeFAXA9pKcX5wkVyMvGADCld5ghht8lrLw+BjnZyOU3+nQaGtAN/wrE/Y9aMvp/nx7Glic5ESdwCTt1yLAhzl3/yQ5Me5/hFJDnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117799; c=relaxed/simple;
	bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNNkikQS0u4lBTDYG0BsOAPnPNDW4N3xmNNcATCveI/OC+ZQ9xLRKtmr61SlBU7cvtBbOGLHLfGJPRHp5GHk5ZkF44KRSyImyJqxZw6WIrWZ3Q67IJyQM0JzCxLGGo2zJHuKEE4w3UGi1KLZOKbsVGRaM/ciocf4YqTyF10t2/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSlPe9Et; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSlPe9Et"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4843e9c5960so603267f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 02:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117793; cv=none;
        d=google.com; s=arc-20260327;
        b=UMJJqudQVnzMFCeJsWIZ86y1qjllSSYMhkcjb1qnH0TarwL3CrKy2fkbYxONSNiIte
         Rm3iSsz5KmhplJv8EQLr+IGRtYkisdL9NKkd/7NvV4mVmOJiSFSIlLczj7cl1BoNkdlg
         oMiMcmBGl76oxlAKqZmnAT9jUwoIVPmDRtho8Rhn8G74ICSjNptUaJprx8f5y/EUbGib
         2hh5qUSm9C+hkVa53JEElsOjzPoxzEZ7VPKivM6TS7Uwg6vlQHXWtaZeC+QXg/xQ7826
         o8TkGvJPiERYV2PawFFFUxCtdIuOLiEguQ5AibxEqYBdcrTh57ZUH3ZaF6LfTHppvusN
         6G7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        fh=yVtFXeL8y1htxbGxOnF42cMlwTMo7wjm8Y/VYTd1LwA=;
        b=T/gH/ZbKA0Ty41gP//7E5Lxp+wdKRwUEctd+/mek1yskHas2GteaoAM2m7jq0UC8Ao
         uotGKo6zkD431TwZ2d1NDHRH5/Q60vDobQYAOvdWYC3THfAzXPIxZZRq1b8ty4zHbX2t
         Pz23Xvon2uAX3syQkNNBHcHzTGCpU9H/lk5CEsxftbMtTMPaJGKLYGsLKOqzUelKrT4F
         ovJkugCNqdzeZAZ7vqcS+iw1W8yRtUhzaJp9X0DPoG9ZABLyiMvsprmsYv6X1GI8A4q8
         rPGYKjEKr5Dl0geNW5K0V7vau0Wlr+b2JdA+buv43CrJ0heVJX1aZV/3P11DPB4tuPoR
         MvUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117793; x=1789722593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=MSlPe9Et/aYooxs+mmr25pr80uFZG23i1Ff+HYNwoUYblRVkid0l2inKFKvyYhCHpA
         74RMEIvUI+LYnoLKLKfOmV3XsO+idJkaF0kKg+yth0rRQtl5E2y2iqZ2+BzrV44esGe9
         Gfqu0/0FtTeTt/gj1nMdkeGllp4GG8/dPMW6SAduAajB2PJTTh0EyTtISUFtDK6olxs/
         iuCpPN7ycYnpIx1qtI10WS4KO12IM90KAskYtoHYQeaRXYEsRQKGp3BGi7i/JLvOBusZ
         K3RJXi816wGUGyT/m2NeekI8C+6tI9P5dFmWFfKhpigFYWlsVGwnGy/m0LuueQHmrlvX
         Kr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117793; x=1789722593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=bJj+syFpuH012sgHuiemVbt4PYiV4H370+HW19+GtFznWPxnSvYUj7JrmH+fIaPrft
         WhpImzrOZxF4XFqzUczUkC37XtFj/wC+bLRtpwR02VEsiAYF+5TuZ7tnxVVDSuFYnPB8
         uRYxClkyCXOv0gexc8Z30OzHuZh8TjrbAmjDF0RMO46pUjyusLCZdEv0XORghw/MEvmB
         HLKDdqqW8rlbdykZDDsdwp+IYobmugSCmbsSqDO+Ezm9vjWIvMMtVhNsFZUhqLKteOru
         yqNinsR/jDbs9kR3CD52872AvdqAwKYyF16neXNXiSsKWhLuWSWsboVq9Hyd9mV3J913
         9yKw==
X-Forwarded-Encrypted: i=1; AKwUvBxI6Hz25TOfcz785+Bn0SNVMGOpXxPRiZex7oMNAJLrKsU7nT761wrsFBxpMqrR71pN3aYAm9+BLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kywXEk0aGCT6PIHFC45jN11h2lOa5pWMpLD7eUHym//PEgRW+8
	jz5NKd47n/e1IJTDvOA5ypg/Dgep6rAt/sRDk7H/Nd6HpjImAyQfG3N8ZZVdk7N5EKR29u18LeL
	1wmkK8knF9Vjyffh7BUhY40Q3mH9ck/D/tOHmtzrw
X-Gm-Gg: AYBFou1PucvniTRrLedWGvNGHL7M7xdG0qaLJXJ07ODMOt0gJfcYD6A7s2o3orr72H5
	vkNfMRKZxGLPPkfh+QEvA8hPIS8gtfWeRgDb7c9zFWT7Uc49Z+fhQopxnozm3IqSZVYzt5p0CT5
	DtvHpFCeUObVhNINXbxVcoLDLmxytJTN/2KU/XxGWHFdXou0ve7qLtSh8VcQneMxZ93Lf3Yvocu
	fMDvsxo9hAUrnNp9lQ5IK8wxtBqb07I8bQ7So0OF9Ut4TpL6fM1hmOm3dUhTSvHGZPIy3mKh33M
	JrfO8scWQdnF8vSRx76fnIwRqjA8BR1GZW+4yZEIPLHJXJ73aAO8m5DzmrDywoYSy5yrlD9ZG92
	zX7q0dzycc1luQnxy2engzmRBC51ASskY02hyaPH83GhZIwgGDAtX
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id
 ffacd0b85a97d-486eb2fe6e9mr2544735f8f.42.1789117791504; Fri, 11 Sep 2026
 02:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-5-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:09:37 +0200
X-Gm-Features: AcwNN1U8uQc4Zj212gVRashrRro-WErwh8uVMQ_MWKQsPaL29993fZfZR2Hn4U8
Message-ID: <CAH5fLggBGvXayMT2QGo5JeQkYeJYc0L-348-kKLsBs_g45-fnQ@mail.gmail.com>
Subject: Re: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef` example
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
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:02=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
