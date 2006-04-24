From: Pavel Machek <pavel@suse.cz>
Subject: Re: RE: on-ness
Date: Mon, 24 Apr 2006 23:32:45 +0200
Message-ID: <20060424213245.GP3386@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<20060421183340.GA3071@isilmar.linta.de>
	<20060421190121.GB2078@elf.ucw.cz>
	<200604241404.41122.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20744884561816002=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604241404.41122.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============20744884561816002==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 24-04-06 14:04:40, David Brownell wrote:
> 
> > > > > Uh. Not /sys/power/state. But /sys/devices/...../power/{[a],[b],[c]} where
> > > > > [a], [b] and [c] need sensible names.
> > > > 
> > > > Well, "on" could have one defined meaning.  Maybe it's the only option
> > > > available, until drivers add intelligence.  I don't see any problem
> > > > with the other names being system-specific, since it's rather unlikely
> > > > that a PCI_D3hot state will ever appear on most embedded ARM boxes.
> > > > And if any userspace code tries to set power states, it had darn well
> > > > better understand exactly what's going on.
> > > 
> > > Yes. However if a network managing userspace code wants to set the power
> > > conusmption of a WLAN device to the lowest possible setting, it shouldn't
> > > need a configuration file specific for each platform.
> > 
> > I'd say that "on" and "off" are well defined.
> 
> Are they?  Does "off" imply the device will have been reset the next
> time it goes to "on"?  If not, there would seem to be two "off" states.
> Or maybe more ... PCI_D0 is probably "on", but all of the other PCI
> device states seem to be variants of "off", not of "on".

I'd say "off" is as low as possible, perhaps including device reset.

> And for that matter, "on" doesn't seem to me to imply anything more
> than "full functionality from external POV".  That doesn't necessarily
> imply "full power-on", and in fact it'd be better if it were using the
> lowest power state(s) available.  That state might be compatible with
> certain system sleep states, or not, depending on the device's
> workload.

Agreed.

> > For certain classes (like ethernet), other states may be common
> > between platforms, too, like "off-with-WOL".
> 
> Actually the wakeup characteristics are orthogonal, there are per-device
> bits controlling whether a device can and should do the wakeup.  We don't
> for example treat "PCI_D3hot with wakeup" as a distinct state.

Ok, "off-with-WOL" was example. Hopefully there's better example. 
								Pavel
-- 
Thanks for all the (sleeping) penguins.

--===============20744884561816002==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20744884561816002==--
