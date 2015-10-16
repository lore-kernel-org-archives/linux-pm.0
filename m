From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 3/3] power: bq27xxx_battery: fix defined but not used
 warnings
Date: Fri, 16 Oct 2015 16:47:05 +0200
Message-ID: <20151016144705.GG28216@pali>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
 <1445003052-31373-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445003052-31373-4-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 16 October 2015 15:44:12 Sebastian Reichel wrote:
> If BQ27XXX is enabled, but neither I2C based initialization, nor
> platform based initialization are activated, bq27xxx_powersupply_init
> and bq27xxx_powersupply_unregister are defined but not used.
>=20
> This configuration doesn't make sense, but there is no easy way
> to make it unavailable in the build system, so just mark the
> functions as __maybe_unused instead.
>=20

What about?

#if defined(CONFIG_1) || defined(CONFIG_2)
#define NEED_POWER_SUPPLY
#endif

And then wrap power supply code into #ifdef NEED_POWER_SUPPLY?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
