From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/2] powercap/rapl: add support for skx
Date: Tue, 14 Jun 2016 07:47:45 -0700
Message-ID: <20160614074745.315512c1@icelake>
References: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1464021943-14915-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<2701882.MhyhBLMFz2@vostro.rjw.lan>
	<1853463.fUpAPaBi47@vostro.rjw.lan>
	<20160613170622.02f0f80d@yairi>
	<CAJZ5v0j=Tv-mzdU9cyBYz-=9zfggDerSpCS+kaWBO_Z4TMX0TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j=Tv-mzdU9cyBYz-=9zfggDerSpCS+kaWBO_Z4TMX0TA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Prarit Bhargava <prarit@redhat.com>, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Tue, 14 Jun 2016 02:21:41 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Jun 14, 2016 at 2:06 AM, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> > On Mon, 13 Jun 2016 23:56:18 +0200
> > "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> >
> >> On Monday, June 13, 2016 11:32:10 PM Rafael J. Wysocki wrote:
> >> > On Monday, May 23, 2016 09:45:42 AM Jacob Pan wrote:
> >> > > SKX RAPL interface is similar to HSX/BDX.
> >> > >
> >> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> > > ---
> >> > >  drivers/powercap/intel_rapl.c | 1 +
> >> > >  1 file changed, 1 insertion(+)
> >> > >
> >> > > diff --git a/drivers/powercap/intel_rapl.c
> >> > > b/drivers/powercap/intel_rapl.c index 470bb62..a417e68 100644
> >> > > --- a/drivers/powercap/intel_rapl.c
> >> > > +++ b/drivers/powercap/intel_rapl.c
> >> > > @@ -1096,6 +1096,7 @@ static const struct x86_cpu_id rapl_ids[]
> >> > > __initconst = { RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake
> >> > > */ RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview
> >> > > */ RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
> >> > > + RAPL_CPU(0x55, rapl_defaults_hsw_server),/* Skylake
> >> > > server */ RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
> >> > >   RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
> >> > >   RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
> >> > >
> >> >
> >> > Can you please rebase this on top of 4.7-rc3?
> >>
> >> Or rather on top of the x86/cpu branch from tip?
> >>
> > done. just sent you v2.
> > [PATCH v2] powercap/rapl: add support for denverton
> 
> Thanks for that one, but the $subject one was for SKX.  Any chance to
> rebase and resend this one too?

SKX has already been added by commit below in tip/x86/cpu:

commit d40671e30cb46e834651e0ce3d4590c915171414
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu Jun 2 17:19:55 2016 -0700

    x86, powercap, rapl: Add Skylake Server model number
    
    SKX uses similar RAPL interface as Broadwell server according to
    Jacob Pan.
    
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Cc: Andy Lutomirski <luto@amacapital.net>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Brian Gerst <brgerst@gmail.com>
    Cc: Dave Hansen <dave@sr71.net>
    Cc: Denys Vlasenko <dvlasenk@redhat.com>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: jacob.jun.pan@intel.com
    Cc: linux-pm@vger.kernel.org
    Link: http://lkml.kernel.org/r/20160603001955.38E1E684@viggo.jf.intel.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index f4f8532..2e8f2be 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1114,6 +1114,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
        RAPL_CPU(INTEL_FAM6_SKYLAKE_DESKTOP,    rapl_defaults_core),
        RAPL_CPU(INTEL_FAM6_SKYLAKE_MOBILE,     rapl_defaults_core),
+       RAPL_CPU(INTEL_FAM6_SKYLAKE_X,          rapl_defaults_hsw_server),
        RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,    rapl_defaults_core),
        RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,   rapl_defaults_core),
 
