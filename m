From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4 3/3] USB / PM: Allow USB devices to remain
 runtime-suspended when sleeping
Date: Thu, 16 Jul 2015 14:09:41 +0200
Message-ID: <CAAObsKD_pKmzCLLij3YhO8pPOqXi-z0FNiGrXXcqr6Dt+V-KXw@mail.gmail.com>
References: <1436964008-15151-1-git-send-email-tomeu.vizoso@collabora.com>
 <1436964008-15151-4-git-send-email-tomeu.vizoso@collabora.com> <7175055.CJlfILVf3s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7175055.CJlfILVf3s@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16 July 2015 at 02:42, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, July 15, 2015 02:40:08 PM Tomeu Vizoso wrote:
>> Have dev_pm_ops.prepare return 1 for USB devices and ports so that USB
>> devices can remain runtime-suspended when the system goes to a sleep
>> state, if their wakeup state is correct and they have runtime PM enabled.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>
>>  drivers/usb/core/port.c |  6 ++++++
>>  drivers/usb/core/usb.c  | 11 ++++++++++-
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index 210618319f10..f49707d73b5a 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -168,12 +168,18 @@ static int usb_port_runtime_suspend(struct device *dev)
>>
>>       return retval;
>>  }
>> +
>> +static int usb_port_prepare(struct device *dev)
>> +{
>> +     return 1;
>> +}
>>  #endif
>>
>>  static const struct dev_pm_ops usb_port_pm_ops = {
>>  #ifdef CONFIG_PM
>>       .runtime_suspend =      usb_port_runtime_suspend,
>>       .runtime_resume =       usb_port_runtime_resume,
>> +     .prepare =              usb_port_prepare,
>>  #endif
>>  };
>>
>> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
>> index 8d5b2f4113cd..cf4dde11db1c 100644
>> --- a/drivers/usb/core/usb.c
>> +++ b/drivers/usb/core/usb.c
>> @@ -316,7 +316,16 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
>>
>>  static int usb_dev_prepare(struct device *dev)
>>  {
>> -     return 0;               /* Implement eventually? */
>> +     struct usb_device *udev = to_usb_device(dev);
>> +
>> +     if (!pm_runtime_enabled(dev))
>
> Why just enabled and not suspended?

Hmm, the core checks if it's runtime suspended before going
direct_complete, but it's true that the API docs say that it should
return a positive value only if it's runtime suspended.

Is there a reason why the prepare() implementations have to check that
instead of leaving it to the core?

Thanks,

Tomeu

>> +             return 0;
>> +
>> +     /* Return 0 if the current wakeup setting is wrong, otherwise 1 */
>> +     if (udev->do_remote_wakeup != device_may_wakeup(dev))
>> +             return 0;
>> +
>> +     return 1;
>>  }
>>
>>  static void usb_dev_complete(struct device *dev)
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
