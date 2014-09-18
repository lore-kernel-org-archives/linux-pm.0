From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/4] thermal: rockchip: add driver for Thermal
Date: Thu, 18 Sep 2014 10:02:49 -0700
Message-ID: <20140918170249.GC14809@core.coreip.homeip.net>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
 <1410926353-15674-2-git-send-email-caesar.wang@rock-chips.com>
 <20140917170223.GB25297@core.coreip.homeip.net>
 <541A985C.6030301@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <541A985C.6030301@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, addy.ke@rock-chips.com, zyf@rock-chips.com, cjf@rock-chips.com, =?utf-8?B?6ZKf5YuH5rGq?= <zyw@rock-chips.com>, zhengsq@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

On Thu, Sep 18, 2014 at 04:31:24PM +0800, Caesar Wang wrote:
> Dear Dmitry,
>=20
>=20
> =E5=9C=A8 2014=E5=B9=B409=E6=9C=8818=E6=97=A5 01:02, Dmitry Torokhov =
=E5=86=99=E9=81=93:
> >Hi Caesar,
> >
> >On Wed, Sep 17, 2014 at 11:59:10AM +0800, Caesar Wang wrote:
> >>+{
> >>+	int i;
> >>+
> >>+	for (i =3D 0; i < ARRAY_SIZE(v2_code_table) - 1; i++) {
> >>+		if (code >=3D v2_code_table[i].code)
> >>+			return v2_code_table[i].temp;
> >>+	}
> >>+
> >>+	return 0;
> >I think if we do not find the code we should be returning max
> >temperature, not 0.
> Agree.
> >And also WARN_ON() as this should not be happening.
> >
> Maybe,I will fix it as the follows:
>=20
> pr_warn("Don't find code from v2_code_table\n");
> return 125;
>=20
> Do you agree?

Sounds good.

Thanks.

--=20
Dmitry
