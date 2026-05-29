Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814543D88E1
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054802; cv=none; b=UZWBCw70HQGgHAao208ZhwAGg9tVQ4LL2hzsEBxf3ITtELzrH4VexbcHcUaTLvLo9KDquOBdDz9XCrTOIQHmhBO/UwPZktgPXUajRu/uSMM798zbhaTKfhgR2HwRywyCAiKJU+aH/cHUB9p7zPu9VCdLdSCQ9CprmQfST+GR2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054802; c=relaxed/simple;
	bh=BFbpEcP2gl8SzS9V6g807nEM04+krO73ZpdU1ywX/YY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=iWHvGcRP8iR3KOIE+742iHxM8zEsXi5BOSNBWR6WpKieUsfL/RH+oKDoNqLYFhNa7myYuu0HCe1BoIwNv45AhOvRcJIKBsGeiha/H6sHfJZlyVVho4jpYSESOmkejC4zRx2lkEKlt+bDYaht75DbjR6054WoG94c1ksDHQEviH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=VZbS/zX/; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="VZbS/zX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Cc: To: From: Subject: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1780054798;
 bh=mvGXi3GnoQLfXUwepfNKreQtoZ065df4GYADd0i3vGY=;
 b=VZbS/zX/szNJKb7EbvE+4V4ABFIKuNOQXkc/8rtKb1tHOPreiihPJVZZ9qXU0ZZ6AIiYWyGuZ
 F3+bMTpT736vBeTFy7MIsFaVP99cilzzv16YK9xQ3Olm7GZw7xZlI9sJDEDJj+waQQvlwPUtCqX
 Z4lAupR9FARkcySXTZoPfhoE8+jjbURqWT0P4lyeTqr7r7teMOdqdR3il1THok4lPka6LZNHioG
 6a5Aw0MqecSzxs3fVSEBCAUS2ox07OVpLnKBH0rJX2wKT5X5e+y/jDifcdmoEhoNnAbVAjDSnZd
 B3xme771VoQ0yDWGgo47kBV66MAhcNgQ38jE30/dvGvQ==
X-Forward-Email-ID: 6a1978895c58ed9868160fa3
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 29 May 2026 07:29:08 -0400
Message-Id: <DIV4J6UGUQGG.28KL8EGBZWJSJ@ubuntu.com>
Subject: Re: [PATCH v1 4/6] power: Use named initializers for
 platform_device_id arrays
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Sebastian Reichel" <sre@kernel.org>
Cc: "Yixun Lan" <dlan@kernel.org>, "Andreas Kemnade" <andreas@kemnade.info>,
 "Matti Vaittinen" <mazziesaccount@gmail.com>, "Sven Peter"
 <sven@kernel.org>, "Janne Grunau" <j@jannau.net>, "Neal Gompa"
 <neal@gompa.dev>, "Amit Sunil Dhamne" <amitsd@google.com>, "Samuel Kayode"
 <samkay014@gmail.com>, <linux-pm@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
 <1ceacf4f9c3f827bcad85b378aa04cdca1c04635.1780048925.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <1ceacf4f9c3f827bcad85b378aa04cdca1c04635.1780048925.git.u.kleine-koenig@baylibre.com>

On Fri May 29, 2026 at 6:18 AM EDT, Uwe Kleine-K=C3=B6nig (The Capable Hub)=
 wrote:
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
>
> While touching these arrays unify spacing and usage of commas.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
>  drivers/power/reset/spacemit-p1-reboot.c | 4 ++--
>  drivers/power/reset/tps65086-restart.c   | 2 +-
>  drivers/power/supply/bd71828-power.c     | 8 ++++----
>  drivers/power/supply/macsmc-power.c      | 2 +-
>  drivers/power/supply/max77759_charger.c  | 2 +-
>  drivers/power/supply/max8998_charger.c   | 2 +-
>  drivers/power/supply/pf1550-charger.c    | 2 +-
>  drivers/power/supply/rt5033_charger.c    | 2 +-
>  8 files changed, 12 insertions(+), 12 deletions(-)

[snip]

> diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/m=
acsmc-power.c
> index 33ca07460f3a..ced07f71e0a8 100644
> --- a/drivers/power/supply/macsmc-power.c
> +++ b/drivers/power/supply/macsmc-power.c
> @@ -834,7 +834,7 @@ static void macsmc_power_remove(struct platform_devic=
e *pdev)
>  }
> =20
>  static const struct platform_device_id macsmc_power_id[] =3D {
> -	{ "macsmc-power" },
> +	{ .name =3D "macsmc-power" },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, macsmc_power_id);

For macsmc-power,

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>

(I'm not sure if one can "Review-by" a specific section of a singular
patch, but also the other changes in the patch look fine to me, so
consider it reviewed as well.)
