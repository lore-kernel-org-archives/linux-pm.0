From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Fri, 5 May 2017 13:11:05 +0300
Message-ID: <1493979065.3591.26.camel@nxp.com>
References: <1493823533.11226.28.camel@nxp.com>
         <e46a57c2-4a28-a8b6-445e-299dd9d8659c@denx.de>
         <1493834298.11226.40.camel@nxp.com>
         <51fb1bd0-028d-c431-acc8-3c4f1d25fdba@denx.de>
         <1493890943.11226.42.camel@nxp.com>
         <6dbf67a0-42ea-ee84-d144-41422a21c1c5@denx.de>
         <20170504124446.GO18578@dragon>
         <4ba6bdf2-56b2-972d-3326-0eda3985c80b@denx.de>
         <20170504134100.GR18578@dragon>
         <8c3827c4-1272-f004-52d9-7c79e93813c6@denx.de>
         <20170505011834.GS18578@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170505011834.GS18578@dragon>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-05-05 at 09:18 +0800, Shawn Guo wrote:
> On Thu, May 04, 2017 at 04:34:14PM +0200, Marek Vasut wrote:
> > If you model the
> > power distribution correctly, the OPP hackery can be removed.

> The OPP hackery can be removed even without reg_arm/reg_soc modeling.
> That's why we can do hackery dropping and reg_arm/reg_soc modeling in
> separate patches.
> 
> @Leonard, if someday we support 'LDO bypass' mode in upstream kernel,
> the OPP hackery needs to be back in some way even with reg_arm/reg_soc
> modeling in place, right?  Or will we have a better way to ensure SW1A
> rail can always feed a correct voltage directly to reg_arm®_soc?

Maybe? Or maybe the cpufreq driver could detect this situation and
handle it internally. In the vendor tree this the cpufreq driver has a
special fsl,arm-soc-shared property for this anyway.

I posted another RFC at upstreaming ldo-bypass recently but it did not
handle this particular case of a shared input rail. It can be handled
separately.

See: https://lkml.org/lkml/2017/3/22/640

But getting that series to an acceptable state might take a long time.

-- 
Regards,
Leonard
