From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: freeze_processes questions
Date: Tue, 5 Apr 2005 20:02:29 +0200
Message-ID: <200504052002.30245.rjw@sisk.pl>
References: <200504051120.44496.rjw@sisk.pl> <20050405092742.GA1327@elf.ucw.cz>
	<200504051153.11481.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76486780516714781=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504051153.11481.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============76486780516714781==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday, 5 of April 2005 11:53, Rafael J. Wysocki wrote:
> On Tuesday, 5 of April 2005 11:27, Pavel Machek wrote:
> > Hi!
> > > 
> > > I have two questions regarding freeze_processes():
> > > 
> > > 1) Shouldn't we take the TASK_UNINTERRUPTIBLE state into consideration?  Now
> > > we will fail if a process is sleeping when we try to freeze it.
> > 
> > We can't allow processes to sleep at arbitrary places. Therefore we
> > send UNINTERRUPTIBLE task a signal, and hope it can get into
> > refrigerator in time.
> 
> Hm, AFAIK we can't kill an UNINTERRUPTIBLE process, can we?  Which means that
> we can't deliver a signal to it too ...

Well, the problem is that signal_wake_up() is not sufficient to make
an uninterruptible task get the signal.  It only sets TIF_SIGPENDING for the
task, which is not quite good,  IMHO (when the task finally wakes up,
it gets the "signal" and enters refrigerator(), because it has PF_FREEZE set,
and stays there forever, as there's nothing that could clear PF_FROZEN for
it).

I think it may be fixed in one of the two ways:

1) We can treat uninterruptible tasks as non-freezable (in analogy to stopped
tasks) - if all of the other tasks are frozen, nothing can wake up an uninterruptible
task, so this seems to be a safe approach.

2) We can try to force uninterruptible tasks to get their "signals" anyway using
wake_up_state() directly on them (which I don't like as much).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============76486780516714781==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76486780516714781==--
