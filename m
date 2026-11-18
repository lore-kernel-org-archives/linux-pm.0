Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020151;
	b=WHpTKVkaZiSLXDqOLYk/wY9ufwuGcA8Q2fr8xizBvFohyUN3Jlc5GS8NSEp2aXHl7mXJ
	 MQLd51ljBhn7KbOIsvNmnfVhN4ourx3Ib5mdw5zB2bcSxa+jWSfi69VYN0vYxG2bQ00+t
	 EyDm8y6XVl8i8gmToNn1mG7G6jJDJ/9PE48DDuhYok28rezq6NlIbyXRBDhyNjKOKMMDd
	 7V7s/rNoxveLnIsjFUMp3uNW6IKDjUtB32u6UQ0X8jF174FJ/Cou90m9t3sazqiBawRmc
	 GRUPoFkaXelYvZYEvLXGRZ6c52O/hF1vtBV4JIzYtaaZmDYl1tiwHgB7nT0Bo65OHhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020151;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+lTaRiyl+AR7PaEBfcfzeHvNkcZq06BPtocMWKpDA8c=;
	b=0z6Kxx5A4C9AolyfGnj82yNNL1CK++LwQ/vvugKiEhguAOGadnp1h2eyQkPsMR1WheWN
	 Mj8ltrlIYxNYKv/X6332J1S1x9v8AfjzBsdn1B1+P5gfeExCh+8DpDkPY7+fV79DfUd/v
	 SW+Aw/DlM3PdBNIucbfaz+opBsDp7vscIH8GOunbn+CDfktlvMBWGWzVOxMVIe1GzRFtn
	 sEHPlJW1+4k4+vnXrCYZYs79z6LxetoW5I8WpFv0fHsG87baQtHvcp4GoOeHRJS0MrX0Z
	 kMCKh6/dzAk2ungt3WiaZ6jpBTT5APtBJrVANsLcuBLlELMNJkZDgfhzJACfshPY2mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1IPDzps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3E60A2605;
	Wed, 18 Nov 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1IPDzps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FB71F000C8;
	Wed, 18 Nov 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020151;
	bh=+lTaRiyl+AR7PaEBfcfzeHvNkcZq06BPtocMWKpDA8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X1IPDzpsRLjI+mItmBK63WBmOYqn9+4paqR9Wyi7wO8CdxA+d3aF4tLYbG1sIpSVz
	 CYJczH7Px0BGTJ1nxRTp7y7QmaQycIl1/1JLHB/jGpKc3DzBCsY5NeShtm0h9EJpyj
	 YSVIMAqA+vj423PnilZxzi+KZWnvlDxh0/Y/O91bKjk6tVi8XhzjMcrFGcBhRhG335
	 LDiF5WCZwfGX4Y05iUztiYezBqIvqpYHn5E8Nc9/70wxcOZxSA7gTUepzlYlSD/KTt
	 nHhmGYHsxKagjY0t0j+5qsY9GbyJAxk74kbBzhIKJzgPqMnL4B48vXC6xtXptMZ4eF
	 VQQ8JRBmUL+xQ==
Date: Wed, 18 Nov 2026 10:42:29 -0600
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jens Reidel <adrian@mainlining.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Val Packett <val@packett.cool>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
Message-ID: <20261118164229.GA2892053-robh@kernel.org>
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
 <20261117-bat-temp-adc-v4-2-14d5d309ebfa@fairphone.com>
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
In-Reply-To: <20261117-bat-temp-adc-v4-2-14d5d309ebfa@fairphone.com>

On Tue, Nov 17, 2026 at 09:23:12AM +0100, Luca Weiss wrote:
> Document the property to allow using this sensor with io-channels.
> 
> This means that the output of generic-adc-thermal can be used as an
> input into a different node.
> 
> As a specific example, generic-adc-thermal takes in an ADC io-channel in
> Volt, outputs temperature in degC, which can then be consumed by a fuel
> gauge driver to provide the battery temperature readings to user space.

But this is already a thermal-sensor provider, why wouldn't the fuel 
gauge use that provider? 

Seems like this is letting current Linux driver design dictate the 
binding.

Rob
