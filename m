Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4794430FC1C
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140859; cv=pass; b=EkH0ngKEy/mpIgoxpcvXAfdR31Ftx0EBETtiaUeyeUnzFJfMTddcd3tEvDvn8olYj60PV7+yhpJqT4wDjviLoRn+S16rITnunG18xPaja8A2ZXpy1IdZ3alBWWU7w5meS8es/w6oLzO0DCuN8NxxdHH3PrMPefefBAcVSImZeX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140859; c=relaxed/simple;
	bh=7juR9p8Xv5arQajgMs8TzRWY4io96iOYQct7TEDteFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWbeDYe8GGvaAIRfzCzVR+vFTSxxKmBMesCHJ+KzOJEyafTbj6K+fyTsQfh8ugJlvFS+81w6ol7wB9aGE3eGcdPBUet2JAO51Bp6My2a9slDB4Bs7izo93qzdQt4+RaZ+1rb0pTumztDjmQhkSCAHFxF+bABKttGQvFNoMI9eBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C12T/7qQ; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C12T/7qQ"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304dd3bb7a6so216860eec.0
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 04:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780140857; cv=none;
        d=google.com; s=arc-20240605;
        b=WsRsEsRUkiS0gGSJMO7hoX+me1z0MHEUAzs2ntTV6BAvavqxbn9XwIiOi4s5oyQe6T
         EPApyGSvJ4JtPey4+Gr/dczo6JsnXUHdbq3sQFKaF0DQfiORVltGRr2/nToP4ryNi3qH
         IZd3kQs6AuWDnus+kUke9t7cLaJBPF/a7vrd+YBqTFFpj+d5QmaWHGhEEOFDo8IvZDfZ
         YxIAkv8oUp8y/90eYow9yJeKwCHp66QhUE5fCTlsHRdq2JhuZYk54bkFWx3/N0sefgwl
         QJpfMKSCBGaUYg7z9zRY+WRC3bFtoJopptIFoSxXVDmAlX3TGcy0PEzmy25JuWTfhPeq
         bhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yoaIvqz3mqLE/33YsmI2LMsK8ApZkxaDEDAycdVwp0U=;
        fh=0Axzf9IQdWqolgY8bCKMNt88KMO4wWEmmyOmruxWDgk=;
        b=ROM86M2Az1cbLMcBZ0EDQK0uSSTs0IXA1g21r8RAJ5n1U1p8CTDPXQ7PAGXoz6RC7f
         hs8ON9c6fSZlu5B3QxSDdegyTsIoPzntriSmLrn8ow6WOTI34h3M2H2w3NFe9+e7UOg1
         UAhzLMyCnU3AKbd9iUPkh2chPz+pANBO2PkdJOGEfeouqZNvXrF3XDczGn2R/e+Isw6K
         v5PAnzeGccXmz3EYNiHBUtvVinwP2T0DEoFmxOOf6sHII47Z5KTGCsvQonYcR8WBN8cw
         kIo1NKZwQrCzpOPPE/qYgcrT2nlaqTp2IQI0hYXyeq/3A31MLXvxWP9dXU/zCVryGQiE
         9AGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780140857; x=1780745657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoaIvqz3mqLE/33YsmI2LMsK8ApZkxaDEDAycdVwp0U=;
        b=C12T/7qQExF7M+xAh4jbzmbwcYR6l6S6usG+T5rrx4k8SNonk1+upZzrj86aSZteiQ
         KWLQt8H25JQ4/Odg1wmQMDlA+ryvfMq72Y8Ia4xin2cSEo3rlNGWLPVCxXRP9jBK+Xyi
         XrDs5QiXpDubHQLDBCH/IHVJd3/rpnsD9jmgTPPryB9V2xg1Y4I1UzQfxrF40YmFphJg
         M2EVkWFgQ2ErM0PGpCAfIECLY4eYiPTqV5HRSrH0/G67cWRSoPR1hF1M3DwMFgiy6jjQ
         uiEelKH9suYP8mDLs4A7h6XS8vGMGL8Rv+/xcdilq4uMhHNdB/HhNMvugDyYvZep4TNf
         Awdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780140857; x=1780745657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yoaIvqz3mqLE/33YsmI2LMsK8ApZkxaDEDAycdVwp0U=;
        b=jTylSb+hd6k8zw+ETwlOIzrnmWCmjRm+FgJDlzWEbKhXfiZgpvTYM2Ne8UTH6EIJMb
         guvFRASllUSZMT13rPVvmlx2Ww8qa69hOz6qhQiKEHBNAUi/ZDw7v4fC+UgnuK2Ynd7A
         rdZL6zs65G4RMb2zhMCa5S8e/jQC59E7kyLrI9G4BGOYPykQHcEb3LG8uqiuJdAlXcTo
         VE6zg9NT25EDeiijrwIisw9UlcioXwH7Ze5rRG0N5TNMD56SgWAN8FdG3Vv+2aLxYGga
         DRTnA5FXe1Ak9Qs84B36fYHVE1THhHUdyCCyxtSHpunoIaXi/MEBFf/WrsLVCXBXzbpg
         3Bxw==
X-Forwarded-Encrypted: i=1; AFNElJ/+3B9ucMe7s3a23XinCKFHeWxABrhdEhdHh3etLKRwc0Ri5PMCw7susqZTFpqxXkUdQDiuaOkTvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCYzMSYPr77Qx2HK8aClt33yvjeTEebMNDRCgeutJL8lNhK+O
	aMP15UQQVlWf3snYnqGOHUUK9Kody0NXAA43nGU9qcQfsMKr1ujygUTGvhBRNrm5l9l6NLpkZw7
	4KgjyESN/C2CS4O4bn/84TGW04WiJYXo=
X-Gm-Gg: Acq92OG236nzG8YiHraVmNsA+SoTOzBXA0N84wBBA7k2oAp1vOlFA4NCDiztqbx3JsX
	t94ao2x3Q1880PLa7TRf5dggQFBk7mHyPqxGK9O2s0P36iv2F7uqb4dB6RzUTUHCZNSVRP2xKW9
	mxYRdLVye7UypE7nCP+7aOPMsW/FwEI62dhmcXsrUR2K09ZDOFKsLz7KbqvsY+mz762cYBOxai5
	IeaZTUu8aJPY6hPk+XPay5V3mk90vruusz5zuo94eEnOblLSMszpFbuPJ6lsSxJOAOEQJLfTjC5
	WFMkqiD/LP5o3KWU74d9Y+vYtseKf4Y+1uVn6D0I3heZ5bopCE1z0HPqZ9SOOb5t/vlfSs4qRRe
	FH3za6ezJRRQbXefsZK57TJKxOjpXpImAbg==
X-Received: by 2002:a05:7300:6ca1:b0:304:8860:74dd with SMTP id
 5a478bee46e88-304fa6c4509mr884143eec.8.1780140857291; Sat, 30 May 2026
 04:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530095809.213611-1-ojeda@kernel.org>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 30 May 2026 13:34:04 +0200
X-Gm-Features: AVHnY4KQK2kRwQKYuYnJGv_YwzRpnyRzJ6oFPD1S0YuI_SIHE6subfsnC0txmV8
Message-ID: <CANiq72ncuqxjjx+1SMV977UC-TZL9aPrbFECmCPPdzSLi-Oc=Q@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 11:58=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Starting with Rust 1.98.0 (expected 2026-08-20), Clippy is likely
> introducing a new lint `clippy::map_or_identity` [1][2], which currently
> triggers in a single case:
>
>     warning: expression can be simplified using `Result::unwrap_or()`
>         --> rust/kernel/cpufreq.rs:1326:60
>          |
>     1326 |         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).map_or(0, |f| f))
>          |                                                            ^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          |
>          =3D help: for further information visit https://rust-lang.github=
.io/rust-clippy/master/index.html#map_or_identity
>          =3D note: `-W clippy::map-or-identity` implied by `-W clippy::al=
l`
>          =3D help: to override `-W clippy::all` add `#[allow(clippy::map_=
or_identity)]`
>     help: consider using `unwrap_or`
>          |
>     1326 -         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).map_or(0, |f| f))
>     1326 +         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::=
get(&mut policy).unwrap_or(0))
>          |
>
> The suggestion is valid, thus clean it up.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust-clippy/issues/15801 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16052 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Viresh, Rafael: I can put this into `rust-next` if you prefer (I
considered `rust-fixes`, but it is not important enough at this
stage).

Cheers,
Miguel
