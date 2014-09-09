From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets' properties
Date: Tue, 9 Sep 2014 09:14:13 +0200
Message-ID: <CACRpkdapk1t+8DnY_ojWm+76=D=7k-wnrm11J6dbpPDkCM_WhQ@mail.gmail.com>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
	<4685530.jbNLD4yaA8@wuerfel>
	<CACRpkdb_bS0P-fGxogiyCzG9CRPhJK1Gro=H3X1Ks_-UoXh52w@mail.gmail.com>
	<3479071.8nx1ubr8a9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <3479071.8nx1ubr8a9@wuerfel>
Sender: linux-leds-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <florian@openwrt.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 8, 2014 at 3:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> [Me]
>> I can add a comment explaining that ARMs terminology does
>> not match the academic terminology or something, and say that
>> the thing we poke into "way-size" is actually "set size", if we agree
>> that is what we're seeing here.
>
> Let's see again: 16KB way-size * 8 ways = 128KB, that seems correct.
> 16KB way-size / 32B line-size = 512 sets, that also seems realistic.
> 128KB cache-size / 512 sets = 256B set-size. 256B / 32B = 8 ways,
> so everything fits together.

I've sent a v2 version of the patch using the terminology and calculations
from this thread, and it yields the right numbers, for PB1176, I will check
with the values from other RealView platforms to see if they also give the
same result back.

I had to squash Florians & my patch, it didn't make sense to have them
artificially separate.

Yours,
Linus Walleij
