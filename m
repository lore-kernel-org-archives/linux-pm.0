From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch] Re: using long instead of atomic_t when only
 set/read is required
Date: Mon, 3 Mar 2008 12:11:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803031207120.3611-100000__40313.1521693014$1204564451$gmane$org@iolanthe.rowland.org>
References: <20080303155330.39e45ad4@core>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080303155330.39e45ad4@core>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Mar 2008, Alan Cox wrote:

> > Atomicity of reads of write for pointers and integral types (other than 
> > long long) should be documented.
> 
> NAK.
> 
> Atomicity of reads or writes for pointers and integral types is NOT
> guaranteed. Gcc doesn't believe in your guarantee.

Miscommunication and lack of clarity.  CPU reads and writes _are_ 
guaranteed to be atomic.  What is not guaranteed is that the compiler 
will generate a single read or write instruction corresponding to a 
particular expression in C.

Consider a routine like the following:

	static task_struct *the_task;

	void store_task(void)
	{
		the_task = current;
	}

Is it possible to say whether readers examining "the_task" are 
guaranteed to see a coherent value?

Alan Stern		
