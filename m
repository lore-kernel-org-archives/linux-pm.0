From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
Date: Tue, 3 Jul 2018 10:57:14 +0200
Message-ID: <fefe0ef4-e21f-72cc-18d6-a5a6693c21c6@redhat.com>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
 <20180702202151.GK533219@devbig577.frc2.facebook.com>
 <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
 <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tejun Heo <tj@kernel.org>
Cc: rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 03-07-18 00:08, Srinivas Pandruvada wrote:
> Hi Hans,
> 
> On Mon, 2018-07-02 at 23:27 +0200, Hans de Goede wrote:

<snip>

>>>> SATA IP block doesn't get turned off till SATA is in DEVSLP mode.
>>>> Here
>>>> user has to either use scsi-host sysfs or tools like powertop to
>>>> set
>>>> the sata-host link_power_management_policy to min_power.
>>>>
>>>> This change sets by default link power management policy to
>>>> min_power
>>>> for some platforms.  To avoid regressions, the following
>>>> conditions
>>>> are used:
>>>> - The kernel config is already set to use med_power_with_dipm or
>>>> deeper
>>>> - System is a modern standby system using ACPI low power idle
>>>> flag
>>>> - The platform is not blacklisted for Suspend to Idle and suspend
>>>> to idle is used instead of S3
>>>> This combination will make sure that systems are fairly recent
>>>> and
>>>> since getting shipped with modern standby standby, the DEVSLP
>>>> function
>>>> is already validated.
>>>>
>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.int
>>>> el.com>
>>>
>>> Seems sane to me.  Hans, what do you think?
>>
>> I think this is going in the right direction, but min_power enables
>> both DEVSLP and HIPM, AFAIK Windows at least in the past did not
>> enable HIPM be default.
> 
> Windows and Linux will need to meet the same criteria to reach SLP_S0
> state. OS is not deciding whether we meet criteria or not, it is
> firmware deciding, and it will look for SATA IP to be in certain
> predefined state, before generating this SLP_S0 signal.
> 
> 
>> Srinivas can you figure out what Windows does wrt HIPM?
> 
> We can see that under Windows the SATA rail voltage is dropped. I don't
> know if there is any other method other than DEVSLP configuration. But
> I will surely check around.

I understand that we need DEVSLP, but AFAIK DEVSLP is entered automatically
after being in slumber for a defined time. The question is how we get into
slumber. Currently with the new med_power_with_dipm policy we always use
DIPM to enter slumber. Your suggested switch to min_power means also
enabling HIPM. What I'm suggesting is that it might better to have
DIPM + DEVSLP rather then DIPM + HIPM + DEVSLP.

So basically the question is does windows use:

a) DIPM + DEVSLP; or
b) DIPM + HIPM + DEVSLP

If b. is the case, then I'm fine with your patch as is, but if Windows
does a. then we should mimic that, which requires a new power-level as
our min_power level is b.

>> We may need a new med_power_with_dipm_and_devslp level if windows
>> does
>> not enable HIPM by default on these systems. In hind sight we really
>> should have separate bools for each, rather then coding this in
>> a single level, ah well.
> Agree. We can certainly do this for even safer implementation.

Ack.

Regards,

Hans
