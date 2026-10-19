Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAD4DEC05
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415123; cv=pass; b=WxYMQ19hXax7uc+TzGA8eOxC4yx2yKCmVLM1ioxo/M/rBF/XVLn9qVwqQBRcLms2oriEiMjx7CjBR9rA9WL/OFg0v8tWBT1+XgJCvITYeE7Mjhi2vuro37KNvctJ8ZZ70QXNvbiQvuuRVrk7SVgOTtGCav7lZIK+0fcF9L7uElE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415123; c=relaxed/simple;
	bh=mysYr6A8Sr788QG2Uz+xMwHs9QNcHlODUZov9aP5+dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDAz4lUjmsk+EniCOTDVhSK12+Bs75IhmLKG5JBwRcnlTwl9yn3TYRC86qOoiMT1szpIlZlov9knTUov99NYOGYE7Rytw9kWMSqARdE1noF3fIqFc/QWeI/TVzSROAvrrfkWfbC2/EQB+YYZsdorfyMxVwgj9d60MJ7h0DRnzfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h06ZJxSy; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h06ZJxSy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-487049569b6so1063173f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 06:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415120; cv=none;
        d=google.com; s=arc-20260327;
        b=bBuiJqKLVNzibSUBvVd2xAFSHa8wLX7pZjHwBXncMlKMqConLMJVuf5+jltvtLVsOS
         9RPQA1jVw6LkJ49XaedQQCrpeYzRmH+v85zwug6yI/iOCNYXM7sSjI07QolXsb7w22NN
         rgzmfk/k9kzqkJ7QGpAFL1K2ZR1qLpPAhUbuFobCPAJohAluUEFcdorglVH6AmKGb5PO
         Dwn9N3Eq+h8vBOsNqBzQH53HknVwhNyuQ0QBdcaAari3pDSO6S/CLAfATuLAX5LLXfWZ
         e0utjY+Ptg/8YlHA8D/AM2ZKJaqJcu1nRZgakkPiqDScYcGoBuhXXW0aXahhQid+4DMk
         B4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LP568MdjFLUoc9cCkTY7fbjg57xRLci7XApvAwiXZXw=;
        fh=mWSOgpDRR2YjSeEcZ3TPJ8AJCQt2VJtQBjxMQhB71S0=;
        b=CJxrm8Zxdl4XXjVaobi/qZFLTreBU6OznwM2tYEvDQwmYFwVm6XNP/hw21L8HouRBW
         SvkhaSGXcmJ802BYGrmcVzNwstIaUdvWN0Z9PrTH0ihoWxU9cuUGHaFYbe/z2SoKC/Oo
         sj9MyMN5KoU5J1VTzxdfSpK0sLDsaWWVhF8Qk2oh01K5FtxFG0udy991xRb5vTGf7TJw
         mZUNDC/hb018FnUvSu6rPaSncN9M3pMuo8P4lae3trw0JsMY4iJQTPGcogy7/sD3+bb0
         nSngnVyAjmI4hP14DJbloPO5XgAgOpbw2bj26p2vl0wQfAIKbdro7PCwDcNk1M9ui2AO
         kLgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792415120; x=1793019920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LP568MdjFLUoc9cCkTY7fbjg57xRLci7XApvAwiXZXw=;
        b=h06ZJxSyJzHBkIkdcJrxbNDVG+79WZnYHCG7CZghSHyk3JuncPcIX0DSVEo2rZirWI
         RntnJqrfhocZDDvG3ouVtrToUHIOwWxe5uPTlGvA8bpmrthXIDs3h6cPB13yJoRQzi9f
         fW+ugKZE7rVU2oTunNnRhJ6rijSpb+J4erCw4AWiva4/Dz/PTsFyDoRQxGtEVHDy5iA5
         7Qia34acg7wD10Usz1LMGHCuDDSYWXVaX+UjtEgBxgHeSwaRfQJawzdio8Q2lZbvnl5O
         JVsZY9jRlggtPesKO6coon5Gs/JQlscflXNzt40MXIJySv+GYrU9WC8beZ+X3b1cQ4lC
         2a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415120; x=1793019920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LP568MdjFLUoc9cCkTY7fbjg57xRLci7XApvAwiXZXw=;
        b=flbyMAG+58Au91XpFRqpp4ZHDGx+gsV99Vnsn4q8INcVDPOsgNL+Ljznc8GwL8oBtI
         adBiXxXu+XXq8Hh8tVUND2IbMBgzPnaoySE12B9Z8sDBDx3btRvZJYA45LOrJC14wdug
         yCk3VVkbNbjsfoBq9jnunxYovSnfY4R6Z4MFPb3H9sDbqvFXhGJLf0X/5tvFVnjLkl7n
         Jh643X0ThiHwfrJLRKf+YftZCdD4UJG4LzP/EDq69Go3/CTAkhxp511gRL7zTnu3yfcL
         SjqkSfP9OTxAP/yBpLRCtkoKqDJJwnj1SJnHdWEdk94ArgalDRxdj7jf6ju3yAjXHovZ
         Lchw==
X-Forwarded-Encrypted: i=1; AKwUvBxql9GNC85LCXXGI1TPFOR34i3rOmbAtSfkUOI9eiGpMGBorq0Sd8ISzDD2cZKNsW017rLJAGpHKA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLj5Tco5b08DT6IKrZEU5N6gP8Gn8IYIFKHwQct9GXkCMYsS5nO
	M2mcRfW9g0/HROlbERPCMvwuZS9oq5JqPv7uou+W6fEe3PjJYSJelugIh8GMkgKaDvqG7tz+xUd
	bmJY/slJNvYPmH7IvWR4yQM8r38shv/A328kBd8MY
X-Gm-Gg: AYBFou3sIwcFASsYVQdxhqeDzxbAI/iGhj6b6PS+bYODyxBQI7iTgZnwLx7/UU18TC6
	0OYOJ+FU1LyCRS+Q130tl7zlMYU0kQ7i32SxETI76uIWn3e/DuTcYTC/6nHen37xhM7mZQgr3uY
	1JSywW2+57xpSeQ+ijgDcua9+9Q8X93PtJEd75um2WX9DjfmrLW1iP+LQtUoJ3nGqOKK5Tbb54f
	pe1eqcvXUXOOVGuyh+gacKQ+r49zkmDVwiusvavUVVWD8mtaTt30aHSRiEmyXf+Z8QaRU1oC0xu
	NXfkuUl9VjmJQI1OSxrnqon8nIYJVCm9N+1+bGpbR8sS1qd9GiOxgg/hx/xyx743jF+k/fSEO3k
	D5gv+wkMwmfErVTCgZFBW9stiMW8YQ5zhjPaiJWQwTlyU06AgljeX
X-Received: by 2002:a05:6000:4025:b0:485:8c17:9764 with SMTP id
 ffacd0b85a97d-48e07fad8c4mr14437246f8f.38.1792415118156; Mon, 19 Oct 2026
 06:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005133857.1572243-1-beata.michalska@arm.com>
 <20261005133857.1572243-3-beata.michalska@arm.com> <20261016121230.3724323-2-aliceryhl@google.com>
 <atYKvHQm9qJ9wY-e@arm.com>
In-Reply-To: <atYKvHQm9qJ9wY-e@arm.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 19 Oct 2026 15:04:43 +0200
X-Gm-Features: AclHuK_TBh9nrF6wdCskikKjrKbXbBPQNYzprNDJUvoT1849kJ0giuue1RmdKZk
Message-ID: <CAH5fLgjcqHJs-mVsmUVwatyap7BOKU+k6LiAPFkqOcqC3soB3A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rust: platform: wire runtime PM callbacks
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, daniel.almeida@collabora.com, 
	boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
	acourbot@nvidia.com, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:19=E2=80=AFPM Beata Michalska <beata.michalska@ar=
m.com> wrote:
>
> On Fri, Oct 16, 2026 at 12:12:30PM +0000, Alice Ryhl wrote:
> > On Mon, Oct 05, 2026 at 03:37:40PM +0200, Beata Michalska wrote:
> > > @@ -223,6 +225,14 @@ pub trait Driver {
> > >      /// The table of ACPI device ids supported by the driver.
> > >      const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Non=
e;
> > >
> > > +    /// Provides driver's PM callbacks, if any.
> > > +    fn dev_pm_ops() -> Option<crate::pm::DevPMOpsRef<'static, Adapte=
r<Self>>>
> > > +    where
> > > +        Self: Sized,
> > > +    {
> > > +        None
> > > +    }
> >
> > Since `DevPMOps::pm_ops()` is a `const fn`, can this be an associated c=
onstant
> > `const DEV_PM_OPS: Option<crate::pm::DevPMOpsRef<'static, Adapter<Self>=
>> =3D None;`
> > to match `OF_ID_TABLE` and `ACPI_ID_TABLE` right above it?
> >
> It can, as long as no one would mind making the Driver trait sized.

That seems fine to me

Alice
