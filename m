From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix rounding of core_pct
Date: Wed, 11 Jun 2014 23:56:33 -0700
Message-ID: <00c401cf860b$73a81030$5af83090$@net>
References: <1402490012-19969-1-git-send-email-stratosk@semaphore.gr><009b01cf857a$d5032090$7f0961b0$@net><539862DB.9060905@semaphore.gr><00a001cf8586$24eb5c70$6ec21550$@net><CAJZ5v0hEFp8sQH3iB6SUeVVEmdYA6ZK1kvc9NM+7sbS-LTW6nQ@mail.gmail.com><00b401cf85bd$b4851f10$1d8f5d30$@net> <CAJZ5v0jPPkWCZBCTKazNJsK8m4aNB-1C6GKtUOmOUt+v_CV+WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta4.telus.net ([209.171.16.77]:51182 "EHLO cmta4.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbaFLG4g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jun 2014 02:56:36 -0400
In-Reply-To: <CAJZ5v0jPPkWCZBCTKazNJsK8m4aNB-1C6GKtUOmOUt+v_CV+WQ@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Stratos Karafotis' <stratosk@semaphore.gr>, linux-pm@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, dirk.j.brandewie@intel.com


On 2014.06.11 14:45 Rafael J. Wysocki wrote:
> On Wed, Jun 11, 2014 at 11:40 PM, Doug Smythies <dsmythies@telus.net> wrote:
>
>> Myself, I consider the issue of excessive deferred timer times to be a much higher priority (see my on-list e-mail from Monday). Correct me if I am wrong.
>> Even without the "excessive" part, and for a 250 Hz kernel, the current kick in point can be hit routinely, unduly biasing the CPU frequency downwards.
>> A random example (250 Hz kernel): 23% load at 25 Hertz load / sleep frequency for 300 total seconds.
>>
>> Duration histrogram:
>>
>> Occurrences duration (seconds)
>>      16 0.044
>>      39 0.024
>>      45 0.028
>>      46 0.016
>>      48 0.032
>>      61 0.036
>>     166 0.012
>>     198 0.020
>>    7166 0.040
>>
>> Where you can see that the majority of the time the duration is such that the code will force the CPU frequency downwards.
>> It runs at minimum pstate instead of maximum pstate where it should be.

> I see.
> What would you suggest to do to address this problem, then?

The above specific example can be solved by increasing the kick in factor from "sample_rate * 3" to something more.

As mentioned in my e-mail of Monday, I do not know how to proceed further with investigating the excessive deferral issue.

There are some ideas (I think originally from Dirk) that wouldn't involve "[PATCH 3/4] intel_pstate: add sample time scaling" at all, but so far they have had issues also. There is something I would like to try, but it will take at least a few days.

... Doug


