From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 01:18:15 -0400
Message-ID: <87wsx1ylig.fsf__45987.2380634353$1184563192$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707151915570.28934-100000@netrider.rowland.org>
	<Pine.LNX.4.64.0707151650090.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707151650090.25614@asgard.lang.hm>
	(david@lang.hm's message of "Sun\,
	15 Jul 2007 16\:53\:47 -0700 \(PDT\)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

david@lang.hm writes:

[snip]

>> Isn't is possible to avoid this problem by mounting an ext3 filesystem
>> as readonly ext2?  Provided the filesystem isn't dirty it should be
>> doable.  (And provided the filesystem doesn't use any ext3 extensions
>> that are incompatible with ext2.)

> from the last discussion I saw on the kernel mailing list, no. the act of
> mounting the ext3 filesystem as ext2 read-only will change it as the unsupported
> extentions get turned off (and I think the journal contents at least are lost as
> part of this)

The fact of the matter is that it really doesn't matter whether mounting
it read-only actually corrupts the data on disk or not.  Regardless, it
should not be done, because you are accessing a dirty filesystem that is
still in use, and consequently there are no guarantees that either the
metadata or the file contents are consistent.  It isn't necessary for
hibernation to be able to access mounted partitions anyway.

-- 
Jeremy Maitin-Shepard
