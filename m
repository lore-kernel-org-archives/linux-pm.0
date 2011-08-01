From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] Commit
	02c24a82187d5a628c68edfe71ae60dc135cd178 breaks s2disk
Date: Tue, 2 Aug 2011 01:47:00 +0200
Message-ID: <201108020147.01136.rjw__32625.7182787687$1312243825$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Josef Bacik <josef@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi,

Unfortunately s2disk (which is a user space tool for saving hibernate images)
doesn't work any more after your commit 02c24a82187d5a628c68edfe71ae60dc135cd178
(fs: push i_mutex and filemap_write_and_wait down into ->fsync() handlers).
The symptom is that the s2disk's resume counterpart cannot find the image in
the device even though s2disk considers it as successfully saved.

What happens is that s2disk opens a block device (disk partition to be precise)
directly and writes to it eventually calling fsync().  My interpretation of the
failure is that before commit 02c24a82187d5a628c68ed, when s2disk called fsync()
the VFS layer would run filemap_write_and_wait_range() that in turn would cause
the data to go to the disk, but after that commit this doesn't happen any more.

If I'm right, then not only s2disk, but any process writing directly to a block
device will have a problem with fsync().

Thanks,
Rafael
