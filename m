From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Mon, 3 Mar 2008 10:42:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803031023550.3611-100000__457.435209728096$1204559149$gmane$org@iolanthe.rowland.org>
References: <20080303120842.GA28369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080303120842.GA28369@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Mar 2008, Pavel Machek wrote:

> Hi!
> 
> > > Alan thinks that `subj` is correct...
> > 
> > More precisely, reads and writes of pointers are always atomic.  That 
> > is, if a write and a read occur concurrently, it is guaranteed that the 
> > read will obtain either the old or the new value of the pointer, never 
> > a mish-mash of the two.  If this were not so then RCU wouldn't work.

Right, Paul?

> Ok, so linux actually atomicity of long?
> 
> If so, this should probably be applied...
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
> index 4ef2450..0a7d180 100644
> --- a/Documentation/atomic_ops.txt
> +++ b/Documentation/atomic_ops.txt
> @@ -21,6 +21,9 @@ local_t is very similar to atomic_t. If 
>  updated by one CPU, local_t is probably more appropriate. Please see
>  Documentation/local_ops.txt for the semantics of local_t.
>  
> +long (and int and void *) can be used instead of atomic_t, if all you
> +need is atomic setting and atomic reading.
> +
>  The first operations to implement for atomic_t's are the initializers and
>  plain reads.

Yes indeed.  This fact doesn't seem to be documented anywhere, but it 
is clearly a requirement of the kernel.  I would make the text a little 
more explicit, see below.

Alan Stern

-------------------------------------------------------


Atomicity of reads of write for pointers and integral types (other than 
long long) should be documented.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/Documentation/atomic_ops.txt
===================================================================
--- usb-2.6.orig/Documentation/atomic_ops.txt
+++ usb-2.6/Documentation/atomic_ops.txt
@@ -21,6 +21,21 @@ local_t is very similar to atomic_t. If 
 updated by one CPU, local_t is probably more appropriate. Please see
 Documentation/local_ops.txt for the semantics of local_t.
 
+For all properly-aligned pointer and integral types other than long
+long, the kernel requires simple reads and writes to be atomic with
+respect to each other.  That is, if one CPU reads a pointer value at
+the same time as another CPU overwrites the pointer, it is guaranteed
+that the reader will obtain either the old or the new value of the
+pointer, never some mish-mash combination of the two.  Likewise, if
+one CPU writes a long value at the same time as another CPU does, it
+is guaranteed that one or the other of the values will end up stored
+in memory, not some mish-mash combination of bits.
+
+Thus, if all you need is atomicity of reading and writing then you can
+use plain old ints, longs, or pointers; you don't need to use
+atomic_t.  (But note: This guarantee emphatically does not apply to
+long long values or unaligned values!)
+
 The first operations to implement for atomic_t's are the initializers and
 plain reads.
 
