From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 10:49:49 +1100
Message-ID: <1111621789.19905.119.camel@gaston>
References: <Pine.LNX.4.44L0.0503221216430.954-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58857305781102598=="
In-Reply-To: <Pine.LNX.4.44L0.0503221216430.954-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============58857305781102598==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-03-22 at 12:24 -0500, Alan Stern wrote:
> On Tue, 22 Mar 2005, Pavel Machek wrote:
> 
> > And do we really want user writing D2 to /sys file?
> 
> Yes, absolutely.  And we want the power/state file to contain "D2" when 
> a PCI device is in that state.

No. "D2" isn't a leaf device state imho. It's a PCI state tho, but I
would have the driver expose some more meaninful names, like "standby",
"suspended", ... If the entire PCI busses goes unclocked, we could have
the PCI _bus_ expose D2. If the PCI bus is about to lose power, we could
haev the PCI _bus_ expose D3. But the leaf driver should be more
meaninful, that is the power states should be relative to the function
of the driver.

> > > Even just from first principles the mistake is apparent.  pm_message_t is
> > > (or will be, when the structure is defined in its final form) a _message_,
> > > not a _state_.  It contains (will contain) things other than the power
> > > state setting, such as the "flags" field.  Why would a device want to
> > > store pm_message_t.flags as part of its current state?
> > 
> > Because device may enter different hw states for different flags?
> 
> But once the device is in a particular state, the reason why it entered
> that state doesn't matter any more.  Certainly it shouldn't be _part_ of 
> the state.

It does matter for one thing: Wether the device can get out of the state
by itself (upon reception of a request for example) or should it block
all activities until resume().

> Consider this: Device states are bus- or device-specific structures, as 
> discussed before.  But the PM core can export a set of minimal generic 
> state structures for use by drivers that don't need anything more 
> complicated than On, Frozen, or Suspended.  How does that sound?

Yes. That is also a compatibility path from current scheme. But I
wouldn't make these states accessibles to userland ...

Ben.



--===============58857305781102598==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============58857305781102598==--
