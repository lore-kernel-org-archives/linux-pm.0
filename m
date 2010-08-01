From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 16:12:12 -0700
Message-ID: <20100801161212.23a5d043__49776.6187218533$1280704375$gmane$org@infradead.org>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org> <201008020102.24674.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008020102.24674.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Mon, 2 Aug 2010 01:02:24 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> Generally speaking, you can divide applications into the ones that
> will be allowed to influence ths system's behavior with respect to
> power management and the others that won't be allowed to do it.  The
> latter may be forcibly "frozen" (this way or another) when the
> "trused" ones collectively decide it's a good idea to enter a deeper
> "energy saving" state.  However, it is not a given that specific
> applications will always be in the same group.  They may be "trusted"
> on some systems and they may not be "trusted" on some other system,
> depending on the configuration etc.  That even may change over time
> on the same system.
> 

it might even be a sliding scale; the voting rights don't have to be
"0" and "1", but could also be "0.2" and such.... 
