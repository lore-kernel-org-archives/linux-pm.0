From: "Chandramouli, Dasaratharaman"
	<dasaratharaman.chandramouli@intel.com>
Subject: RE: [PATCH] intel powerclamp: support Knights Landing
Date: Mon, 22 Jun 2015 16:51:13 +0000
Message-ID: <56FD0D4EC3679746A2BD9228E7E608363E2A974D@ORSMSX114.amr.corp.intel.com>
References: <1429309866-63063-1-git-send-email-dasaratharaman.chandramouli@intel.com>
	<1429896814.16073.4.camel@localhost> <20150424145835.53888d75@ultegra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150424145835.53888d75@ultegra>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Rao, Nikhil" <nikhil.rao@intel.com>
List-Id: linux-pm@vger.kernel.org

Can we make this patch available for 4.2

> -----Original Message-----
> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Friday, April 24, 2015 2:59 PM
> To: Chandramouli, Dasaratharaman
> Cc: Zhang, Rui; Eduardo Valentin; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Pan, Jacob jun; Rao, Nikhil
> Subject: Re: [PATCH] intel powerclamp: support Knights Landing
> 
> On Fri, 24 Apr 2015 10:33:34 -0700
> Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
> wrote:
> 
> > Adding Jacob Pan
> >
> > On Fri, 2015-04-17 at 15:31 -0700, Dasaratharaman Chandramouli wrote:
> > > This patch enables intel_powerclamp driver to run on the
> > > next-generation Intel(R) Xeon Phi Microarchitecture code named
> > > "Knights Landing"
> > >
> looks good.
> 
> Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> > > Signed-off-by: Dasaratharaman Chandramouli
> > > <dasaratharaman.chandramouli@intel.com> ---
> > > drivers/thermal/intel_powerclamp.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/thermal/intel_powerclamp.c
> > > b/drivers/thermal/intel_powerclamp.c index 12623bc..e34ccd5 100644
> > > --- a/drivers/thermal/intel_powerclamp.c
> > > +++ b/drivers/thermal/intel_powerclamp.c
> > > @@ -690,6 +690,7 @@ static const struct x86_cpu_id
> > > intel_powerclamp_ids[] = { { X86_VENDOR_INTEL, 6, 0x4c},
> > >  	{ X86_VENDOR_INTEL, 6, 0x4d},
> > >  	{ X86_VENDOR_INTEL, 6, 0x56},
> > > +	{ X86_VENDOR_INTEL, 6, 0x57},
> > >  	{}
> > >  };
> > >  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
> >
> >
> 
> 
> 
> 
> --
> Jacob Pan
