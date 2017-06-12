From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
Date: Mon, 12 Jun 2017 11:30:41 -0300
Message-ID: <CAOMZO5B63ZefwN5Obab-a6rsngFy5m38US-pVvZtjHJSwUOvtw@mail.gmail.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
 <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
 <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
 <1497005895.28352.88.camel@nxp.com> <20170609154638.3b64e6d0@karo-electronics.de>
 <1497022484.28352.105.camel@nxp.com> <20170612124029.1643469d@karo-electronics.de>
 <1497268028.32422.15.camel@nxp.com> <CAOMZO5Dm8+1Ddh1QqkgNLbSrZPQgFL=EO6NcjusXA0Vi9mvXeg@mail.gmail.com>
 <20170612153752.3b71516c@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36383 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdFLOam (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 10:30:42 -0400
In-Reply-To: <20170612153752.3b71516c@karo-electronics.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Bai Ping <ping.bai@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 12, 2017 at 10:37 AM, Lothar Wa=C3=9Fmann <LW@karo-electronics.=
de> wrote:
> Hi,
>
> On Mon, 12 Jun 2017 10:22:45 -0300 Fabio Estevam wrote:
>> On Mon, Jun 12, 2017 at 8:47 AM, Leonard Crestez
>> <leonard.crestez@nxp.com> wrote:
>>
>> > However it seems that this might be accidental, it just happens that
>> > the OCOTP clock starts as enabled and is only disabled later in the
>>
>> Most likely because U-Boot enabled the OCOTP clock as it reads the
>> speed grading fuse.
>>
> No, the imx6q_opp_check_speed_grading() runs on an i.MX6Q which, as
> mentioned in my other mail <20170612124029.1643469d@karo-electronics.de>,
> does not require any clock to be enabled for accessing the OCOTP regs.

[Sorry I removed the list in my previous response by mistake]

What I was trying to say is that the OCOTP clock is enabled by U-Boot
on mx6ul evk board.

Please check:
http://git.denx.de/?p=3Du-boot.git;a=3Dblob;f=3Dboard/freescale/mx6ul_14x14=
_evk/mx6ul_14x14_evk.c;h=3Da5746fe08688d5752bf1d69cff465a355404d6da;hb=3DHE=
AD#l833

This would explain why Leonard did not see the kernel hang on his test.

So I agree with you that the thermal driver needs the IMX6UL_CLK_OCOTP too.
