From: corbet@lwn.net (Jonathan Corbet)
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 07:28:52 -0600
Message-ID: <10659.1190986132__23089.7048641511$1190993793$gmane$org@lwn.net>
References: <20070927235034.ae7bd73d.akpm@linux-foundation.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: Your message of "Thu, 27 Sep 2007 23:50:34 PDT."
	<20070927235034.ae7bd73d.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chakri n <chakriin5@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>, nfs@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org

Andrew wrote:
> It's unrelated to the actual value of dirty_thresh: if the machine fills up
> with dirty (or unstable) NFS pages then eventually new writers will block
> until that condition clears.
> 
> 2.4 doesn't have this problem at low levels of dirty data because 2.4
> VFS/MM doesn't account for NFS pages at all.

Is it really NFS-related?  I was trying to back up my 2.6.23-rc8 system
to an external USB drive the other day when something flaked and the
drive fell off the bus.  That, too, was sufficient to wedge the entire
system, even though the only thing which needed the dead drive was one
rsync process.  It's kind of a bummer to have to hit the reset button
after the failure of (what should be) a non-critical piece of hardware.

Not that I have a fix to propose...:)

jon
