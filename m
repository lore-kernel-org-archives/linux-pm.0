From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] intel powerclamp: support Knights Landing
Date: Fri, 24 Apr 2015 14:58:35 -0700
Message-ID: <20150424145835.53888d75@ultegra>
References: <1429309866-63063-1-git-send-email-dasaratharaman.chandramouli@intel.com>
	<1429896814.16073.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22258 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965837AbbDXV6h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Apr 2015 17:58:37 -0400
In-Reply-To: <1429896814.16073.4.camel@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan Jun <jacob.jun.pan@intel.com>, Nikhil Rao <nikhil.rao@intel.com>

On Fri, 24 Apr 2015 10:33:34 -0700
Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
wrote:

> Adding Jacob Pan
> 
> On Fri, 2015-04-17 at 15:31 -0700, Dasaratharaman Chandramouli wrote:
> > This patch enables intel_powerclamp driver to run on the
> > next-generation Intel(R) Xeon Phi Microarchitecture
> > code named "Knights Landing"
> > 
looks good.

Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> > Signed-off-by: Dasaratharaman Chandramouli
> > <dasaratharaman.chandramouli@intel.com> ---
> >  drivers/thermal/intel_powerclamp.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/thermal/intel_powerclamp.c
> > b/drivers/thermal/intel_powerclamp.c index 12623bc..e34ccd5 100644
> > --- a/drivers/thermal/intel_powerclamp.c
> > +++ b/drivers/thermal/intel_powerclamp.c
> > @@ -690,6 +690,7 @@ static const struct x86_cpu_id
> > intel_powerclamp_ids[] = { { X86_VENDOR_INTEL, 6, 0x4c},
> >  	{ X86_VENDOR_INTEL, 6, 0x4d},
> >  	{ X86_VENDOR_INTEL, 6, 0x56},
> > +	{ X86_VENDOR_INTEL, 6, 0x57},
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
> 
> 




-- 
Jacob Pan
