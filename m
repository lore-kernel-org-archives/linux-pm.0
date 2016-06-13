From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] powercap/rapl: add support for skx
Date: Mon, 13 Jun 2016 23:56:18 +0200
Message-ID: <1853463.fUpAPaBi47@vostro.rjw.lan>
References: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com> <1464021943-14915-2-git-send-email-jacob.jun.pan@linux.intel.com> <2701882.MhyhBLMFz2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2701882.MhyhBLMFz2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Prarit Bhargava <prarit@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Monday, June 13, 2016 11:32:10 PM Rafael J. Wysocki wrote:
> On Monday, May 23, 2016 09:45:42 AM Jacob Pan wrote:
> > SKX RAPL interface is similar to HSX/BDX.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/powercap/intel_rapl.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> > index 470bb62..a417e68 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -1096,6 +1096,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
> >  	RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake */
> >  	RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview */
> >  	RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
> > +	RAPL_CPU(0x55, rapl_defaults_hsw_server),/* Skylake server */
> >  	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> >  	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
> >  	RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
> > 
> 
> Can you please rebase this on top of 4.7-rc3?

Or rather on top of the x86/cpu branch from tip?

BTW, I can take the Denverton support for RAPL too (unless already applied
elsewhere), but it has to be based on x86/cpu as well.

Thanks,
Rafael
