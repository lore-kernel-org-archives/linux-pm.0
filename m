From: rwells@codeaurora.org
Subject: Re: [PATCH v2] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Tue, 26 Apr 2016 14:46:32 -0400
Message-ID: <9bf9293aa62b0a7caef7c032ed18749b@codeaurora.org>
References: <1461024699-13734-1-git-send-email-ahs3@redhat.com>
 <CAJ5Y-ea+oO22FAjXJBWdFYTZ+6xqpQvYXGZuyy4ZwPDO5hToqA@mail.gmail.com>
 <5716B706.2050700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5716B706.2050700@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ahs3@redhat.com
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2016-04-19 18:53, Al Stone wrote:
> On 04/19/2016 02:12 PM, Ashwin Chaugule wrote:
>> + Ryan
>>=20
>> Hi Al,
>>=20
>> On 18 April 2016 at 20:11, Al Stone <ahs3@redhat.com> wrote:
>>> When CPPC is being used by ACPI on arm64, user space tools such as
>>> cpupower report CPU frequency values from sysfs that are incorrect.
>>>=20
>>> What the driver was doing was reporting the values given by ACPI=20
>>> tables
>>> in whatever scale was used to provide them.  However, the ACPI spec
>>> defines the CPPC values as unitless abstract numbers.  Internal=20
>>> kernel
>>> structures such as struct perf_cap, in contrast, expect these value=
s
>>> to be in KHz.  When these struct values get reported via sysfs, the
>>> user space tools also assume they are in KHz, causing them to repor=
t
>>> incorrect values (for example, reporting a CPU frequency of 1MHz wh=
en
>>> it should be 1.8GHz).
>>>=20
>>> While the investigation for a long term fix proceeds (several optio=
ns
>>> are being explored, some of which may require spec changes or other
>>> much more invasive fixes), this patch forces the values read by CPP=
C
>>> to be read in KHz, regardless of what they actually represent.
>>>=20
>>> The downside is that this approach has some assumptions:
>>>=20
>>>    (1) It relies on SMBIOS3 being used, *and* that the Max Frequenc=
y
>>>    value for a processor is set to a non-zero value.
>>>=20
>>>    (2) It assumes that all processors run at the same speed.  This
>>>    patch retrieves the first CPU Max Frequency from a type 4 DMI
>>>    record that it can find.  This may not be an issue, however, as =
a
>>>    sampling of DMI data on x86 and arm64 indicates there is often=20
>>> only
>>>    one such record regardless.
>>>=20
>>> For arm64 servers, this may be sufficient, but it does rely on
>>> firmware values being set correctly.  Hence, other approaches are
>>> also being considered.
>>>=20
>>> This has been tested on three arm64 servers, with and without DMI,=20
>>> with
>>> and without CPPC support.
>>>=20
>>> Changes for v2:
>>>     -- Corrected thinko: needed to have DEPENDS on DMI in=20
>>> Kconfig.arm,
>>>        not SELECT DMI (found by build daemon)
>>>=20
>>> Signed-off-by: Al Stone <ahs3@redhat.com>
>>=20
>> This looks like a good short term solution. Does it make more sense =
to
>> move this to the cppc_cpufreq driver though? Since that ties more
>> closely into the cpufreq framework which requires the kHz values in
>> sysfs. That way we can keep the cppc_acpi.c shim compliant with the
>> ACPI spec. (i.e. values read in cppc structures remain abstract and
>> unitless).
>=20
> Perhaps.  Doing it that way made the patch a bit messier since
> cppc_acpi.c would set values that then had to be replaced in
> cppc_cpufreq.c, so initialization looked odd to me; that's how
> I ended up here.  You do raise a good point, however; I'll look
> at that approach again since I could have missed an easier way
> to do it.
>=20
>> Rafael, Viresh, others,
>>=20
>> Any other ideas how to handle this better in the long term?
>>=20
>>  - Decouple the cpufreq sysfs from the cppc driver and introduce its
>> own entries. Is it possibly to do this cleanly while still allowing
>> usage of cpufreq registration with existing governors?
>>=20
>>  - Come up with a scaling factor using the PMU cycle counter at boot
>> before the CPPC drivers are initialized. This would use the current
>> freq set by some UEFI var. This would possibly require some messy
>> perfevents plumbing and added bootup time though.
>>=20
>> - .. ?
>>=20
>>=20
>> Cheers,
>> Ashwin.
>>=20
>=20
> The other thought that occurs to me is to go back through the
> perf_cap and cpufreq structs and make them more general -- perhaps
> store the units being used and pointers to functions to convert them
> to KHz.  This may require separating sysfs data for perf_cap from the
> cpufreq sysfs data from the cppc sysfs data.  But, if units are then
> reported out to sysfs, user space tools can do whatever conversions
> they want, or at least know what they're reporting instead of there
> being an implicit ABI between the kernel and the tools.  This would
> be a far more invasive patch set, I think, but it still may be the
> right thing to do for the long term.

The issue is a little more fundamental than that even.  We are=20
retrofitting a performance management interface (CPPC) into a frequency=
=20
management framework (cpufreq) and accompanying tools.  Regardless of=20
what scheme we come up with for deriving/exposing frequency, we still=20
haven=E2=80=99t completely solved the problem as that assumes a linear=20
relationship between freq and performance.  This will work for many but=
=20
not necessarily all CPPC systems.  In fact, making that assumption is=20
explicitly forbidden in the ACPI spec: "OSPM must make no assumption=20
about the exact meaning of the performance values presented by the=20
platform, or how they may correlate to specific hardware metrics like=20
processor frequency."

So to be completely consistent with the current spec, we would need to=20
ween the tools off of frequency altogether and move to abstract=20
performance - either specifically when CPPC driver is loaded or more=20
generally.  If we think reporting frequency is required that might stil=
l=20
be doable, but would need to be separate interface from the CPPC perf=20
scale.  But I agree with Al that is a more invasive change.

=46or the time being, I don't think it is unreasonable to assume=20
performance is linear with frequency and come up with a scaling factor=20
via one of several mechanisms:
    1) SMBIOS as Al proposed (caveats above)
    2) Measure at boot using PMU or other mechanism as Ashwin floated=20
(more complicated but removes dependency on SMBIOS and assumption that=20
freq scale is same across all CPUs)
    3) Just hardcode a CPPC perf to kHz mapping - maybe everyone is usi=
ng=20
MHz today? (simplest but obviously least flexible)
    4) Others?
None of these are full solution - it is a question of how many differen=
t=20
scenarios do we need to cover with initial solution.  I think the SMBIO=
S=20
one is probably a good simplicity/flexibility compromise.

-Ryan

Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center,=20
Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a=20
Linux Foundation Collaborative Project
