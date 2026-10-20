Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.120.86.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457841;
	b=cgZkc7Wf233n0tzVUkKglXOhsM+6C2DzOQp7nF/WZ+MD51fnxCIQA2CmfhZJOjvMcpft
	 Nhwz3nIx7r8Rc5Of3pLcx2y9Z95LELVdXFV0fIUFpR/IfLRu/xZFxKT3gTBj4sx4NB6ro
	 DmucviTgJ7oDxZjmvx1zyRBY7crsDiuX8aCRdKGGWeicWIiBfeye0IcNzFTUn+gYFyd9N
	 gE1qrVghdVIwBraJTEYHQjP+UMxnSdHRir6rNjMvrNBndbUVDdU19rqaIAwKbwo7blcl+
	 LL1sikRa1ZAf3S7+2l1xoGs117UKjUu4SaMbtz1RRlV+RUmgRvmBpfE4rAodpAfSzsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457841;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:
	 X-Report-Abuse:Feedback-ID:X-smtpcorp-track:Date:Message-ID:From:To:
	 Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=baFTI7feHfHjUs2Z1HfLPGTNQHlNGEUNjb1UhcudQe8=;
	b=Wl597Q5dkr/wFM0Kgb+9OQ3Mx4mtLAkS0bD+bfCRSTI9gBJL37Le7jmIu9aFF8R/E3U9
	 aK3PIxXz3U+HIbXHUJah1XGTYkN7IyFn7GrUUdwDXD1D2PWRPo3jV53k9NFn7qH0NLuj0
	 O+D/EbmyOkq/fJ7iAV3VY+TyqkdsU62EXxtCk+GF2X4eE8zPJTar3TrE2qNglVcIVRAXo
	 IASefBEIgcj7Q6HKZ5O4PBkWuJ6aXB8r0RTqUJq9+UcDOMZI3hdo55OGbMUXXu+kppFlp
	 Akc+Xn+WUXqYkZ2VOylGO9P2GNVEo6buOe99iKK0pgAR29lFf3L6bQ6cxKNzbzoZTBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fkr.dev;
	spf=pass smtp.mailfrom=em1020969.fkr.dev;
	dkim=pass header.d=fkr.dev header.i=@fkr.dev header.a=rsa-sha256 header.s=s1020969 header.b=G186HOOC;
	dkim=pass header.d=fkr.dev header.i=@fkr.dev header.a=rsa-sha256 header.s=default header.b=X5G4kOiQ;
	arc=none smtp.remote-ip=158.120.86.30
Received: from e3i542.smtp2go.com (e3i542.smtp2go.com [158.120.86.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7589606A31E
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 00:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7589606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1020969.fkr.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fkr.dev header.i=@fkr.dev header.a=rsa-sha256 header.s=s1020969 header.b=G186HOOC;
	dkim=pass (2048-bit key, unprotected) header.d=fkr.dev header.i=@fkr.dev header.a=rsa-sha256 header.s=default header.b=X5G4kOiQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fkr.dev;
 i=@fkr.dev; q=dns/txt; s=s1020969; t=1792457834; h=from : subject : to
 : message-id : date : list-unsubscribe : list-unsubscribe-post;
 bh=baFTI7feHfHjUs2Z1HfLPGTNQHlNGEUNjb1UhcudQe8=;
 b=G186HOOC4O/LZ4nL4ONO3grI0S/AJ+pa+LWK/IY6T1TezDWqeuCFpl8PZJTHY0UgjQoAw
 ZXGLmOI8Ccofmf0T/0RpTSZZ5FJo2HTL3i8HhD7kVC+FaGqhnPcY8cW9h+ux+05XaWI274T
 XYdJE1hKrAsWNouO23u0hTME2/pWX1gWv1AzuZ9KwqBg3Fyy9UtpQ8BeubHM8owJ3Ne7jEw
 0AqYzMgg2xSigD0LctvFGCgpOtRhxZzeIwRRPNBjSaYMzeW1OWFAbIQSmWf3l7v92ltKQ70
 Azb11X1ZwHTPkDqBzbaZ49y2W3SImJaln7ZoHv4+PRdq3stJqjfG/g3v0PjQ==
Received: from [10.244.246.9] (helo=fkr.dev)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128:X25519)
	(Exim 4.100.1)
	(envelope-from <florian.krischer@fkr.dev>)
	id 1xIyA6-FnQW0hPvgRA-l4b6;
	Tue, 20 Oct 2026 00:57:06 +0000
DKIM-Signature: a=rsa-sha256; bh=baFTI7feHfHjUs2Z1HfLPGTNQHlNGEUNjb1UhcudQe8=; c=relaxed/relaxed; d=fkr.dev;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@fkr.dev; s=default; t=1792457824; v=1; x=1792889824;
 b=X5G4kOiQaw0oaWEFVOVcN8ACj5el/tE15KiCmx5ZmF7yp1Y1qajbyAJEPkpol0Zi4Sn4Yqfm
 L2HfKgXtNB5ChfTtM1CH5qd5GYisvgI9OSrkbowFKQeVZ1VJHvbEiFgCl8OqYPTMK+08+sxKgEA
 e7rd/f+ZnnyqRl9kNPUOQ26jr5a6XXaAsqqiirg4B3NzcZzWCau74dg97dlR0vE5cFL7qxZ7Y2U
 PBGn3KJRVR8qMQPV80hFuvk2ijpXtIEQZb4CpbNEptimpTHkU3JcNOgd3bQUjwEoDDcJ1JcU41I
 RQ8crMwUucd7sO249fwKG3ugn+c9wOUG9v+hGmYbCY4lg==
Received: by fkr.dev (envelope-sender <florian.krischer@fkr.dev>) with
 ESMTPS id 5b88a664; Tue, 20 Oct 2026 00:57:04 +0000
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1020969m:1020969amTSgpp:1020969sMMvfpqAzu
X-smtpcorp-track: x1CmlGXZl4gi.sEKU9J7JBtnH.cUtzygw3bbk
Date: Tue, 20 Oct 2026 02:57:03 +0200
Message-ID: <70f4c4d7f6263385d29ed8baa2106769@fkr.dev>
From: "Florian Krischer" <florian.krischer@fkr.dev>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Ion Agorria <ion@agorria.com>,
	Michał Mirosław <mirq-linux@rere.qmqm.pl>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 0/7] mfd: Add support for Asus Transformer embedded controller
In-Reply-To: <20261019100406.103687-1-clamor95@gmail.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I tested the v12 series on an ASUS Eee Pad Slider SL101 running Debian 13
with the 7.0.1 postmarketOS Grate kernel.

The system booted successfully. The EC identified as ASUS-EP102-DOCK,
firmware SL101-0202. I verified keyboard key events from the EC keyboard
and touchscreen contact and coordinate events from the tablet's maXTouch
device.

Tested-by: Florian Krischer <florian.krischer@fkr.dev>
