From: Pavel Machek <pavel@suse.cz>
Subject: Re: usblp suspend failure with 2.6.15-rc5
Date: Fri, 9 Dec 2005 22:21:49 +0100
Message-ID: <20051209212148.GD4658@elf.ucw.cz>
References: <438F3A2F.5090207@gmx.net> <4395DE67.4050101@gmx.net>
	<20051209211351.GF23349@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94198933179638278=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051209211351.GF23349@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>, linux-pm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============94198933179638278==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > since I switched to 2.6.15-rc2-git6, my machine is not able to suspend
> > anymore if my USB printer is plugged in. The problem is reproducible.
> > 
> > usb 1-2: new full speed USB device using uhci_hcd and address 3
> > drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 
> > 0 proto 2 vid 0x04E8 pid 0x3242
> > usbcore: registered new driver usblp
> > drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> > PM: Preparing system for mem sleep
> > Stopping tasks: ==================================================|
> > usblp 1-2:1.0: no suspend?
> > Could not suspend device 1-2: error -16
> > Some devices failed to suspend
> > Restarting tasks... done
> > 
> > 
> > Earlier kernels (2.6.14.2 and before) worked just fine.
> > 
> > A first search suggests this problem was introduced between
> > 2.6.14 and 2.6.15-rc2-git6. Should I try to narrow it down further?
> 
> yes, that would be good.
> 
> In this case, it would also help if you'd open a bug at 
> bugzilla.kernel.org.

Well, usblp does not have any suspend method, and usb probably just
started checking... There's also CONFIG_USB_SUSPEND option you may
want to play with.
							Pavel
-- 
Thanks, Sharp!

--===============94198933179638278==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94198933179638278==--
