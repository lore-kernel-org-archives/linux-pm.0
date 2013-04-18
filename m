From: Alex Shi <alex.shi@intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 13:24:51 +0800
Message-ID: <516F83A3.9050401@intel.com>
References: <516CFA57.3060709@intel.com> <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com> <516F42EE.6080802@intel.com> <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com> <CAKohpon6t9kruo7=Zbn3Zf8Vin-k-FJd4ymzCi_ZJykR9YiuPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25325 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab3DRFZ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Apr 2013 01:25:29 -0400
In-Reply-To: <CAKohpon6t9kruo7=Zbn3Zf8Vin-k-FJd4ymzCi_ZJykR9YiuPQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 04/18/2013 12:36 PM, Viresh Kumar wrote:
>>> >> Wihtout your patch
>>> >> [alexs@lkp-sb01 ~]$ cat /sys/.../cpu*/cpufreq/scaling_cur_freq
>>> >> 2201000
>>> >> 2201000
>>> >> 2201000
>>> >> 2201000
>>> >> 2201000
>>> >> 2201000
>>> >> 2201000
>>> >> 2201000
>> >
>> > I think something wrong is happening without my patch as setting
>> > related_cpus alone was wrong.
> BTW, it looks many of your cpus are staying at higher or max freq and
> that's why you are getting better values. And this happened unintentionally
> due to a bug in setting related_cpus which my patch fixed.


Anyway, that make 'ondemand' governor get quite better performance and
perf/watt. :)

-- 
Thanks Alex
