From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH] thermal: of: look for sensor driver parent node if
 device node missing
Date: Thu, 24 Jul 2014 15:15:00 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926301396F53@SHSMSX101.ccr.corp.intel.com>
References: <1405336354-31310-1-git-send-email-ldewangan@nvidia.com>
 <53D0D694.9040101@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37235 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759184AbaGXPPt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 11:15:49 -0400
In-Reply-To: <53D0D694.9040101@nvidia.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, "eduardo.valentin@gmail.com" <eduardo.valentin@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Laxman,

As Eduardo is the of thermal author and maintainer, I will take your patch only if you can get ACK from Eduardo.

Eduardo,
Do you have any comments on this?

Thanks,
rui

> -----Original Message-----
> From: Laxman Dewangan [mailto:ldewangan@nvidia.com]
> Sent: Thursday, July 24, 2014 5:49 PM
> To: Zhang, Rui; eduardo.valentin@ti.com
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] thermal: of: look for sensor driver parent node if
> device node missing
> Importance: High
> 
> On Monday 14 July 2014 04:42 PM, Laxman Dewangan wrote:
> > There are some mfd devices which supports junction thermal interrupt
> > like ams,AS3722. The DT binding of these devices are defined as the
> > flat and drivers for sub module of such devices are registered as the
> > mfd_add_devices. In this method, the sub devices registered as
> > platform driver and these do not have the of_node pointer on their
> > device structure. In this case, use the parent of_node pointer to get
> > the required of_node pointer.
> >
> Any comment please?
