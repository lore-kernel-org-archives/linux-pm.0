From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Sat, 8 Oct 2005 19:00:18 +0200
Message-ID: <20051008170017.GC10865@openzaurus.ucw.cz>
References: <20051005013133.87E7BBF45E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
	<Pine.LNX.4.44L0.0510051454540.6157-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11410489606447882=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0510051454540.6157-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============11410489606447882==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> As part of the infrastructure changes, we could remove
> dev->power.power_state, dev->power.prev_state, and maybe also
> dev->power.saved_state (currently it is used only in a few platform
> drivers for stuff that could easily be stored in a private data
> structure).  Nothing would be needed but the name pointer, and that should
> be under the bus/driver's control.
> 
> People have already pretty much agreed that ->resume needs to take a 
> pm_message_t argument, and that will mean changing a lot of drivers.  We 
> ought to settle on a decision about the rest of this too, so we won't have 
> to go through and change them all yet again.

I think they need to go in one-after-one, anyway... Adding parameter
to resume() should definitely be separate patch, because it needs to
change all drivers *at once*.  Removing power_state usage can be
done incrementally...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============11410489606447882==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11410489606447882==--
