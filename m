From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 0/2] cpufreq: ondemand: Eliminate the deadband effect
Date: Sat, 12 Jul 2014 08:45:09 -0700
Message-ID: <000001cf9de8$43925230$cab6f690$@net>
References: <1404147574-17422-1-git-send-email-stratosk@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta2.telus.net ([209.171.16.75]:56523 "EHLO cmta2.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbaGLPpL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 12 Jul 2014 11:45:11 -0400
In-Reply-To: <1404147574-17422-1-git-send-email-stratosk@semaphore.gr>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stratos Karafotis' <stratosk@semaphore.gr>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


On 2014.07.30 10:00 Stratos Karafotis wrote:

> This patchset changes slightly the calculation of target frequency to
> eliminate the deadband effect (explained in patch 2 changelog) that it
> seems to slow down the CPU in low and medium loads.
>
> Patch 1 introduces a new relation (RELATION_C) for the next frequency
> selection, which chooses the closest frequency to target.
>
> Patch 2 is the actual change to ondemand governor.

> You may find graphs with the 'deadband' effect and benchmark results:
> https://docs.google.com/spreadsheets/d/16kDBh5lyc6YvBnoS1hUa1t2O38z0xrWvaEj5XtJ8auw/edit#gid=2072493052

I did the same benchmark tests before (without) and after (with) this patch set on my i7-2600K system.
I added the results, which are similar to Stratos', under a new "benchmark" tab on the spreadsheet.

... Doug


