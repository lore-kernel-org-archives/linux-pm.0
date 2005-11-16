From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH 1/6] PCI PM: create pm.c and relocate PM
	functions
Date: Tue, 15 Nov 2005 22:18:13 -0800
Message-ID: <20051116061813.GA31375@suse.de>
References: <1132111873.9809.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41621008984530583=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1132111873.9809.50.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============41621008984530583==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 15, 2005 at 10:31:13PM -0500, Adam Belay wrote:
> pci_save_state(), pci_restore_state(), pci_enable_wake(),
> pci_choose_state(), and pci_set_power_state() are moved to
> drivers/pci/pm.c.
> 
> This patch makes several code cleanups but no functional changes.

Looks good but:

> --- a/drivers/pci/pm.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/pci/pm.c	2005-10-24 06:23:15.000000000 -0400
> @@ -0,0 +1,296 @@
> +/*
> + * pm.c - PCI Device Power Management
> + */ 

You should say where this came from, and the copyrights for that file.

thanks,

greg k-h

--===============41621008984530583==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41621008984530583==--
