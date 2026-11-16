Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817359;
	b=qR5tqV9ZNCt5nG8ZLog8Ukq9+Ph/Brbpr94V2zcuCdpz8HUTWCpOF11KZhHDh55TNiD4
	 v8tvdkMNLucOEPNl3edOwiD1h+qBKrxqU+ll9fW8IcugZo4pg2amMMwGQ3oSmTsNT1TWa
	 Bo+zN/RSKvZ4I3KqymuRwajEuQbaYGWSRzEnEB9zsjddCdeVDdWs0AQnEab0p4srtAbQA
	 aIU5ZYm32plKkq+5+ZoF6SUwTsW0ex1o/jOIRY5sxy5D/WM5nAWJAzSMYNqj1pikZ18eU
	 YFDWrpeaax9qDeJsXkKswhnG2VWVHC2eTKRtFfktWlSzEK735aTov5iOlEezgtIl30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817359;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FhHfyYwYQ9ZGP17NUjMsOu+VrPrB95iXQbOeEOYKFOs=;
	b=F2MnnwP+EYaAovS6T0c3BlBDsHo6GDJhAQLu1PQKBpOOP4SpD4NONTzyoitghIEUjU2I
	 zl5nvxOwIOUlM7f9z9sCkMVJqrbkspWUZI03J6XuPqoj2TWI4cJDuE5otLuQw08yxjKVw
	 ZDJRufvQl9oT48DU5XSDhUXGJZsUvCMWbGYZP69orWiER2/RbpwBdkZqkir/A+1nm5fJf
	 6zG7JE4lfZRyJy7YNa6ro5f56Cw0jTy1HMN2lCi32uRYOhYLLSiBSNVS/ogr0aYErZmZf
	 aQYpllZGpk9jjt0Is0hNriM5clAFJ1SS1aqs88SzLsL7M4uJsI+BIcUfaZmOzVVGm0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b="jx/ZBIZU";
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9731606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 08:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9731606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=jx/ZBIZU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=FhHf
	yYwYQ9ZGP17NUjMsOu+VrPrB95iXQbOeEOYKFOs=; b=jx/ZBIZUH+eiIfgl591n
	kki9k049+ZNEFJ6O8zEQf43eL2mUryLnYS6WONV35hADltlR8913ZsixH40hIN7M
	VJdX7R7NtHbnnEPcK1Cx4qLIwgAAAkEUIxLghF2sGxEwGhBpfpcraSVFS6OxBnWb
	6knyJdn2tt5NVk4EcrvGRFASslihaJ6ZF+tfI7gAzsFc7aD1zwt/+xbbXmBtFWoB
	GDjvx0KFOdXUqMvBTGcsvH2veU13F0d7G/YP2XBruubZ0O1r2rjAH1rynewjJarR
	s6SMAGdGvyLWzOH4nB8m5Esih77sNNP7aIVQQEjfU1NA4nbdlGVAspdZE4N3OISG
	bw==
Received: (qmail 1194944 invoked from network); 16 Nov 2026 09:22:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:22:35 +0100
X-UD-Smtp-Session: l3s3148p1@Iy/hemBg+Igujnv5
Date: Mon, 16 Nov 2026 09:22:34 +0100
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
Subject: Re: [PATCH v4 5/8] pmdomain: Make genpd_get_from_provider() return
 -EPROBE_DEFER
Message-ID: <avq9SkUx-3q_28wO@shikoro>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <4524363679c1f2163aca3b3dda2bfbde170d095a.1792163045.git.geert+renesas@glider.be>
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
In-Reply-To: <4524363679c1f2163aca3b3dda2bfbde170d095a.1792163045.git.geert+renesas@glider.be>

On Fri, Oct 16, 2026 at 05:55:44PM +0200, Geert Uytterhoeven wrote:
> Unlike provider-based look-up functions in other subsystems[1],
> genpd_get_from_provider() returns -ENOENT instead of -EPROBE_DEFER when
> the provider is not found, thus not supporting probe deferral.
> Currently this is worked around in of_genpd_add_subdomain() by remapping
> -ENOENT[2].
> 
> Fix this for all current and future callers by returning -EPROBE_DEFER
> instead, and drop the no longer needed remapping code.
> 
> [1] of_clk_get_hw_from_clkspec(), __fwnode_reset_control_get()),
> [2] Commit 18027d6f392ee8d8 ("PM: domains: Make of_genpd_add_subdomain()
>     return -EPROBE_DEFER").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

