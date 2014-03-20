From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC] PM / Hibernate: no kernel_power_off when pm_power_off NULL
Date: Thu, 20 Mar 2014 14:36:31 -0700
Message-ID: <CADHgK6uXg0CXZC5s5Z5Kpy6dYH58UChL-p9ozCCcoUU=-0KJYw@mail.gmail.com>
References: <1395348795-8554-1-git-send-email-sebastian.capella@linaro.org>
	<1395348795-8554-2-git-send-email-sebastian.capella@linaro.org>
	<20140320212336.GA17368@amd.pavel.ucw.cz>
	<20140320213502.795a5d3c@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:64860 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759890AbaCTVgc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Mar 2014 17:36:32 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so1006225wes.8
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2014 14:36:31 -0700 (PDT)
In-Reply-To: <20140320213502.795a5d3c@alan.etchedpixels.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Thanks Pavel and Alan for your comments!

I'll rework and try again.

Sebastian

On 20 March 2014 14:35, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:
>>       if (pm_power_off)
>>                 pm_power_off();
>> }
>>
>> ## It really should do while (1) here.
>
>         while(1)
>                 cpu_relax();
>
> or similar at minimum.
>
> Alan
