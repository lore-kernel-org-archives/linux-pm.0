From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] powercap/rapl: add support for skx
Date: Wed, 15 Jun 2016 01:08:14 +0200
Message-ID: <1823182.O8gXhAsMXu@vostro.rjw.lan>
References: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com> <CAJZ5v0j=Tv-mzdU9cyBYz-=9zfggDerSpCS+kaWBO_Z4TMX0TA@mail.gmail.com> <20160614074745.315512c1@icelake>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48433 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932073AbcFNXEG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 19:04:06 -0400
In-Reply-To: <20160614074745.315512c1@icelake>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Prarit Bhargava <prarit@redhat.com>

On Tuesday, June 14, 2016 07:47:45 AM Jacob Pan wrote:
> On Tue, 14 Jun 2016 02:21:41 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > On Tue, Jun 14, 2016 at 2:06 AM, Jacob Pan
> > <jacob.jun.pan@linux.intel.com> wrote:
> > > On Mon, 13 Jun 2016 23:56:18 +0200
> > > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > >
> > >> On Monday, June 13, 2016 11:32:10 PM Rafael J. Wysocki wrote:
> > >> > On Monday, May 23, 2016 09:45:42 AM Jacob Pan wrote:
> > >> > > SKX RAPL interface is similar to HSX/BDX.
> > >> > >
> > >> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > >> > > ---
> > >> > >  drivers/powercap/intel_rapl.c | 1 +
> > >> > >  1 file changed, 1 insertion(+)
> > >> > >
> > >> > > diff --git a/drivers/powercap/intel_rapl.c
> > >> > > b/drivers/powercap/intel_rapl.c index 470bb62..a417e68 100644
> > >> > > --- a/drivers/powercap/intel_rapl.c
> > >> > > +++ b/drivers/powercap/intel_rapl.c
> > >> > > @@ -1096,6 +1096,7 @@ static const struct x86_cpu_id rapl_ids[]
> > >> > > __initconst = { RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake
> > >> > > */ RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview
> > >> > > */ RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
> > >> > > + RAPL_CPU(0x55, rapl_defaults_hsw_server),/* Skylake
> > >> > > server */ RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> > >> > >   RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
> > >> > >   RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
> > >> > >
> > >> >
> > >> > Can you please rebase this on top of 4.7-rc3?
> > >>
> > >> Or rather on top of the x86/cpu branch from tip?
> > >>
> > > done. just sent you v2.
> > > [PATCH v2] powercap/rapl: add support for denverton
> > 
> > Thanks for that one, but the $subject one was for SKX.  Any chance to
> > rebase and resend this one too?
> 
> SKX has already been added by commit below in tip/x86/cpu:
> 
> commit d40671e30cb46e834651e0ce3d4590c915171414
> Author: Dave Hansen <dave.hansen@linux.intel.com>
> Date:   Thu Jun 2 17:19:55 2016 -0700
> 
>     x86, powercap, rapl: Add Skylake Server model number

OK, thanks!

