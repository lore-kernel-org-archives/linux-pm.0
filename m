From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v2] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Wed, 11 May 2016 17:08:10 -0600
Message-ID: <359d426f-4e6d-6411-2bb0-0daa215dbbb4@redhat.com>
References: <1461024699-13734-1-git-send-email-ahs3@redhat.com>
 <CAJ5Y-ea+oO22FAjXJBWdFYTZ+6xqpQvYXGZuyy4ZwPDO5hToqA@mail.gmail.com>
 <20160422053020.GB2235@vireshk-i7>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160422053020.GB2235@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 04/21/2016 11:30 PM, Viresh Kumar wrote:
> On 19-04-16, 16:12, Ashwin Chaugule wrote:
>> + Ryan
>>
>> Hi Al,
>>
>> On 18 April 2016 at 20:11, Al Stone <ahs3@redhat.com> wrote:
>>> When CPPC is being used by ACPI on arm64, user space tools such as
>>> cpupower report CPU frequency values from sysfs that are incorrect.
>>>
>>> What the driver was doing was reporting the values given by ACPI tables
>>> in whatever scale was used to provide them.  However, the ACPI spec
>>> defines the CPPC values as unitless abstract numbers.  Internal kernel
>>> structures such as struct perf_cap, in contrast, expect these values
>>> to be in KHz.  When these struct values get reported via sysfs, the
>>> user space tools also assume they are in KHz, causing them to report
>>> incorrect values (for example, reporting a CPU frequency of 1MHz when
>>> it should be 1.8GHz).
>>>
>>> While the investigation for a long term fix proceeds (several options
>>> are being explored, some of which may require spec changes or other
>>> much more invasive fixes), this patch forces the values read by CPPC
>>> to be read in KHz, regardless of what they actually represent.
>>>
>>> The downside is that this approach has some assumptions:
>>>
>>>    (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
>>>    value for a processor is set to a non-zero value.
>>>
>>>    (2) It assumes that all processors run at the same speed.  This
>>>    patch retrieves the first CPU Max Frequency from a type 4 DMI
>>>    record that it can find.  This may not be an issue, however, as a
>>>    sampling of DMI data on x86 and arm64 indicates there is often only
>>>    one such record regardless.
> 
> Don't we have any big LITTLE ARM servers yet ? Or we will not have them at all ?

My apologies, but I missed this question earlier and just now noticed
it.  AFAIK, there are no big.LITTLE ARM servers yet.  That doesn't mean
there aren't any, or that no one is planning one; I just don't know of
any.  I have been in discussions about doing that, but in the past those
have ended up concluding that there is probably no need for that level
of power management in a server.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
