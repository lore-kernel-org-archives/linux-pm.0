From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Tue, 22 Mar 2005 12:24:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503221216430.954-100000@ida.rowland.org>
References: <20050322110802.GA1751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76981430791100125=="
In-Reply-To: <20050322110802.GA1751-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============76981430791100125==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 22 Mar 2005, Pavel Machek wrote:

> And do we really want user writing D2 to /sys file?

Yes, absolutely.  And we want the power/state file to contain "D2" when 
a PCI device is in that state.

> > Even just from first principles the mistake is apparent.  pm_message_t is
> > (or will be, when the structure is defined in its final form) a _message_,
> > not a _state_.  It contains (will contain) things other than the power
> > state setting, such as the "flags" field.  Why would a device want to
> > store pm_message_t.flags as part of its current state?
> 
> Because device may enter different hw states for different flags?

But once the device is in a particular state, the reason why it entered
that state doesn't matter any more.  Certainly it shouldn't be _part_ of 
the state.

Consider this: Device states are bus- or device-specific structures, as 
discussed before.  But the PM core can export a set of minimal generic 
state structures for use by drivers that don't need anything more 
complicated than On, Frozen, or Suspended.  How does that sound?

Alan Stern


--===============76981430791100125==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76981430791100125==--
