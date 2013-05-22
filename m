From: "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH 1/2] x86 thermal: Delete power-limit-notification
 console messages
Date: Wed, 22 May 2013 23:31:12 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712205633D379@ORSMSX106.amr.corp.intel.com>
References: <1368741246-3998-1-git-send-email-lenb@kernel.org>
 <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB59C9371C@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46829 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549Ab3EVXbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2013 19:31:13 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59C9371C@BGSMSX101.gar.corp.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>, Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Andi Kleen <ak@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> From: R, Durgadoss
> Hi Len/Fenghua,
> 
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Len Brown
> > Sent: Wednesday, May 22, 2013 1:05 AM
> > To: Zhang, Rui
> > Cc: linux-pm@vger.kernel.org; Yu, Fenghua
> > Subject: [PATCH 1/2] x86 thermal: Delete power-limit-notification
> console
> > messages
> >
> > From: Fenghua Yu <fenghua.yu@intel.com>
> >
> > diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> > b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> > index 47a1870..68fa890 100644
> > --- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> > +++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> > @@ -181,11 +181,6 @@ static int therm_throt_process(bool new_event,
> int
> > event, int level)
> >  				this_cpu,
> >  				level == CORE_LEVEL ? "Core" : "Package",
> >  				state->count);
> 
> Here, can we remove the other print also ?
> (The thermal throttling prints)

The thermal throttling is legacy code and users could use the printed info already. Adding Andi who wrote the thermal throttling code and may have more insight.

Thanks.

-Fenghua

