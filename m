From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely
 since 4.6
Date: Tue, 11 Apr 2017 17:42:15 +0100
Message-ID: <20170411164214.tqcvxkqm6exd6ilw@techsingularity.net>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>
 <CAJZ5v0jXGtZwx5m72fkFwjU6PTnv8uak+G4j1T9LK-kUgzr28Q@mail.gmail.com>
 <004801d2b2da$0c65d2a0$253177e0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <004801d2b2da$0c65d2a0$253177e0$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?iso-8859-15?Q?'J=F6rg?= Otte' <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 11, 2017 at 08:41:09AM -0700, Doug Smythies wrote:
> On 2017.04.11 03:03 Mel Gorman wrote:
> >On Mon, Apr 10, 2017 at 10:51:38PM +0200, Rafael J. Wysocki wrote:
> >> On Mon, Apr 10, 2017 at 10:41 AM, Mel Gorman wrote:
> >>>
> >>> It's far more obvious when looking at the git test suite and the length
> >>> of time it takes to run. This is a shellscript and git intensive workload
> >>> whose CPU utilisatiion is very low but is less sensitive to multiple
> >>> factors than netperf and sockperf.
> >> 
> 
> I would like to repeat your tests on my test computer (i7-2600K).
> I am not familiar with, and have not been able to find,
> "the git test suite" shellscript. Could you point me to it?
> 

If you want to use git source directly do a checkout from
https://github.com/git/git and build it. The core "benchmark" is make
test and timing it.

The way I'm doing it is via mmtests so

git clone https://github.com/gormanm/mmtests
cd mmtests
./run-mmtests --no-monitor --config configs/config-global-dhp__workload_shellscripts test-run-1
cd work/log
../../compare-kernels.sh | less

and it'll generate a similar report to what I posted in this email
thread. If you do multiple tests with different kernels then change the
name of "test-run-1" to preserve the old data. compare-kernel.sh will
compare whatever results you have.

Thanks for taking a look.

-- 
Mel Gorman
SUSE Labs
