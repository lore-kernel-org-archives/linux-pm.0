From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 10:50:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006041042410.1794-100000__32001.3620461852$1275663121$gmane$org@iolanthe.rowland.org>
References: <20100604003934.GA5221@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100604003934.GA5221@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Jun 2010, Ingo Molnar wrote:

> Note that this does not necessarily have to be implemented as 'execute suspend 
> from the idle task' code: scheduling from the idle task, while can certainly 
> be made to work, is a somewhat recursive concept that we might want to avoid 
> for robustness reasons.
> 
> Instead, the 'deepest idle' (suspend) method could consist of a wakeup of a 
> kernel thread (or of any of the existing kernel threads such as the migration 
> thread) - which kernel thread then does a race-free suspend: it offlines all 
> but one CPU [on platforms that need that] and then initiates the suspend - but 
> aborts the attempt if there's any sign of wakeup activity.

Out of morbid curiosity...  A typical sign of wakeup activity is a
thread becoming runnable because of expiration of a kernel timer or an
I/O completion interrupt.  How would the "race-free suspend" thread
detect this sort of thing?  Indeed, isn't the inability to detect these 
part of what makes the existing suspend implementation (the freezer in 
particular) not race-free?

Alan Stern
