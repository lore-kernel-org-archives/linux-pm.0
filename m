From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v19 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Thu, 30 Mar 2017 11:16:59 +0800
Message-ID: <CAMz4ku+PAn3nUGg7gs04cPHhn16cKgNv_+duv-kz0GqOEYTYkQ@mail.gmail.com>
References: <cover.1487578977.git.baolin.wang@linaro.org> <87zih3m73h.fsf@notabene.neil.brown.name>
 <CAMz4ku+98HAgVnMoCg0YaPpcY1NvdKdbK6AuDyzgNOrcbpaz9A@mail.gmail.com> <8737dx6m0b.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8737dx6m0b.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfou
List-Id: linux-pm@vger.kernel.org

Hi,

On 29 March 2017 at 07:04, NeilBrown <neilb@suse.com> wrote:
> On Tue, Mar 07 2017, Baolin Wang wrote:
>
>> On 3 March 2017 at 10:23, NeilBrown <neilb@suse.com> wrote:
>>
>>>
>>> I understand your reluctance to change drivers that you cannot test.
>>> An alternative it do change all the
>>>   atomic_notifier_call_chain(.*notifier,
>>> calls that don't pass a pointer to vbus_draw to pass NULL, and to
>>> declare the passing of NULL to be deprecated (so hopefully people won't
>>> use it in new code).
>>> Then any notification callback that expects a current can just ignore
>>> calls where the pointer is NULL.
>>
>> I am afraid if it is enough to send out vbus draw information from USB
>> phy driver, for example you will miss super speed (900mA), which need
>> get the speed information from gadget driver.
>
> When the gadget driver determines that 900mA is available, it calls
> usb_phy_set_power() which calls the ->set_power() method on the usb_phy.
> The usb_phy the uses the notifier to inform all interested parties
> that 900mA is available.

That is one possible way. Now we only set vbus draw by
usb_gadget_vbus_draw() after setting config and suspend/resume usb
device. Maybe we can add one condition in usb_gadget_vbus_draw() like:

if (mA >= 500 && gadet->speed >= SUPER_SPEED)
     mA = 900;

-- 
Baolin.wang
Best Regards
