From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 1/7] thermal: rcar_gen3_thermal: add delay in
 .thermal_init on r8a7796
Date: Tue, 7 Mar 2017 11:28:08 +0100
Message-ID: <20170307102808.GI20587@bigcity.dyn.berto.se>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-2-niklas.soderlund+renesas@ragnatech.se>
 <98691387-0546-4884-b0ae-09814b7964d0@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34727 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754670AbdCGKfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2017 05:35:36 -0500
Received: by mail-lf0-f46.google.com with SMTP id k202so84880744lfe.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2017 02:35:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <98691387-0546-4884-b0ae-09814b7964d0@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

HI Sergei,

Thanks will update for v2.

On 2017-03-07 12:49:25 +0300, Sergei Shtylyov wrote:
> On 3/6/2017 11:03 PM, Niklas Söderlund wrote:
> 
> > The .thermal_init needs to be delayed a short amount of to allow for the
> 
>    Amount of what? :-)
> 
> > TEMP register to contain something useful. If it's not delayed theses
> 
>    These.
> 
> > warnings are common during boot:
> > 
> > thermal thermal_zone0: failed to read out thermal zone (-5)
> > thermal thermal_zone1: failed to read out thermal zone (-5)
> > thermal thermal_zone2: failed to read out thermal zone (-5)
> > 
> > The warnings are triggered by the first call to .get_temp while the TEMP
> > register contains 0 and rcar_gen3_thermal_get_temp() returns -EIO since
> > a TEMP value of 0 will result in a temperature reading which is out of
> > specifications.
> > 
> > This should have been done in the initial commit which adds the driver
> > as the same issue was found and corrected for r8a7795.
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> [...]
> 
> MBR, Sergei
> 

-- 
Regards,
Niklas Söderlund
