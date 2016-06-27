From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/5] PM / devfreq: make devfreq explicitly non-modular
Date: Mon, 27 Jun 2016 11:27:19 +0900
Message-ID: <57708F07.1010008@samsung.com>
References: <20160625184351.5045-1-paul.gortmaker@windriver.com>
 <CGME20160625184554epcas1p268dc9f280b6191d1043bec7c0ca8393d@epcas1p2.samsung.com>
 <20160625184351.5045-2-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33232 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcF0C13 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jun 2016 22:27:29 -0400
In-reply-to: <20160625184351.5045-2-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org

Hi Paul,

On 2016=EB=85=84 06=EC=9B=94 26=EC=9D=BC 03:43, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> menuconfig PM_DEVFREQ
>       bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) supp=
ort"
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
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>=20
> We don't replace module.h with init.h since the file already has that=
=2E
> But we do add export.h since this file does export some symbols.
>=20
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/devfreq/devfreq.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chanwoo Choi

