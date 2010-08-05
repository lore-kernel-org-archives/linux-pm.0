From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 02:15:13 +0200
Message-ID: <201008050215.14319.rjw__28201.1781972416$1280967444$gmane$org@sisk.pl>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
	<201008050133.01169.rjw@sisk.pl>
	<alpine.DEB.2.00.1008041650470.6545@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008041650470.6545@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 05, 2010, david@lang.hm wrote:
> On Thu, 5 Aug 2010, Rafael J. Wysocki wrote:
> 
> > On Thursday, August 05, 2010, david@lang.hm wrote:
> >>
> >> My proposal would never freeze a subset of processes.
> >>
> >> what my proposal:
> >>
> >> only consider the activity of a subset of processes when deciding if we
> >> should suspend or not. If the decision is to suspend, freeze everything.
> >
> > That alone doesn't allow you to handle the race Matthew was referring to
> > (ie. wakeup event happening right after you've decided to suspend).
> >
> > A mechanism of making a decision alone is not sufficient, you also need a
> > mechanism to avoid races between wakeup events and suspend process.
> >
> 
> I thought you just posted that there was a new feature that would be able 
> to abort the suspend and so that race was closed.

Yes, you can use that for this purpose, but then you'd need a user space
power manager who would decide whether or not to suspend.  Then, however,
the problem boils down to setting up appropriate communication between the
power manager and the other applications in user space (ie. the kernel
doesn't need to be involved in that at all).

Thanks,
Rafael
