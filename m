From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] Force cppc_cpufreq to report values in KHz to fix user space reporting
Date: Fri, 22 Apr 2016 14:47:28 +0200
Message-ID: <1822199.gohiEZHYSb@vostro.rjw.lan>
References: <1461024699-13734-1-git-send-email-ahs3@redhat.com> <CAJ5Y-ea+oO22FAjXJBWdFYTZ+6xqpQvYXGZuyy4ZwPDO5hToqA@mail.gmail.com> <20160422053020.GB2235@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160422053020.GB2235@vireshk-i7>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Al Stone <ahs3@redhat.com>, Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Friday, April 22, 2016 11:00:20 AM Viresh Kumar wrote:
> On 19-04-16, 16:12, Ashwin Chaugule wrote:
> > + Ryan
> > 
> > Hi Al,
> > 
> > On 18 April 2016 at 20:11, Al Stone <ahs3@redhat.com> wrote:
> > > When CPPC is being used by ACPI on arm64, user space tools such as
> > > cpupower report CPU frequency values from sysfs that are incorrect.
> > >
> > > What the driver was doing was reporting the values given by ACPI tables
> > > in whatever scale was used to provide them.  However, the ACPI spec
> > > defines the CPPC values as unitless abstract numbers.  Internal kernel
> > > structures such as struct perf_cap, in contrast, expect these values
> > > to be in KHz.  When these struct values get reported via sysfs, the
> > > user space tools also assume they are in KHz, causing them to report
> > > incorrect values (for example, reporting a CPU frequency of 1MHz when
> > > it should be 1.8GHz).
> > >
> > > While the investigation for a long term fix proceeds (several options
> > > are being explored, some of which may require spec changes or other
> > > much more invasive fixes), this patch forces the values read by CPPC
> > > to be read in KHz, regardless of what they actually represent.
> > >
> > > The downside is that this approach has some assumptions:
> > >
> > >    (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
> > >    value for a processor is set to a non-zero value.
> > >
> > >    (2) It assumes that all processors run at the same speed.  This
> > >    patch retrieves the first CPU Max Frequency from a type 4 DMI
> > >    record that it can find.  This may not be an issue, however, as a
> > >    sampling of DMI data on x86 and arm64 indicates there is often only
> > >    one such record regardless.
> 
> Don't we have any big LITTLE ARM servers yet ? Or we will not have them at all ?
> 
> > > For arm64 servers, this may be sufficient, but it does rely on
> > > firmware values being set correctly.  Hence, other approaches are
> > > also being considered.
> > >
> > > This has been tested on three arm64 servers, with and without DMI, with
> > > and without CPPC support.
> > >
> > > Changes for v2:
> > >     -- Corrected thinko: needed to have DEPENDS on DMI in Kconfig.arm,
> > >        not SELECT DMI (found by build daemon)
> > >
> > > Signed-off-by: Al Stone <ahs3@redhat.com>
> > 
> > This looks like a good short term solution. Does it make more sense to
> > move this to the cppc_cpufreq driver though? Since that ties more
> > closely into the cpufreq framework which requires the kHz values in
> > sysfs. That way we can keep the cppc_acpi.c shim compliant with the
> > ACPI spec. (i.e. values read in cppc structures remain abstract and
> > unitless).
> > 
> > Rafael, Viresh, others,
> > 
> > Any other ideas how to handle this better in the long term?
> > 
> >  - Decouple the cpufreq sysfs from the cppc driver and introduce its
> > own entries. Is it possibly to do this cleanly while still allowing
> > usage of cpufreq registration with existing governors?
> > 
> >  - Come up with a scaling factor using the PMU cycle counter at boot
> > before the CPPC drivers are initialized. This would use the current
> > freq set by some UEFI var. This would possibly require some messy
> > perfevents plumbing and added bootup time though.
> 
> I may be missing the obvious, but can't we just create the cpufreq-table from
> this table in khz? We wouldn't require any further change then.

I wouldn't really like to do that, because the freq table would be totally
artificial then.

Thanks,
Rafael

