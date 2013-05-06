From: "myungjoo.ham" <myungjoo.ham@samsung.com>
Subject: RE: [PATCH V3] PM / devfreq: tie suspend/resume to runtime-pm
Date: Mon, 06 May 2013 20:42:14 +0900
Message-ID: <003601ce4a4e$c0bb54d0$4231fe70$@samsung.com>
References: <1366205301-4249-1-git-send-email-rajagopal.venkat@linaro.org>
 <8888976.pxWaKvWiK0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52498 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab3EFLmQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 07:42:16 -0400
In-reply-to: <8888976.pxWaKvWiK0@vostro.rjw.lan>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Rajagopal Venkat' <rajagopal.venkat@linaro.org>
Cc: 'Kevin Hilman' <khilman@linaro.org>, 'Alan Stern' <stern@rowland.harvard.edu>, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
> On Wednesday, April 17, 2013 06:58:21 PM Rajagopal Venkat wrote:
> > Devfreq core runtime suspend/resume of a device is explicitly handled 
> > by devfreq driver using devfreq_suspend_device() and
> > devfreq_resume_device() apis typically called from runtime 
> > suspend/resume callbacks. This patch aims to take away this from 
> > devfreq drivers and handle it from runtime-pm core. So that devfreq 
> > core runtime suspend/resume of a device is automatically done with 
> > runtime pm suspend/resume. The devfreq drivers shouldn't be concerned 
> > on when to suspend/resume the devfreq.
> 
> I agree, but perhaps there's a better way to achieve that than fumbling in the PM core?
> 
> Did you consider using a PM domain for that?

As genpd_add_device seems to allow a device to register multiple domains, it seems fine. We need to ensure that there is only one device for the devfreq domain though.

pm_domain seems to be an overkill; however, the excessive overhead seems to be there only for register/unregister and that seems acceptable.

> 
> > This patch is targeted to handle devfreq core load monitoring runtime 
> > suspend/resume only. Not the actual hardware itself.
> > All the resources like clocks and regulators must still be handled by 
> > device driver using runtime-pm. The sequence of devfreq and device 
> > runtime suspend/resume is,
> > 
> > pm_runtime_suspend(dev) will first suspend device devfreq (if 
> > available) before device is suspended to ensure devfreq load 
> > monitoring is stopped and no device resources like clocks are accessed 
> > while device suspend is in progress.
> > 
> > pm_runtime_resume(dev) will resume device devfreq(if available) after 
> > device is resumed to ensure device resources like clocks are ready for 
> > use.
> > 
> > As devfreq runtime suspend/resume is done automatically from runtime 
> > core, this patch removes the existing devfreq_suspend_device() and
> > devfreq_resume_device() apis.
> > 
> > Signed-off-by: Rajagopal Venkat <rajagopal.venkat@linaro.org>
> 
> I'm having a problem with this patch, because it's adding overhead into
> rpm_suspend() and rpm_resume() for all devices, even though many of them may not use devfreq.  Worse yet, there are systems in which devfreq will never be used at all.
> 
> Thanks,
> Rafael

I thought about having the polling loop to check if the device is running or not before getting usage statistics. But we still need something to notify resume.


> 
> 
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
>

Cheers,
MyungJoo


