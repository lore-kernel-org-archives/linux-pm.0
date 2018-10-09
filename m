From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RESEND][PATCH] ACPI / CPPC: Add support for guaranteed
 performance
Date: Tue, 09 Oct 2018 13:41:57 -0700
Message-ID: <e534dafea0a138777e46f41b8c33618148a79d57.camel@linux.intel.com>
References: <20181008165136.9288-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0h1ir+vU7xzQ15edSO6uNwXzmqXRFkbhPGpUY8gSz+gVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h1ir+vU7xzQ15edSO6uNwXzmqXRFkbhPGpUY8gSz+gVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@acpica.org, Linux PM <linux-pm@vger.kernel.org>, Prashanth Prakash <pprakash@codeaurora.org>, George Cherian <george.cherian@cavium.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-10-09 at 09:35 +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 8, 2018 at 6:55 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > The Continuous Performance Control Package can have guaranteed
> > performance
> > field. Add support to read guaranteed performance.
> 
> The spec says that it is optional, but you seem to assume that it
> always will be there.
> 
Even if there is some missing optional field, the place will not be
filled by the next mandatory field as the order of fields is _CPC is
fixed.

"Optional _CPC package fields that are not supported by the platform
should be encoded as follows:
• Integer fields: Integer 0
• Register fields: the following NULL register descriptor should be
used:
ResourceTemplate() {Register {(SystemMemory, 0, 0, 0, 0)}}
"

> What happens if it is not there?
Will see 0 acpi_cppc sysfs.

But this may confuse users, so better not to add guaranteed attribute
to acpi_cppc sysfs.

I will submit v2 of patch series.

Thanks,
Srinivas

> 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> > No changes. But adding CC to mailing lists.
> > 
> >  Documentation/acpi/cppc_sysfs.txt |  2 ++
> >  drivers/acpi/cppc_acpi.c          | 10 ++++++++--
> >  include/acpi/cppc_acpi.h          |  1 +
> >  3 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/acpi/cppc_sysfs.txt
> > b/Documentation/acpi/cppc_sysfs.txt
> > index f20fb445135d..812574d30717 100644
> > --- a/Documentation/acpi/cppc_sysfs.txt
> > +++ b/Documentation/acpi/cppc_sysfs.txt
> > @@ -22,6 +22,7 @@ $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
> >  /sys/devices/system/cpu/cpu0/acpi_cppc/:
> >  total 0
> >  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
> > +-r--r--r-- 1 root root 65536 Mar  5 19:38 guaranteed_perf
> >  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
> >  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
> >  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
> > @@ -33,6 +34,7 @@ total 0
> > 
> >  ----------------------------------------------------------------
> > ----------------
> > 
> > +* guaranteed_perf : Guaranteed performance of this processor
> > (abstract scale).
> >  * highest_perf : Highest performance of this processor (abstract
> > scale).
> >  * nominal_perf : Highest sustained performance of this processor
> > (abstract scale).
> >  * lowest_nonlinear_perf : Lowest performance of this processor
> > with nonlinear
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index d9ce4b162e2c..5babb9402f11 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -153,6 +153,7 @@ __ATTR(_name, 0444, show_##_name, NULL)
> >         }                                                          
> >      \
> >         define_one_cppc_ro(member_name)
> > 
> > +show_cppc_data(cppc_get_perf_caps, cppc_perf_caps,
> > guaranteed_perf);
> >  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
> >  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
> >  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
> > @@ -189,6 +190,7 @@ static struct attribute *cppc_attrs[] = {
> >         &nominal_perf.attr,
> >         &nominal_freq.attr,
> >         &lowest_freq.attr,
> > +       &guaranteed_perf.attr,
> >         NULL
> >  };
> > 
> > @@ -1061,9 +1063,9 @@ int cppc_get_perf_caps(int cpunum, struct
> > cppc_perf_caps *perf_caps)
> >  {
> >         struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> >         struct cpc_register_resource *highest_reg, *lowest_reg,
> > -               *lowest_non_linear_reg, *nominal_reg,
> > +               *lowest_non_linear_reg, *nominal_reg,
> > *guaranteed_reg,
> >                 *low_freq_reg = NULL, *nom_freq_reg = NULL;
> > -       u64 high, low, nom, min_nonlinear, low_f = 0, nom_f = 0;
> > +       u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0,
> > nom_f = 0;
> >         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> >         struct cppc_pcc_data *pcc_ss_data = NULL;
> >         int ret = 0, regs_in_pcc = 0;
> > @@ -1079,6 +1081,7 @@ int cppc_get_perf_caps(int cpunum, struct
> > cppc_perf_caps *perf_caps)
> >         nominal_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
> >         low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
> >         nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
> > +       guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
> > 
> >         /* Are any of the regs PCC ?*/
> >         if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
> > @@ -1107,6 +1110,9 @@ int cppc_get_perf_caps(int cpunum, struct
> > cppc_perf_caps *perf_caps)
> >         cpc_read(cpunum, nominal_reg, &nom);
> >         perf_caps->nominal_perf = nom;
> > 
> > +       cpc_read(cpunum, guaranteed_reg, &guaranteed);
> > +       perf_caps->guaranteed_perf = guaranteed;
> > +
> >         cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
> >         perf_caps->lowest_nonlinear_perf = min_nonlinear;
> > 
> > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > index 8e0b8250a139..cf59e6210d27 100644
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -104,6 +104,7 @@ enum cppc_regs {
> >   * today.
> >   */
> >  struct cppc_perf_caps {
> > +       u32 guaranteed_perf;
> >         u32 highest_perf;
> >         u32 nominal_perf;
> >         u32 lowest_perf;
> > --
> > 2.17.1
> > 
