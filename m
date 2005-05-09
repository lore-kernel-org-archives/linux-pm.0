From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Disabling Devices
Date: Mon, 9 May 2005 14:06:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0505091350020.5866-100000@iolanthe.rowland.org>
References: <200505090951.59037.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26803435429492328=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505090951.59037.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============26803435429492328==
Content-Type: TEXT/PLAIN; charset=US-ASCII

There's an issue here that needs to be discussed explicitly.  How finely
should the kernel allow userspace to control runtime power management?

    (A) Do we want userspace to have to make decisions on the lines
	of: Put this device into D2, set that clock frequency to
	1 MHz, set that GPIO line to 0, and so on?

    (B) Or should the kernel export a relatively small set of power 
	domains and a small set of primitives for each domain?  Like:
	suspend, turn off remote wakeup, go to full power, suspend
	after N seconds of inactivity?

(A) means that the kernel provides very transparent access.  On the other
hand, it requires userspace applications to have a tremendous amount of
platform-specific knowledge built in -- knowledge that really belongs only
in the kernel.

(B) seems a lot easier for apps to handle and is closer to what users will
expect to see.  But it does mean that the kernel has to contain mechanisms
for implementing and exporting these power domain abstractions.

In general (A) most resembles what sysfs does right now.  I suspect that 
(B) will be a better solution in the end.

Regarding Dave's comments about hdparm and xset dpms -- what matters most 
about these interfaces is not that they are application-specific but that 
they are ad-hoc.  I don't see why we can't strive to present a much more 
uniform interface, even if it does describe widely varying subsystems.  I 
also don't see anything wrong with implementing this interface by means of 
sysfs instead of using driver-specific ioctls.

Alan Stern


--===============26803435429492328==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26803435429492328==--
