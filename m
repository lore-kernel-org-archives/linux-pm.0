From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: External devices
Date: Wed, 3 Sep 2014 23:23:17 +0300
Message-ID: <CAJ2oMhL=wuWA3Ga4bdeqvW0QA-cccLA0BfVRDKyLuykyChqu7w@mail.gmail.com>
References: <CAJ2oMhKRA+0Ge_m=-zFqgTxcZbuGMNAOvBQKP=_GyWRwvfsKFw@mail.gmail.com>
	<CAGAs2Amw1jvmDxL8+uXU4XW3u6Mxr7LKP4EiP8taTNQ2OpnWNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:57155 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126AbaICUXT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 16:23:19 -0400
Received: by mail-qg0-f45.google.com with SMTP id e89so8799320qgf.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 13:23:17 -0700 (PDT)
In-Reply-To: <CAGAs2Amw1jvmDxL8+uXU4XW3u6Mxr7LKP4EiP8taTNQ2OpnWNw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Cc: linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>

Hi Ayan,
Thanks very much for the explanations, it makes things a bit more
clearer than before, but I still have some question marks.

"System moving to idle state would correspond to most devices in  a
runtime-pm idle state. Each device enter into idle state when its
corresponding driver invokes so"

How does the driver invokes moving to idle state ?  Is it the smae as
invoking runtime suspend by the driver ?
What is the difference between idle state to runtime suspend ?
Are you familiar with any character device example for using PM ?

Thanks, Ran



On Wed, Sep 3, 2014 at 11:01 AM, AYAN KUMAR HALDER <ayankumarh@gmail.com> wrote:
>> 1. Are external devices can be integrated into the runtime
>> suspend/resume , or are they outside the subject of PM ? for example I
>> have external dsp connected to omap, can it be integrated to the PM ?
>> If it is controled through character device how can it be tailored
>> into the generic PM ?
>
> Any external device can be integrated in runtime-pm framework provided
> its device driver or subsystem driver has runtime pm operations
> (namely dev_pm_ops->.runtime_suspend/resume/idle).
>
> Runtime suspend/resume is called by your driver to suspend the
> respective device. It can do so by incrementing/decrementing the usage
> count via pm_runtime_get and pm_runtime_put or by directly calling
> pm_runtime_suspend/pm_request_resume.
> So your char device driver for omap has to enable runtime pm for the
> device by calling pm_runtime_set_active() and pm_runtime_enable() from
> its init/probe methods.
> Whenever the driver needs to wakeup the device(say on receiving a
> interrupt), it can call runtime_pm_get. After handling the interrupt,
> if the driver wants to suspend the device, it can call runtime_pm_put.
>
> My statements are generic as I am unaware how the dsp functions.
>
>> 2. When the system moves to idle does it then automatically call all
>> tuntime suspend of all devices ?
>>
> As I have mentioned in my previous reply that the runtime-pm is device
> specific(and not system specific). so each device driver calls its
> runtime suspend/resume for its corresponding devices whenever it feels
> so. The runtime-pm framework has some policies like it checks if the
> device to be suspended has any active children or not, etc
>
> System moving to idle state would correspond to most devices in  a
> runtime-pm idle state. Each device enter into idle state when its
> corresponding driver invokes so. Each device is independently moved to
> idle/suspend/resume state unless their exist a parent-child
> relationship between the devices.
>
> Runtime power management is different from system power management (ie
> suspend to RAM/Disk) in which the PM framework calls the suspend and
> resume of all the devices(sequentially). However, these suspend/resume
> functions are different from runtime suspend/resume functions.
> eg
> static const struct dev_pm_ops usb_device_pm_ops = {
>         .prepare =      usb_dev_prepare,
>         .complete =     usb_dev_complete,
>
> /* the following two functions are system power management's
> suspend/resume functions which are invoked by PM framework when the
> system suspends/hibernates.  */
>
>         .suspend =      usb_dev_suspend,
>         .resume =       usb_dev_resume,
>         .freeze =       usb_dev_freeze,
>         .thaw =         usb_dev_thaw,
>         .poweroff =     usb_dev_poweroff,
>         .restore =      usb_dev_restore,
> #ifdef CONFIG_USB_SUSPEND
> /* the following three functions are runtime power management's
> suspend/resume/idle functions invoked by the driver when it wants to
> put the corresponding device in suspend/idle/resume state.  */
>         .runtime_suspend =      usb_runtime_suspend,
>         .runtime_resume =       usb_runtime_resume,
>         .runtime_idle =         usb_runtime_idle,
> #endif
> };
>
> Regards,
> Ayan Kumar Halder
