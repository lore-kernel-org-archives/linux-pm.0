From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Performance of low-cpu utilisation benchmark regressed severely since 4.6
Date: Tue, 11 Apr 2017 08:41:09 -0700
Message-ID: <004801d2b2da$0c65d2a0$253177e0$@net>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net> <CAJZ5v0jXGtZwx5m72fkFwjU6PTnv8uak+G4j1T9LK-kUgzr28Q@mail.gmail.com> xsd9cM4EBnsYHxsdFcKt0R
Mime-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: xsd9cM4EBnsYHxsdFcKt0R
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Mel Gorman' <mgorman@techsingularity.net>
Cc: 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?iso-8859-1?Q?'J=F6rg_Otte'?= <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2017.04.11 03:03 Mel Gorman wrote:
>On Mon, Apr 10, 2017 at 10:51:38PM +0200, Rafael J. Wysocki wrote:
>> On Mon, Apr 10, 2017 at 10:41 AM, Mel Gorman wrote:
>>>
>>> It's far more obvious when looking at the git test suite and the length
>>> of time it takes to run. This is a shellscript and git intensive workload
>>> whose CPU utilisatiion is very low but is less sensitive to multiple
>>> factors than netperf and sockperf.
>> 

I would like to repeat your tests on my test computer (i7-2600K).
I am not familiar with, and have not been able to find,
"the git test suite" shellscript. Could you point me to it?

... Doug
