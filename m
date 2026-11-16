Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817348;
	b=nSXSUXRXKeGe9yVMGCu1JM50efGYoBr4mhVdvqnjcCaizIPFucuXwwo7/vUY+ixTea66
	 hWG3kDBNzdJYudRntCkGwHL7bTbkubvO9DfdaKPrmG3y19azJj58ybfO3/AZmA+LZ2gBJ
	 2McjwV/L7CP8eV+l0POLw7CvoCf+WNZTubAJL6O8k7AV0C3xFt8GC9o+ua86cGS+G+BlY
	 7jfY1CGMEgOaEBZbCbmgnKkrPOKknt7kt7gLx6VGMHe77rxMTZF6sBXrn0GlNcjbXwVEB
	 Wg9oy+rhd2wuYsM09RnY6ZRCbXpd0sKre58mojwTCZspV+7N02aEwoKWe14Mpxwqxqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817348;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6zLq5fm3OmZRvOt3lyD6r9AW3NWjUqASxeSxrYrs2BI=;
	b=rDj/uJhAvnYw9UPShYJMHaGcq8BVY53vAvKHtYHMh/MQ/Ms9dzCngonRRYhRvxglCH5s
	 EP4hJ3zt7E4FMD6y+BlZtVANaLnD4Vowe6ktenxm7j1MA41vmCu4R3+Clo9qSZJjuDDf3
	 cuKxon4EqnVLpQRCyxa9Y5mSOe7fK15SPnPsLh66N2XeAPF87gkgfY3U3TfHcX3nBcjBw
	 v+1sInZGNFchvpiSs4aRBWOTAGM6GoFjXV+BD9JyoyRfUK3qHvA51d6Bqf3Ow3YqToEKA
	 BainngoiPMpOJI6EJhWqWFX5KnmZMJgH6y03Dh1Of02Feqw5uyNgloXWUe23nKNy/3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b="kY/1Xfsr";
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A480606A329
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 08:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A480606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=kY/1Xfsr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=6zLq
	5fm3OmZRvOt3lyD6r9AW3NWjUqASxeSxrYrs2BI=; b=kY/1XfsrFQOr3WDOyqw+
	BL+DpZczzezRMyxqyf9OH83LcdouDCP1xAlUsADWy3VQQ05SwrYUo1ADp/Go6AFA
	VBgRXaVE+2xBIrpsXOwRn3GGMn86wHIhKSV1f8JpfsgoZX0tDqpUkQSjDaktOYPd
	IfqOVQLe4VSglZ27RfzoTwI/fu8lnfxcRBEPDC3RXAm0ZhD1vG60GDjUdPy5sSxb
	S1uDmBwnEUWdtvDPNUH+JpM5NLAc+3T9T/GDLGmDfcYJe2QntA1c++ddmIV49kbd
	LqYdLHiHnoldnzqrQrLTFjBYRspF54oVVay4gUsDPExcbnXW+qh7uFHZmiIUBobE
	uQ==
Received: (qmail 1194710 invoked from network); 16 Nov 2026 09:22:24 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:22:24 +0100
X-UD-Smtp-Session: l3s3148p1@jrU8emBg4qoujnv5
Date: Mon, 16 Nov 2026 09:22:24 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/8] reset: Extract __reset_control_get_from_provider()
Message-ID: <avq9QEAGR-C0EZuR@shikoro>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <7df36f036d72403260a51491cd6c3d387f0dfed7.1792163045.git.geert+renesas@glider.be>
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
In-Reply-To: <7df36f036d72403260a51491cd6c3d387f0dfed7.1792163045.git.geert+renesas@glider.be>

On Fri, Oct 16, 2026 at 05:55:42PM +0200, Geert Uytterhoeven wrote:
> Extract the code to create a reset_control structure from a given
> provider into its own function, so it can be reused later.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

