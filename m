From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Thu, 09 Jul 2015 10:11:45 +0100
Message-ID: <559E3AD1.4050805@arm.com>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>	<9e352cbe2feac01158a21511bac5c544dc2f29e2.1434398373.git.ashwin.chaugule@linaro.org>	<2138469.Io9yItSdst@vostro.rjw.lan>	<CAJ5Y-eZBYb551T=kBdbjM4YQ1f_hwYBgkVk4wJsDHSib00XfrA@mail.gmail.com>	<CAJZ5v0gKW7bR66trxvuhd_Gb=ZMBbec++u+V+T4mroCZMtO+vg@mail.gmail.com>	<CAJ5Y-ebW3aCSSs4UQFLpLFSfo7d9zPVfigoROjN80uXzG1sZLw@mail.gmail.com>	<CAJZ5v0h24-YAeqW79Se8kRr+_+RknwNfLwS_74-sN+W0_wBaZg@mail.gmail.com>	<CAJ5Y-eYwnaDzyL78CyJDmo35CFTNoQrYfEcO3VYnpaZkSVPdcw@mail.gmail.com>	<CAJ5Y-eaGmF6pRKuapzQo8ruMt0FX4kVrdyu-os6maVaS7WO-Pw@mail.gmail.com>	<CAJZ5v0iGGgvzdcvAfS9ZiQTWMhqF9GWfZ7Fx6_rF1BGZmACpXw@mail.gmail.com> <CAJ5Y-eZCWF8fsfwtJFAS9wyz8ttpGVTZKhoboCudLhUHw80qkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJ5Y-eZCWF8fsfwtJFAS9wyz8ttpGVTZKhoboCudLhUHw80qkg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jaswinder Singh <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 08/07/15 22:46, Ashwin Chaugule wrote:
> On 8 July 2015 at 16:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> Hi Ashwin,
>
> Hi,
>
>> On Wed, Jul 8, 2015 at 10:28 PM, Ashwin Chaugule
>> <ashwin.chaugule@linaro.org> wrote:
>>> On 8 July 2015 at 16:05, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>>>> On 8 July 2015 at 15:55, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>> Hi Ashwin,
>>>>>
>>>>> On Wed, Jul 8, 2015 at 9:16 PM, Ashwin Chaugule
>>>>> <ashwin.chaugule@linaro.org> wrote:
>>>>>> Hi Rafael,
>>>>>>
>>
>> [cut]
>>
>>>>>
>>>>> Also I'm still unsure what the connection between _CST and CPPC is.
>>>>>
>>>>
>>>> There isnt. But I'm missing where I've implied the dependency?
>>>
>>> Perhaps the confusion is coming from the introduction of ACPI_CST in
>>> this file. I could leave it as it is and just separate out the
>>> ACPI_PSS bits. But I figured, while I'm at it, I'd introduce ACPI_CST,
>>> since we know the LPI stuff is coming up soon as a CST alternative
>>> anyway. So if you prefer, I can drop the CST bits and maybe Sudeep can
>>> address that as part of his LPI patchset?
>>
>> Yes, please.  That would be much less confusing.
>
> Deja Vu. :)
>
> When I let processor_driver and processor_idle compile on ARM64, I get
> a bunch of errors because processor_idle.c contains a lot of X86
> specific defines. That is why I'd created the ACPI_CST option which
> we'd enable only on X86.
>
> I'm not entirely sure what these enums and functions should default
> to, or what they should be on ARM specifically. Given that on ARM64
> we're likely to use LPI as against CST, it seems the original approach
> is better. Thoughts?

Correct, I addressed this in my RFC posting[1] and wanted to get
feedback from Rafael before proceeding. As I said in other email,
I will try to rebase and repost that series ASAP.

Regards,
Sudeep

[1] https://lkml.org/lkml/2015/5/6/486
