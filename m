From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
Date: Mon, 2 Jul 2018 23:27:03 +0200
Message-ID: <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
 <20180702202151.GK533219@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702202151.GK533219@devbig577.frc2.facebook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 02-07-18 22:21, Tejun Heo wrote:
> On Mon, Jul 02, 2018 at 12:08:45PM -0700, Srinivas Pandruvada wrote:
>> From: Srinivas <srinivas.pandruvada@linux.intel.com>
>>
>> One of the requirement for modern x86 system to enter lowest power mode
>> (SLP_S0) is SATA IP block to be off. This is true even during when
>> platform is suspended to idle and not only in opportunistic (runtime)
>> suspend.
>>
>> Several of these system don't have traditional ACPI S3, so it is
>> important that they enter SLP_S0 state, to avoid draining battery even
>> during suspend even with out of the box Linux installation.

Question can systems which do have S3 not also enter SLP_S0 state during
normal operation to save power?

I guess the change of that happening without being in a suspend like state
(screen turned off, etc), is very small because there will always be
something blocking entering of SLP_S0, so that it is not worth
bothering looking into SLP_S0 on systems which use S3 for suspend ?

>> SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
>> user has to either use scsi-host sysfs or tools like powertop to set
>> the sata-host link_power_management_policy to min_power.
>>
>> This change sets by default link power management policy to min_power
>> for some platforms.  To avoid regressions, the following conditions
>> are used:
>> - The kernel config is already set to use med_power_with_dipm or deeper
>> - System is a modern standby system using ACPI low power idle flag
>> - The platform is not blacklisted for Suspend to Idle and suspend
>> to idle is used instead of S3
>> This combination will make sure that systems are fairly recent and
>> since getting shipped with modern standby standby, the DEVSLP function
>> is already validated.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Seems sane to me.  Hans, what do you think?

I think this is going in the right direction, but min_power enables
both DEVSLP and HIPM, AFAIK Windows at least in the past did not
enable HIPM be default.

Srinivas can you figure out what Windows does wrt HIPM?

We may need a new med_power_with_dipm_and_devslp level if windows does
not enable HIPM by default on these systems. In hind sight we really
should have separate bools for each, rather then coding this in
a single level, ah well.

Regards,

Hans
