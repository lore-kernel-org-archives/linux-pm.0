From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq policy
Date: Mon, 2 May 2016 20:35:39 +0530
Message-ID: <20160502150538.GJ2855@vireshk-i7>
References: <CANMsd00DqTiTQEM3HxEvY3Qyo9cBpAHV83BjVpXKcq4gE0B96Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34731 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbcEBPFr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 11:05:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id y69so79551747pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 02 May 2016 08:05:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANMsd00DqTiTQEM3HxEvY3Qyo9cBpAHV83BjVpXKcq4gE0B96Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org

On 02-05-16, 19:15, Ryan wrote:
> Hi,
> 
> How can i change the governor at runtime or run at a specific
> frequency while doing an operation.
> For example i might want the cpu not to scale down during specific
> operations in the driver.

https://www.kernel.org/doc/Documentation/cpu-freq/

Please read this.. It has all the information you need. In short, you
have a bunch of files present in
/sys/devices/system/cpu/cpuX/cpufreq/, which are useful for your case.

-- 
viresh
