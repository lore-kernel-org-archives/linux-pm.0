From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] The x86 cpu RAPL id was added in to support BXT core
Date: Tue, 13 Oct 2015 21:53:36 -0700
Message-ID: <20151013215336.2a12b2c2@yairi>
References: <1444751963-23743-1-git-send-email-amy.l.wiles@intel.com>
	<1444777614.10629.6.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44939 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbbJNExi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 00:53:38 -0400
In-Reply-To: <1444777614.10629.6.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "Wiles, Amy L" <amy.l.wiles@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, 13 Oct 2015 23:07:21 +0000
"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com> wrote:

> On Tue, 2015-10-13 at 08:59 -0700, amy.l.wiles@intel.com wrote:
> > From: Amy Wiles <amy.l.wiles@intel.com>
> > 
> > BUG=None
> > TEST=Navigate to /sys/class/powercap and check that the directory 
> > intel-rapl:0 is present
> Remove above lines and just say "Enabled Broxton RAPL support".
> Copied to Jacob.
> 
agreed, other than that looks good to me.
> Thanks,
> Srinivas
> 
> 
> > Signed-off-by: Amy Wiles <amy.l.wiles@intel.com>
> > ---
> >  drivers/powercap/intel_rapl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c
> > index 5efacd0..cc97f08 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -1102,6 +1102,7 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst = {
> >  	RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
> >  	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> >  	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
> > +	RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
> >  	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
> >  	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing
> > */
> >  	{}
[Jacob Pan]
