From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/3] PM: More fine grained ACPI handling
	during suspend and hibernation (rev. 2)
Date: Mon, 27 Aug 2007 10:25:39 +0200
Message-ID: <20070827082539.GF2060__22615.8998710618$1188216557$gmane$org@elf.ucw.cz>
References: <200708270149.52585.rjw@sisk.pl> <200708270154.16797.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708270154.16797.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Mon 2007-08-27 01:54:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> According to the ACPI specification (eg. ACPI 2.0c, sec. 7.3.1, 7.3.3,
> ACPI 3.0b, sec. 7.3.1, 7.3.3) the _GTS and _BFS global control methods should
> be executed, respectively, right before entering a sleep state (S1-S4) and right
> after leaving it, but we don't follow this reqirement.  Namely, in our
> implementation the nonboot CPUs are disabled after executing _GTS and enabled
> before executing _BFS, which doesn't seem to be correct.  [In fact, the ACPI
> specification requires that no physical I/O and interrupt servicing be performed
> after the sleep state has been left and before _BFS is executed as well as after
> executing _GTS and before the sleep state is entered, but we can't follow this
> requirement literally, since our AML interpreter needs to run with interrupts
> enabled and we need to carry out some operations with interrupts disabled before
> entering the sleep state and after leaving it.]  Moreover, acpi_enable() called
> after restoring the system memory state from a hibernation image should really
> be executed before enabling the nonboot CPUs, since functional ACPI may be
> needed for that.  All of this means that we need to handle ACPI in a more fine
> grained manner during suspend and hibernation.
> 
> For this reason we can introduce new global platform callbacks prepare_late()
> and finish_early() to be executed, respectively, between disabling the nonboot
> CPUs and entering a sleep state and between leaving the sleep state and enabling
> the nonboot CPUs.  For ACPI systems they can be used to execute the _GTS and
> _BFS global control methods, respectively.
> 
> It also seems to be a good idea to introduce new hibernation-related callback
> post_snapshot() to be executed after creating a hibernation image, instead of
> finish() (for now, both these callbacks are defined to point to the same
> function, but that will be changed in the future).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks ok to me.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
