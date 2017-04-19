From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Wed, 19 Apr 2017 10:52:06 +0530
Message-ID: <20170419052206.GA5436@vireshk-i7>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
 <20170417173431.GA10447@localhost.localdomain>
 <20170418103818.GQ28191@vireshk-i7>
 <3925c07c-1442-9e00-6f50-c4ae900ed834@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34089 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759562AbdDSFWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 01:22:11 -0400
Received: by mail-pg0-f48.google.com with SMTP id s64so7048117pgb.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2017 22:22:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3925c07c-1442-9e00-6f50-c4ae900ed834@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 18-04-17, 15:40, Lukasz Luba wrote:
> Hi Viresh,
> 
> I have checkout your branch at newest commit:
> 908063832c268f8add94
> I have built it and run it on my Juno r2.
> I have some python tests for IPA and I run one of them.
> 
> I seen a few issues so I have created a patch just
> to be able to run IPA.
> My next email will have the patch so you can see the changes.
> 
> IPA does not work with this patch set.
> I have tested two source codes from your repo:
> 1. your change 908063832c268f8add94
> 2. your base 8f506e0faf4e2a4a0bde9f9b1
> 
> In case 1. IPA does not work - temperature rises to 83degC
> in case 2. works - temperature is limited to 65degC.

Yeah, there were some cases power specific cases that weren't covered in my
tests and thanks a lot for testing it out. I have pushed my branch again and it
has all your fixes (a bit refined) in it.

> On Monday I can allocate more time for it.

My branch should just work now. Please see if you can allocate 10-15 min today
to give it a try, so that we can get it in earlier. I will send a V3 today and
your Tested-by would be very much appreciated.

Thanks Lukasz.

-- 
viresh
