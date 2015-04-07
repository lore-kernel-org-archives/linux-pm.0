From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/3] Thermal: Intel SoC: DTS thermal IOSF core
Date: Tue, 07 Apr 2015 12:45:57 -0700
Message-ID: <1428435957.28880.59.camel@spandruv-DESK3.jf.intel.com>
References: <1425330780-18957-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <744357E9AAD1214791ACBA4B0B909263014CE76D@SHSMSX101.ccr.corp.intel.com>
	 <AF233D1473C1364ABD51D28909A1B1B733B39667@PGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48197 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbbDGTrW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Apr 2015 15:47:22 -0400
In-Reply-To: <AF233D1473C1364ABD51D28909A1B1B733B39667@PGSMSX104.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ong, Boon Leong" <boon.leong.ong@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, 2015-04-07 at 06:01 +0000, Ong, Boon Leong wrote: 
> >-----Original Message-----
> >From: Zhang, Rui
> >Sent: Tuesday, April 7, 2015 1:25 PM
> >To: Srinivas Pandruvada; edubezval@gmail.com
> >Cc: linux-pm@vger.kernel.org; Ong, Boon Leong
> >Subject: RE: [PATCH 1/3] Thermal: Intel SoC: DTS thermal IOSF core
> >
> >The quark thermal driver (https://patchwork.kernel.org/patch/5965211/) also
> >uses iosf, but it seems that it can not reuse the code in this patch set.
> >
> >Srinivas and Boon Leong,
> >Can you please check if it is possible to refine the code?
> Ahh... this was discussed internal before with Srinivas.
> The initial version was using the same driver for Baytrail but it has to refactored to
> support both BYT & Quark.   
> 
> From my assessment, thermal DTS hardware difference for BYT vs Quark as follow:
> 1) Quark is using degree C. 
>      BYT is using milli-degree BYT.
> 2) Quark does not support DTS Aux, PTTSS & PTMC. 
>      BYT HW supports them. 
> 3) Quark does not have MSR register for Tj Max
>     BYT provides MSR register for Tj Max value.
> 4) Quark does not have APIC interrupt for thermal zone update,
>      it depends on polling mode.
>     BYT has APIC interrupt for updating thermal zone
> 
> Srinivas suggested late last year to spin new driver for Quark thermal driver.
> I think that looking at the vast hardware difference, I agree that it will be better for Quark
> to have a separate thermal driver.
> 
We have looked into this as Boon suggested. Other than using IOSF for
communication there is not much commonality (They don't even have same
registers). So I suggested to have a special quark dts driver.

Thanks,
Srinivas 

> Happy to discuss further which is the right direction. Thanks


