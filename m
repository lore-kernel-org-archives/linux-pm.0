From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC v2 0/7] PM / devfreq: draft for OPP suspend impl (even
 draftier)
Date: Mon, 19 Dec 2016 20:18:19 +0900
Message-ID: <5857C1FB.2040101@samsung.com>
References: <CGME20161219021836epcas1p37f8c12ca0bc7a404fc206f81331811bb@epcas1p3.samsung.com>
 <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36702 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbcLSLSW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 06:18:22 -0500
In-reply-to: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com

Hi Tobias,

On 2016년 12월 19일 11:16, Tobias Jakobi wrote:
> Hello everyone,
> 
> this is v2 of the RFC. You can find the first version here:
> https://www.spinics.net/lists/linux-samsung-soc/msg56331.html
> 
> I'm still unhappy with this approach, for multiple reasons:
> - the global boolean -- cpufreq also has it, but I have the feeling that we don't need it here.

> - keeping track of which device was suspended looks convoluted -- some reference counting would definitely help here.
> - the bus driver (here exynos_bus) sets suspend_freq, but devfreq core actually uses it.
> - returning -EBUSY from devfreq_{suspend,resume}_device() requires handling this in the device drivers -- again refcounting could solve this.
> - rather a question: do we need the restore on resume -- or should be just wait for the next update through the governor?
> - like Chanwoo already suggested, move setting suspend freq to devfreq_suspend_device().

I want to separate the two subject as following:
- subject1 : Where should devfreq set the suspend-freq for device.
- subject2 : How can devfreq support the duplicate call of devfreq_{suspend,resume}_device().

For subject1:
I explain why devfreq need to set the supend-freq in devfreq_suspend_device().
Following explanation do not include the refcount of suspend and bit operation.

The devfreq has two case to enter the suspend mode for devfreq instance as following:
case 1. Some device driver call the 'devfreq_suspend/resume_device()' directly regardless the sequence of suspend mode (echo mem > /sys/power/state).
case 2. The system enter the suspend mode by using 'echo mem > /sys/power/state' command.

When setting suspend frequency in the devfreq_suspend/resume_device(),
this suggestion can cover all cases for suspend freq setting.

I make the separate function[1] to set the frequency.
[1] https://git.kernel.org/cgit/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-test&id=8851e989ccaf0ee23a4278724227e879f8752625

	devfreq_suspend_device(struct devfreq *devfreq) {
		/* Enter the suspend mode */
		devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_SUSPEND, NULL);

		/* Set the suspend-freq */
		devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
	}

	devfreq_resume_device(struct devfreq *devfreq) {
		/* Set the resume freq */
		devfreq_set_target(devfreq, devfreq->resume_freq, 0);

		/* Wakeup from suspend mode */
		devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_RESUME, NULL);
	}

And,
devfreq_suspend() call the devfreq_suspend_device() for all registered devfreq instance.

	void devfreq_suspend(void)
	{
		mutex_lock(&devfreq_list_lock);

		list_for_each_entry(devfreq, &devfreq_list, node) {
			ret = devfreq_suspend_device(devfreq);
			if (ret < 0)
				dev_warn(&devfreq->dev, "%s: governor suspend failed\n", __func__);
		}

		mutex_unlock(&devfreq_list_lock);
	}

	void devfreq_resume(void)
	{
		mutex_lock(&devfreq_list_lock);

		list_for_each_entry(devfreq, &devfreq_list, node) {
			ret = devfreq_resume_device(devfreq);
			if (ret < 0)
				dev_warn(&devfreq->dev, "%s: governor resume failed\n", __func__);
		}

		mutex_unlock(&devfreq_list_lock);
	}


For subject2:
- subject2 : How can devfreq support the duplicate call of devfreq_{suspend,resume}_device().
devfreq_{suspend,resume}_device() have to check whether devfreq device is already suspended or not
with refcount or enum devfreq_flag_bits.

If devfreq_{suspend,resume}_device() support it, devfreq_suspend/resume() don't need to consider duplicate call.

> 
> Concerning refcounting, I'm a bit unsure what we wanna count here? Usually we count usage. If usage goes from zero to one, we do something (alloc), and when it goes back from one to zero (free).
> If we keep the current semantics however we have to count number of suspends. That's kinda unintuitive if you ask me.
> 
> With best wishes,
> Tobias
> 
> Tobias Jakobi (7):
>   PM / devfreq: Replace 'stop_polling' boolean with flags
>   PM / devfreq: Track suspend state of DevFreq devices
>   PM / devfreq: Add DevFreq subsystem suspend/resume
>   PM / devfreq: Suspend subsystem on system suspend/hibernate
>   PM / devfreq: exynos-bus: add support for suspend OPP
>   ARM: dts: exynos4x12: add suspend OPP for DMC and leftbus
>   ARM: dts: exynos4x12: add suspend OPP for DMC and leftbus for Prime
> 
>  arch/arm/boot/dts/exynos4412-prime.dtsi |   2 +
>  arch/arm/boot/dts/exynos4x12.dtsi       |   2 +
>  drivers/base/power/main.c               |   3 +
>  drivers/devfreq/devfreq.c               | 170 ++++++++++++++++++++++++++++++--
>  drivers/devfreq/exynos-bus.c            |   8 ++
>  include/linux/devfreq.h                 |  14 ++-
>  6 files changed, 188 insertions(+), 11 deletions(-)
> 


-- 
Regards,
Chanwoo Choi
