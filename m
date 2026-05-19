Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627733002BB;
	Tue, 19 May 2026 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189491; cv=none; b=lC5sWipY4n3pIVlNDJnNwiAPt+LFdjZk8XZ1sh5U6G0SvMdLjBUN2X6YUjN16R8qSeqAGnar50cRv0QHaXhW+XtJJnJPebbrhxFSBu+vgrxlLtdjyzsVLDm9pitIdDBeioTXYiJ/dIwJMr3KXrZk0fGeC4WrW0m9DuQ9DOS4rw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189491; c=relaxed/simple;
	bh=05fiyOdVnVLGij1sPGUbxQG+Vxaxh6SeAQTSPM6JwwE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=B/RqXH8fwb+7hQUBhalUbRv9JYf/GuRXy2MnR1gD6laVsBnb0r/y5YbuPvKKXrTbjLHsYqAPsycYGnd0MJ/I2QWJ19e+DKp4/pSBmCD07cH0qp2U4pAtXnz+XAjq8c4uM15wf53FPcOcxw/Z247e1ugvLD7XH8U1FzkW1GawHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XM3XDIKv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XM3XDIKv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E35A04E42CEF;
	Tue, 19 May 2026 11:18:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A1AF4606E9;
	Tue, 19 May 2026 11:18:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A153107E8183;
	Tue, 19 May 2026 13:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779189486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=05fiyOdVnVLGij1sPGUbxQG+Vxaxh6SeAQTSPM6JwwE=;
	b=XM3XDIKvf3DD5FVw2jYAsmoikc5OlUr8pEGuEbizp33GgWk+PCpf/5nOvSdUdNI94vM3Yz
	wvtqgXfiEXdEHsJEkO+arxlo20YfZDO25iJA+nzf7uDmrdjIQkQ6B6gYl6fNpRcaGaIec+
	wZmoeCjciAnkrNrD29WSJqYkUSQslwopiSePWP26HaXPokG3ZH/I/CxfoIsTROT+QvukfH
	fkAq8G7MaGqdQY576wu0utnDWURc4DihfDhamz7K/rxi5/KUFv5swyXfV5KdYXhK7eRTRk
	yYbJ6FnceVkmFRQEf61HiubOyU18u/Vh6+mNchc1VHpUKike8ihuSjGWojYFjg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 13:17:58 +0200
Message-Id: <DIMM16UB9JEN.31INBXKSQ2WFB@bootlin.com>
Subject: Re: [PATCH] power: supply: Use named initializers for arrays of
 i2c_device_data
Cc: "Michael Hennerich" <Michael.Hennerich@analog.com>,
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Tobias Schrammm"
 <t.schramm@manjaro.org>, "Iskren Chernev" <me@iskren.info>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Matheus Castello" <matheus@castello.eng.br>,
 "Hans de Goede" <hansg@kernel.org>, "Sebastian Krzyszkowiak"
 <sebastian.krzyszkowiak@puri.sm>, "Purism Kernel Team" <kernel@puri.sm>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Hardevsinh Palaniya"
 <hardevsinh.palaniya@siliconsignals.io>, "Bhavin Sharma"
 <bhavin.sharma@siliconsignals.io>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Sebastian Reichel" <sre@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260515101629.4132270-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260515101629.4132270-2-u.kleine-koenig@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri May 15, 2026 at 12:16 PM CEST, Uwe Kleine-K=C3=B6nig (The Capable Hu=
b) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>
> While touching all these arrays, unify usage of whitespace and commas.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # max77976_charger.c

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
