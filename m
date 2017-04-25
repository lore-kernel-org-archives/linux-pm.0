From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Tue, 25 Apr 2017 14:26:10 -0300
Message-ID: <CAOMZO5DRhyRrwRoAVjd3uW6MgSUQ_k4gu8ZNQvMEh+0EcskVUg@mail.gmail.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
 <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
 <CAOMZO5CKUsEr1yf5RrsPLipNtLC_6sK0dPjT2M-eN-uo8hEbrQ@mail.gmail.com> <1493141004.3557.8.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36678 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1951992AbdDYR0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 13:26:11 -0400
In-Reply-To: <1493141004.3557.8.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christoph Fritz <chf.fritz@googlemail.com>

On Tue, Apr 25, 2017 at 2:23 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> Wow, that was literally 15 minutes before my patch. In my defense I did
> search the archives before starting to format the patch but it had not
> arrived yet.
>
> Anyway, that version also sets the supply for reg_arm and reg_soc. It
> is not necessary for fixing the crash I'm seeing but is good because it
> will result in the minimum voltage on VDD_ARM_SOC_IN rather than a fix
> 1375mv. I tested Marek's patch and it works fine on my rev B board
> (which otherwise fails to boot upstream).

Excellent! I only have revA board and do not get the crash with this revision.

If you can reply to Marek's patch with your Tested-by that would be
nice, thanks.
