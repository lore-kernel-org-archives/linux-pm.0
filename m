From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] [PATCH -mm 1/2]: PM: Fix handling of
	stopped tasks
Date: Thu, 7 Dec 2006 00:13:22 +0100
Message-ID: <200612070013.23230.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <200612060008.51373.rjw@sisk.pl>
	<20061205234550.GA10914@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061205234550.GA10914@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 6 December 2006 00:45, Pavel Machek wrote:
> Hi!
> =

> > > > ...after resume.
> > > =

> > > This is because of how signal_wake_up() works, I think..
> > > =

> > > > But I think it is right approach.
> > =

> > Okay, with the appended patch applied everything seems to work and I do=
n't
> > see any undesirable side-effects.
> =

> I promise to try it... tommorow. Looks very good to me.

Unfortunately there's one problem with it.

To reproduce it I run "gdb /bin/cat", execute "run" in gdb and press ^Z twi=
ce
to stop both processes.  Next I suspend and resume and run "fg" to get the =
gdb
back.and press "Enter" to get the prompt.  Then, it turns out that the
terminal echo doesn't work and "Enter" doesn't make it go to the next line.
I can recover from this state by typing "fg+Enter" (with no echo) so that
/bin/cat gets the continuation signal and it restores the terminal settings,
apparently.

This means, however, that with this patch the behavior of a process (gdb)
after the resume may be different to its normal behavior, which is wrong.

With my original [1/2] this problem doesn't appear (ie. after the resume gdb
behaves normally).  Thus I think that, although this patch is much more
elegant, my original [1/2] is a safer solution, because we can say exactly
what it does.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
