From: jfannin@gmail.com (Joseph Fannin)
Subject: Re: Hibernating To Swap Considered Harmful
Date: Fri, 13 Jul 2007 02:20:39 -0400
Message-ID: <20070713062039.GA29055__11361.7118950517$1184307700$gmane$org@nineveh.local>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707121453.49616.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121150460.25614@asgard.lang.hm>
	<200707122134.29991.rjw@sisk.pl>
	<Pine.LNX.4.64.0707121953440.25614@asgard.lang.hm>
	<20070713054244.GA20082@nineveh.local>
	<Pine.LNX.4.64.0707122250170.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707122250170.25614@asgard.lang.hm>
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
Cc: linux-kernel@vger.kernel.org, Joseph Fannin <jfannin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 12, 2007 at 10:57:04PM -0700, david@lang.hm wrote:
> On Fri, 13 Jul 2007, Joseph Fannin wrote:
>
> the only justification I have heard for why the hibernate image must be
> written to the swap partition is backwards compatibility (i.e., we've
> always done it that way)
>
> if you are going to reserve disk space for hibernation, what is so bad
> about useing a normal partition?
>
    You have to either repartition when you upgrade your memory, or
waste a bunch of disk space with a partition as large as you think
your RAM might ever expand to.

    Swap/hibernate files can be created, deleted, and resized without
partitioning.

    Also: not all platforms support a large number of partitions.
It's not academic -- Intel Macintoshes are limited to four, with two
taken by Mac OS.  Add Windows and a Linux /, and you're out --
there's no room for a swap file.

--
Joseph Fannin
jfannin@gmail.com
