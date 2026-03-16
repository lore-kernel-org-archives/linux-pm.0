Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484404207A
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773636559; cv=pass; b=Gkfcru6iZ7qhqIbZVPdcYLIckywzbalu2lh075aUpOOYjyy3StvXS8i0nYgCVte653Soz/i/DWUxWK8BTsBAWgeHOnuv6/E0USzu2RinJn+ae7DnqL5MoUl/BQofo2oaLu02M3sKAoA47sfRXMP9dhywIjE8Fe5j6dmnLH3EJ8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773636559; c=relaxed/simple;
	bh=2EGPGYJeFqAsw8j4F6t9zjYLmgzKpIJWNtykYTrdbss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cweT0ZkW9GsVZ8/7LOIZQ2fO7Um0n3omLfdSVzAe6Giv14OD5vhbyuO4sgkNqKoQ25FIhQN3HpfMUkaG4YuOWZi8Ruzc+hdQ8uvJA0JaQcXJkpYaekwTTB+tRaEBIJKM64+Be/EyUn5Gl5vmwA+zlFsG9+B7Qr50WkaOSErGp6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1I9mCRz; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1I9mCRz"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bd5658b901so260508eec.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Mar 2026 21:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773636557; cv=none;
        d=google.com; s=arc-20240605;
        b=ETAt1SVkaiplp0TZph+IJPwPTCooiTzXuHwdYYcbh7PnQ+PqaECC2n4GYYNezYpJNa
         UQlykJXaPFhkartAEHSvikxXqENOdoPxZ/R9JLYdXRlmWQK91FEUimltQ56baOciZOSY
         bsvbSiy5BmpIi9OuyAjS5je6VA33DJ+y51Mf4zQmi4or9uwgDVmIUq1UR4+JSw6MqaCM
         VI2ISnHUdSol7zEcXk+GIO+gf4GRBVidk8YxLPLKtn58iB6Qu24j+rgb/t55jLVIRsMq
         hWjgvrmrinh5Bx4OdkyW55kRHTDEbFlrnU1EyjxGDQ5f20cdjeErsLEqcXe/Ly1dUqGp
         8VeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ItM5s3kACGOPjpgdmLv+DofJwL0CaMeYOqjFvsZD1Lc=;
        fh=a7Okiy5FkW2E1YyChY6EVq8tk/dO+miGpym8uYla5VE=;
        b=lSsRljehHe8gSYxQwgXRfV8eCOTljDFnXQiCT34I0dsEnW74y9g2LBqJcoIn5FEWpf
         5YL1aFIlwUdhbIMAyk3JyyPyPM1aK8GCvkTYMvDCADF81YguJesfK546s45bnqGTA2BO
         HpJTLlxZzF+fAsrpt5Muh4ZXP8H4VYFTV8JqGMcC25sk1l+sBI45Ge7MzpaV2+bCJJKR
         46RrPU4ZrgrVeoOeX7FgX6ve35r4/qv5/oUL2C9A6Uzak/PEYpug0uH6ATWoKp+o3Hh8
         Mm1QQvj+te00dUypfB/vnX2SWKl2mQhhPg4ZOk0E900UI/brF8P5byZx3iLNUzqQQCiZ
         s9cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773636557; x=1774241357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItM5s3kACGOPjpgdmLv+DofJwL0CaMeYOqjFvsZD1Lc=;
        b=G1I9mCRzAnWp1jFVkO5PjBpZnEjxI2RBviRlTqEQLX4GCtxWNjN39q5Ql1jqukIgvn
         4GJsgx7bD4Hhm2qx5ks9z3f/huzl6RnkL6ezHxQQDpw6pf4YuVacUAtmKsGkmqAHYenr
         1eIC5JELM4jaZr3H5xREiXePIHYssRrdZ7kawnjVq+M1dLIYccmrRPgap4ZzgBaAVF0f
         j4Rx3CGd/NjZV1k9pptJ3Ev9Kuba5GoebstRGVTd3/1l/mG/Oydf+Fv77SEA82fU1Wud
         Auwr70oVbvSPmjBX88BiOC0z8Nncq1HMd0TS74q9jpww7HTXT+asW3gz9rtaFLRxYEKZ
         BuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773636557; x=1774241357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItM5s3kACGOPjpgdmLv+DofJwL0CaMeYOqjFvsZD1Lc=;
        b=WODJygc1rZp7XkfRMX8vmCxR8dNP7EuAARfsLDQtuWRHgo6xA4KmQMABjJ78qn9ldt
         4oKQKbhoDCIqtLbyrhg3hnBxmbduTuSRSJ7zYKCw3YCqItsIfydc3DimpwxbggwtU5PX
         eEGIs/FCDctf4OTzDIa4ci1X38eFli3SshEEd4ufISlFqwJz0n6pV2ye5Zd47XqFpsSR
         o7j3o+fCXObrSMqgPvjFHa2TWoOzKI7tEVvKdrvGdxJYUAULV/SXe7nzHQlbxFL2V51n
         C2FS1rAlpDg5OEM7A+DWjWanP9G+i9k95suF9lPJjjrvBAb+1li/SMnj786ktGJPDi+i
         qBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJu6yKkeQ+QqFYzUblZBX1O7vI6oyCKPdbrBLdi9WTpfEaFYqVsXLKCW+goLy5KJqWwzhZjs2rZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7khk34D3AJH7OC0ZzODwDswuFjIvbR6mNccy/qXSvE6dvL8W
	K8tzgamJuSLMORAQIfRUvA0hMnHvG7EKe8lf5bxhU7wWeqWIgSraTTmIvGKMxwZRPR1p8xO1uYl
	im+3Xfv48V3y31nlS4lrThMAyBGyWB1A=
X-Gm-Gg: ATEYQzzjVcB2CjUX3yrYZoDXghKSjnOM9W4zcViMYeRjSgrs0sIyyoqXChnmEEf4NVR
	SNCNWxKh6bS3N54Kp1FT++VNX0kLkLbF6lW88EsGjTT9UaXxYFyfKSh+dMSN5uqB5QT/oB1TkVr
	+8Tm5ZIGiif3q4y2gGOjXNKOFDjZi43dl75K9Wdxlcqh7vGcqmJhf7wmfiXuECD1IY8r4dzHjRI
	e2lHKLnuRglDCkv6v9wVE8RUWHhTBFaAugXxdoxiwr+PN4WlkjO/jE4alf2n9w/P+7pjttTwJy1
	sxB584DXHTfsqB8pfHtFfdpF1TOpNUF0Ph88bSZREncGTziikAxO5MWnLKwDAsuMyB3RyzQornH
	jH1GfikWyjJuKrmANzuKvoBk=
X-Received: by 2002:a05:7301:9bcb:b0:2ba:7d5a:a816 with SMTP id
 5a478bee46e88-2bea553847emr2790472eec.4.1773636557208; Sun, 15 Mar 2026
 21:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
 <20260307170929.153892-1-ojeda@kernel.org> <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com>
 <abdJE4BsrzGDTVZT@sirena.co.uk>
In-Reply-To: <abdJE4BsrzGDTVZT@sirena.co.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Mar 2026 05:49:02 +0100
X-Gm-Features: AaiRm53tL8XU6UHYFssRJKAAu-83HnX_0LD9DK3qSvFTjE4_i0y7A7lmu4Wc588
Message-ID: <CANiq72nXMbP2ZbyNE6voWXrEXg85s99pXLj5LeybZry4eAyzEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: kbuild: support global per-version flags
To: Mark Brown <broonie@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, gary@garyguo.net, 
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	lossin@kernel.org, rafael@kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 1:04=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> At the minute whatever linux-next runs is whatever Debian stable has!

Great, that would mean we are effectively keeping the minimum one
clean, which is in a way the best we can do (apart from the maximum)
if we don't try to keep every single version clean between them.

It is also what we have asked patch submitters to do so far, i.e. to
keep things clean for both the minimum and the maximum:

  https://rust-for-linux.com/contributing#submit-checklist-addendum

Thanks for confirming!

Cheers,
Miguel
