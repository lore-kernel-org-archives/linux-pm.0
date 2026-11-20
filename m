Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189952;
	b=qhccdx5WPyPo9GfvCczUFX3rGhPOJoUj1kEbzdiBJcQITdoSIciN9DDVW6ZawvTU4S96
	 60SSFnSVvFtuAnWqegMHeWKw7Nfrl3yH9uN92H0Ixw6pfFKRJ7vX+myj8gIrC1rDygPKI
	 6R1J5bSTbH5/CPPG7MYZoFcwgEl17HJOr+T3bGepOjablw0aBkEvNVPO4panoZRIC6Pp4
	 iC7S6rKxX7ODAEZqOxuNMHsNieP5If/uP/28qoRFwX5R7/4THBPGV9TWGb98OHH5KVgEZ
	 x6quIG5YpqZvE/RY0w1C9MoBUb5i+qKreG+6SCu4I0Ie8sv+zRim5Iti0tQGMnX0e3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189952;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:References:In-Reply-To;
	bh=TSTpvO4spealzt2/kLbsRgFYe1Ou7JNCyzrkbKYJ+ko=;
	b=k/ZQDhUTbeYdl74hzNc4osXnRcVWW2CMqQvgUYg6+hGFw5jB3v/PKnjgt+fvG1Q4fFtg
	 U7L9PJvCm35SXumdDT6cKbBhSWE+TvwkZAJGzvEc7j31azhfM8HR8psOrIw4xhrb6cvE3
	 sOQeX0YG6yNnZFa8cbWBMK21o4EyIiNawpYGX5AvFIBob/t9wZIh/i/BR+Pq7ttil/lFR
	 ANAcXk/TafuYy1pFggEv9fUKl8PbhMz4RI5017wvnEF7NFv31NMTc4FNG+JFtOdYcI2Il
	 UTOHYneTVxPeWkEiETVvavJCvDTOlcvPM8W6Rp8VqLil7lSJBoNwNrBHTrxdU6SVMeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=disroot.org;
	spf=pass smtp.mailfrom=disroot.org;
	dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=bpxc4Jy+;
	arc=none smtp.remote-ip=178.21.23.139
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB839606A320;
	Fri, 20 Nov 2026 15:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB839606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=bpxc4Jy+
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4A46182EB0;
	Fri, 20 Nov 2026 16:52:29 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuwwcV_3q_fl; Fri, 20 Nov 2026 16:52:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1795189948; bh=TSTpvO4spealzt2/kLbsRgFYe1Ou7JNCyzrkbKYJ+ko=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To;
	b=bpxc4Jy+Yxc9ToeDYOlN3VQqx/zQ2klgGzdIc5NvXgUlmkbsDBFjxDSJeKujN7cEp
	 gp+6A1lp/afJxcNX5qtfVgkmyNVBPComHpRMdtfvccNmo1Bm0lsUseKJPEaBncXrKx
	 ECXip/iuYsqd+iSq9X+en7JDkUat4a/YZmpUdZrsF4zLS47K7JvzqRZNQGMQVaD9LP
	 RWN9iicNBMnwELFkUvXORedbkAN2V8B53AJWaY0d2H2hnheyKD07vyHI3tngwOHDu+
	 Mw35VADNjXwlOm5gqlc39SadUWCaBOm9oCPFMXyT9VDRnVHfbOzFvcWyhPw5Gh7QsQ
	 qLbJog/AIB4/w==
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 21:22:14 +0530
Message-Id: <DN05PYTW4NV6.SOA0NRNOJBAR@disroot.org>
To: =?utf-8?q?Adil_H=C3=BCsrev_Tepe?= <tadilhusrev@gmail.com>, "Sebastian
 Reichel" <sre@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: "Yassine Oudjana" <y.oudjana@protonmail.com>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] power: supply: s2mu005-battery: add S2MU106
 (Samsung Galaxy XCover5)
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
References: <20261116074000.355176-1-tadilhusrev@gmail.com>
 <6afc2f77.2bb6edcb.1518d5.5d4f@mx.google.com>
In-Reply-To: <6afc2f77.2bb6edcb.1518d5.5d4f@mx.google.com>

On 2026-11-17 02:41 -08:00, Adil H=C3=BCsrev Tepe wrote:
> I'd like to withdraw this series rather than send a v2.
>
> A review bot (Sashiko AI) flagged that patch 1's fallback compatible
> (samsung,s2mu106-fuel-gauge falling back to samsung,s2mu005-fuel-gauge)
> is unsound: a board using that fallback binds to the S2MU005 driver as-is=
,
> which still reads the MONOUT average-monitoring registers for
> VOLTAGE_AVG/CURRENT_AVG and uses current_avg to help decide
> POWER_SUPPLY_STATUS. The S2MU106 doesn't have that path, so those reads
> return garbage, and garbage current_avg can flip the reported charging
> status. Patch 3's has_monout flag avoids calling into that path from the
> S2MU106 variant I added, but the binding still allows a device to bind
> through the plain samsung,s2mu005-fuel-gauge compatible with no
> has_monout gate at all, which is the actual hole.
>
> On reflection, extending s2mu005-battery.c was the wrong shape for this
> chip regardless of that specific bug. The S2MU106 fuel gauge is a
> separate, standalone I2C device on the Galaxy XCover5 (own address,
> 0x3b), not a drop-in register-compatible S2MU005 variant sharing a
> device tree node -- it only happens to reuse the same STATUS/RVBAT/
> RCURCC/RSOC register layout and scaling. A dedicated driver avoids the
> fallback-compatible construction entirely, since there's nothing to
> fall back to.
>
> I'll send that as a new series instead: a samsung,s2mu106-fuelgauge
> binding and a standalone drivers/power/supply/s2mu106-fuelgauge.c,
> with no changes to s2mu005-battery.c or its binding. Sorry for the
> noise -- I should have settled on this shape before sending v1.

Actually, this one was just fine. I didn't look at the patches
meticulously but it seems like it does belong here. The correct approach
would be to adjust the driver correctly so that it accepts both.

The compatible patch is, in fact incorrect. The driver clearly uses two
separate compatibles for the two devices, so there should not be any
fallback.

> Adil

