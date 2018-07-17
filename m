From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
Date: Tue, 17 Jul 2018 12:09:21 +0200
Message-ID: <3724084.DyflrVPzDS@aspire.rjw.lan>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <20180717092721.onkaf3qsu7te6syi@suselix> <20180717093620.ym6phfmr3rfvsxyo@suselix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717093620.ym6phfmr3rfvsxyo@suselix>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 17, 2018 11:36:20 AM CEST Andreas Herrmann wrote:
> On Tue, Jul 17, 2018 at 11:27:21AM +0200, Andreas Herrmann wrote:
> > On Tue, Jul 17, 2018 at 11:23:25AM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Jul 17, 2018 at 11:11 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > > On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
> > > >> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > >>
> > > >> [cut]
> > > >>
> > > >> >
> > > >> > On balance before this commit users could use pcc-cpufreq but had
> > > >> > already suboptimal performance (compared to say intel_pstate driver
> > > >> > which can be used changing BIOS options).
> > > >>
> > > >> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.
> > > >
> > > > I think this is because of (in intel_pstate_init()):
> > > >
> > > >         /*
> > > >          * The Intel pstate driver will be ignored if the platform
> > > >          * firmware has its own power management modes.
> > > >          */
> > > >         if (intel_pstate_platform_pwr_mgmt_exists())
> > > >                 return -ENODEV;
> > > >
> > > 
> > > OK, because of the "Proliant" entry, right?
> > > 
> > > So it looks like we have an issue there.  We find the entry and we
> > > look for _PSS.  It is not there, so we assume that the firmware is
> > > expected to control performance, which is not the case.
> 
> FYI, there is another BIOS setting on those systems. It's called
> "Collaborative Power Control" (AFAIK enabled by default).
> 
> Only if this is disabled, firmware is (alone) in control of
> performance. (And of course in this case neither pcc-cpufreq nor
> intel_pstate will be loaded).

OK, the patch is below.

First, I hope that if "Collaborative Power Control" is disabled, it will
simply hide the PCCH object and so intel_pstate will still not load then.

The main question basically is what the OS is expected to do if "Dynamic
Power Savings Mode" is set.  If we are *expected* to use the PCC interface
then, intel_pstate may not work in that case, but I suspect that the PCC
interface allows extra energy to be saved over what is possible without it.

---
 drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2391,6 +2391,18 @@ static bool __init intel_pstate_no_acpi_
 	return true;
 }
 
+static bool __init intel_pstate_no_acpi_pcch(void)
+{
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, "\\_SB", &handle);
+	if (ACPI_FAILURE(status))
+		return true;
+
+	return !acpi_has_method(handle, "PCCH");
+}
+
 static bool __init intel_pstate_has_acpi_ppc(void)
 {
 	int i;
@@ -2450,7 +2462,10 @@ static bool __init intel_pstate_platform
 
 	switch (plat_info[idx].data) {
 	case PSS:
-		return intel_pstate_no_acpi_pss();
+		if (!intel_pstate_no_acpi_pss())
+			return false;
+
+		return intel_pstate_no_acpi_pcch();
 	case PPC:
 		return intel_pstate_has_acpi_ppc() && !force_load;
 	}
