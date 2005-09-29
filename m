From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems with PM_FREEZE
Date: Thu, 29 Sep 2005 11:22:15 -0700
Message-ID: <20050929182215.0C19FE9E4F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509291136210.4928-100000@iolanthe.rowland.org>
	<20050929171245.7012DE9E1F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
	<20050929173158.GJ1990@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============49554993718000984=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050929173158.GJ1990@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@ucw.cz
Cc: linux-pm@lists.osdl.org, ncunningham@cyclades.com
List-Id: linux-pm@vger.kernel.org

--===============49554993718000984==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > > Pavel is obviously right that the clean solution is to add a pm_message_t 
> > > argument to resume().
> > 
> > I tend to disagree with that.  Changing every resume() method is
> > not "clean", and it's more obvious to me that the pm_message
> > semantics are (still) problematic.  Any argument to resume() would
> > be encouraging fragile "if (came_from(X)) { ... }" style logic.
>
> Alan wants to cut few miliseconds from suspend-to-disk. That's okay
> with me, just add pm_message_t to resume(). If it is okay to use it in
> specific driver is other question.

Sorry; changing every driver in the whole tree is in my book
under "things to avoid unless there's a more significant win".


> > Heck, there's still no way for drivers to know what the target
> > system state is ... and THAT is a core issue here.
> > 
> > During FREEZE, the target system state is "something snapshottable".
> > During SUSPEND, it's one of numerous variants of "low power" ... and
> > device drivers can only guess which one it'll be.  (Is it an ACPI
> > state?  S1, S3, S4?  Some non-ACPI platform state?)
>
> Why does your driver need to know? Anyway, extending pm_message_t with
> flags is okay with me.

Well, I've always said that what we want _instead of_ a pm_message
is just an object describing the platform-specific target state.  
And clean definitions of those states.

I don't quite see how to map those to "flags".


> > Case in point:  in some system low power states, drivers need to turn
> > off certain clocks, and may not be able to support wakeup.  In others,
> > drivers leave those clocks on, and can support wakeup.  But there is
> > no way to figure out the target state given the pm_message ...
>
> Eh? I do not see how knowing S1 vs. S3 vs. S4 help you here. It looks
> more like "does user want to resume from that?" question.

The "user" will _always_ want to resume.  S1/S3/S4 is only an answer
for ACPI systems (that don't use swsusp/"shutdown"!), and ISTR "video
needs to use PCI_D2 in S1 and S3" was a common issue (since PCI_D3
tends to expect re-init, but Linux developers don't have chip specs
saying how to re-init).  But non-ACPI systems have similar issues.

I've given examples before with USB controllers, where the 48 MHz clock
must be turned off to enter certain system states, but not others;
and turning the clock off has _significant drawbacks_ that make it
sub-optimal to always do it.  (Drawbacks like resetting the controller,
which disconnects all devices, and not supporting wakeup.)

- Dave


--===============49554993718000984==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============49554993718000984==--
