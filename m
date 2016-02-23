From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] power: bq27xxx_battery: Restore device name
Date: Tue, 23 Feb 2016 10:32:39 +0100
Message-ID: <20160223093239.GJ4606@pali>
References: <56B0A318.9060306@gmail.com>
 <1454417257-10992-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201602061135.49665@pali>
 <201602211234.54709@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201602211234.54709@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday 21 February 2016 12:34:54 Pali Roh=C3=A1r wrote:
> On Saturday 06 February 2016 11:35:49 Pali Roh=C3=A1r wrote:
> > On Tuesday 02 February 2016 13:47:37 Ivaylo Dimitrov wrote:
> > > Patch <703df6c097956d17a818e63961c82e8e9eef9fef> ("power:
> > > bq27xxx_battery: Reorganize I2C into a module") has removed the
> > > device name numbering from bq27xxx_battery_i2c_probe. Fix that by
> > > restoring the code.
> > >=20
> > > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> >=20
> > Fixes: 703df6c097956d17a818e63961c82e8e9eef9fef
> > Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> >=20
> > Please apply this patch and backport to stable kernels with already
> > has patch 703df6c097956d17a818e63961c82e8e9eef9fef.
>=20
> I still do not see this patch in any tree... Please apply.

PING

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
