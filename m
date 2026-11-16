Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787742;
	b=S6KCZnpu7JdfNF7dMjrbrkFCPDD2uwLuOnr+Z3YTfbDqsCGyODGeKVtYFvNqsctZ90yP
	 lOwiil+L0YgdKftfdOVqYOs6n9+oF7ZFh8bx1NprJ+DiVm4FNKI+lL8wNtJhyvWzgAct7
	 5KkrQDhQgj9Qo3Y724Erj0Xk2Q2LyeD5p1bdrDj/Op7Hyxk2A01RwTGNjJJwJw4swrhF3
	 xbNyl2gaNlPzH/g+KPKdL9tc64aTwM1HPF9pjOmk3/ZIkHIUVrHoMuZ5oaNCpYun9bfQT
	 3ucIHuxPZqCxwj0GTyx8Hm+sG0edXCrVbRTFq4vrH8H3c4yRqZaAaFXnKXUY+iYlMFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787742;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=rNJ/PtYBiesoTZdlaZPWFi2IyDfiWWvfogoY9WJcEN8=;
	b=KlLxqFe2ENhOz8Wm3w10RaRjHaGy8EWiBx+WDlnw7D03XYGPTUVXA6iJ9HHlaB4OinC8
	 rOP21WwzLFfd25bcISwZKho9yXHSRwo7WqpKel+azFocIUrHC8df0zhmWNEwdXPZsZJKU
	 s15Q0qCEhfB1QUpmteO35P2H+W0DSqjtAwsn+tQSxXdVyJm7MbHcSERJfS+AkVMR363vw
	 rI9K46aj7aV45GfEDsN/UUoedPPRkiqCboAsbdoO66BK+YdN88RCenWxUGN783A+PsSYh
	 F0CZi9SQ9PmVY31hVYFIxTeuSDQN/Q5qVdk+DP6RP/jM7IwFPmWmWfsZTpcaoaMVVbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846FB606A333;
	Mon, 16 Nov 2026 00:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2B61F000C5;
	Mon, 16 Nov 2026 00:09:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3F601181BFB; Mon, 16 Nov 2026 01:09:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hex Lindqvist <hex@freenixos.com>
Cc: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matt Ranostay <matt@ranostay.sg>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261108030945.92766-1-hex@freenixos.com>
References: <20261108030945.92766-1-hex@freenixos.com>
Subject: Re: [PATCH] power: supply: bq27xxx: Don't report missing battery
 properties as invalid
Message-Id: <179478774024.232281.14973437163759110508.b4-ty@b4>
Date: Mon, 16 Nov 2026 01:09:00 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sat, 07 Nov 2026 19:09:45 -0800, Hex Lindqvist wrote:
> When the device tree leaves out energy-full-design-microwatt-hours or
> charge-full-design-microamp-hours, power_supply_get_battery_info() sets
> the field to -EINVAL. bq27xxx_battery_settings() then compares it with
> an unsigned limit, so -EINVAL becomes a large positive number and the
> missing property is also reported as invalid:
> 
>   bq27xxx-battery 10-0055: missing battery:energy-full-design-microwatt-hours
>   bq27xxx-battery 10-0055: invalid battery:energy-full-design-microwatt-hours -22
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: Don't report missing battery properties as invalid
      commit: 376589960dd90ed09679a2c835c288a0f5456940

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

