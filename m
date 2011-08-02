From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Regression] Commit
 02c24a82187d5a628c68edfe71ae60dc135cd178 breaks s2disk
Date: Mon, 1 Aug 2011 15:22:02 -1000
Message-ID: <CA+55aFxPAowBwgK7JqN0uH-ytvg+BKdE3yBGF0z_6kNDNcOYcQ__22486.5485368811$1312248206$gmane$org@mail.gmail.com>
References: <201108020147.01136.rjw@sisk.pl> <201108020217.48952.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108020217.48952.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Josef Bacik <josef@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 1, 2011 at 2:17 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Well, I'm not sure if the patch below is the right fix, but it evidently makes
> s2disk work for me again.

Looks right to me.

The only issue is whether we should use "db_mapping->i_mapping" or
"file->f_mapping". I think they are the same for block devices.

Al?

Also, what about some of the other fsync things that apparently
weren't updated to write back page caches. ps3flash_fsync? Others?

                Linus
