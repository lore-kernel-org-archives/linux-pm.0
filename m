From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v7 3/8] ACPI: Decouple ACPI idle and ACPI processor drivers
Date: Wed, 5 Aug 2015 09:47:18 -0400
Message-ID: <CAJ5Y-eaOujd2nqC4aqMvv0DOz2nnrDw_ugrn+JK10rANsmV0yw@mail.gmail.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
	<da1eb99c0e128a4c8160537295045164d8fde00d.1436464513.git.ashwin.chaugule@linaro.org>
	<55AD03F7.60108@arm.com>
	<CAJ5Y-eYqfpdC2EvEO5gRm7zRbzr0+KwhiL4MUY23uXM91y=MJA@mail.gmail.com>
	<55C0D156.9090808@arm.com>
	<CAJ5Y-eaibuK0c_wSsRjM68vOfuRdRSChRdzR=2qtwVYwQcAzVQ@mail.gmail.com>
	<55C0D7DC.2060709@arm.com>
	<CAJ5Y-eZo07qVMS37eo=OShCLcgpURfyRA=dOQhtF0Y6_fvR=1Q@mail.gmail.com>
	<55C0EFA3.2040006@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55C0EFA3.2040006@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On 4 August 2015 at 13:00, Sudeep Holla <sudeep.holla@arm.com> wrote:

> On 04/08/15 16:44, Ashwin Chaugule wrote:
>> On 4 August 2015 at 11:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Bisectability aside, without the idle changes to decouple it from
>> ACPI_PROCESSOR, the CPPC code will be non-functional. CPPC code has
>> been around for review publicly for almost a year and we need it to be
>> mainlined soon. So, given that we've converged on a solution for new
>> Kconfigs for Idle and PSS and that they're separate patches, why not
>> let it progress forwards as part of this series?
>>
> Sorry, I didn't mean to block this series in anyway. I was just thinking
> on how to post the preparatory changes to introduce _LPI. I prefer to
> base it on mainline rather than this patch series and hence I made that
> request.
>

Can you please try rebasing with Patch 2,3,6 and 9 of the V8 series?
Those should get you going for your LPI work.

Thanks,
Ashwin.
