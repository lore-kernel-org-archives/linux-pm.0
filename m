From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspended devices and drivers
Date: Sun, 11 Sep 2005 15:16:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509111507420.9186-100000@netrider.rowland.org>
References: <20050911190622.E1113E9E16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60001121015360903=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050911190622.E1113E9E16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============60001121015360903==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 11 Sep 2005, David Brownell wrote:

> > > > > > With the USB device, things are more interesting.  If you unplug the
> > > > > > device (even while it's not in use), Windows warns you not to do this
> > > > > > ...
> > > > > 
> > > > > So it's inconsistent in behavior, since this isn't how it handles
> > > > > the same thing during resume-from-hibernate ...
> > > > ...
> >
> > It sounds like we've got a failure to communicate.  There were two 
> > experiments.  In the first, I simply unplugged the device.  Windows did 
> > detect this and did warn me.  In the second experiment, I first did the 
> > snapshot-and-poweroff, then removed the device, then replaced the device, 
> > then did resume-from-snapshot.  In that experiment Windows could _not_ 
> > tell and did not warn me.
> 
> I'm saying that the *HARDWARE* absolutely did tell ... but Windows
> discarded that information, creating the inconsistency I highlighted.

What do you mean?  _How_ was the hardware able to tell (considering that
the computer was powered off at the time) that I had unplugged and
replugged the device?

Or do you mean to say that any poweroff event should be considered an 
unplug, always?  I'm sure there are people at Microsoft who would argue 
about that.

If we're going to be careful about use of words, then "unplug" and
"replug" should refer to physical actions taken on cables and connectors.  
What you seem to have in mind could better be described as "breaking and
restoring connectivity", or even "interrupting and restoring Vbus power".

So yes, Windows did behave inconsistently with respect to interruptions of 
Vbus.  But it did not behave inconsistently (to within the limits of its 
knowledge) with respect to plugging and unplugging.

(Although my latest experiment _does_ show inconsistent behavior in this 
regard when I unplugged the device while it was not in use and Windows was 
asleep.  Maybe this was regarded as such a likely occurrence that there 
was no point in warning against it.)

Alan Stern


--===============60001121015360903==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60001121015360903==--
