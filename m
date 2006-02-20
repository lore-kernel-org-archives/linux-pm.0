From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 5/5] [pci pm] Make pci_choose_state() use the
	real device state requested
Date: Sun, 19 Feb 2006 16:09:52 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602191559310.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171759190.30811-100000@monsoon.he.net>
	<20060218155836.GF5658@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============88542927493393453=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060218155836.GF5658@openzaurus.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============88542927493393453==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sat, 18 Feb 2006, Pavel Machek wrote:

> Hi!
>
> >  	case PM_EVENT_FREEZE:
> >  	case PM_EVENT_SUSPEND:
> > -		return PCI_D3hot;
> > +		if (msg.state && msg.state <= PCI_D3hot)
> > +			state = msg.state;
> > +		break;
> >  	default:
>
> Silently ignores wrong value passed-in by user. Not nice...

The value is bounded, so anything passed above PCI_D3hot is translated to
PCI_D3hot.

[ That's the best we can do since we can't report an error nicely because
the pci_choose_state() interface was poorly designed. The function must be
called by the drivers, and returns a pci_power_t. It is not expected to
fail, and the argument is usually passed unchecked to
pci_set_power_state().

It would have been much safer to have pci_device_suspend() in
drivers/pci/pci-driver.c call pci_choose_state() to translate the value.
That could easily verify the user input, and it could just pass the
translated state to the drivers, which would have been compatible with the
previous API and not required a change to every single PCI driver.. ]

Thanks,


	Pat


--===============88542927493393453==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============88542927493393453==--
