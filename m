From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/2] powercap/rapl: add support for skx
Date: Mon, 13 Jun 2016 17:06:22 -0700
Message-ID: <20160613170622.02f0f80d@yairi>
References: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1464021943-14915-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<2701882.MhyhBLMFz2@vostro.rjw.lan>
	<1853463.fUpAPaBi47@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16351 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030193AbcFNAGY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jun 2016 20:06:24 -0400
In-Reply-To: <1853463.fUpAPaBi47@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Prarit Bhargava <prarit@redhat.com>, jacob.jun.pan@linux.intel.com

On Mon, 13 Jun 2016 23:56:18 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Monday, June 13, 2016 11:32:10 PM Rafael J. Wysocki wrote:
> > On Monday, May 23, 2016 09:45:42 AM Jacob Pan wrote:
> > > SKX RAPL interface is similar to HSX/BDX.
> > > 
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  drivers/powercap/intel_rapl.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/powercap/intel_rapl.c
> > > b/drivers/powercap/intel_rapl.c index 470bb62..a417e68 100644
> > > --- a/drivers/powercap/intel_rapl.c
> > > +++ b/drivers/powercap/intel_rapl.c
> > > @@ -1096,6 +1096,7 @@ static const struct x86_cpu_id rapl_ids[]
> > > __initconst = { RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake */
> > >  	RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview
> > > */ RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
> > > +	RAPL_CPU(0x55, rapl_defaults_hsw_server),/* Skylake
> > > server */ RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> > >  	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
> > >  	RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
> > > 
> > 
> > Can you please rebase this on top of 4.7-rc3?
> 
> Or rather on top of the x86/cpu branch from tip?
> 
done. just sent you v2.
[PATCH v2] powercap/rapl: add support for denverton
> BTW, I can take the Denverton support for RAPL too (unless already
> applied elsewhere), but it has to be based on x86/cpu as well.
> 
Not applied elsewhere, please take it. I was confused powercap/rapl with
perf/rapl which should be in tip.
