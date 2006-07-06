From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 6 Jul 2006 15:27:28 -0700
Message-ID: <200607061527.29421.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060629030923.GA18968@kroah.com>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
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
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 June 2006 8:24 pm, Linus Torvalds wrote:
> =

> On Wed, 28 Jun 2006, Greg KH wrote:
> > =

> > Any thoughts as to applying your patch to the tree or not?  No objection
> > from me if you want to.
> =

> I've not actually had anybody report any testing success from it, and =

> since I don't use suspend-to-disk, for example, if would be good to have =

> verification.

Well, FWIW I don't think it interfered with anything either.  I tried
it with RC1 on three different systems (none very current):

 - Athlon XP based, with that memcpy/3dnow fix ... core behaved, though
   more than the usual number of drivers seemed to misbehave.

     * The ohci1394 driver problems may have been there for a long time,
       I don't normally configure it.  Failure:  hang after resume().

     * The net2280 problem is new, possibly caused by some recent fixes.

 - i686 coppermine ... core behaved, ACPI broke in irq router reactivation.

 - ARM at91rm9200 ... worked fine

That testing was STD, except for the rm9200 which was just "standby"
(since nobody implemented slow-clock-mode yet, and of course STD is
irrelevant on most embedded hardware).

The only other new behaviors of note are that the console changes now
prevent diagnostics during suspend (sigh), and that something (maybe
the PM_TRACE stuff?) is causing a 60 GB ext3 filesystem to fsck on
every reboot, claiming it's been 10+ years since it was last checked.

- Dave
