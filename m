From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Mon, 14 Mar 2005 17:31:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503141717240.620-100000@ida.rowland.org>
References: <20050314022308.GD6008@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8513987579109128=="
In-Reply-To: <20050314022308.GD6008-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
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
Cc: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============8513987579109128==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 14 Mar 2005, Bernard Blackham wrote:

> Not happy yet. Passing D0 to uhci suspend's method is the cause of
> the issue (it doesn't handle it particularly well), and D0 is also
> passed when PMSG_FREEZE is sent. So while it works for entering S3,
> it fails in the same way when preparing for the atomic copy in S4.
> 
> Hacking around the issue by always using D3hot should return it back
> to the pre-drivermodel behaviour and mostly works. However at least
> one person has reported that even doing this, uhci_hcd alone
> suspends fine, but if both uhci_hcd and ehci_hcd are loaded, USB is
> dead on resume until reloading both modules. I'm still digging
> deeper and may need to enlist the help of linux-usb-devel...

I'm seeing similar problems on my system, using the gregkh-2.6 kernel.  
The motherboard is a PIIX4 and the builtin UHCI controller doesn't support 
PCI PM.  The following sequence of commands provokes the problem (with no 
USB devices attached):

	cd /sys/device/pci*/*7.2	# The UHCI controller's directory
	echo -n 3 >usb1/power/state	# Suspend the root hub
	echo -n 3 >power/state		# Suspend the controller
	echo -n 0 >power/state		# Resume the controller

(The log indicates at this point that it's resuming from D0.)

	echo -n 0 >usb1/power/state	# Try to resume the root hub

Now things go crazy.  For some reason the controller is left in an
unconfigured state, as revealed by lspci -vvb (no I/O mapping, IRQs not
routed anywhere).  I'm not sure if that happens before or after the final
command.  I'm also not sure if it's caused by the resume routines in
hcd-pci.c or the resume routines in uhci-hcd.c.

The whole suspend/resume support in uhci-hcd is due for a drastic 
overhaul.  I've just done the work leading up to it; finishing it will 
take some time -- maybe a few weeks.

I'll try running some more tests when there's a chance, and let you know 
what turns up.

Alan Stern


--===============8513987579109128==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============8513987579109128==--
