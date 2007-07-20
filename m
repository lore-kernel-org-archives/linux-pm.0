From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 13:31:41 -0400
Message-ID: <87myxroubm.fsf@jbms.ath.cx>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707192228.05136.rjw@sisk.pl>
	<Pine.LNX.4.64.0707191542430.28721@asgard.lang.hm>
	<200707201317.58025.rjw@sisk.pl>
	<f29402c6050f9c3ff5d83a59cea2de58@bga.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f29402c6050f9c3ff5d83a59cea2de58@bga.com> (Milton Miller's
	message of "Fri\, 20 Jul 2007 11\:56\:43 -0500")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Milton Miller <miltonm@bga.com>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Milton Miller <miltonm@bga.com> writes:

[snip]

>>>> (7) how to avoid corrupting filesystems mounted by the hibernated kernel
>>> 
>>> I didn't realize this was a discussion item. I thought the options were
>>> clear, for some filesystem types you can mount them read-only, but for
>>> ext3 (and possilby other less common ones) you just plain cannot touch
>>> them.
>> 
>> That's correct.  And since you cannot thouch ext3, you need either to assume
>> that you won't touch filesystems at all, or to have a code to recognize the
>> filesystem you're dealing with.

> Or add a small bit of infrastructure that errors writes at make_request if you
> don't have a magic "i am a direct block device write from userspace" flag on the
> bio.

I still don't understand why there is this fixation on accessing dirty
filesystems in use by the hibernated system.  Even if you avoid
corrupting the filesystem by avoiding writing to the block device, there
isn't any real guarantee about the state of the data, except for a
filesystem that specifically makes guarantees about such data (and I
don't believe any of the existing ones do).

It isn't necessary to be able to access such filesystems: everything can
be done from an initramfs/initrd.

[snip]

-- 
Jeremy Maitin-Shepard
