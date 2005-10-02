From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 2/3] Runtime PM support for named power states
Date: Sun, 2 Oct 2005 22:41:42 +0200
Message-ID: <20051002204142.GB2239@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509301616200.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============64575120456292523=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509301616200.4470-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============64575120456292523==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Index: usb-2.6/drivers/pci/probe.c
> ===================================================================
> --- usb-2.6.orig/drivers/pci/probe.c
> +++ usb-2.6/drivers/pci/probe.c
> @@ -22,6 +22,54 @@ EXPORT_SYMBOL(pci_root_buses);
>  
>  LIST_HEAD(pci_devices);
>  
> +const char pci_name_D0[] = "D0";
> +const char pci_name_D1[] = "D1";
> +const char pci_name_D2[] = "D2";
> +const char pci_name_D3[] = "D3";

Why not "D3hot"? And what about "D3cold"?

> +/**
> + * pci_state_to_name -- return a static name string for a power state
> + * @state: power state to convert
> + */
> +const char *pci_state_to_name(pci_power_t state)
> +{
> +	static const char *(names[]) = {
> +		pci_name_D0, pci_name_D1, pci_name_D2,
> +		"D3hot", "D3cold", "Unknown"};

} should go on separate line.

> +	int i = (int __force) state;
> +
> +	if (i < 0 || i >= sizeof(names) / sizeof(names[0]))
> +		return "Error";

Why the "Unknown" in the array, then?

> @@ -109,6 +117,7 @@ struct pci_dev {
>  	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
>  					   this is D0-D3, D0 being fully functional,
>  					   and D3 being off. */
> +	const char	*(states[5]);	/* Names for supported states */

That constant looks strange here...
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============64575120456292523==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============64575120456292523==--
