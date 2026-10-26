Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052775;
	b=wR7NzD9h5QvkHn2crBRK8LYwQB+gtad/E1Plo3nnxu+Vi08RuFl6VL0qgzi3/O4YjAd/
	 0i0QxIp2KCXNQcOj9nmtlJryVr+EviuTZbkc8PQ0TnCfoBryvWIpZ4cPfv0bq6ElBGpgS
	 2nnZ2GHkZ6DCja6kiC9IPinCWYKGaTNMTz0W18d2GAKFVwGeqzcTC48xtoaIuBXBt8ki/
	 zpGeZja9jMW+BBruK464LHv9br+c/uPwaa0+1oswD7RYRI9+MnXuK4UjNPIcrfe55+Rjo
	 X8L8UAjPuG/Vto4fr5ZfciAHfxIvEIXHUUqfFHGfkihO6/BbOxTOErIfRvt3ZRwuUXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052775;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r+kxRt2F7dr17vhcy6Xq7mbad3R/ctX1xx02kP9+rH0=;
	b=bSOgg6Ys65egja18q/AYrj6VYhEwx3mn7ncxLL4T0DE07xX0elbe2PlUS3qW/w6jEfkF
	 MtwtJaiEc5L/4NzmGutVUT0PRLKyX8pbCy3/ScKLp0XD4SzFOfZgc+XOnE3R9wk1IIVGm
	 2czpLyobhuvwy4wwsKGRqfLo3uSsfYmOAe4ygJJ2qovBJDKEUPDJCbkHgM2H1uMuSz7BR
	 +B3vT6TKnjfwmO09XyKsiYj8/Yq6Rr0v9pGRU7nNqsTixj5lnwOnzmeVxTlY6LajPOIO8
	 s5v8FwkPC+J0ZTjNFTqFfL9FOfmrxbOUPzxVbkINu0TtdGJJXw8sOq3fYhVVllWLy/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qmc9hmUd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E94606A31A;
	Mon, 26 Oct 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qmc9hmUd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C43B1F01825;
	Mon, 26 Oct 2026 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052774;
	bh=r+kxRt2F7dr17vhcy6Xq7mbad3R/ctX1xx02kP9+rH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qmc9hmUd9drSHLh4u3U5pgyDlQFvBhLc+9Nndml8xkkn9E6XOjJkBfCpqaNVhvO5e
	 UzubR56p+SrmUuY89WfF84X92vRuSKhvud5+jbAMFY2q3WMdAMV0o3tdJomp+83M4f
	 NoHH1MTPqMmTJcgIAvNzf80OX3drbMw7cj9oEMHPZJ/qBQ5ZFWfZgYicgItotVha4z
	 6/1NWmXSrx6q+q8c+r34mLVHn6zjdtlaO4Z3DOyodsDuEi/H5g02fhZ7+NynfBCzsS
	 Kk+hg0eIAUpdpD3qtgSgFoA+xKe00IQ8LoNqhQwAPhp7AqsiKk2scy0DFN7h/jtMqO
	 V9QztRIE0yOUQ==
Date: Mon, 26 Oct 2026 17:12:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 1/1] dt-bindings: power: supply: maxim,max8903:
 Document MAX8922L and RT9524
Message-ID: <179305276926.4032096.5720095014424223708.robh@kernel.org>
References: <20260930072450.61836-1-clamor95@gmail.com>
 <20260930072450.61836-2-clamor95@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930072450.61836-2-clamor95@gmail.com>


On Wed, 30 Sep 2026 10:24:50 +0300, Svyatoslav Ryhel wrote:
> Document MAX8922L and RT9524, which use a similar charging control pattern
> to the MAX8903. The MAX8903 is set as a fallback for both chips. No driver
> changes are required.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max8903.yaml           | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

