From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/5] PM / devfreq: make devfreq-event explicitly non-modular
Date: Mon, 27 Jun 2016 11:28:17 +0900
Message-ID: <57708F41.6010201@samsung.com>
References: <20160625184351.5045-1-paul.gortmaker@windriver.com>
 <CGME20160625184528epcas1p33648f7cd37ab9170d2536c715b01f198@epcas1p3.samsung.com>
 <20160625184351.5045-3-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160625184351.5045-3-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Paul,

On 2016=EB=85=84 06=EC=9B=94 26=EC=9D=BC 03:43, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> menuconfig PM_DEVFREQ_EVENT
> 	bool "DEVFREQ-Event device Support"
>=20
> ...meaning that it currently is not being built as a module by anyone=
=2E
>=20
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>=20
> This code wasn't using module_init, so we don't need to be concerned
> with altering the initcall level here.
>=20
> We don't replace module.h with init.h since the file already has that=
=2E
> But we do add export.h since this file does export some symbols.
>=20
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>=20
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/devfreq/devfreq-event.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chanwoo Choi
