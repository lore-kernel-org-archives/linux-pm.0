From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Wed, 25 Feb 2015 15:17:41 -0300
Message-ID: <54EE11C5.8000307@free-electrons.com>
References: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com> <54EE009E.8070206@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EE009E.8070206@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Tyler Hall <tylerwhall@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 02/25/2015 02:04 PM, Gregory CLEMENT wrote:
>>
>> My conclusions about these registers are based on experimental data.=
 The
>> documentation is very sparse, but the Thermal Manager Control and St=
atus
>> Register looks like the preferred register given the way it is laid =
out in the
>> public spec.
>=20
> Ezequiel,
>=20
> as you worked on this do you know why we used the Thermal Sensor Stat=
us Register
> instead of the Thermal Manager Control and Status Register ?
> My first guess is that the giving the name of the registers the 1st o=
ne made
> more sens to use for a thermal sensor.
>=20

Actually, we based this driver in the vendor bootloader. The specs were=
n't
of much use back then.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
