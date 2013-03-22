From: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Subject: Re: [PATCH 2/2] PM / devfreq: tie suspend/resume to runtime-pm
Date: Fri, 22 Mar 2013 14:35:07 +0530
Message-ID: <CA+Z25wXYprpAOChV2P1vfbTgUyd7Te5s3RCmTLLaez6qiTx5GA@mail.gmail.com>
References: <1363872506-3630-3-git-send-email-rajagopal.venkat@linaro.org>
	<Pine.LNX.4.44L0.1303211101530.1899-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:64186 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350Ab3CVJFI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 05:05:08 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so3702699obb.23
        for <linux-pm@vger.kernel.org>; Fri, 22 Mar 2013 02:05:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1303211101530.1899-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: myungjoo.ham@samsung.com, rjw@sisk.pl, Kevin Hilman <khilman@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 21 March 2013 20:32, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 21 Mar 2013, Rajagopal Venkat wrote:
>
>> Allow device devfreq to be suspend/resume automatically with
>> runtime pm suspend/resume. The devfreq drivers should be least
>> cared when to suspend/resume the devfreq.
>>
>> pm_runtime_suspend(dev) will first suspend device devfreq(if available)
>> before device is suspended from runtime pm core.
>>
>> pm_runtime_resume(dev) will resume device devfreq(if available) after
>> device is resumed from runtime pm core.
>
> Aren't these backward?  The device continues to need its clocks and
> frequency settings until _after_ it has been suspended.  Similarly, it
> needs them to be available _before_ it resumes.
>

To clarify, devfreq suspend/resume means suspend/resume of load
monitoring of a device. The clocks and other resources are still taken
care by the devfreq driver runtime-pm callbacks. The devfreq must be
suspended _before_ runtime-pm suspend callback in order to stop load
monitoring while device is suspending. Similarly devfreq resume should
happen _after_ runtime-pm resume callback.

Just realised both devfreq suspend/resume are done _before_ invoking
runtime-pm callbacks. I will fix this up. Thanks.


> Alan Stern
>



-- 
Regards,
Rajagopal
