From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v6 0/3] Stingray thermal driver support
Date: Fri, 8 Mar 2019 10:44:15 -0800
Message-ID: <4b8324a6-1d02-983c-7d4c-d824b57d8675@gmail.com>
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
 <a6113115-453c-4606-f99d-c79263d8f4bb@broadcom.com>
 <20190205235811.GA19687@localhost.localdomain>
 <CABe79T4bcNs9efLRt1OsTekT+9PHq837x0fngf0kGUdkC5mMsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABe79T4bcNs9efLRt1OsTekT+9PHq837x0fngf0kGUdkC5mMsA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Ray Jui <ray.jui@broadcom.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2/14/19 8:20 PM, Srinath Mannam wrote:
> Hi Eduardo,
> 
> Could you please provide your review comments?

So it sounds like this driver was included in a pull request to Linus
for 5.1 [1], although I did not see a response to that patch series,
which would have helped synchronize the Device Tree changes and send
them to Linus as well... I will see if the ARM SoC folks will accept a
late request, most likely they would not.

Eduardo, can you include replies to patches when you applies those to
your tree that way we know whether/when to take the corresponding DTS
changes? Thank you.

[1]:
https://git.kernel.org/torvalds/c/9f24a81e2e5daf8820c8654afcd8512e797c41f2

> 
> Regards,
> Srinath.
> 
> On Wed, Feb 6, 2019 at 5:28 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>>
>> Hello,
>>
>> On Mon, Feb 04, 2019 at 04:16:19PM -0800, Ray Jui wrote:
>>> Hi Zhang/Eduardo,
>>>
>>> Can this patch series be merged? It looks like Srinath has addressed all
>>> review comments?
>>
>> I will take a look. Side note, thermal patches are reviewed on
>> linux-pm@vger.kernel.org. Copying that list it does help because that
>> is how the patches get assigned in patchwork.kernel.org.
>>
>>>
>>> The following tag should be added to the binding document patch:
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>> Thanks,
>>>
>>> Ray
>>>
>>> On 1/3/2019 12:55 AM, Srinath Mannam wrote:
>>>> These patches adds the stingray thermal driver and its
>>>> corresponding DT nodes with documentation.
>>>>
>>>> Changes from v5
>>>>   - Addressed Eduardo Valentin comments.
>>>>
>>>> Changes from v4
>>>>   - Addressed Rob Herring comments on DT parameters and
>>>>     thermal driver architecture.
>>>>   - Removed brcm,max-crit-temp DT parameter
>>>>   - Changed driver to thermal sensor registration model.
>>>>   - Added trip DT properties.
>>>>
>>>> Changes from v3
>>>>   - Addressed Daniel lezcano comments.
>>>>   - Elaborated commit description of thermal driver patch.
>>>>   - Added brcm,max-crit-temp DT parameter.
>>>>
>>>> Changes from v2:
>>>>   - All stingray TMON DT nodes are combine together into single.
>>>>     Temperature registers are combined into one mem resource.
>>>>     brcm,tmon-mask parameter has available TMONs mask value.
>>>>   - All available TMONs are initialized together in single
>>>>     instance of driver probe call.
>>>>
>>>> Changes from v1:
>>>>   - Fixed auto build sparce warning.
>>>>
>>>> Pramod Kumar (3):
>>>>   dt-bindings: thermal: Add binding document for SR thermal
>>>>   thermal: broadcom: Add Stingray thermal driver
>>>>   arm64: dts: stingray: Add Stingray Thermal DT support.
>>>>
>>>>  .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++++
>>>>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++++
>>>>  drivers/thermal/Kconfig                            |   3 +-
>>>>  drivers/thermal/broadcom/Kconfig                   |   9 ++
>>>>  drivers/thermal/broadcom/Makefile                  |   1 +
>>>>  drivers/thermal/broadcom/sr-thermal.c              | 122 +++++++++++++++++++++
>>>>  6 files changed, 328 insertions(+), 1 deletion(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>>>>  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
>>>>


-- 
Florian
