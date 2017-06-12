From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Mon, 12 Jun 2017 10:22:45 -0300
Message-ID: <CAOMZO5Dm8+1Ddh1QqkgNLbSrZPQgFL=EO6NcjusXA0Vi9mvXeg@mail.gmail.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
 <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
 <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
 <1497005895.28352.88.camel@nxp.com> <20170609154638.3b64e6d0@karo-electronics.de>
 <1497022484.28352.105.camel@nxp.com> <20170612124029.1643469d@karo-electronics.de>
 <1497268028.32422.15.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35206 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdFLNWq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 09:22:46 -0400
In-Reply-To: <1497268028.32422.15.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>, Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 12, 2017 at 8:47 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> However it seems that this might be accidental, it just happens that
> the OCOTP clock starts as enabled and is only disabled later in the

Most likely because U-Boot enabled the OCOTP clock as it reads the
speed grading fuse.
