From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 8/8] PCC: Enable PCC only when needed
Date: Tue, 21 Jul 2015 16:28:43 +0100
Message-ID: <55AE652B.7030409@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>	<f88f374b4e09f23d5601a2081d1d3d9322e3caf5.1436464513.git.ashwin.chaugule@linaro.org>	<55AD042D.9040204@arm.com>	<4609299.WWrJ4WHTsa@vostro.rjw.lan>	<55AE0F7B.8010804@arm.com> <CAJZ5v0j-_QB1U-A0F2YSoDa_71nyEGR=yn8Kb5qe-FSqDPevOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j-_QB1U-A0F2YSoDa_71nyEGR=yn8Kb5qe-FSqDPevOA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 21/07/15 15:34, Rafael J. Wysocki wrote:
> Hi Sudeep,
>
> On Tue, Jul 21, 2015 at 11:23 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 20/07/15 23:04, Rafael J. Wysocki wrote:
>>>
>>> On Monday, July 20, 2015 03:22:37 PM Sudeep Holla wrote:
>>>>
>>>>
>>>> On 09/07/15 19:04, Ashwin Chaugule wrote:
>>>>>
>>>>> CPPC is the first client to make use of the PCC Mailbox channel. So
>>>>> enable it only when CPPC is also enabled.
>>>>>
>>>> This sounds like a reverse dependency to me. So if there's some client
>>>> unrelated to CPPC using PCC, CPPC_LIB needs to be selected to enable PCC
>>>> ?
>>>
>>>
>>> No.  The other client will need to select PCC too.
>>
>>
>> Yes the PCC users/clients selecting PCC is fine and that's already
>> done(i.e. ACPI_CPPC_LIB selects PCC). I still don't understand the need
>> for this change, also how will other clients possibly select PCC which
>> now depends on CPPC_LIB ? e.g. if we have
>>
>> config ACPI_XYZ_LIB
>>          select PCC
>>
>> config ACPI_XYZ
>>          select ACPI_XYZ_LIB
>>
>> Won't this shout warning: (ACPI_XYZ_LIB && ACPI_CPPC_LIB) selects PCC
>> which has unmet direct dependencies (MAILBOX && ACPI && ACPI_CPPC_LIB)
>> if ACPI_CPPC_LIB is not selected ?
>
> That depends on the "depends on" clauses used.  Selecting itself
> doesn't cause any dependencies to appear.
>

Agreed and I am absolutely fine with that. But if you look at this 
patch, it does

config PCC
	bool "Platform Communication Channel Driver"
	depends on ACPI && ACPI_CPPC_LIB

I am fine with ACPI_CPPC_LIB selecting PCC which is already done in
earlier patch. I am against making PCC depend on ACPI_CPPC_LIB.

Lets assume it's fine to do that. Now if another feature XYZ as in my
example say on x86 selects PCC then you will *get warnings* as we will
not able to select PCC without selecting ACPI_CPPC_LIB after this patch
and x86 will never select ACPI_CPPC_LIB. I did test something like my
XYZ example and it did trigger the warning as I suspected.

I am sorry either I am missing to understand again or unable to express
the problem here :(

>> OK, for now we enable ACPI_CPPC_LIB on ARM64 and not on x86. When x86
>> has a PCC client how will that select PCC without ACPI_CPPC_LIB. Sorry
>> if I am missing to understand something.
>
> Presumably, the new feature will have a Kconfig option associated with
> it and it will do "select PCC" too.
>

As I say I am fine with that and no arguments there.

Regards,
Sudeep
