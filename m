From: Pavel Machek <pavel@ucw.cz>
Subject: Re: freeze_processes questions
Date: Tue, 5 Apr 2005 22:37:53 +0200
Message-ID: <20050405203753.GC1380@elf.ucw.cz>
References: <200504051120.44496.rjw@sisk.pl> <20050405092742.GA1327@elf.ucw.cz>
	<200504051153.11481.rjw@sisk.pl> <200504052002.30245.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46751217032673109=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504052002.30245.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============46751217032673109==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > I have two questions regarding freeze_processes():
> > > > 
> > > > 1) Shouldn't we take the TASK_UNINTERRUPTIBLE state into consideration?  Now
> > > > we will fail if a process is sleeping when we try to freeze it.
> > > 
> > > We can't allow processes to sleep at arbitrary places. Therefore we
> > > send UNINTERRUPTIBLE task a signal, and hope it can get into
> > > refrigerator in time.
> > 
> > Hm, AFAIK we can't kill an UNINTERRUPTIBLE process, can we?  Which means that
> > we can't deliver a signal to it too ...
> 
> Well, the problem is that signal_wake_up() is not sufficient to make
> an uninterruptible task get the signal.  It only sets TIF_SIGPENDING for the
> task, which is not quite good,  IMHO (when the task finally wakes up,
> it gets the "signal" and enters refrigerator(), because it has PF_FREEZE set,
> and stays there forever, as there's nothing that could clear PF_FROZEN for
> it).

Do you see any problem with UNINTERRUPTIBLE processess? THey should
not stay in UNINTERRUPTIBLE state for too long.. If they get back into
something normal within timeout, we freeze them just okay.

> I think it may be fixed in one of the two ways:
> 
> 1) We can treat uninterruptible tasks as non-freezable (in analogy to stopped
> tasks) - if all of the other tasks are frozen, nothing can wake up an uninterruptible
> task, so this seems to be a safe approach.

HW event can wake that task up.

> 2) We can try to force uninterruptible tasks to get their "signals" anyway using
> wake_up_state() directly on them (which I don't like as much).

They are probably uninterruptible for a reason...

If something is staying in UNINTERRUPTIBLE for more than 1 second, it
is going to cause problems elsewhere, anyway. Do you see that happening?

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============46751217032673109==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46751217032673109==--
