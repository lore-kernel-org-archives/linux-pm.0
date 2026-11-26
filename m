Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795687230;
	b=eQKSYXfmU8V8v8jtjrBalUpCVwp/0frHBK2LUrQb77DAr+5zIRMV3XmKmJ3muLzyQde4
	 dkfyyUWZgHp7r2WqdnLDkPh/24Ydem4Gk/5uAkPnAwTq5qQv9u5M08SSQTMS30G1ttQbw
	 9iHRkWVsr+sw96FiP6Y3/t+KafcVBfyMUdRahrFlk4bihUonL0KjSaLhnhN5qjQeZ3G+z
	 LDq4SEhHcwm0JO59KexImCkLnLFImB3pGgTMybu2ZqgpW4r5BRh+ziBnk1LDsC/tGQQ7c
	 aoRX4Lkzb00X4jcM62r7WhNY1BMnYeo0MuOiKJtQRSyM5mQPMuaVen2fY5U0Lg++M0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687230;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=q2mecaHdf9fQt6uFtB3JOo6SnHGQnL+J6Uhto1mX8V4=;
	b=Y1ShRJanqDa4ynW9fZTrQWelee/Qp/cXaTcoaKQSZnYtMKaEiW2KQHkCVey8H52CLCdP
	 a5tubCsOdXCaXup7M2eJYAvZniDf/x2lUFS9RrRePCHK6ClpAcpLCh4kEv2CYbhZ3C+Ze
	 uPJBCEo2/Thlkjyyi29/Jkt8BAxsuJF8nF+Relt7CTQQAmtId0IL7hrNjhWsI66RGiGtD
	 UGhF2OJW6hZ1UNiYLS9CO/weRRgNhl1MAMRyr3sEoOHS1rt3v9iKOUQZ5dsYl+Q7ByhcB
	 kQxuV72zlwq6nUbAUjDp8PbZn6YArUeihrae0zzD1ikg3T46tJ3276aFi9ZN4i0/nHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=E2nkLJu8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713E606A321;
	Thu, 26 Nov 2026 10:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A713E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=E2nkLJu8
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3062F200509;
	Thu, 26 Nov 2026 11:00:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795687227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2mecaHdf9fQt6uFtB3JOo6SnHGQnL+J6Uhto1mX8V4=;
	b=E2nkLJu8uEfaPkMO+WNZl7KByQ7wd17jFeir36TfrYvQxbfFKC7mn2SdTAalXdGoaa2ZmX
	4JdaOx+npG715reCsbR4dqlTOdAhV8XxUMxPAVhifDuL7NIW999vC1SXMStE2T4J1Qyuue
	wH7HPosPfk522LVvVeI0DhpI8n1UkwymWyW5FjEOB3ne4Tr3hfd4c4JyIhyW7mrNfZ6Yyr
	YEMwxxw+xpvmpjaLvvWb3e13r5hSYOVKAgLvp23gvm7kpUNJtj7UTG1HeEDxMugxEkKLmA
	DzPgwizW2yWZHh4Cjdyyk6ZugjJLAFSmbay1dQGQJVh6ynP4voaDmCXb9xt25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795687227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2mecaHdf9fQt6uFtB3JOo6SnHGQnL+J6Uhto1mX8V4=;
	b=FE0vI8qUEgOEZFKbIBM0XdrhW/hSbyHWJ79sdSHrsOnIVg9JEElEXBugFVTnApGxcIFa7G
	Wue4egM96zYl+LHmjwCZWd8cH1JvD4fGUp2BNUcsKW7KeqGlECqkUe3YOKg0dBdRHcqH8B
	xehcEpC+OMFHPxEOGXEywsiSKKbqf014iK9FsG18lWx0/XBf9LNJpEe4n6Uzrd10g0vBo1
	QzCfZpwxO9juycrNaJDMumwinDvIQBiKp8shIONQe8lRT7fgnDC1xY9uGvGRflNo35fwcR
	CrNeELb7j1xccXRj/53szIGDZ7MjEDL49PqzujbKBUcC9uQ1Ec4cl3pg/JbMYA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795687227; a=rsa-sha256;
	cv=none;
	b=VNKAcbU6083evAYtgG/4DbGEJvDmbeaURvQyZkqMuPvl3kT6NFUlGfwrj14ied8bMDmGsK
	1nd8XCpCfywUpvxt6Au1HrWlkK9V+ujelfUgjVJme3TKo2WX51GbHeQUN2f6+ZssaL+Cvw
	jVFVZIrrzbRYtsqnHcmYFbKCYUT1VQzHDacWYk7TY6rBCSZNLAET3rpVHCvqCsr7acPb5o
	/5pi015kNzKdfOLW6rpZi2T620SePC75+kmFWGpWl8si/nqfvUhDKd+qwgUhBaxgXG8++s
	iNrMfHtbfyiBxB3FcQXdd0c0imCObGH4V4h8A/FeZdcfswD8UykmGrHKvBJTFA==
Message-ID: <66d5a395e692387ff39669b60f803cde8f97affe.camel@pengutronix.de>
Subject: Re: [PATCH v2 5/9] reset: google: Add CPM reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Brian
 Masney <bmasney+clk@redhat.com>,  Jerome Brunet <jbrunet+clk@baylibre.com>,
 Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>,  Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>,  =?ISO-8859-1?Q?Andr=E9?= Draszik	
 <andre.draszik@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, Jakub
 =?UTF-8?Q?G=C5=82owacki?=	 <jglow@google.com>, linux-clk@vger.kernel.org,
 Douglas Anderson	 <dianders@chromium.org>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org,  Mariano Marciello <mmarciello@google.com>,
 google-soc@lists.linux.dev
Date: Thu, 26 Nov 2026 11:00:27 +0100
In-Reply-To: <awcz1aP6xcL6G2t4@google.com>
References: <20261125000349.3385325-1-briannorris@chromium.org>
	 <20261124160343.v2.5.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
	 <f89e293688feb3f9bcdce0f1b6fed0ee424e5cd8.camel@pengutronix.de>
	 <awcz1aP6xcL6G2t4@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mi, 2026-11-25 at 11:15 -0800, Brian Norris wrote:
> On Wed, Nov 25, 2026 at 09:48:04AM +0100, Philipp Zabel wrote:
> > On Di, 2026-11-24 at 16:03 -0800, Brian Norris wrote:
> > > Google Tensor SoCs (used on Pixel phones) manage many resources
> > > (including resets) using a Central Power Manager (CPM) co-processor. =
We
> > > communicate with CPM using mailboxes, abstracted in the
> > > devm_cpm_get_handle(), etc., API.
> > >=20
> > > For posterity, I list a summary of changes made relative to the
> > > downstream Pixel driver:
> > >=20
> > > * Switch to auxiliary bus, as a child of a CPM device
> > >=20
> > > * Use devm more heavily
> > >=20
> > > * Avoid representing each reset as its own Device Tree node.
> > >=20
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > >=20
> > > Changes in v2:
> > >  * Rename symbols from goog_cpm_rst_* to cpm_reset_*
> > >  * Moved shared protocol details to CPM driver
> > >  * Remove custom reset debugfs interface and .remove callback.
> > >  * Remove per-SoC table; we only need naive translation of firmware I=
Ds
> > >=20
> > >  drivers/reset/Kconfig            |   1 +
> > >  drivers/reset/Makefile           |   1 +
> > >  drivers/reset/google/Kconfig     |  11 +++
> > >  drivers/reset/google/Makefile    |   2 +
> > >  drivers/reset/google/reset-cpm.c | 154 +++++++++++++++++++++++++++++=
++
> > >  5 files changed, 169 insertions(+)
> > >  create mode 100644 drivers/reset/google/Kconfig
> > >  create mode 100644 drivers/reset/google/Makefile
> > >  create mode 100644 drivers/reset/google/reset-cpm.c
> > >=20
[...]
> > > diff --git a/drivers/reset/google/reset-cpm.c b/drivers/reset/google/=
reset-cpm.c
> > > new file mode 100644
> > > index 000000000000..ef0863f25cac
> > > --- /dev/null
> > > +++ b/drivers/reset/google/reset-cpm.c
> > > @@ -0,0 +1,154 @@
[...]
> > > +	if (lpcm_id > CPM_RST_ID_MAX)
> >=20
> > This looks a bit weird.
> >=20
> > Maybe add a CPM_LPCM_ID_MAX, directly use U8_MAX here, or rename the
> > constant to not include RST_ID?
>=20
> How about these (with the masks made 8-bit as they should be)?
>=20
>   FIELD_MAX(CPM_RST_LPCM_ID_MASK))
>   FIELD_MAX(CPM_RST_ID_MASK))

Even better. I just got tripped up by the comparison between lpcm_id
and what looked like the limit for rst_id.

regards
Philipp
