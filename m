From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: Freescale IMX6 active cooling
Date: Wed, 18 Nov 2015 13:56:55 -0800
Message-ID: <20151118215654.GA23251@localhost.localdomain>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
 <CAOMZO5AX9owvovpdmdr=rKNApbuNrkp9pKexJk_mMyMdH1=1qg@mail.gmail.com>
 <CALHpu37MNnzW=3YNKUq-aOHgF12EhjyN7g1juTwuMad_Xv891w@mail.gmail.com>
 <CABH3fy-QPV1bv-WaO3mWVq2RN5=f-AnBHMgFTmmU-Ve3xgyUrw@mail.gmail.com>
 <564C0453.6020400@kosagi.com>
 <CABH3fy-UY7YdbaaZxymfcaxnhsNkozeRD9uUU5DOQH2S50sEXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35205 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046AbbKRV47 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 16:56:59 -0500
Received: by pacej9 with SMTP id ej9so57322321pac.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 13:56:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABH3fy-UY7YdbaaZxymfcaxnhsNkozeRD9uUU5DOQH2S50sEXQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Crenguta <catalin.crenguta@gmail.com>
Cc: Sean Cross <xobs@kosagi.com>, Jon Nettleton <jon.nettleton@gmail.com>, Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

Hello,

On Wed, Nov 18, 2015 at 12:00:05PM +0200, Catalin Crenguta wrote:
> On Wed, Nov 18, 2015 at 6:53 AM, Sean Cross <xobs@kosagi.com> wrote:
> > Perhaps the correct order of patches is:
> >
> > 1) Add generic thermal zone support
> > 2) Remove zone and cdev from imx_thermal
> > 3) Add cpufreq-cooling to imx6
> > 4) Add cpufreq-cooling to all other SoCs that support imx_thermal
> > 5) Add default generic thermal zone support to imx6qdl.dtsi
> In my opinion, I guess a patch series containing this would be good.

The recommendation is for you to use of-thermal, yes. In that way you
may benefit of describing your thermal hw specific data over DT. And you
can benefit of the existing cooling devices that have DT cooling
descriptors too, such as gpio-fan, and cpufreq-cooling, yes.

To use cpufreq-cooling, you may want to make sure your device works with
cpufreq-dt driver.

I would appreciate if you could clean up the IMX code to use the DT way
of describing thermal.

BR,

> 
> Thanks again!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
