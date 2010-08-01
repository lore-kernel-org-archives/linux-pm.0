From: David Brownell <david-b@pacbell.net>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 16:19:21 -0700 (PDT)
Message-ID: <85179.49541.qm__18618.4233673432$1280704810$gmane$org@web180301.mail.gq1.yahoo.com>
References: <201008020102.24674.rjw@sisk.pl>
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
To: Ted Ts'o <tytso@mit.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


> be "trusted" on some systems and they may not be "trusted"
> on some other
> system, depending on the configuration etc.

Yes, let's reserve "trusted" for security contexts.
One might view agressively bad power management as
a security threat, of course:  when the machine
becomes unavailable because its battery dies, that
can be viewed as a security attack, since keeping the machine available is the primary security goal.

Distinguish bugs from broken-by-design, too.

- Dave
