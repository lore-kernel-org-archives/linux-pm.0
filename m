From: David Brownell <david-b@pacbell.net>
Subject: Re: Suspended devices and drivers
Date: Sun, 11 Sep 2005 12:06:22 -0700
Message-ID: <20050911190622.E1113E9E16@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509061134280.5078-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33424622514823099=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509061134280.5078-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============33424622514823099==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > > > > With the USB device, things are more interesting.  If you unplug the
> > > > > device (even while it's not in use), Windows warns you not to do this
> > > > > ...
> > > > 
> > > > So it's inconsistent in behavior, since this isn't how it handles
> > > > the same thing during resume-from-hibernate ...
> > > ...
>
> It sounds like we've got a failure to communicate.  There were two 
> experiments.  In the first, I simply unplugged the device.  Windows did 
> detect this and did warn me.  In the second experiment, I first did the 
> snapshot-and-poweroff, then removed the device, then replaced the device, 
> then did resume-from-snapshot.  In that experiment Windows could _not_ 
> tell and did not warn me.

I'm saying that the *HARDWARE* absolutely did tell ... but Windows
discarded that information, creating the inconsistency I highlighted.

- Dave


--===============33424622514823099==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33424622514823099==--
