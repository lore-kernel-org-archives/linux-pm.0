From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: System will not suspend with highest numbered CPU offline
 [REGRESSION][BISECTED]
Date: Sat, 5 Sep 2015 13:44:07 +0530
Message-ID: <20150905081407.GK5285@linux>
References: <001401d0e691$302127b0$90637710$@net>
 <3237049.urJsZkC6Rf@vostro.rjw.lan>
 <20150904144241.GJ29194@linux>
 <000701d0e741$5933c580$0b9b5080$@net>
 <CAJZ5v0iqX+Sh6rDNKW+Nm2hNnEnC7uvzhZ6ta9Qxc3Rs2CZPJg@mail.gmail.com>
 <000e01d0e766$2f07dfb0$8d179f10$@net>
 <CAJZ5v0gvq5KF9jZobHFkXiAe=WfN=B=oSVt7o2ui-Wdx7_8Umg@mail.gmail.com>
 <000f01d0e783$6fe75cf0$4fb616d0$@net>
 <001601d0e7af$01a22140$04e663c0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34197 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbbIEIOM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Sep 2015 04:14:12 -0400
Received: by padhy16 with SMTP id hy16so43802843pad.1
        for <linux-pm@vger.kernel.org>; Sat, 05 Sep 2015 01:14:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <001601d0e7af$01a22140$04e663c0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On 05-09-15, 00:46, Doug Smythies wrote:
> > It is not clear to me why that echo line (there is only one)
> > would fail.

To me it is clear now :)

> The echo line fails because the related CPU is offline.
> If the failed echo is the last pass through the loop,
> then the script interprets the overall execution of
> 94cpufreq as a failure and aborts the suspend. If the
> failed echo is not the last pass through the loop, then
> the bad exit code gets overwritten with a good one before
> the loop exits.
> 
> Since the loop is merely setting a temporary governor,
> to test I just used performance mode anyway, and commented
> out the echo. pm-suspend with CPU 7 offline then worked fine.
> 
> I have not yet gone back to any before the patch kernel
> to determine why it used to work (it is late in my time zone).
> However, I would have to assume that before the commit in
> question, the echo worked even if the CPU was offline.

So here is the story behind it.
- In your system all CPUs are independent, that is there are no links
  to cpufreq directory, so that check in the script is useless for
  you.
- The $COMMIT in question did a significant change. Earlier, while
  offlining the CPU, we used to remove the cpufreq directory from
  sysfs, which is not the case any more.

- So to be precise, following lines came to your rescue earlier:

# if we do not have a scaling_governor file, skip.
# [ -f "$gov" ] || continue

- But they don't after the patch, as the file and directory are
  present even if the CPU is offline.
- But because the CPU is offline, writing to those files isn't allowed
  and so the echo failed.

Solution to that is that we check for CPU offline as well in the
beginning of the script, and skip if the CPU is offline.

-- 
viresh
