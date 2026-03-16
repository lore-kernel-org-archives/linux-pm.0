Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4E1EA7DB
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668576; cv=pass; b=OrzzS97txilSyg2Q/D1rlEpjo/1qbJaty1nHK6mFKRFbBamJPG2McEX/U9BjSFsF2tLnAuRQa1oHGGQp7SDU4N/W5ABAP3LRjpw+gGja7COK/oqBtGBh9ktu0fK68oU5w447XZz/FVAaikb3MLFgXuRqnXJ1WFqnHjn9/uY+KbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668576; c=relaxed/simple;
	bh=UGXywQp2Z6F4UsVZuss/tTPRAQ9Jwo4akIrTzpCcSh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSRJjtKD/E+t8YksXsMph0lxjQWKDK6LVKp+/NTOP7r2U7UmQwVgAmsUXd10OfWcG8Lxi5ArIGX8siMcJLLOungg3N/FP14Hl/4W5t8DLxzAnS8Ta/XvaPXmM+gFi7GEZiY1Yruo8LOxB+/JXx6kzEVzx1W/EerrijvoNkOXePE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVqBNAlu; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVqBNAlu"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12714f01940so243470c88.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 06:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773668575; cv=none;
        d=google.com; s=arc-20240605;
        b=e86WC8osnafirAzRa75hW+3Ydz5B0cWOMvEL9jy1SASlYlfndgjYWEj/HdM8ubwjDu
         XlNm+4xHh/MMl4USvrd8OzG8Ph9xFNn9LiVpF0AvHfs+Q7tayecx0bOJ07rTSyPO5xIw
         UwstGKDUFT7fNS2SzE1mxakn9Yu1cmWZorXZlMfOFgg/JOfe2y+hA3TU4DaXRakntskx
         MpdbtC2ZFMUlkMV0gscz0QEkzufCQKzLrFpNa+bIEsRw1XQshZVLCS4XTzGOFZjmSviU
         7IO66xp0ikRvBRm5wdcY4Lpaa6f5LLVEY/fR0yRzhhj5CBlDLD4GkSfVSzUYBvxpMiXe
         dr6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m8+K1sW9BSF5n+0C12GtQpV/icnD/37T6P2UnmEpBVg=;
        fh=bsyVDZvp1s/+nAjCJcAxMDU9gNTCw24/ytvNSwOuZ9w=;
        b=BdGlM9P7s7qLjf6qZNw4gQ0rvsGFvW2kV/IRRFOCA38y8BUxqT0Jubb63VShTQkKcw
         MIW8M6FNvo39WONBtkdpyIQTKB2E1R098KlqAAG4I/JjYf637hey7M0fOHeXL16BkfDI
         A+cICXlLIgp3ctEvNWgdWudsi2e8mIE7rdKX21kKjW6ysHItZkOED/EYRNJR02sqqdei
         OXBBSnxrTXNotMUtPEx68TNBdhTr2WlYeiUjLleJOHP6TVevMUWlpfixjpWfCYeHJo+r
         31/32ul+dlBhtfRIWQVPisO6TaqDP5OSdjXe4oQ9a5NA56PZbAcqjmWRkwXMrbWyunb2
         2r+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773668575; x=1774273375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8+K1sW9BSF5n+0C12GtQpV/icnD/37T6P2UnmEpBVg=;
        b=KVqBNAluXb7Q/mglti1RE8M7lp9QqKak3dPZtHviNR+M0BnAE1N0ILQx7EYryAyBk8
         8P6tEInyunDTD0bzCwcfaXY1v19noSH76j3Qpi9ZtoS3zk1/+l6HJgs0nKCwSPzJrOE0
         gz07SuZQOzgjhamO8ocMJzkKEa2t98/MgYVXdN3yt89y5kUAuwQLhfkA9iSIO1qxrccF
         TLsSHUpMx+RH9tfKyGMwgCwt2ENtB21R+kP9N/Nf+UFUO6gxdVv0APLveRxstCjSaGhZ
         2irp+LSu4ORsU5AfyxdhVqn9BfhXjMlB0iIPxy7spnTPlcafSrDk1N7+16CvZR/0U3Ms
         4QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773668575; x=1774273375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m8+K1sW9BSF5n+0C12GtQpV/icnD/37T6P2UnmEpBVg=;
        b=fEvJzPmh8qAdXl/64dZh7983SN0NYtcCR7Kg3Sjd0AOJYD1rEIMfwBxGPdNP5YSPjW
         b7haFQfsA1Mi4lNWNgYAeCP2S0DXH0CXASVBNXuA/tYBTSTaaSeI+05CID1CgmcIjwN4
         4mQIIChXytOtW9j4KBI+gCqB43jamdwpcPXwNuOGeeQ4/MXiEancfD/7spIAXMGZvJ17
         54ArUPA0rHoniC7/3TIt64oqFa4hykU2KSJAVczR0HJO0ttsv24AiR9QVF6WdLn2whke
         LqBGCmKM9elFa7Oo0lo/8uzezYwn77SxP0t4DE2e52nNvxquoAn7wcuTbl6AHzyuQ918
         2WSg==
X-Forwarded-Encrypted: i=1; AJvYcCVztV881AAkKXZGSRUlQkXYYW4pxGHTCKts3zOWFe1Nua6SYKkgbXevB8X1JrPSIa9VciFa05qY+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcV4zgY3JnfTgET7CS5vWBiAmMIxnzwPw//H9Nh3MxLhEUsSM
	XULVHxL77/SX+kFD6CJElKtawTKgs+oCQAMaCgknn9UXfHkGbcA9LnLVFtpJdNNqfzR3GRRMTOf
	VtWQqtUFrllEhYiIhHoffPoFi4xbcqu0=
X-Gm-Gg: ATEYQzzz7VsXQoPO9TGGtb3tHx/F3qSIc4u7tSHclUjdazneKtY2NIRiTz4eyBXHqWY
	v9TaZvT2nTWnEH8RqvokwmtUo8Fx8AoDKXoJDsVCGtFVBYHptGEtEt9l4yzvFH+hc0R1AXS838b
	2+smcgvVHmWRhNH+J2aHQTTx4NCye57EBfQmdXrfNuFMLBnK/oUaZSBiaiTWFPZ2DwVeylrh4SS
	p0eIB7OkKT0tHBB8+6UfyUhmiecDLmjx941d2nr+H7eARsiPCYs/kySyVjMexqniti0uDAvIfVq
	/bdRC6Xsiko1UrHcdHZpmrdX0fOJQ199a8WtXiRIS/YFO9x/h6uKbl0VMfdR7Q94SYvlrV4FyNE
	V6tiUT4OVWmB4jMKbnevI8Phmo2aRCKVeyg==
X-Received: by 2002:a05:7300:72ce:b0:2bd:fa8f:77f4 with SMTP id
 5a478bee46e88-2bea54e9348mr2776762eec.4.1773668574749; Mon, 16 Mar 2026
 06:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
 <20260307170929.153892-1-ojeda@kernel.org> <CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com>
 <abdJE4BsrzGDTVZT@sirena.co.uk> <CANiq72nXMbP2ZbyNE6voWXrEXg85s99pXLj5LeybZry4eAyzEQ@mail.gmail.com>
 <ffd14e81-c64e-42fa-aa18-60c8036f13e8@sirena.org.uk>
In-Reply-To: <ffd14e81-c64e-42fa-aa18-60c8036f13e8@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Mar 2026 14:42:41 +0100
X-Gm-Features: AaiRm50FoteeJbrCo_ESw2Kb5ArFolVqU4b04Mp39bjrwMxArbZfy8ruQyWMPtk
Message-ID: <CANiq72m0v1Pq6xRb6SjPOgqyYWndeC4WWkgJmWeS0e2YN5C2AA@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: kbuild: support global per-version flags
To: Mark Brown <broonie@kernel.org>, Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, gary@garyguo.net, dakr@kernel.org, 
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	lossin@kernel.org, rafael@kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 1:50=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> Note that I've not started running with clippy yet, currently due to
> Linus' tree having:
>
> error: current MSRV (Minimum Supported Rust Version) is `1.78.0` but this=
 item is stable since `1.79.0`

This was fixed in upstream Clippy in Rust 1.90.0 due to a request we
made (thanks to  Tamir):

  https://github.com/rust-lang/rust-clippy/issues/14425

I would suggest to allow the lint locally (perhaps once at the top of
the file). This will go away this cycle since I am going to bump the
minimum version to Debian Trixie's.

Alternatively, we could use the patch above to add
`clippy::incompatible_msrv`, but that is more involved, and allowing
it locally is what we did elsewhere too.

Cheers,
Miguel
