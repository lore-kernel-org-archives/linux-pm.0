Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE34197A7D
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102823; cv=pass; b=RMtPMAWsX/ybeBKmB6W340aNbSN29cUfZJR8ocODGFMtlpInYtWVEJIHfR1lsTaac1MQzLc4c0FA4jiG9EalP3JaY+KWxOQ9negxczRWXSKZWQopQ2W13bQDZ3T4XogMOTycx+xdl9xNJEhb7OVGbaMK8t7JUi5forKcCMJHWzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102823; c=relaxed/simple;
	bh=anX8UaxJ4WrYOir1Bf7AqZ78Tml7E4ZtoJ1AaNrJv6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGmJWP58pHRiUYaYzSRIPAw3tpyQS8kItCYjfHws9homgEbBqa/I/RY61rMHWqlvqfNauu1XoJiqI4P25yyPp0VCi+q92GEHUa8TcCz79+1CqH/K7Mu4vpneMRw6s90gOcfnT9IS3OAExhLsU2zgoNJAhxb9Wsk/9P7SBs+ktXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAx1F5ZG; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAx1F5ZG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so27627005e9.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784102820; cv=none;
        d=google.com; s=arc-20260327;
        b=k3jd0LZ66JjsWAwUxsXkeIQr2DsWhBvE9PS/FQI2k0cD2300CffME2AG53bNJfaj2o
         MxM7Lj8c68KdSkI09h1unNlCtzV11MIkHmPe2YCGfO16YZag3vH8M12Vl9AlNpQYQUnL
         zTyrwnTZkBlIJ7iN7pPdFmIjuH+eMu5JR61tiXQ+t+Kb4OOTnAeqDYL52YH53fMZwJvK
         j0sb4CjQctMYp4mTKDqq8pbPa/DCiDf0so+q45RMxwXaDprGBuYMBaWw74x/WIQbts7o
         NUMCd/c/aQm8pCj9KyNI4c8cd5iZQiOQ19jsOyE3TSPL2tI/9PgtkrD9nbpNAHNfbsie
         NwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7grnnCCD4sCgZ0pN3Sf5LRFWY9qV6BVxBPnYIus15LQ=;
        fh=8b0oI1iqkbngG0WUI+qXvKnB5k2Q0B2LTKPOeiLd2II=;
        b=qpdltkkXVb7nAznTwyYEOx1bOw12U+PPI0+rRoycIMJNdgYZku+QgELaxGlzUx9hc2
         XHZIbifJfPvx0nZVv3glnc0xHHCB+ElEExZhMwQfkBq50KHpzYs3toWHozrQlyzKTtPh
         sK+pcxD04QoxnmLhsw1DhCMdgLFENRN9nu8aAuft/rEsicoXs4T6B8lgsXcMv3SmjZ5R
         8Q0ss2s1+x40q28D5Y6it9+6HdtfvXarUQYsYS9u9aswvHsXrYRX4B7Qo70VaIRnWfVA
         WL2wuLR+luajccWdbtAI7k9VW4qKVN+LEeMQzGa89z567EKZqApXCET11/nw6BtJk9nY
         KSfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784102820; x=1784707620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7grnnCCD4sCgZ0pN3Sf5LRFWY9qV6BVxBPnYIus15LQ=;
        b=mAx1F5ZG7hvagA5iCSXJ1NuUY3k08JIwfGFme5OVkC7DE44jq5B9Gs4pftXkDtGNIF
         SK31an4b1dc8bazAfAcZxHjyhMH5gktkv91jxTyJsfbBuVf/NNifHhzj0EqKOAyf3b2M
         nyCjW1qFMnn24jgW192OtGhExtDyVElzmsCdF44HeE9H1ShCx5skWBsB/OumJhK9LOe8
         oX4Pt3eNvdfiNDiXXinjQvW57llpvd7RMo8JcPYxq+Plqj8Vd0K7QmTuDuNHKu7mtB6h
         lJGUt29Y6zsMJgFFe4JFf5eXjef4tvfZFIALwP4oQQF9HDPB7iSSzC+kQ+Owez88DD5a
         p/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784102820; x=1784707620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7grnnCCD4sCgZ0pN3Sf5LRFWY9qV6BVxBPnYIus15LQ=;
        b=Vp71brillRZ3rFFdVNmVgKG8Tt1UCRoQeSExSQSqo4MbzE4eKrtqhNpYkQdo0/Zvaq
         CIPddg39yK5evMQQUjFUJLZLiWLpbn97mrBsxhXLUOn1PsvkfbU8wX8b+i6xLtRCz2tj
         R9lml3lkWIuHzkyo05YtbS9xaM3S+v7zYt1cueXgUOttvJ1SKomExCOL64eOZF20pUAy
         E2Um+HbOPUNZ25vQEHjiwBosr4fY+58frrV+ytPTScBTGRB/2qmYvFTAYu0ivU9qQtvU
         fYLAy2c4gzzaT1cwQuYh2VhSMQkt541myY16uioFvU15KGJH4xX5h20HX20KecU5CKmc
         QjJA==
X-Forwarded-Encrypted: i=1; AHgh+RpvBQE1oU/yj3Zs3V3u9d8yNp5CctdM6Os/lP73zDQkw6Nb6w/l2SX/fP0MMe9vmZR7guFdECwTyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhqdyFoUc+VPG0nGpumMCI4sozxQVYdcBLS2Tpmix3dxshWm2
	U2m4h1YlHjBM6WFtDTNxn9c/aoqW9EnvsPuEfLqgGBfMOSTVM9SySVkM+cdbaYzyx1hLso6Wo3z
	ugStb6tYMux/XZblyx3ul53EzLMOO28IdONgMjpTL
X-Gm-Gg: AfdE7clnQZosG3qxSDY1jUhUQRtQ99QU20am06u9MgB6Kg3ijKaKIkaIOhoqtPTLRS2
	epV2+Mv4owVJzu+Aadr9gEZtCUgGpkIkalInGZhp6XRPqJ7/TBuTZpEWCCww42uipa+RianciWs
	IqEfz6xXKAEikeUujw++clzhFWwP2PJTZm/qqEPo5KIZKzU+lq6bmnX4U8w7InYraWKn/Rtgewc
	tR+2pDlWKesAF+2LJKNABdXw9BBpIwNJOWETKEK9Y13yApb8J+pF2s/et5vNXETb6sEUj/UQz6E
	WMSYQb5fWb2qV9AiQ4lS4Z1yglk=
X-Received: by 2002:a05:600c:8483:b0:493:c8a6:b517 with SMTP id
 5b1f17b1804b1-4953c3944d9mr18980225e9.38.1784102820014; Wed, 15 Jul 2026
 01:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783456063.git.pgovind2@uci.edu> <f56e1010822963b2f8133c63de47645834281007.1783456063.git.pgovind2@uci.edu>
 <ouf2qqkiqgvn5yy6umr36ii5ltgacx3qthyhbol7ly3qn6lypv@pmkv27ngsbcf>
In-Reply-To: <ouf2qqkiqgvn5yy6umr36ii5ltgacx3qthyhbol7ly3qn6lypv@pmkv27ngsbcf>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 15 Jul 2026 10:06:47 +0200
X-Gm-Features: AUfX_mxcfDa7WSudj0Q6zu8VDrJ89ChidSgbwBc0KxRCpnunkL6_Q7YNcncqaK4
Message-ID: <CAH5fLgjHWsVc-o_kv9=CBPVWqHJP_V2kRN97C9b+6aHt8agb2g@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: cpufreq: Fix temporary write in Registration::bios_limit_callback
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Priya Bala Govindasamy <pgovind2@uci.edu>, rafael@kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, ardalan@uci.edu, 
	zhiyunq@cs.ucr.edu, dzueck@uci.edu, ytan089@ucr.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 8:11=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 14-07-26, 20:30, Priya Bala Govindasamy wrote:
> > Writes made by `T::bios_limit` go to a temporary on the stack instead o=
f the
> > limit pointer passed by C.
> > Fix by creating a mutable reference to the actual memory location of
> > the limit pointer.
> >
> > Additionally there is a creation of a reference from the
> > uninitialized limit pointer which is unsound.
> > Fix by initializing the limit pointer to 0 before
> > calling `T::bios_limit`.
> >
> > ---
> > Fixes: c6af9a1191d042839e56abff69e8b0302d117988 ("rust: cpufreq: Extend=
 abstractions for driver registration")
> > Reported-by: Dylan Zueck<dzueck@uci.edu>
> > Reported-by: Yuan Tan<ytan089@ucr.edu>
> > Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>
> > Assisted-by: ChatGPT:gpt-5.4
> >
> >  rust/kernel/cpufreq.rs | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> > index 58ac04c650a1..0f9385d41b64 100644
> > --- a/rust/kernel/cpufreq.rs
> > +++ b/rust/kernel/cpufreq.rs
> > @@ -1349,12 +1349,12 @@ impl<T: Driver> Registration<T> {
> >      unsafe extern "C" fn bios_limit_callback(cpu: c_int, limit: *mut c=
_uint) -> c_int {
> >          // SAFETY: The C API guarantees that `cpu` refers to a valid C=
PU number.
> >          let cpu_id =3D unsafe { CpuId::from_i32_unchecked(cpu) };
> > -
> > +        unsafe { core::ptr::write(limit, 0); }
>
> Maybe add a comment over this on why this is done ?
>
> Miguel, can we get around this somehow ? The driver is supposed to fill t=
he
> `limit` field and not use the uninitialized value.

Why not just use a return value like this?

/// Driver's `bios_limit` callback.
///
/// Returns the limit.
fn bios_limit(_policy: &mut Policy) -> Result<u32> {

Alice
