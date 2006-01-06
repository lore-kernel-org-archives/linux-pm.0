From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 10:00:52 +0100
Message-ID: <20060106090052.GJ3339@elf.ucw.cz>
References: <20060105215528.GF2095@elf.ucw.cz>
	<20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
	<20060105235838.GC3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
	<20060106001252.GE3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============68578848265091708=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============68578848265091708==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

One more nit...

> +	s += sprintf(s, "d0");
> +	if (dev->poss_states[PCI_D1])
> +		s += sprintf(s, " d1");
> +	if (dev->poss_states[PCI_D2])
> +		s += sprintf(s, " d2");
> +	if (dev->poss_states[PCI_D3hot])
> +		s += sprintf(s, " d3");
...
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -106,6 +106,7 @@ struct pci_dev {
>  					   this if your device has broken DMA
>  					   or supports 64-bit transfers.  */
> 
> +	u32		poss_states[4];

So this probably should be poss_states[PCI_D3hot]; or something,
instead of explicit "4".
							Pavel

-- 
Thanks, Sharp!

--===============68578848265091708==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============68578848265091708==--
