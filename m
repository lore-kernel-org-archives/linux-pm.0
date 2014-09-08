From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets' properties
Date: Mon, 08 Sep 2014 14:20:21 +0200
Message-ID: <4685530.jbNLD4yaA8@wuerfel>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org> <1410176286-32533-6-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1410176286-32533-6-git-send-email-linus.walleij@linaro.org>
Sender: linux-leds-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday 08 September 2014 13:38:04 Linus Walleij wrote:
> +       of_property_read_u32(np, "cache-size", &size);
> +       of_property_read_u32(np, "cache-sets", &sets);
> +
> +       if (!size || !sets)
> +               return;
> +
> +       way_size = size / sets;

Going back to this one: Isn't (size / sets) the set-size rather
than the way-size?

After we discussed this on IRC, I had expected a calculation like

	set_size = size / sets;
	ways = set_size / line_size;
	way_size = size / ways;

	Arnd
