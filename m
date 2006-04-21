From: Pavel Machek <pavel@suse.cz>
Subject: Re: RE: on-ness
Date: Fri, 21 Apr 2006 21:01:21 +0200
Message-ID: <20060421190121.GB2078@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<200604211003.41049.david-b@pacbell.net>
	<20060421171249.GA18617@isilmar.linta.de>
	<200604211130.05650.david-b@pacbell.net>
	<20060421183340.GA3071@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============085028618615990093=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060421183340.GA3071@isilmar.linta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============085028618615990093==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > > > > Well, the big problem with names and anything "system specific" is that it
> > > > > makes _abstractions_ harder. It makes userspace's life harder, as it needs
> > > > > to know what "idle" means on a specific system, instead.
> > > > 
> > > > If by "userspace" we can mean just "what writes the /sys/power/state file",
> > > > it's straightforward for a given system to provide mappings between some
> > > > common tokens ("standby", "mem", etc) to a system-specific meaning.
> > > 
> > > Uh. Not /sys/power/state. But /sys/devices/...../power/{[a],[b],[c]} where
> > > [a], [b] and [c] need sensible names.
> > 
> > Well, "on" could have one defined meaning.  Maybe it's the only option
> > available, until drivers add intelligence.  I don't see any problem
> > with the other names being system-specific, since it's rather unlikely
> > that a PCI_D3hot state will ever appear on most embedded ARM boxes.
> > And if any userspace code tries to set power states, it had darn well
> > better understand exactly what's going on.
> 
> Yes. However if a network managing userspace code wants to set the power
> conusmption of a WLAN device to the lowest possible setting, it shouldn't
> need a configuration file specific for each platform.

I'd say that "on" and "off" are well defined.

For certain classes (like ethernet), other states may be common
between platforms, too, like "off-with-WOL".
									Pavel
-- 
Thanks for all the (sleeping) penguins.

--===============085028618615990093==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============085028618615990093==--
