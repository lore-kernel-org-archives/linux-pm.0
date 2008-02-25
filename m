From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: using long instead of atomic_t when only set/read is
 required (was Re: [Bug 10030] Suspend doesn't work when SD card is
 inserted)
Date: Mon, 25 Feb 2008 09:46:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802250943410.3549-100000__48844.262926332$1203950981$gmane$org@iolanthe.rowland.org>
References: <20080225090316.GA420@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080225090316.GA420@elf.ucw.cz>
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
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, davem@davemloft.net, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Feb 2008, Pavel Machek wrote:

> Hi!
> 
> Alan thinks that `subj` is correct...

More precisely, reads and writes of pointers are always atomic.  That 
is, if a write and a read occur concurrently, it is guaranteed that the 
read will obtain either the old or the new value of the pointer, never 
a mish-mash of the two.  If this were not so then RCU wouldn't work.

> I guess it only works as long as longs are aligned? Should it be
> written down to atomic_ops.txt?

Forget it, I'm going to withdraw the entire thing.  The whole approach 
is wrong.  More details in a new email thread, to follow soon.

Alan Stern
