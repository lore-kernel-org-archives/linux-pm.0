Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3A374A0C;
	Mon,  6 Jul 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359053; cv=none; b=kZ28VtSy7ZNV7bYG1ofS+AWRzGwbW1yXMn663JpFjVAT0ixTebA2xY1/w0P8MzM57tlMqoMq2LTW8aJiN65RhSiS5MQS73QJeZy02ezqdZ5Rxt/+SAyVicKcLj86n6c9tPrz3OUOqMJXfO/mtijh3JUN6ts7TUdOoLuCf+OCctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359053; c=relaxed/simple;
	bh=0ve5TR7M6W6V+YUiCfXYERFO0p7DK0MnKLcyKIvC3qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVUkeBozrhSm+1jndajUMVoHn0xlz/0EJ4yr5s5l93ws6c/dERDoQykuOSvVCbuQIMPy/Ja8DA8okwfkh6YgjRRtIQEkv2dYlZn1c6Wt2bUTFNBXKXI8Ryi+BVuUJ8DCziY8K+3ZlZKzJu9XAeap6Cozt0yWyRXmYQjqxAonjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLUC+NnK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLUC+NnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727631F000E9;
	Mon,  6 Jul 2026 17:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359052;
	bh=0ve5TR7M6W6V+YUiCfXYERFO0p7DK0MnKLcyKIvC3qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iLUC+NnKendS6Qw8Cmp6jBpJINcK2+VRZl8W8VbCrGWGeTxnZl6iEGLixtXq0f+e7
	 RRzQotYJTG+E+PEOqTGwk6AkzJJgCEHywGzZ+3PrX5ucOOGCG7SVx4FbwwEmghRcN6
	 co0oXV4tRK64xlELV9h8nN7HurrnvtTyl28qcmJEwyyERpaZO1YOJODGuPXc96iZKA
	 iKfYo5yYev4E29KH6/d/RLFXp7Qf6dDf1TYSM71X6tsUY8tSXUBG+X4AdAAvfqt6FX
	 8AWDf1n885wo8ja16APK1JjtRNJaLND30rlF5uTPYCHsEa362oOOmQ+OyckAfS0UUL
	 0w28d0/hW4hig==
Date: Mon, 6 Jul 2026 18:30:45 +0100
From: Mark Brown <broonie@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Dilip Kota <dkota@codeaurora.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Girish Mahadevan <girishm@codeaurora.org>,
	Alok Chauhan <alokc@codeaurora.org>,
	bjorn.andersson@oss.qualcomm.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
Message-ID: <f6532e0f-a0b3-490d-8313-d6f5b72e8236@sirena.org.uk>
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-1-92feb5a7b926@oss.qualcomm.com>
 <CAJZ5v0i4Zc4HNUdgJ_2=4=wv7vRDTugo71qsWnZxVRRqV+W8mw@mail.gmail.com>
 <9d271393-c500-46a9-8795-f1371585445c@sirena.org.uk>
 <CAJZ5v0g9AxpqUQUQ-vwG2LN3pfT3qXi3_S=So42=VdVtzg-=Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CrLHFYWN/IguOnfv"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g9AxpqUQUQ-vwG2LN3pfT3qXi3_S=So42=VdVtzg-=Dw@mail.gmail.com>
X-Cookie: Did I do an INCORRECT THING??


--CrLHFYWN/IguOnfv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 04:10:34PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Mon, Jul 6, 2026 at 3:21=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > I've got a bunch of other stuff in flight for that driver - I'll need to
> > check but just in case perhaps a tag I could pull in?

> I'm wondering though if the patches in the series really depend on each o=
ther.

> There doesn't appear to be any code dependency between them.

That would also work, a bit annoying for any bisects possibly but so
long as we land both in the same release we should be good.

--CrLHFYWN/IguOnfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpL5kUACgkQJNaLcl1U
h9CwTQf+LP+GUzoAhJWFTkWhqsyVxS/28om6taZlVclXtEqOfM+Rw5KT9yiQYjTp
NTewsbIt0uMNJ4KilOxVAHom3SRoY6s9oT52RiwNP2LbS3kW2OO/StUYPNCtnj2B
HAgYmEGjIbfoH9NSbrMoXw5nFS67UTWwhwkCY30cuO9NWQLIcRi4TRqL0gqXk9Gm
IeGXzvGMPzOV6ArKixhEwTbNIlIY55PGleiMd6VbWgjgfKa0GQRneSL6fab7rLfm
evkoVX0fRc59vvW67CiYxPam8oAtI61KfZ0Fjuc8ZM/fU2bWj/2I1gHHhCoR7ihC
LfVnkEaJxlqy52b6mLztNJMzVPCmHQ==
=B5g2
-----END PGP SIGNATURE-----

--CrLHFYWN/IguOnfv--
