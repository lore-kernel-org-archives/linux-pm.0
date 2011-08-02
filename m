From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [Regression] Commit
 02c24a82187d5a628c68edfe71ae60dc135cd178 breaks s2disk
Date: Tue, 2 Aug 2011 02:30:27 +0100
Message-ID: <20110802013027.GJ2203__48288.6196150959$1312248681$gmane$org@ZenIV.linux.org.uk>
References: <201108020147.01136.rjw@sisk.pl> <201108020217.48952.rjw@sisk.pl>
	<CA+55aFxPAowBwgK7JqN0uH-ytvg+BKdE3yBGF0z_6kNDNcOYcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxPAowBwgK7JqN0uH-ytvg+BKdE3yBGF0z_6kNDNcOYcQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Josef Bacik <josef@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 01, 2011 at 03:22:02PM -1000, Linus Torvalds wrote:
> On Mon, Aug 1, 2011 at 2:17 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > Well, I'm not sure if the patch below is the right fix, but it evidently makes
> > s2disk work for me again.
> 
> Looks right to me.
> 
> The only issue is whether we should use "db_mapping->i_mapping" or
> "file->f_mapping". I think they are the same for block devices.
> 
> Al?

Applied (in file->f_mapping variant; it is equal to bdev->bd_mapping,
but what's wrong with using ->f_mapping here?)

> Also, what about some of the other fsync things that apparently
> weren't updated to write back page caches. ps3flash_fsync? Others?

ps3flash, IIRC, doesn't go through page cache on read and write...
If anything, we probably have instances that bother with pagecache
for no reason...
