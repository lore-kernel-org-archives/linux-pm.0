From: Christoph Hellwig <hch@infradead.org>
Subject: Re: PM / hibernate xfs lock up / xfs_reclaim_inodes_ag
Date: Wed, 27 Jul 2011 06:33:08 -0400
Message-ID: <20110727103308.GA20805@infradead.org>
References: <4E1C70AD.1010101@u-club.de> <201107262228.12099.rjw@sisk.pl>
	<20110727004543.GE8048@dastard> <201107271135.13297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201107271135.13297.rjw@sisk.pl>
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
Cc: Christoph <cr2005@u-club.de>, Dave Chinner <david@fromorbit.com>, xfs@oss.sgi.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 27, 2011 at 11:35:13AM +0200, Rafael J. Wysocki wrote:
> The Pavel's objection, if I remember it correctly, was that some
> (or the majority of?) filesystems didn't implement the freezing operation,
> so they would be more vulnerable to data loss in case of a failing hibernation
> after this change.  However, that's better than actively causing pain to XFS
> users.

The objection never made sense and only means he never read the code.
freeze_super (or freeze_bdev back then) always does a sync_filesystem
before even checking if we have a freeze method, and sync_filesystem is
what we iterate over for each superblock in sync().
