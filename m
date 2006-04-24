From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Mon, 24 Apr 2006 14:04:40 -0700
Message-ID: <200604241404.41122.david-b@pacbell.net>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<20060421183340.GA3071@isilmar.linta.de>
	<20060421190121.GB2078@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============57457988856159248=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060421190121.GB2078@elf.ucw.cz>
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
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============57457988856159248==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> > > > Uh. Not /sys/power/state. But /sys/devices/...../power/{[a],[b],[c]} where
> > > > [a], [b] and [c] need sensible names.
> > > 
> > > Well, "on" could have one defined meaning.  Maybe it's the only option
> > > available, until drivers add intelligence.  I don't see any problem
> > > with the other names being system-specific, since it's rather unlikely
> > > that a PCI_D3hot state will ever appear on most embedded ARM boxes.
> > > And if any userspace code tries to set power states, it had darn well
> > > better understand exactly what's going on.
> > 
> > Yes. However if a network managing userspace code wants to set the power
> > conusmption of a WLAN device to the lowest possible setting, it shouldn't
> > need a configuration file specific for each platform.
> 
> I'd say that "on" and "off" are well defined.

Are they?  Does "off" imply the device will have been reset the next
time it goes to "on"?  If not, there would seem to be two "off" states.
Or maybe more ... PCI_D0 is probably "on", but all of the other PCI
device states seem to be variants of "off", not of "on".

And for that matter, "on" doesn't seem to me to imply anything more
than "full functionality from external POV".  That doesn't necessarily
imply "full power-on", and in fact it'd be better if it were using the
lowest power state(s) available.  That state might be compatible with
certain system sleep states, or not, depending on the device's workload.

Is either "on" or "off" a suspend state?  Why, or why not?  :)


> For certain classes (like ethernet), other states may be common
> between platforms, too, like "off-with-WOL".

Actually the wakeup characteristics are orthogonal, there are per-device
bits controlling whether a device can and should do the wakeup.  We don't
for example treat "PCI_D3hot with wakeup" as a distinct state.

- Dave



--===============57457988856159248==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============57457988856159248==--
