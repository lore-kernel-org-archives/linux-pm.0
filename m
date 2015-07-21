From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 8/8] PCC: Enable PCC only when needed
Date: Tue, 21 Jul 2015 10:23:07 +0100
Message-ID: <55AE0F7B.8010804@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <f88f374b4e09f23d5601a2081d1d3d9322e3caf5.1436464513.git.ashwin.chaugule@linaro.org> <55AD042D.9040204@arm.com> <4609299.WWrJ4WHTsa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4609299.WWrJ4WHTsa@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 20/07/15 23:04, Rafael J. Wysocki wrote:
> On Monday, July 20, 2015 03:22:37 PM Sudeep Holla wrote:
>>
>> On 09/07/15 19:04, Ashwin Chaugule wrote:
>>> CPPC is the first client to make use of the PCC Mailbox channel. So
>>> enable it only when CPPC is also enabled.
>>>
>> This sounds like a reverse dependency to me. So if there's some client
>> unrelated to CPPC using PCC, CPPC_LIB needs to be selected to enable PCC ?
>
> No.  The other client will need to select PCC too.

Yes the PCC users/clients selecting PCC is fine and that's already
done(i.e. ACPI_CPPC_LIB selects PCC). I still don't understand the need
for this change, also how will other clients possibly select PCC which
now depends on CPPC_LIB ? e.g. if we have

config ACPI_XYZ_LIB
	select PCC

config ACPI_XYZ
	select ACPI_XYZ_LIB

Won't this shout warning: (ACPI_XYZ_LIB && ACPI_CPPC_LIB) selects PCC
which has unmet direct dependencies (MAILBOX && ACPI && ACPI_CPPC_LIB)
if ACPI_CPPC_LIB is not selected ?

OK, for now we enable ACPI_CPPC_LIB on ARM64 and not on x86. When x86
has a PCC client how will that select PCC without ACPI_CPPC_LIB. Sorry
if I am missing to understand something.

>
> I requested that change, because I'm slightly bothered by the fact that we
> build code used by no one by default.
>

I understand, but will keeping them default off should suffice ? No ?

Regards,
Sudeep
