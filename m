From: Pavel Machek <pavel@ucw.cz>
Subject: [patch] Re: using long instead of atomic_t when only
	set/read is	required
Date: Mon, 3 Mar 2008 13:08:42 +0100
Message-ID: <20080303120842.GA28369__26862.0084076703$1204555759$gmane$org@elf.ucw.cz>
References: <20080225090316.GA420@elf.ucw.cz>
	<Pine.LNX.4.44L0.0802250943410.3549-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802250943410.3549-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@osdl.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Alan thinks that `subj` is correct...
> 
> More precisely, reads and writes of pointers are always atomic.  That 
> is, if a write and a read occur concurrently, it is guaranteed that the 
> read will obtain either the old or the new value of the pointer, never 
> a mish-mash of the two.  If this were not so then RCU wouldn't work.

Ok, so linux actually atomicity of long?

If so, this should probably be applied...

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
index 4ef2450..0a7d180 100644
--- a/Documentation/atomic_ops.txt
+++ b/Documentation/atomic_ops.txt
@@ -21,6 +21,9 @@ local_t is very similar to atomic_t. If 
 updated by one CPU, local_t is probably more appropriate. Please see
 Documentation/local_ops.txt for the semantics of local_t.
 
+long (and int and void *) can be used instead of atomic_t, if all you
+need is atomic setting and atomic reading.
+
 The first operations to implement for atomic_t's are the initializers and
 plain reads.
 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
