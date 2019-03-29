From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Date: Sat, 30 Mar 2019 00:02:12 +0100
Message-ID: <1774302.IF6vfKfJ7U@aspire.rjw.lan>
References: <cover.1553285718.git.Janakarajan.Natarajan@amd.com> <f3a749646c66a84e17383204385d8c73750d4813.camel@intel.com> <SN6PR12MB26399489011DD026910B6049F85A0@SN6PR12MB2639.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SN6PR12MB26399489011DD026910B6049F85A0@SN6PR12MB2639.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Moore, Robert" <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, March 29, 2019 9:18:04 PM CET Ghannam, Yazen wrote:
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org> On Behalf Of Pandruvada, Srinivas
> > Sent: Wednesday, March 27, 2019 10:48 AM
> > To: linux-kernel@vger.kernel.org; devel@acpica.org; Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>; linux-
> > acpi@vger.kernel.org; linux-pm@vger.kernel.org
> > Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; lenb@kernel.org; viresh.kumar@linaro.org; Moore, Robert
> > <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>; rjw@rjwysocki.net
> > Subject: Re: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
> > 
> > On Fri, 2019-03-22 at 20:26 +0000, Natarajan, Janakarajan wrote:
> > > From: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > >
> > > Newer AMD processors support a subset of the optional CPPC registers.
> > > Create show, store and helper routines for supported CPPC registers.
> > >
> > > Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > > [ carved out into a patch, cleaned up, productized ]
> > > Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> > >
> > 
> > [..]
> > 
> > > +	/* desired_perf is the only mandatory value in perf_ctrls */
> > > +	if (cpc_read(cpu, desired_reg, &desired))
> > > +		ret = -EFAULT;
> > > +
> > > +	if (CPC_SUPPORTED(max_reg) && cpc_read(cpu, max_reg, &max))
> > > +		ret = -EFAULT;
> > > +
> > We should create and use different macro other than CPPC_SUPPORTED.
> > CPC_SUPPORTED doesn't validate the correctness of object type for a
> > field. For example "Maximum Performance Register" can only be buffer
> > not integer. In this way invalid field definitions can be ignored.
> > 
> 
> So create something like "CPPC_SUPPORTED_BUFFER" for buffer-only registers?
> 
> And then buffer/integer registers will continue to use "CPPC_SUPPORTED".
> 
> These seem to be the only two cases at this time. Is this okay?

Yes, something like that.

Thanks,
Rafael
