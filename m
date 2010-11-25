From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 3] PM: add synchronous runtime interface
	for interrupt handlers
Date: Thu, 25 Nov 2010 21:03:29 +0100
Message-ID: <201011252103.29401.rjw__38555.7297537618$1290715500$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1011251052010.22247-100000@netrider.rowland.org>
	<201011251958.49249.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011251958.49249.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Partha Basak <p-basak2@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, November 25, 2010, Oliver Neukum wrote:
> Am Donnerstag, 25. November 2010, 16:52:39 schrieb Alan Stern:
> > When a device is declared irq-safe in this way, the PM core increments
> > the parent's usage count, so the parent will never be runtime
> > suspended.  This prevents difficult situations in which an irq-safe
> > device can't resume because it is forced to wait for its non-irq-safe
> > parent.
> 
> Shouldn't you walk further up the tree if the parent itself is irq-safe?
> It seems like a waste of power to not suspend a paren, that can be
> woken in irq.

Then we should walk up the tree if the parent's parent is irq-safe and so
on, which would make us spend uncertain amount of time in the ISR (or generally
with interrupts off).  I think it's safer not to do that.

Thanks,
Rafael
