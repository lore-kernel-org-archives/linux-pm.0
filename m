From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v5] Thermal: introduce INT3406 thermal driver
Date: Thu, 11 Dec 2014 10:17:16 +0800
Message-ID: <5488FEAC.2010005@intel.com>
References: <54868CF6.6020505@intel.com>	<CAOesGMirF-_H2ZzFR-VpwkEErZE2uQJSYx5EuePArQsEh=r_Kw@mail.gmail.com>	<20141211010226.GA26253@aaronlu.sh.intel.com> <CAOesGMj_uObbxLdpobEhP=nRPsFUJNCtq01RH7ZSECd5=1Ti6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOesGMj_uObbxLdpobEhP=nRPsFUJNCtq01RH7ZSECd5=1Ti6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Zhang Rui <rui.zhang@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/11/2014 10:15 AM, Olof Johansson wrote:
> On Wed, Dec 10, 2014 at 5:02 PM, Aaron Lu <aaron.lu@intel.com> wrote:
>> On Wed, Dec 10, 2014 at 11:53:25AM -0800, Olof Johansson wrote:
>>> Hi,
>>>
>>> [+daniel vetter]
>>>
>>> On Mon, Dec 8, 2014 at 9:47 PM, Aaron Lu <aaron.lu@intel.com> wrote:
>>>> INT3406 ACPI device object resembles an ACPI video output device, but its
>>>> _BCM is said to be deprecated and should not be used. So we will make
>>>> use of the raw interface to do the actual cooling. Due to this, the
>>>> backlight core has some modifications. Also, to re-use some of the ACPI
>>>> video module's code, one function has been exported.
>>>>
>>>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>>> ---
>>>> v5:
>>>> Add the missing file drivers/thermal/int340x_thermal/Kconfig
>>>> Remove the assignment of .owner field from the device_driver structure
>>>
>>>
>>> Did this patch show up in -next for the first time last night, or did
>>> some other change break this?
>>>
>>> It causes a panic in i915 when booting Minnowboard Max for me.
>>
>> Sorry for the trouble, I'm looking at this now.
>> Is there anything special about the Minnowboard Max? I'll try to
>> reproduce the issue here locally with a typical Intel desktop.
> 
> Another good question is why the code showed up in -next today. Code
> going in for 3.19 is supposed to have been baking there already, and
> it's too early to stage anything for 3.20.
> 
> Zhang?
> 
>> Is it the next/master branch?
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Yes. But I've confirmed that it happens with Zhang's next branch too
> without the rest of linux-next.

Can you please give me your kernel config file too?

Thanks,
Aaron

> 
> 
> -Olof
> 
