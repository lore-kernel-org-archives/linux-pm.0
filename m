From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] Enabled Broxton RAPL support
Date: Mon, 19 Oct 2015 23:52:23 +0200
Message-ID: <2430289.u4jfCLFiPJ@vostro.rjw.lan>
References: <1444835355-26582-3-git-send-email-amy.l.wiles@intel.com> <34419145.BT4t4sgNS0@vostro.rjw.lan> <20151014201158.36826c09@yairi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57737 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751985AbbJSVXe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2015 17:23:34 -0400
In-Reply-To: <20151014201158.36826c09@yairi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@intel.com>
Cc: amy.l.wiles@intel.com, rui.zhang@intel.com, srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org

On Wednesday, October 14, 2015 08:11:58 PM Jacob Pan wrote:
> On Thu, 15 Oct 2015 01:29:04 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Wednesday, October 14, 2015 08:09:15 AM amy.l.wiles@intel.com
> > wrote:
> > > From: Amy Wiles <amy.l.wiles@intel.com>
> > > 
> > > Signed-off-by: Amy Wiles <amy.l.wiles@intel.com>
> > > ---
> > >  drivers/powercap/intel_rapl.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/powercap/intel_rapl.c
> > > b/drivers/powercap/intel_rapl.c index 5efacd0..cc97f08 100644
> > > --- a/drivers/powercap/intel_rapl.c
> > > +++ b/drivers/powercap/intel_rapl.c
> > > @@ -1102,6 +1102,7 @@ static const struct x86_cpu_id rapl_ids[]
> > > __initconst = { RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
> > >  	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> > >  	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
> > > +	RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
> > >  	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
> > >  	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights
> > > Landing */ {}
> > > 
> > 
> > Jacob, any problems with this one?
> > 
> looks good to me. I also tested it.

OK, applied.

Thanks,
Rafael

