From: Florian Mickler <florian@mickler.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 07:34:00 +0200
Message-ID: <20100802073400.68a6edd7__28742.5739727498$1280727323$gmane$org@schatten.dmk.lab>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
	<20100802030304.GU2470@linux.vnet.ibm.com>
	<20100801210548.23f77ff6@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100801210548.23f77ff6@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

Hi,

On Sun, 1 Aug 2010 21:05:48 -0700
Arjan van de Ven <arjan@infradead.org> wrote:

> I'm a little worried that this whole "I need to block suspend" is
> temporary. Yes today there is silicon from ARM and Intel where suspend
> is a heavy operation, yet at the same time it's not all THAT heavy
> anymore.... at least on the Intel side it's good enough to use pretty
> much all the time (when the screen is off for now, but that's a memory
> controller issue more than anything else). I'm pretty sure the ARM guys
> will not be far behind.

I think that the only thing that really matters (longterm) with suspend
is that processes don't get scheduled anymore when the system is
suspended.

Cheers,
Flo
