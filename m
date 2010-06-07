From: Florian Mickler <florian@mickler.org>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 17:56:04 +0200
Message-ID: <20100607175604.4c8f1fa4__14400.7758856334$1275926254$gmane$org@schatten.dmk.lab>
References: <20100606152946.GA11351@srcf.ucam.org>
	<Pine.LNX.4.44L0.1006061956510.4894-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006061956510.4894-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Felipe Balbi <felipe.balbi@nokia.com>, Peter@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Jun 2010 20:01:56 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> And since Android can reach essentially the same low-power
> state from idle as from suspend, it appears that they really don't need
> any kernel changes at all.

Well, perhaps a hint to the scheduler to fall through as fast as
possible into deepest idle?

> 
> Alan Stern
> 

Cheers,
Flo
