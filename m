From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Fri, 4 Sep 2015 08:26:20 -0700
Message-ID: <000301d0e726$0da7ab10$28f70130$@net>
References: <001401d0e691$302127b0$90637710$@net> <3237049.urJsZkC6Rf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta11.telus.net ([209.171.16.84]:47986 "EHLO cmta11.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759597AbbIDP0Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 11:26:24 -0400
In-Reply-To: <3237049.urJsZkC6Rf@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On 2015.09.04 08:00 Rafael J. Wysocki wrote:
> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
>> As of, or about, Kernel 4.2RC1 if I take my highest numbered
>> CPU offline (7 in my case), the system will not suspend.

> Does "will not suspend" mean that the suspend will fail with an error
> or will it crash or hang or something else?

Something else: Nothing at all happens, no error, no crash, no hang,
no log entries (at least that I have been able to find).
I use the "sudo pm-suspend" command, and it is as if it is a no-op.

doug@s15:/sys/devices/system/cpu$ cat /sys/devices/system/cpu/cpu*/online
1
1
1
1
1
1
0

Someone suggested to me that I have to take the core offline, not just
the 1 of 2 CPUs on the same core. However it makes no difference, and
CPU 3 offline by itself works fine.

>> The issue persists through Kernel 4.2.
>> This is on my test computer with an i7-2600K.
>> I do not normally use suspend on this computer,
>> but was doing so while working on a bug report.
>> 
>> The kernel was bisected, and the result was:
>> 
>> $ git bisect bad
>> 87549141d516aee71d511138e27117c41e8aef68 is the first bad commit
>> commit 87549141d516aee71d511138e27117c41e8aef68
>> Author: Viresh Kumar <viresh.kumar@linaro.org>
>> Date:   Wed Jun 10 02:13:21 2015 +0200
>> 
>> cpufreq: Stop migrating sysfs files on hotplug
>> 
>> See also several e-mails with the above subject line
>> between June 8th and 10th.
>> 
>> With any other combination of taking CPUs offline,
>> not including CPU 7, suspend seems to work properly.

> Well, we'll need to debug it some.
> Can you please check what's in the
> /sys/devices/system/cpu/cpuX/cpufreq/related_cpus
> files for all CPUs on your system?

doug@s15:/sys/devices/system/cpu$ cat cpu?/cpufreq/related_cpus
0
1
2
3
4
5
6
7


