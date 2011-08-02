From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [Regression] Commit
 02c24a82187d5a628c68edfe71ae60dc135cd178 breaks s2disk
Date: Tue, 2 Aug 2011 02:39:47 +0100
Message-ID: <20110802013947.GK2203__44681.510263081$1312249244$gmane$org@ZenIV.linux.org.uk>
References: <201108020147.01136.rjw@sisk.pl> <201108020217.48952.rjw@sisk.pl>
	<CA+55aFxPAowBwgK7JqN0uH-ytvg+BKdE3yBGF0z_6kNDNcOYcQ@mail.gmail.com>
	<20110802013027.GJ2203@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Josef Bacik <josef@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 02, 2011 at 02:30:27AM +0100, Al Viro wrote:

> Applied (in file->f_mapping variant; it is equal to bdev->bd_mapping,
> but what's wrong with using ->f_mapping here?)

BTW, I've put s-o-b: Rafael J. Wysocki <rjw@sisk.pl> in there.  Rafael,
do you have any problems with that?
