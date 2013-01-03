From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: Manage only online cpus
Date: Thu, 3 Jan 2013 09:02:22 +0530
Message-ID: <CAKohponGtLNBnWWX1miV3zjO4pJPumbWoPwoQ2+adCE5t2w5Dw@mail.gmail.com>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org>
	<CAKohpomfEHGrCdbZ-EakRN4=qF8epd5seX5TWRcErQj9BEFpNA@mail.gmail.com>
	<CAKohpomxCSVRXkvde-P6T3Ks=7Z8PX1NSjzFfvKsPYQXTScwRw@mail.gmail.com>
	<7569403.CvHy03LdiU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57975 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab3ACDcX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jan 2013 22:32:23 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13621104oag.5
        for <linux-pm@vger.kernel.org>; Wed, 02 Jan 2013 19:32:22 -0800 (PST)
In-Reply-To: <7569403.CvHy03LdiU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org

On 3 January 2013 06:43, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> BTW, i consider them as fixes and so would make sense to get them in next rc.
>> What do you think?
>
> Yes, if somebody tells me "yes, this fixes a problem for me".  Otherwise,
> I don't quite see the reason.

I don't know how much people test HOTPLUG, but there are clear bugs related
to hotplug of cpus on a multiple cpu system :)
