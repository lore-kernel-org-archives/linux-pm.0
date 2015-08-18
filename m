From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 18 Aug 2015 14:51:10 +0100
Message-ID: <20150818135110.GF6180@x1>
References: <cover.1439866451.git.baolin.wang@linaro.org>
 <4e3447ef209fbbdc3ee1c82428be2bc19c30bd30.1439866451.git.baolin.wang@linaro.org>
 <20150818132447.GD9493@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150818132447.GD9493@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, balbi@ti.com, broonie@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Aug 2015, Charles Keepax wrote:

> On Tue, Aug 18, 2015 at 07:14:21PM +0800, Baolin Wang wrote:
> > Integrate with the newly added USB charger interface to limit the c=
urrent
> > we draw from the USB input based on the input device configuration
> > identified by the USB stack, allowing us to charge more quickly fro=
m high
> > current inputs without drawing more current than specified from oth=
ers.
> >=20
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
>=20
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>=20
> Sorry if you guys got a bunch of bounces, we had a bit of an
> email fiasco at this end. Hopefully all fixed now.

Yes, I sent you guys a mail about that.

Glad it's all sorted now.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
