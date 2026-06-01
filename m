Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8B33F5AC
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294952; cv=pass; b=DfM7jF+ZxTce6PsLCxQeeD4dk637Pc9mXMeSJ0ZN63ommDY7YuWkULfAJdBFX3OKVzf5UKjjKs/vp7hHb/UbxVje3CFpXjPhG2lSUK36AQMZFfLe+ftZl7rfUDcEpep2PDtF84SuC2b8QjRzKVTLMBFsD/e2AzYHGWQ+TRJ1BIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294952; c=relaxed/simple;
	bh=rDizJErqrmQNdM5KasAdxwRqqjmYM+IPstQR76bgPHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7Jye6OVwvkLpJBbH2/rMiYYAX0eVvFOcRsl3hpRJduNck0TUOw4K/WD1al4N5e1bN/1D7RNvrnmmFDWRCz0sNcWwoqx5aIRvC3CBf0Xhh2f+OjTdKAfa/gCdJF+CETvh8virqnoLxKbK71B0Su5KYAkYhe5ZCGcv1XvR0hS+Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8lc/XjC; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8lc/XjC"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304f9bc869aso181458eec.2
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 23:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780294950; cv=none;
        d=google.com; s=arc-20240605;
        b=bcKU/DSwvaYRnw2Fa8V4Jye9EWgykQ+DdjqMaXh0H0jR6I5YNUBDHbSmo3PcpsAREF
         qHQQVzxM3WEZsETCRosVAx/nJWXRRoaBf5q9ofRUkjk4XoPXJIsyAc7HncGWS/ov94MU
         k9X7DBGaAf8uKU6KrXz1T+sk0eLTz6oTCEnGEqvwjEzLCRCJbPd5RiXzncZ1ari1k5ty
         bvJvnUSeN9Ty88PEylo17eKgwCW5kE+9MoRxvRadMqo3LnLID0hx4qa1spxcZtHkhlLO
         F/W0yXqLN7xecl6bmf0uZ7lEWU7rwuM5Q8ZquScNWBRfvt/YZdgUQ9YPYfll+ZYUd1IW
         onZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGx73QraS4d3NwxPqGYPl3kROHfaW+2ydJcmeDAJZc4=;
        fh=bYlYRoMZiLDwGqoLGSSAfI7q5dhcXt7mIa/BmeP4LFI=;
        b=dOKBTs3e4j1mqFxlMqIym9ejihWEgks9LE+8rHHXGgGYkQLKCq4NF2YrMIj9jAFLcZ
         g0LHVPbCyYoTuXkF/hZ+4DIipVEzyZ0ykHnAEx7RD5ly2d5dHKsNkzCEvgU9xHdvW6xx
         t+2emtNzcI1JoiMYTJCLpURgH0omhYQ4TCT47mzIo//B3pNeBRbRtJiSZHaf6SrBigPP
         TVy+AU5rbLjsY05W1LRO8+aqbQYuvVaZErsb7pi3s03+8THP1ffW6fLvJm4LmSsnDpNb
         eigG0GrTy9FkbvlNtiHfdFsPry+PJQCXFcuTYjphxdClFrw4Vqc+FXPUzIShBbySVL4g
         lYtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780294950; x=1780899750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGx73QraS4d3NwxPqGYPl3kROHfaW+2ydJcmeDAJZc4=;
        b=D8lc/XjCS1sX/vOZDYtCPJ8o1w/4xcBFBLkVfIazdmjTuj9cVvzswffeSyNT315ydC
         mLfinRIVj4VBbOdbihJdQQwRjYYOhUza7uCfLjQnu9VEJAh8lMBbZ9w9Ynu8Tx5XqO/A
         5udKRuHdIGThJlsCcwheP2d2GvmH9pteG9Q5H9A12ZbRQDXlIPQ90WbozHV6rSI2NnHM
         rRY+Sn3gFwu7Tze478imdtSZRMm+yx5knO2tj9Lvf4JBSHY8PvfeAcWhLqb2TmtRnjRk
         9In2SNAyCavOjt1hiLCze2ScyTalzLPTcQ9Qhuu64PKJT8YaDP+a3KhKfVSyPS52NGnz
         BBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294950; x=1780899750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGx73QraS4d3NwxPqGYPl3kROHfaW+2ydJcmeDAJZc4=;
        b=kg3rWOvUbuOMbY29p/Hs5JVK7FmMiyyBY0dkRYujc71w0Cb6Bvv6kAS3tBtiBcqnLF
         qgNOWUWUOQCp8PIXWiDyWBPns1A4QaAft/QRz+U/RmVdvSn/bB4R/tH5u1ffvTBOaPNT
         YOMoMEro3hTS5dcYLXbO6ZVPQVmFOSjoAbK5HB61YrEuxjt1EMP1QHYeHOYyCRY/FNoR
         gfG24u+PzOlStZe07W3GO0NldaKARhEm3ojEHbEbsf7/s9B18dKAKCYRi382zBbPxnc1
         8SZBiI3Bqgdb9RPYYLgeQkkOvvzcFnCY1cSI/nS0ZFwQ41wzuEwDN2ZHmAMAfAGJOnrz
         VOsg==
X-Forwarded-Encrypted: i=1; AFNElJ8TilurJw6dZR08RkH7KqiPIM5qBPHUNlkNc/rMlxdozL6GZN41SfJ+Ytt8wNyZ/hLqhF78Ib/eiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVVuyvThXn5gBn33oKGdFmbE6rXjGsiuHKA2nNV5JY7OzoZvg
	CdQ0e96Qn5RQo+3ESuRPL3hzqnCgsluo+0gKVgl1u0hQb5kzM2lzOlrcqCZaRRz/W+//c3i4O/m
	z+tQJt4UriAmWE4/1JEopGQ4rk3xmWS8=
X-Gm-Gg: Acq92OF+laIaZhBrrjmhMBca/U33nijX2qbWeV1orlNU0/H1eOw7BfmGsYDDIOiu61K
	fGUu+GQvEE/fFtSM0sWYSYZKoG5idJuYvWt/AsbPYpRFgLK6doMWROx2Y7Ub6QMMCzL9TJXhVtr
	sKxZsiViT2CHnA41mer0dH10I5q/ls04SeQrN2MHP47oPNRV8Uob/eWma+fC7iLp5YT5FpjG3q1
	VsJIdnJ8crR84KqZTvKTyEWZRNRKRoLhefbNtsvwWUckjSkUvJL/rKMKTrJ1vgnIIFE88zIckj+
	4onAblO7K0fqXh17Ql9IqzLbb2sfzVTrEx3P0Gv9yEPX260eVQ6YcWGg4B1O30s+XGd3QypUOr+
	QLnt+Aycx/05c84zqCy9aprPuvEIN0nEFhQ==
X-Received: by 2002:a05:693c:2c8c:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-304fa31c4a2mr1997529eec.0.1780294949513; Sun, 31 May 2026
 23:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530095809.213611-1-ojeda@kernel.org>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Jun 2026 08:22:15 +0200
X-Gm-Features: AVHnY4KP0YOUaR4NJ1WZ9OpAGjVDV2NNLjYAMpqZXvWh8Oba9IqjlLwbsWvbpmE
Message-ID: <CANiq72ktxVkvECrfK-y-+YkOANXjV_qQfzPSOJYzwZwiG6xA6Q@mail.gmail.com>
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

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel
