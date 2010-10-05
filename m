From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5] power: introduce library for
	device-specific OPPs
Date: Tue, 05 Oct 2010 13:50:14 -0700
Message-ID: <8739skpdo9.fsf__46159.8958740526$1286311880$gmane$org@deeprootsystems.com>
References: <1285933174-24053-1-git-send-email-nm@ti.com>
	<201010050036.23179.rjw@sisk.pl> <4CAB228C.7030902@ti.com>
	<201010052244.11403.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010052244.11403.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 5 Oct 2010 22:44:11 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Paul <paulmck@linux.vnet.ibm.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, October 05, 2010, Nishanth Menon wrote:
>> Rafael J. Wysocki had written, on 10/04/2010 05:36 PM, the following:
>> > On Friday, October 01, 2010, Nishanth Menon wrote:

[...]

>> > 
>> > I'm not really sure why so many mutexes are needed here.  I don't think you
>> > need a separate mutex in every struct device_opp object.  I'd just use
>> > dev_opp_list_lock for everything.
>> 
>> I did consider using  dev_opp_list_lock to lock everything *but* here is 
>> the contention:
>> 
>> dev_opp_list_lock locks modification for addition of domains device. 
>> This operation happens usually during init stage.
>> 
>> each domain device has multiple opps, new opps can be added, but the 
>> more often usage will probably be opp_enable and disable. domain are 
>> usually modifiable independent of each other - device_opp->lock provides 
>> device level lock allowing for each domain device opp list to be 
>> modified independent of each other. e.g. on thermal overage we may 
>> choose to lower mpu domain while a coprocessor driver in parallel might 
>> choose to disable co-processor domain in parallel.
>> 
>> Wondering why you'd like a single lock for all domains and restrict 
>> parallelization?
>
> Because of the simplicity, mostly.  If there's only a relatively short period
> when the lock will be contended for, that still is not too bad and it's much
> easier to get the synchronization right with just one lock for starters.

FWIW, I agree with Rafael

These are not going be highly contended locks, and the lock durations
are very short, so simplifying the locking is a big win for readability.

Kevin
