From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: of: look for sensor driver parent node if
 device node missing
Date: Fri, 25 Jul 2014 09:35:19 +0100
Message-ID: <20140725083519.GA2865@e104805>
References: <1405336354-31310-1-git-send-email-ldewangan@nvidia.com>
 <53D0D694.9040101@nvidia.com>
 <744357E9AAD1214791ACBA4B0B90926301396F53@SHSMSX101.ccr.corp.intel.com>
 <53D213A8.6000506@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44351 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759739AbaGYIfY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 04:35:24 -0400
In-Reply-To: <53D213A8.6000506@nvidia.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 25, 2014 at 09:22:00AM +0100, Laxman Dewangan wrote:
> Thanks Rui.
> It seems I have put the wrong email-id for Eduardo (which I got from 
> get_maintainer) and the original patch not reached to Eduardo.
> 
> Do I need to re-post patch?
> 
> Thanks,
> Laxman
> 
> On Thursday 24 July 2014 08:45 PM, Zhang, Rui wrote:
> > Hi, Laxman,
> >
> > As Eduardo is the of thermal author and maintainer, I will take your patch only if you can get ACK from Eduardo.
> >
> > Eduardo,
> > Do you have any comments on this?

[Fixed Eduardo's email.]

> >> -----Original Message-----
> >> From: Laxman Dewangan [mailto:ldewangan@nvidia.com]
> >> Sent: Thursday, July 24, 2014 5:49 PM
> >> To: Zhang, Rui; eduardo.valentin@ti.com
> >> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH] thermal: of: look for sensor driver parent node if
> >> device node missing
> >> Importance: High
> >>
> >> On Monday 14 July 2014 04:42 PM, Laxman Dewangan wrote:
> >>> There are some mfd devices which supports junction thermal interrupt
> >>> like ams,AS3722. The DT binding of these devices are defined as the
> >>> flat and drivers for sub module of such devices are registered as the
> >>> mfd_add_devices. In this method, the sub devices registered as
> >>> platform driver and these do not have the of_node pointer on their
> >>> device structure. In this case, use the parent of_node pointer to get
> >>> the required of_node pointer.
> >>>
> >> Any comment please?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

