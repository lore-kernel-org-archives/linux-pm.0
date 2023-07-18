Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FCFEB64DC
	for <linux-pm@archiver.kernel.org>; Tue, 18 Jul 2023 12:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGRMBe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 18 Jul 2023 08:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGRMBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2023 08:01:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989B618E;
        Tue, 18 Jul 2023 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689681689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFkovm95/NomURdsGPIAPD0hFqphahW/5HgAnQNo7ZA=;
        b=tq0JK9YFWofWplFZTCbhVKU/E4dCyURCFTQ+mh315DhR29FezVDG+WSSgKtpw2nIhggtQE
        c9lZeQCC+ShIJCgXLdnYzKas1cnC52mqtxqMY6I6t9RUUHTxyj4eM1JB2rg5hGXoNoPm8w
        PLzaccWdEndc+qisR8UbQytF3Typ3fo=
Message-ID: <f002fe945307d0904bcee8bd1f21d9e589d32ffb.camel@crapouillou.net>
Subject: Re: [PATCH v2 10/10] pinctrl: tegra: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sean Wang <sean.wang@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Tue, 18 Jul 2023 14:01:27 +0200
In-Reply-To: <ZLZ5obLK89E1S_2R@orome>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
         <20230718111143.000067dc@Huawei.com> <ZLZ5obLK89E1S_2R@orome>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thierry,

Le mardi 18 juillet 2023 =C3=A0 13:38 +0200, Thierry Reding a =C3=A9crit=C2=
=A0:
> On Tue, Jul 18, 2023 at 11:11:43AM +0100, Jonathan Cameron wrote:
> > On Mon, 17 Jul 2023 20:28:21 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >=20
> > > Since pm.h provides a helper for system no-IRQ PM callbacks,
> > > switch the driver to use it instead of open coded variant.
> > >=20
> > > Signed-off-by: Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>
> >=20
> > No pm_sleep_ptr()?
>=20
> pm_sleep_ptr() is pointless on this driver. This driver is selected
> by
> ARCH_TEGRA and ARCH_TEGRA also always selects PM.

If I'm not mistaken, ARCH_TEGRA selects CONFIG_PM, not CONFIG_PM_SLEEP.

Cheers,
-Paul
