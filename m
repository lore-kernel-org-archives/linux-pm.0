From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: 2.6.34-rc3-git6: Reported regressions from 2.6.33
Date: Thu, 8 Apr 2010 00:06:07 +0100
Message-ID: <20100407230607.GM30031__29628.7257261158$1270757127$gmane$org@ZenIV.linux.org.uk>
References: <6Pphclm24fK.A.lSF.qsPvLB@chimera>
	<alpine.LFD.2.00.1004071444440.3586@i5.linux-foundation.org>
	<20100407221941.GL30031@ZenIV.linux.org.uk>
	<alpine.LFD.2.00.1004071521500.3586@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004071521500.3586@i5.linux-foundation.org>
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
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 07, 2010 at 03:22:20PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 7 Apr 2010, Al Viro wrote:
> > 
> > No, it's not the same thing; the fix is to have nfs ->d_revalidate()
> > return an error on failing open attempt (in insane codepath that has
> > ->d_revalidate() handling open()).  Confirmed to work by reporter...
> 
> Ok, can you do the proper changelog description and sign-offs etc?

[PATCH] Have nfs ->d_revalidate() report errors properly

	If nfs atomic open implementation ends up doing open request from
->d_revalidate() codepath and gets an error from server, return that error
to caller explicitly and don't bother with lookup_instantiate_filp() at all.
->d_revalidate() can return an error itself just fine...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d79a7b3..fe0cd9e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2068,8 +2068,7 @@ nfs4_open_revalidate(struct inode *dir, struct dentry *dentry, int openflags, st
 			case -EDQUOT:
 			case -ENOSPC:
 			case -EROFS:
-				lookup_instantiate_filp(nd, (struct dentry *)state, NULL);
-				return 1;
+				return PTR_ERR(state);
 			default:
 				goto out_drop;
 		}
