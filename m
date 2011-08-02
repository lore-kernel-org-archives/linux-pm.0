From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Regression] Commit
 02c24a82187d5a628c68edfe71ae60dc135cd178 breaks s2disk
Date: Mon, 1 Aug 2011 15:38:27 -1000
Message-ID: <CA+55aFzSejw7tyTefSXT_uGz=iESWCH536FwWqaD87=bh2rDUA__37568.880551453$1312249171$gmane$org@mail.gmail.com>
References: <201108020147.01136.rjw@sisk.pl> <201108020217.48952.rjw@sisk.pl>
	<CA+55aFxPAowBwgK7JqN0uH-ytvg+BKdE3yBGF0z_6kNDNcOYcQ@mail.gmail.com>
	<20110802013027.GJ2203@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110802013027.GJ2203@ZenIV.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Josef Bacik <josef@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 1, 2011 at 3:30 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Applied (in file->f_mapping variant; it is equal to bdev->bd_mapping,
> but what's wrong with using ->f_mapping here?)

My only issue was that from a "mindless conversion" standpoint, most
of the other users had been changed to use inode->i_mapping.

I dunno why. I agree that file->f_mapping looks cleaner and is what
the code used to do. But maybe there was some reason why the other
fsync methods had been changed to use

  filemap_write_and_wait_range(inode->i_mapping, start, end);

instead.

           Linus
