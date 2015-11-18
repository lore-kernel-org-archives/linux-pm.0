From: Catalin Crenguta <catalin.crenguta@gmail.com>
Subject: Re: Freescale IMX6 active cooling
Date: Wed, 18 Nov 2015 12:00:05 +0200
Message-ID: <CABH3fy-UY7YdbaaZxymfcaxnhsNkozeRD9uUU5DOQH2S50sEXQ@mail.gmail.com>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
	<CAOMZO5AX9owvovpdmdr=rKNApbuNrkp9pKexJk_mMyMdH1=1qg@mail.gmail.com>
	<CALHpu37MNnzW=3YNKUq-aOHgF12EhjyN7g1juTwuMad_Xv891w@mail.gmail.com>
	<CABH3fy-QPV1bv-WaO3mWVq2RN5=f-AnBHMgFTmmU-Ve3xgyUrw@mail.gmail.com>
	<564C0453.6020400@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32815 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbbKRKAI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 05:00:08 -0500
Received: by wmuu63 with SMTP id u63so11496671wmu.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 02:00:06 -0800 (PST)
In-Reply-To: <564C0453.6020400@kosagi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sean Cross <xobs@kosagi.com>
Cc: Jon Nettleton <jon.nettleton@gmail.com>, Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Wed, Nov 18, 2015 at 6:53 AM, Sean Cross <xobs@kosagi.com> wrote:
> Perhaps the correct order of patches is:
>
> 1) Add generic thermal zone support
> 2) Remove zone and cdev from imx_thermal
> 3) Add cpufreq-cooling to imx6
> 4) Add cpufreq-cooling to all other SoCs that support imx_thermal
> 5) Add default generic thermal zone support to imx6qdl.dtsi
In my opinion, I guess a patch series containing this would be good.

Thanks again!
