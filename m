From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Tue, 22 Mar 2005 12:08:02 +0100
Message-ID: <20050322110802.GA1751@elf.ucw.cz>
References: <20050321222609.GK1390@elf.ucw.cz>
	<Pine.LNX.4.44L0.0503212140450.28689-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82981781154827949=="
In-Reply-To: <Pine.LNX.4.44L0.0503212140450.28689-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============82981781154827949==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > > Obviously a message isn't the same thing as a state.  This looks like 
> > > > > something that will need to be changed in a lot of drivers when we 
> > > > > introduce the new notion of a power state.
> > > > 
> > > > This is not so obvious to me. Message seems to represent the state
> > > > driver is in quite well... Plus we need PMSG_ON for state the device
> > > > gets after resume, but that's quite easy...
> > > 
> > > So what value for power_state do you use to tell apart PCI D1 from D2?
> > 
> > You just ask via pci_choose_state(), and it tells
> > you... pci_choose_state() should be deterministic.
> 
> That's useless for sysfs.  It won't know to call pci_choose_state when it 
> has to display the device's current power state in an attribute file.  Nor 
> will it know what pm_message_t to send the driver when the user writes the 
> string "D2" to the attribute.

And do we really want user writing D2 to /sys file?

> Even just from first principles the mistake is apparent.  pm_message_t is
> (or will be, when the structure is defined in its final form) a _message_,
> not a _state_.  It contains (will contain) things other than the power
> state setting, such as the "flags" field.  Why would a device want to
> store pm_message_t.flags as part of its current state?

Because device may enter different hw states for different flags?

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============82981781154827949==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82981781154827949==--
