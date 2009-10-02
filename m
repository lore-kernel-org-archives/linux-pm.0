From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 01/19] freezer: don't get over-anxious while
	waiting
Date: Fri, 02 Oct 2009 19:56:33 +0900
Message-ID: <4AC5DC61.9060900@kernel.org>
References: <1254384558-1018-1-git-send-email-tj@kernel.org>
	<1254384558-1018-2-git-send-email-tj@kernel.org>
	<20091001183655.GA9995@atrey.karlin.mff.cuni.cz>
	<200910012304.00720.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910012304.00720.rjw@sisk.pl>
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
Cc: cl@linux-foundation.org, jeff@garzik.org, pm list <linux-pm@lists.linux-foundation.org>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, Oren Laadan <orenl@librato.com>, dhowells@redhat.com, jens.axboe@oracle.com, akpm@linux-foundation.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Hello, Pavel, Rafael.

Rafael J. Wysocki wrote:
> On Thursday 01 October 2009, Pavel Machek wrote:
>>> Freezing isn't exactly the most latency sensitive operation and
>>> there's no reason to burn cpu cycles and power waiting for it to
>>> complete.  msleep(10) instead of yield().  This should improve
>>> reliability of emergency hibernation.
>> i don't see how it improves reliability, but its probably ok.

It's about battery.  When emergency hibernation kicks in and something
is taking a while to freeze (usually nfs does this for me) burning
power waiting for it to finish is a pretty bad idea.

>> Well... for hibernation anyway. I can imagine cgroup users where
>> freeze is so fast that this matters. rjw cc-ed.		pavel
> 
> Thanks.  I'd like to hear from the cgroup freezer people about that.

Oh... didn't know that.  10ms sleeps really matter there?

-- 
tejun
