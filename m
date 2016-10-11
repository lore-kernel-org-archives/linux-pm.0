From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v17 3/4] usb: gadget: Integrate with the usb gadget
 supporting for usb charger
Date: Tue, 11 Oct 2016 12:32:17 +0800
Message-ID: <57FC6B51.9030205@linux.intel.com>
References: <cover.1476000169.git.baolin.wang@linaro.org>
 <700f8d4fc3c52418eeba5445f6822093cc9ff036.1476000169.git.baolin.wang@linaro.org>
 <57FC573C.2060301@linux.intel.com>
 <CAMz4kuL5yk5EZQ37ofA39uK_JwYYH5DA_=Z+nLEMO06KvyQmDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuL5yk5EZQ37ofA39uK_JwYYH5DA_=Z+nLEMO06KvyQmDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>USB <lin>
List-Id: linux-pm@vger.kernel.org

Hi,

On 10/11/2016 12:07 PM, Baolin Wang wrote:
>>>  /*
>>> >> + * usb_charger_unregister() - Unregister a usb charger.
>>> >> + * @uchger - the usb charger to be unregistered.
>>> >> + */
>>> >> +static int usb_charger_unregister(struct usb_charger *uchger)
>>> >> +{
>>> >> +     ida_simple_remove(&usb_charger_ida, uchger->id);
>>> >> +     sysfs_remove_groups(&uchger->gadget->dev.kobj, usb_charger_groups);
>>> >> +
>>> >> +     mutex_lock(&charger_lock);
>>> >> +     list_del(&uchger->list);
>>> >> +     mutex_unlock(&charger_lock);
>>> >> +
>>> >> +     kfree(uchger);
>> >
>> > Any reasons you want to put kfree() here? You allocated the memory
>> > in usb_charger_init(). Isn't usb_charger_exit() a better place?
> The usb_charger_exit() will issue usb_charger_unregister() and we need
> use the usb_charger structure in usb_charger_unregister() to
> unregister the usb charger.
>

This seems not to be a strong reason. :-)

You can unregister the charger first and then free the structure.
Just do the reverse operation of what you have done in the init
function.

Best regards,
Lu Baolu
