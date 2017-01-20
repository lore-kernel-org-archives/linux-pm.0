From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Fri, 20 Jan 2017 06:32:31 -0800
Message-ID: <5af810f5-ddae-af35-81d0-b8bbc9bd1d4e@roeck-us.net>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth> <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth> <20170119232934.GA18102@roeck-us.net>
 <20170120124404.wmlpiuqyizi7uhyi@earth> <20170120131116.GA26505@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120131116.GA26505@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 01/20/2017 05:11 AM, Thierry Reding wrote:
> On Fri, Jan 20, 2017 at 01:44:04PM +0100, Sebastian Reichel wrote:
>> Hi,
>>
>> On Thu, Jan 19, 2017 at 03:29:34PM -0800, Guenter Roeck wrote:
>>> On Fri, Jan 20, 2017 at 12:00:36AM +0100, Sebastian Reichel wrote:
>>> I actually have a set of patches somewhere which transforms the remaining
>>> direct users of arm_pm_restart to use the framework (unless I removed it
>>> from my trees - I don't really recall). I just never got around to submit
>>> it, and then [2] happened and I lost interest.
>>
>> I found a patchset from you from 2016. I see a few Acks and no
>> negative feedback. Looks like they only need to be uploaded at
>> Russel's patch system?
>>
>> arch/arm/mach-prima2/rstc.c			https://patchwork.kernel.org/patch/8844441/
>> arch/arm/xen/enlighten.c			https://patchwork.kernel.org/patch/8844481/
>> drivers/firmware/psci.c				https://patchwork.kernel.org/patch/8844411/
>> arch/arm/kernel/setup.c				https://patchwork.kernel.org/patch/8844451/
>> removal of ARM64 arm_pm_restart		https://patchwork.kernel.org/patch/8844471/
>> removal of ARM32 arm_pm_restart		https://patchwork.kernel.org/patch/8844391/
>
> Nice, those would be excellent preparatory work for my earlier framework
> proposal.
>
> Do you want me to pick those up and run with them a bit?
>
> Thierry
>

I didn't recall that I ever submitted them. They are all yours ...

Guenter
