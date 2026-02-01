Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C133BBCC;
	Sun,  1 Feb 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769956169; cv=none; b=rEO2sUbnorEcCXip5hnHu45EWimAweTxizamyu2KC97SfNdIWbZMQvy0uTa7JeOpCMl4G3b9YojGq5DgnZTTdNTnpDA0c4kh56ppATiUKkwnk867/VOVn8Orqhr12btbqzm5jouDx3OPenJeFKDHQD4i3/3rAG4AAciTVrtzObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769956169; c=relaxed/simple;
	bh=zvkGLtA6an0FHycpIE71ogcBHJS6HCdtQrfn5c+bjuc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HPMg/x5hJgHWkY2e/7HEhUY440EDbDwUkBYK5g2ztTbUkxslIp0BJeEaM0PCxJFhqWahH0Jzi4PAK+r9Fi/mz157gqVsVD/+1uXxHhgnDvTpVGRY3cycYJvdihmQ8sGPEEM7lFwH7rrV0CIspN4dqAQJAzr6DcYkD/YhXssfn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gX+jFi6+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gX+jFi6+"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B8ACC2621E;
	Sun,  1 Feb 2026 15:29:24 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9NVCeQIX6d0; Sun,  1 Feb 2026 15:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769956164; bh=zvkGLtA6an0FHycpIE71ogcBHJS6HCdtQrfn5c+bjuc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=gX+jFi6+G0qnVX8evZU+mYG2CwWR/DiSagcJSW3K37JtkDudLRfF4LnAgmFQiWrTK
	 pCuoI7DDecd53iG3S2xd4eSayzwoJZjHcy+HmX12wao9XK/UMXRRjdJ618EebicYTb
	 K6npAIs0m8yw0zcxHmdv/qmdoVSrw96A57mihmB+l6GucZUvREwda2tBUcUXHY1RjC
	 PzxjBCZj5E/ig1Qd6HLbkTK14aMpRAkp53Uw0rW87XS0Js0QiwAyZv6RHXlM4gwhiY
	 EA7LbUqfjDWCIqTyUIjJT1HA3+AuYVwMj3CBW1b7JW4CEkH2+cc8YDn3H+q+sO+yWf
	 5hNck7SEetR7w==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Feb 2026 19:59:17 +0530
Message-Id: <DG3P3DHVSC0J.2LVZT4D9SA2QH@disroot.org>
Cc: "Yassine Oudjana" <y.oudjana@protonmail.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] power: supply: add support for S2MU005 battery fuel
 gauge device
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Kaustabh
 Chakraborty" <kauschluss@disroot.org>
References: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
 <20260126-s2mu005-fuelgauge-v1-2-68a146ed0819@disroot.org>
 <aXq7NohfIy3c5AWL@venus> <DG2QBROWWMLI.2EE3CBLLPAJHR@disroot.org>
 <aX8yPp2JVubxHNFJ@venus>
In-Reply-To: <aX8yPp2JVubxHNFJ@venus>

On 2026-02-01 12:14 +01:00, Sebastian Reichel wrote:
> Hi,
>
> On Sat, Jan 31, 2026 at 04:44:36PM +0530, Kaustabh Chakraborty wrote:
>> On 2026-01-29 02:59 +01:00, Sebastian Reichel wrote:
>> >> +static int s2mu005_fg_get_status(struct s2mu005_fg *priv, int *value=
)
>> >> +{
>> >> +	int current_now;
>> >> +	int capacity;
>> >> +	int ret;
>> >> +
>> >> +	ret =3D s2mu005_fg_get_current_now(priv, &current_now);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	if (current_now <=3D 0) {
>> >> +		*value =3D POWER_SUPPLY_STATUS_DISCHARGING;
>> >> +		return 0;
>> >> +	}
>> >> +
>> >> +	ret =3D s2mu005_fg_get_capacity(priv, &capacity);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	if (capacity < 90)
>> >> +		*value =3D POWER_SUPPLY_STATUS_CHARGING;
>> >> +	else
>> >> +		*value =3D POWER_SUPPLY_STATUS_FULL;
>> >
>> > Usually there is some kind of hysteresis that stops charging
>> > when the battery is full and then restarts charging once the
>> > battery drops under a certain capacity. As this code first
>> > checks the current to determine if the battery is discharging
>> > and only then checks if the battery is full - does your code
>> > toggle between FULL and DISCHARGING?
>>=20
>> (Perhaps I misunderstood your query, let me know if I did)
>>=20
>> It has been a while since I last tested this - but as far as I can
>> recall, after a certain threshold, the current would constantly bounce
>> between -ve and +ve. I believe it was somewhere around 90% to 95% and
>> above. If that's what 'hysteresis' is, then yes.
>
> A typical charging setup is:
>
> 1. charge to 100%
> 2. stop charging
> 3. wait for charge to drop under 95% (or some other treshold)
> 4. restart charging
> 5. go to 1

Yes, I believe that's what's happening internally. I just tested it and
the threshold seems to be much higher, at ~97%. I will update it in the
next revision then.

>> An older revision of this driver (I don't have it anymore) used to add
>> up the consecutive values of current in order to reduce the effect of
>> this inconsistency, but it was still unreliable.
>>=20
>> Moreover, I do not possess any documentation for this device, so it's
>> not possible for me to know what or how.
>
> For the setup I described above, you consider everything above the
> treshold as POWER_SUPPLY_STATUS_FULL independent of the current
> direction. So you need to reorder:
>
> if (capacity >=3D 90)
>     return POWER_SUPPLY_STATUS_FULL;
>
> if (current_now < 0)
>     return POWER_SUPPLY_STATUS_DISCHARGING;
> else if (current_now =3D=3D 0)
>     return POWER_SUPPLY_STATUS_NOT_CHARGING;
> else
>     return POWER_SUPPLY_STATUS_CHARGING;

Understood. I will re-implement it in this order then.

>
> Greetings,
>
> -- Sebastian

