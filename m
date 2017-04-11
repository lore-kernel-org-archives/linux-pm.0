From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3] power: supply: cpcap-charger: Add minimal CPCAP PMIC
 battery charger
Date: Tue, 11 Apr 2017 08:31:16 -0700
Message-ID: <20170411153115.GJ5339@atomide.com>
References: <20170327032513.22890-1-tony@atomide.com>
 <20170411152829.padtau2mqtn6gxdg@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:44094 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbdDKPbV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 11:31:21 -0400
Content-Disposition: inline
In-Reply-To: <20170411152829.padtau2mqtn6gxdg@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>

* Sebastian Reichel <sre@kernel.org> [170411 08:31]:
> > +Required properties:
> > +- compatible: Shall be "motorola,cpcap-charger" or
> > +	      "motorola,mapphone-cpcap-charger"
> 
> I queued this with "motorola,cpcap-charger" also dropped from the
> binding document.

Oh OK sorry for missing that.

Thanks,

Tony
