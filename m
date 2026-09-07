Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45043BDB9
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773079; cv=pass; b=QI2N3Iy9scn/sl+Ea2wj0axDFvrz50avqlLQcacrpTZkCjI4ivteVYinBWaBfRi6oEdy9xFbdGhQW+BU1QdKilRNqyq4+t4vjJsplCb+XvztREKk/qayFITtravwU1RNkwHaOiHd2tJJdZS55eKrOOt0VvRrjbkef3XtTenl1JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773079; c=relaxed/simple;
	bh=cSfmMGgIFwjjaaI7Bk9duU/SsMv1zgWa3X4ow3p9Z0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU8RfTaGEiKFuH21zYwqVvFj/HXO54ClMLJLv5GGRVlxFYl3sxbXySK3EMupr1xjP8leFVsLnvgBu51YfnHnqpmZLBVpse4S72pArGrth4Ug2mV4tXDBQJNj1eZcO1ter/sd0F6PTFfiZVrNPF+HxEJ4k/omXe+vVx0zpufHWh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYzWZS6h; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYzWZS6h"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-484362f5c4aso4214894f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 02:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788773075; cv=none;
        d=google.com; s=arc-20260327;
        b=hxrSPEZxJQbYlQUIAa4gEafOwdjkrqqvK0OpTSc/0s5Tzz7IhSt6XEfRfUaxfhpb8z
         D8F4fi391pWxlUPTLNg2he+heqjnTQYciNnSdzt42KaVM1PodyVh1cVY/P1GeHFllKp9
         JgTerHNAZgKul5sfBzZG9oJlvyV9NfEvFFrQx1qC6iGoAhCBK9uM3oMJD8na1e2rTzR5
         YlFSd7SVn5dXRlp7Gbjlnrbf6/pttI7aTjAbwtTU3cH7ZMv430yYJM0wTeBhzVI0HA8X
         L7wUtOgp8/PKjMAN9B/ef4ehrQQCcFksR9XVWeBCwJR02sn3x6ByT173rqN0x0Mjsg84
         +5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        fh=3opT4xkgHeAmMa8s4JJHvcKAWNw6T4k1r7kkIIdvEPs=;
        b=jOAI6ziG86+d2vB3LyzRIKNStev/OJMc5FxnH5I4vjtgWSzvQN8qDVhsiHyAkBfT9V
         WdMr44/j7fLmlGh3qebOugE8cynkTA3fcdCqolqKotJ1aMV952s1sfXvufwPqP+aNiCU
         HvXJO3XwP0pG57CrA3YXS9rsvL3l06RPcuGx6s8Wa9/B+j55MIFac6bE+N61mmBn2jaJ
         +jwtPgmLtrkNbhCpzQCFhutKhtBuq3l4kpyWEV79rMmbxcC88DquGETZCrQCcAjWgIgI
         i5cMQyIyylx1J/yyUzMf4TNvfYJg2QB9eNNaGtQg5flCu5XNY770Qd33X2ucfQ5KR79F
         J8cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788773075; x=1789377875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        b=bYzWZS6hvyblgTmL2WcmqKBFUHHD7UV1gkXyod2CvfAo9EbydIVeGF++9jABbnZPte
         ys7ocRIu1X8wdEIGp96wY0ZJwuX9iep0RRInWAVJmxBvFDn1O/SCyei+2Uu4DEx9EFWy
         Ju0SX+/3BqiQeyfykHFwlXZNMjTYSHT9Hz+p1tge65xlQefntxQdIOB//wajbELDPR6l
         bZSz7BV5hpdU91s0tZALuvzT0BaGoZvdwZ+37h8mSbXVV8RthaPq9o6xvdh7qixRCia5
         5aTu+haqTXNlK7d6WQD6MLUT44ym0DOgw7EgnQhTgLv5A9qh2xRN6Nek2Upj1f/kRQ35
         VQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773075; x=1789377875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfGjfP8T35WEV6rGIAsKY4f5Rwo6my7dAG0voowddxQ=;
        b=fH/XIEFozyGD0lTDUQ6qe6TrbZleYSv0D/66tU6gffYa0wFeWY/8HcPyTC92dgFF6a
         UuRdAccbJivEubbi7HrcgiTgMjct3k+qrDIq6AIo7nwik3Obd0RChAuBak/q083m+FfU
         j0Lic/YGLQ6NBTbQpVwPM2yA5MBneELhYbvm5LWq1YUczFYv/3y80R2k0jXAE772B+Pi
         s7TuBzxtx4QzmOU8uJsJXPMUphxPZ2Jxf4aHGe4lVDn092DXe/t8/ep1OiPSyDKS+7BI
         IYm63V6AFrKJiDyuxQj3NNDpDf/zWrYZOYOc4cef2wVHLpwbtPyZpwSYoOJd8uZoR8Vf
         mi9w==
X-Forwarded-Encrypted: i=1; AKwUvBz9E0U9kj6uIJVKLLg5UUVaX89+VP8du8RF2ayFie3QJXpfbfUSqdzxI1/7iu3bck85oGVGRwlSkA==@vger.kernel.org
X-Gm-Message-State: AFuF++lp8ryfPiGAXdEpSotuHHNanqWgWiFqRBOhDllyaLyKBoPr75K0
	+Z0GYI8yNj+0f6UWd73W6Fi33A3Fw4Yph0qvh+679oaCj4wyZmDFhcnUMSf3p6vmRy4dlGpLYQY
	ZwJHZeJ8PXeCdlPcTfosCkx9Aa5QcFkJgoAEpLFv/
X-Gm-Gg: AYBFou3Uvr9CnJG0SSt9zmir6j5gAdjL82ekjo6mFw8RpW8C3HkTtMpYXZKhkv0JAS8
	OrDwQNl9S0aeyTpVnbW/Nc1HH86Wk8pNof3Q07Rv45bu62xiTcKQ60c0fbqP5EX+rA3lcLj1su5
	8fIe9USrTFnSs9KdDY6AKjkuKz4Y7Pd3cDIMOrwcBwuR4bY7V+3w1Tpdja9GJhkBnwMYGEommp+
	6r4/f0BjAq8P0yMOKLMXRtyueUGVPZKiwf89gCBicgHXlajDnmocPK1fmTA1AkWFeIBjrpqrPdJ
	dk0q78MXsWXtbSY60RmIxzsY97dQWZBL3ngi0ynzPD8FHZ4/EWtAdpsilB/DPhVPvEQj+zadUdP
	wf/bW8bEcOGlqjPgeA1Y+6yZIHdTbZCA=
X-Received: by 2002:a05:6000:430b:b0:485:8ad6:3752 with SMTP id
 ffacd0b85a97d-4858ad63a6fmr37026021f8f.5.1788773074197; Mon, 07 Sep 2026
 02:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org> <ao2WubjLtDuHvRzx@google.com>
 <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
In-Reply-To: <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Sep 2026 11:24:21 +0200
X-Gm-Features: AcwNN1V4plkowyMHAsnIxTQwxzR-aYAz331pg1N8okzwNx7uKX70uWh-YG4Yx6I
Message-ID: <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
To: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> >> +        // SAFETY: We just successfully allocated a page, so we now h=
ave ownership of the newly
> >> +        // allocated page. We transfer that ownership to the new `Own=
ed<Page>` object.
> >> +        // Since `Page` is transparent, we can cast the pointer direc=
tly.
> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
> >
> > This doesn't satisfy the safety requirements of Owned::from_raw()
> > because the page may be used with vm_insert_page(), which increments it=
s
> > refcount and causes it to be shared the vma system, and this occurs
> > before Page::release() is called.
>
> I suppose the existing vm_insert_page() abstraction we have is already
> problematic, because it uses `&Page`?
>
> Maybe we want to change the API to use `ARef<Page>` so it already has to =
be
> shared? Conceptually it takes a reference count from a `&Page`, which isn=
't
> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&ARef<P=
age>`
> to be able to do that op.

Honestly, the problem is the safety requirements of Owned::from_raw().
Pages have a "special" main reference, and free_page() does more than
put_page(). It even does something when the refcount does not hit
zero.

The correct behavior for Page is to allow the user to hold one
Owned<Page> whose drop calls free_page(), *plus* any number of
ARef<Page> references that invoke put_page() on drop. This way, the
owned page controls the special drop codepath.

Alice
