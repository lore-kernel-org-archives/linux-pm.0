From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: Re: [PATCH v2] hwmon: tmp102: add hibernation callbacks
Date: Tue, 3 Feb 2015 19:59:09 +0200
Message-ID: <CAO5CWPLiqwM3nE0LqhPUdH5MoYWRahk9qn2sFjTjXvoKx-+nuA@mail.gmail.com>
References: <1422975718-871-1-git-send-email-grygorii.strashko@linaro.org>
	<20150203174519.GA31926@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:56137 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965829AbbBCR7K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 12:59:10 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so53700483lab.6
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 09:59:09 -0800 (PST)
In-Reply-To: <20150203174519.GA31926@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, Sumit Semwal <sumit.semwal@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On 3 February 2015 at 19:45, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Feb 03, 2015 at 05:01:58PM +0200, grygorii.strashko@linaro.org wrote:
>> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>
>> Setting a dev_pm_ops suspend/resume pair but not a set of
>> hibernation functions means those pm functions will not be
>> called upon hibernation.
>> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
>> assigns the suspend and hibernation handlers and move
>> mp102_suspend/tmp102_resume under CONFIG_PM_SLEEP to avoid
>> build warnings.
>>
>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>
> Applied to -next.


Thanks

-- 
Best regards,
-grygorii
