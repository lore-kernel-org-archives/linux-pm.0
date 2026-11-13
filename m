Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568457;
	b=4a5Docs2bs+SryJBS8ModDQWXhGNsxT4od2qrIUXTFZ20xquC7nLmW2VmjSTXC1dvQus
	 TMYvVnkXFLuox8TWzIQgpI9o/h0pt0evYJMJ58iwvH8SUGxmQqM3bu+WIG9+IyiqHCLXO
	 Py7Gd21muCaXNMQ/AfzKley4dQUctJeXYfzQE2QfT3KaKua7FARuCmSzbIM0tw0xB5IQY
	 Pa6wO452Opzo8v7iFn7N2Exm7cQwvA2u+W0WyULNJTW1ySOMtKq/j5j/6iwCKuDrXu4G8
	 bhLODQ9pR0CDdRfwdwS09D8RI581az7ztU9ZiLjjdY20sE9Rw1cKMBs21H1Lnbr15Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568457;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DI9zUioBstSR1sY+O8dLVu9Yy81WkzynvlyVkvZoxwQ=;
	b=Tmj2kbLczlcQqBce0DPQDAhxgrKBgXzD0+w+ts/dfKNAcTTeCW2AUjaVQZ+wDZyqSmZU
	 gILE/JA+z6J2rrq6BhHwOfs8xXLECp7t9TpN4hjXyj8KUFzZLF2L2IgCCM30nfRwir89Z
	 XjxyJF/Jn1fhp0jbPLVkapBm66DssJcJQ+gxSAmlPgp6yZhWJfn0IvFXxab9Dtw129bBg
	 KQRttRlivN9i0tZz8xnZzqpfw6nHoLuWdKswKUB4E0j0ydXvw6QaM39AWRVCOn8fcGIJ2
	 nC7qBoKumlHETjvUnQtCRq381gwNwPNHuAywbJV+7dkrzDYMUNHqme3xT4Y9Ato3j7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaaZmMX7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C0606A334;
	Fri, 13 Nov 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaaZmMX7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D021F000C5;
	Fri, 13 Nov 2026 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568456;
	bh=DI9zUioBstSR1sY+O8dLVu9Yy81WkzynvlyVkvZoxwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UaaZmMX7mwx68mzgAbMgISBh9qfcSvIv8wGxpNdYkOQkpfhATx4KzLVsYESu7c6sf
	 Rvw8+3eNIREqEsehjjheIaquC0gyyl79lHv99v1bHFNmtGJyaPinwK03GF30+Akbhg
	 eAdILOH5pa3Wr1/KC844fvw3BW7hrC9OJICUbLNMS4hw7NgHWuRzv5InqUl6Csg71T
	 3UrGZYPO/MIjYFWNj5eEixfUwiCw2fKNzh7/2Da/ptUoADxv1gEgjN0nXv1XXe3V8W
	 uetFcQilgLTNVzdxufsEl3npih5Erga2mGj57M8lWtgT3pBh5gUtBVMQcTjtenNe0i
	 OtRdMR/146yBA==
Date: Fri, 13 Nov 2026 12:14:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Asdlerto Korry <korryasdlerto@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Silicon Mitus SM5714
 fuel gauge
Message-ID: <20261113-industrious-myrtle-butterfly-7c1bde@quoll>
References: <20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>
 <20261111-sm5714-fuel-gauge-v1-1-b9d163fff6ff@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-sm5714-fuel-gauge-v1-1-b9d163fff6ff@gmail.com>

On Wed, Nov 11, 2026 at 05:34:59PM +0200, Asdlerto Korry wrote:
> The SM5714 is a power management chip for mobile phones that combines a
> charger, a USB Type-C port controller, a MUIC and a fuel gauge, each on
> its own I2C address. It is used in the Samsung Galaxy M52 5G.
> 
> Add a binding for the fuel gauge. The temperature measured by the gauge
> itself rises with the charge current, so an optional ADC channel can
> point at the battery thermistor.
> 
> Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
> ---
>  .../supply/siliconmitus,sm5714-fuelgauge.yaml      | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

This was already sent.

Best regards,
Krzysztof

