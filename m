From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: Manage only online cpus
Date: Wed, 2 Jan 2013 11:59:57 +0530
Message-ID: <CAKohpomxCSVRXkvde-P6T3Ks=7Z8PX1NSjzFfvKsPYQXTScwRw@mail.gmail.com>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org>
	<4137114.myBUIQvsg3@vostro.rjw.lan>
	<CAKohpomfEHGrCdbZ-EakRN4=qF8epd5seX5TWRcErQj9BEFpNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:43737 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3ABG36 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jan 2013 01:29:58 -0500
Received: by mail-ob0-f172.google.com with SMTP id za17so12613147obc.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Jan 2013 22:29:58 -0800 (PST)
In-Reply-To: <CAKohpomfEHGrCdbZ-EakRN4=qF8epd5seX5TWRcErQj9BEFpNA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org

On 16 December 2012 19:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16 December 2012 18:34, Rafael J. Wysocki <rjw@sisk.pl> wrote:

>> Well, this series makes sense to me, but I'd like to hear what the other people
>> think.
>
> That sounds great :)
>
> Some more information for others about how i reached to these issues
> is present here:
>
> https://lkml.org/lkml/2012/12/10/44

Hmm.. I don't know, if we are going to get any feedback from others :(

BTW, i consider them as fixes and so would make sense to get them in next rc.
What do you think?

--
viresh
