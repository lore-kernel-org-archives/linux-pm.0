From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Date: Wed, 27 Feb 2019 09:27:28 +0000
Message-ID: <abbee52f-39ce-6e8f-af3c-f6f8d1a39020@arm.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <CAKv+Gu9OOzOxx0rTAZqM8r4q_hRmOp3b=KP7fwgNeiu67FCApA@mail.gmail.com>
 <5310b73b-4821-6dff-b9c0-34c59fb7fd72@arm.com>
 <CAKv+Gu_=bQyVZqgUnJm9moCcaCcpDrag6NWGEpaR65=pMiTFJQ@mail.gmail.com>
 <0c433a70-27f6-76ad-c46c-6015de1ffaa4@arm.com>
 <20190226234422.GD174696@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226234422.GD174696@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Amitkumar Karwar <amitkarwar@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>, Kalle Valo <kvalo@codeaurora.org>, Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>, Xinming Hu <huxinming820@gmail.com>, Devicetree List <devicetree@vger.kernel.org>, "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-rockchip@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.o
List-Id: linux-pm@vger.kernel.org

On 26/02/2019 23:44, Brian Norris wrote:
> Hi,
> 
> On Tue, Feb 26, 2019 at 05:14:00PM +0000, Marc Zyngier wrote:
>> On 26/02/2019 16:21, Ard Biesheuvel wrote:
>>> On Mon, 25 Feb 2019 at 15:53, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> It outlines one thing: If you have to interpret per-device PCI
>>>> properties from DT, you're in for serious trouble. I should get some
>>>> better HW.
>>>>
>>>
>>> Yeah, it obviously makes no sense at all for the interrupt parent of a
>>> PCI device to deviate from the host bridge's interrupt parent, and
>>> it's quite unfortunate that we can't simply ban it now that the cat is
>>> out of the bag already.
>>>
>>> Arguably, the wake up widget is not part of the PCI device, but I have
>>> no opinion as to whether it is better modeling it as a sub device as
>>> you are proposing or as an entirely separate device referenced via a
>>> phandle.
>>
>> It is not that clear. The widget seems to be an integral part of the
>> device, as it is the same basic IP that is used for SDIO and USB.
> 
> It's not really a widget specific to this IP. It's just a GPIO. It so
> happens that both SDIO and PCIe designs have wanted to use a GPIO for
> wakeup, as many other devices do. (Note: it's not just cheap ARM
> devices; pulling up some Intel Chromebook designs, I see the exact same
> WAKE# GPIO on their PCIe WiFi as well.)

Arghh! If I can't even point people to an Intel design as an example of
something done halfway right, we're screwed! ;-)

> 
>> It looks like the good old pre-PCI-2.2 days, where you had to have a
>> separate cable between your network card and the base-board for the
>> wake-up interrupt to be delivered. Starting with PCI-2.2, the bus can
>> carry the signal just fine. With PCIe, it should just be an interrupt
>> TLP sent to the RC, but that's obviously not within the capabilities of
>> the HW.
> 
> You should search the PCI Express specification for WAKE#. There is a
> clearly-documented "side-band wake" feature that is part of the
> standard, as an alternative to in-band TLP wakeup. While you claim this
> is an ancient thing, it in fact still in use on many systems -- it's
> just usually abstracted better by ACPI firmware, whereas the dirty
> laundry is aired a bit more on a Device Tree system. And we got it
> wrong.

I stand corrected. I was really hoping for these side-band wires to be a
thing of the past, but clearly the world hasn't moved as quickly as I hoped.

>> Anyway, it'd be good if the Marvell people could chime in and let us
>> know how they'd prefer to handle this.
> 
> I'm not sure this is really a Marvell-specific problem. (Well, except
> for the marvell,wakeup-pin silliness, which is somewhat orthogonal.) In
> fact, if we cared a little more about Wake-on-WiFi, we'd be trying to
> support the same (out-of-band WAKE#) with other WiFi drivers.

I'd definitely like to see this standardized. It would give us more
coverage, and prevent everyone from doing their own thing. But as you
mention, WoW doesn't seem to get much traction.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
