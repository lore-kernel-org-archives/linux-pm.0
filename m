From: Christoph <cr2005@u-club.de>
Subject: Re: PM / hibernate xfs lock up / xfs_reclaim_inodes_ag
Date: Tue, 16 Aug 2011 14:38:44 +0200
Message-ID: <4E4A64D4.4000005__35004.0590078153$1313504874$gmane$org@u-club.de>
References: <4E1C70AD.1010101@u-club.de> <201107262228.12099.rjw@sisk.pl>
	<20110727004543.GE8048@dastard> <201107271135.13297.rjw@sisk.pl>
	<20110810214327.GA9320@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110810214327.GA9320@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Dave Chinner <david@fromorbit.com>, xfs@oss.sgi.com
List-Id: linux-pm@vger.kernel.org

On 10.08.2011 23:43, Pavel Machek wrote:
> Hi!
> 
>>>> Why don't you simply submit a patch to do that?
>>>
>>> a) I don't know how to test suspend/hibernate
>>> b) I don't have any hardware I can test it on.


Hi!

I do apologize fmy silence but I've been in a serious productions the last
weeks.

If there any patches to test, let me know. I can run some decent stress tests.

chris


> 
> hibernation should work on any hardware. Just add cmdline parameter
> resume=<your swap> and use echo disk > /sys/power/state.
> 
> suspend is supported on most PCs, and certainly on any notebook. Just
> echo mem > /sys/power/state.
> 									Pavel
