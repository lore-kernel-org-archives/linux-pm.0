From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Wed, 16 Mar 2005 22:57:45 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503162246160.7210-100000@netrider.rowland.org>
References: <20050317011013.GD10545@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============28227466659638201=="
In-Reply-To: <20050317011013.GD10545-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============28227466659638201==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 17 Mar 2005, Bernard Blackham wrote:

> > I didn't get your attachment.
> 
> D'oh. For real this time.

Of your two changes, it looks like the first one is an unimportant change
to use the new PM types.  The second is to revert something that hasn't
yet migrated out of the USB development tree.  So neither one is really
important.

> > Can _you_ elaborate on "never really being resumed"?  Since the
> > state never changes from D0 much of the code in
> > usb_hcd_pci_suspend never runs, as you said above.  In fact about
> > the only thing that does happen is the call to
> > hcd->driver->suspend.  However the reverse call to
> > hcd->driver->resume does get made in usb_hcd_pci_resume even
> > though the state upon entry is D0.
> 
> I meant specifically in the resume path, there's an if statement to
> check if the pci power state is > D0, and only acts if that's the
> case. Hopefully the first hunk of the patch attached makes this more
> clear. None of the code inside that if statement was being called.

Yes, that's right.  There's a corresponding if statement in the suspend
routine as well, and none of the code inside it was being run either.  In
fact, the stuff inside the resume "if" block undoes the actions taken by
the stuff inside the suspend "if" block.

So I don't think this is related to your mouse not functioning after 
resume.  More likely that was caused by some HID driver not handling the 
suspend/resume sequence correctly.

I tried a similar test on my system, not with a mouse but with a mass 
storage device.  There was no problem about binding the usb-storage driver 
to it after the resume.  This adds to my suspicion that your problem was 
caused by a mouse driver and not by the USB core or UHCI host driver.

Alan Stern


--===============28227466659638201==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============28227466659638201==--
