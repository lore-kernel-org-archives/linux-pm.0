From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/7] CPPC optional registers AMD support
Date: Thu, 18 Apr 2019 00:10:59 +0200
Message-ID: <CAJZ5v0hJpYROLJup0mvCp2G8ekeDyBrp+hdhHdsd+vhBq5RxVQ@mail.gmail.com>
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
 <d44f4893-0b67-4993-2942-6e03d29dffa1@amd.com> <CAJZ5v0jh0Yn1fy5bO3wett5AsjBA55_Z-8L_M8eRyy5cePqwaw@mail.gmail.com>
 <SN6PR12MB26396618BAC0F6600D786E08F8250@SN6PR12MB2639.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SN6PR12MB26396618BAC0F6600D786E08F8250@SN6PR12MB2639.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 17, 2019 at 7:28 PM Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Tuesday, April 16, 2019 4:34 AM
> > To: Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>
> > Cc: Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > pm@vger.kernel.org; devel@acpica.org; Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Viresh Kumar
> > <viresh.kumar@linaro.org>; Robert Moore <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>; Ghannam, Yazen
> > <Yazen.Ghannam@amd.com>
> > Subject: Re: [PATCH v2 0/7] CPPC optional registers AMD support
> >
> > On Tue, Apr 16, 2019 at 12:35 AM Janakarajan Natarajan <jnataraj@amd.com> wrote:
> > >
> > > On 4/4/19 4:25 PM, Natarajan, Janakarajan wrote:
> > > > CPPC (Collaborative Processor Performance Control) offers optional
> > > > registers which can be used to tune the system based on energy and/or
> > > > performance requirements.
> > > >
> > > > Newer AMD processors add support for a subset of these optional CPPC
> > > > registers, based on ACPI v6.1.
> > > >
> > > > The following are the supported CPPC registers for which sysfs entries
> > > > are created:
> > > > * enable                (NEW)
> > > > * max_perf              (NEW)
> > > > * min_perf              (NEW)
> > > > * energy_perf
> > > > * lowest_perf
> > > > * nominal_perf
> > > > * desired_perf          (NEW)
> > > > * feedback_ctrs
> > > > * auto_sel_enable       (NEW)
> > > > * lowest_nonlinear_perf
> > > >
> > > > The CPPC driver is updated to enable the OSPM and the userspace to
> > > > access
> > > > the newly supported registers.
> > > >
> > > > The purpose of exposing the registers via the sysfs entries is to allow
> > > > the userspace to:
> > > > * Tweak the values to fit its workload.
> > > > * Apply a profile from AMD's optimization guides.
> > > >
> > > > Profiles will be documented in the performance/optimization guides.
> > > >
> > > > Note:
> > > > * AMD systems will not have a policy applied in the kernel at this time.
> > > > * By default, acpi_cpufreq will still be used.
> > > >
> > > > TODO:
> > > > * Create a linux userspace tool that will help users generate a CPPC
> > > > * profile
> > > >    for their target workload.
> > > > * Create or update a driver to apply a general CPPC policy in the
> > > > * kernel.
> > > >
> > > > v1->v2:
> > > > * Add macro to ensure BUFFER only registers have BUFFER type.
> > > > * Add support macro to make the right check based on register type.
> > > > * Remove support checks for registers which are mandatory.
> > >
> > >
> > > Are there any concerns regarding this patchset?
> >
> > Yes, there are.
> >
> > Unfortunately, it is generally problematic.
> >
> > First off, the behavior of existing sysfs files cannot be changed at
> > will, as there may be users of them out there already depending on the
> > current behavior.
> >
>
> The intent is to add new sysfs files without changing the existing files. Is that okay?
>
> Or is the addition of new files also not acceptable?
>
> > Second, at least some CPPC control registers are used by cpufreq
> > drivers (cppc_cpufreq and intel_pstate), so modifying them behind the
> > drivers' backs is not a good idea in general.  For this reason, adding
> > new sysfs attributes to allow user space to do that is quite
> > questionable.
> >
>
> Yes, good point.
>
> What if a check is added so that writes only succeed if the CPUFREQ governor is set to userspace?

That wouldn't be particularly straightforward IMO.

What about handling this like the others do, through a proper cpufreq driver?
