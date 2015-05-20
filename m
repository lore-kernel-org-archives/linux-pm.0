From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap / RAPL: Support Knights Landing
Date: Tue, 19 May 2015 17:10:05 -0700
Message-ID: <20150519171005.1f32c052@jacob-VirtualBox>
References: <1432075069-18196-1-git-send-email-dasaratharaman.chandramouli@intel.com>
	<4265007.tICN7CeGKt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4265007.tICN7CeGKt@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nikhil Rao <nikhil.rao@intel.com>
Cc: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 20 May 2015 01:31:54 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Tuesday, May 19, 2015 03:37:49 PM Dasaratharaman Chandramouli
> wrote:
> > This patch enables intel_rapl driver to run on the
> > next-generation Intel(R) Xeon Phi Microarchitecture
> > code named "Knights Landing"
> > 
> > Signed-off-by: Dasaratharaman Chandramouli
> > <dasaratharaman.chandramouli@intel.com>
> 
> Jacob?
looks good.
 Acked-by:Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> > ---
> >  drivers/powercap/intel_rapl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c index fd24323..5796332 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -1069,6 +1069,7 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = { RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
> >  	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> >  	RAPL_CPU(0x5A, rapl_defaults_atom),/* Annidale */
> > +	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights
> > Landing */ {}
> >  };
> >  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> > 
> 

[Jacob Pan]
