Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90C37C909
	for <linux-pm@vger.kernel.org>; Sun, 15 Mar 2026 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773609680; cv=pass; b=NrsJLRopY7HXECM+BC95vm3NXfXEArH7R/PfhxtHbyv7bzvk0yOtGX+pbuHncaLnZdJw1h/Xv0+ghbzkTK0FjzNWv15JWwYkM0/dK5gZE2XaY2g5VxzGL3+7umqrb2+EFpHvOthzKOQn0ifYPduPS+fE89EnkilajPMXERSL5ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773609680; c=relaxed/simple;
	bh=Fn6OScHObcdiYuVDP96/DqXZ9Cr8pfsSOyt+88yaKbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYreO5oNm8B2IZGxRu/shCRl1cnSG0g7LiN38kFCmkjrDG7hY2nwL6reXOQdarzxXGOFVd3lk78uJonykEjJr8Jyyogy4jeEzXNeAhXMJFCAbN5PrcRKbZG1Tm/aYjwJswY+IxhR3vQdHUivGQpkqdJ+m2QoMJ2mwiOTwB3Z1XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2DbcstQ; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2DbcstQ"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bda3b4318dso262048eec.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Mar 2026 14:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773609678; cv=none;
        d=google.com; s=arc-20240605;
        b=WZ6Ez2RYiZTqKC5TQjhpCaIPOECnlJOvX9c8CcJyk8d9RUTIBvb+mzpavD5tY4IRrA
         Fzp61nROmIXNTk2T8GrDuGhOxOZdiBZ/8hZzdgJsERUwJIaDZJN6MHPgoQHZZi5Wf9uI
         sF5hw0cHIlpX8xDS7Ux9DnRkDvC1XOnzozfN9DGdavw16ffMgi67hLSoQneXgEonH0v9
         8vaIcQpTOajYtZgbTHeQGfvrdkby7hDTnjmCi3dNkx5IJG5MS0epnvQjbxyFQzlSQSjY
         uGe6kItnZ9V55GxrtU+7AHD0baym8VpFZz5xtmzdH57xcB1lLvcVxC/nRXFTtclr5taX
         Yilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fn6OScHObcdiYuVDP96/DqXZ9Cr8pfsSOyt+88yaKbM=;
        fh=WiSIK87XBDbn0eqFo+jT9G1LwPGsSXqwbW7kl1acrqo=;
        b=PPKPAqz8+FlEJiEDqM1rsOH4ZRofIgzrw6BLCHx8I4qblmKcbaGbUyHCre6ndMGf6b
         5DdWhd36C9DzXQz0Am7rdH134lq5jgc0Pd7w6WIua1Uc1w/lV2+a6fn38hxN2HVA3etj
         R/O3tgIb3ijXs0p8uqOPBEgMby232GPlp6o7tR1nfPXMzwfTjPu1uzGpYMOyQzv/yok6
         ovuH+kRh06o5X8C+g8M1Sb82jILJDqOpzP7kKPV4g1jqV7GD8Md9CNxYk1v8muBWgISk
         JG6IzFzbbg0Bft5sJf+iG9fi/j3UXQvdCcO/38j3hAsHFWkml8BPYT+abLaja1PSQlAO
         lYww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773609678; x=1774214478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn6OScHObcdiYuVDP96/DqXZ9Cr8pfsSOyt+88yaKbM=;
        b=G2DbcstQJyhhyB5mlD+Qb3EkBO9lKpJQo2RLHpE0R8m4VLmkRz1v0vAESQFURaDFlf
         PzClwltVDd0OqK62WpH77d9oggfnVa5NmdNYUjz39Hi2jryxIFm9Q9yD6Fx++iKffXQh
         N3po2QZZ0RDRxr9x4ja/5nEaOS2BjpFNwIsFw1Av/mADXd0opmfpXpQWAYJvzerROC6V
         qWo6YgPlAH6egchMg+nzS37FQh+6jdmHaauRjrbgXSynn4MeANbFZ8w0VYyyj+21UJHN
         oQM5yWWlBH6fxu+myQm8ilzILTzXRT4LxaA2GLQNpvtu0941kro7w2bQTQRNDuH8jzqW
         hS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773609678; x=1774214478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fn6OScHObcdiYuVDP96/DqXZ9Cr8pfsSOyt+88yaKbM=;
        b=SiRBkdV+K3ELm4arc+E/li7ZogtLtKt0nOx2FPadTG/CP6uDbML3t7WIhKLxaEhvf4
         rIfMVc+gZGK/J8++woD+7aBPnTpYwx+sr9R0AjQfPe2Di2crx15uI69/92VFw9sE/sm9
         umGrbAVFSeUJlsPS/gGeGYJUhraei0+wTiZmBPaABPgbWmNWuUsTxUthUQNaH1zacGF2
         rcmhPosGn8CCXu5TfvxPhcE7lzRjU7CPRZv2wjim5JgTFW1mARm03INB/iwyysEr3SpE
         H0+4s1EY2e4OuNs9H6iystjrQC0qrFmjHUqcpHJ4d23HRav300ZAYAEIeP0Gm0FzGiTN
         5XZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/EnsC8YydKvPiMUzGx+bJkMQKtORYAaf3pyUExAagbwyvdQPkHrc14tchEVosXCsw4hqZ4rtcXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz490gVSvc4gDzO52AOX57bPemmiaAwXNhnFmZ/6+XAWSlpTaLF
	VdzNN43TpsmjfR8O+lc0ERv9xVpdvkv1/fbAudoTddJEZ0wlWEUzItx0sFW8PF0kEzNZj2kOZDC
	XDZVll/wnsFgRn7Yd0dnwq65e2Ir9HY8=
X-Gm-Gg: ATEYQzzLUwFBYlyveKuaJjdQKdx21yV9mx6ItT4a7V2NuGZ3hfZCJCwKLXnqfHpdCWz
	/vgLVbd2+oiDxskaakgIVZAlseCA+xLiSfo42bAkIgkXdkfD89fp7JbMsR06NMH4yhX80WUCGMY
	TbvPc+pgAFtvwyVDYg6nscbbHHBZhLyTl9KFziUauJ6D7mZKCc5QYNwyLkUrqLLT4P/iRFSwK4Q
	I4udAHwQGfZiDTw9bl9CxTZMgRAC1l9CEo7T2kr2szKS2IrDGx+7TwGzAFuP0as1eUUHG5F1p7p
	dGvag6ZyFnxwpFn8R4qfYM6lD/ac+7MUUgX64QJgboRA136HykM8W2SOjKu/jcfjZa7asVbqm+9
	MP2cf1UXH+aHCggacbOsyYmk=
X-Received: by 2002:a05:693c:4088:b0:2c0:b4c4:2b25 with SMTP id
 5a478bee46e88-2c0b4c42ea9mr744151eec.6.1773609677624; Sun, 15 Mar 2026
 14:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
 <20260307170929.153892-1-ojeda@kernel.org>
In-Reply-To: <20260307170929.153892-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Mar 2026 22:21:04 +0100
X-Gm-Features: AaiRm510VDRQcNtTttKVQ75yM96x2koxa41q6VuLJJhInLQt6nz9bFa1tZUsSWA
Message-ID: <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: kbuild: support global per-version flags
To: Miguel Ojeda <ojeda@kernel.org>
Cc: a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
	boqun@kernel.org, dakr@kernel.org, gary@garyguo.net, jhubbard@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lossin@kernel.org, 
	rafael@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	viresh.kumar@linaro.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 6:09=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Sometimes it is useful to gate global Rust flags per compiler version.
> For instance, we may want to disable a lint that has false positives in
> a single version [1].

Regarding this, we currently have a warning on 1.85.1 for
`clippy::precedence` and a few in 1.88.0 for
`clippy::uninlined_format_args`, so we could use this to sort those
out (plus `clippy::double_parens` for 1.92.0).

(We will see how hard it is to keep all these versions clean in the
medium-term future when more Rust is in the kernel: we have the MSRV
bump cadence now with Debian Stable, so it may be doable, but worst
case we could consider relaxing the policy to just the latest stable
release and whatever linux-next runs).

Cheers,
Miguel
