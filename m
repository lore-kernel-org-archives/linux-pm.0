From: David Brownell <david-b@pacbell.net>
Subject: Re: Remote wake up not working
Date: Thu, 8 Jun 2006 11:46:59 -0700
Message-ID: <200606081147.00063.david-b@pacbell.net>
References: <380D9721A8E2114485644D71E87C6AB201FD8476@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB201FD8476@PNE-HJN-MBX01.wipro.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: rasmit.ranjan@wipro.com, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Thursday 08 June 2006 5:21 am, rasmit.ranjan@wipro.com wrote:
> Hi,

[ don't cc "digest" lists ... and avoid ccing multiple lists! ]


>     I am using ACER Aspire 3003LC laptop. Linux version: 2.6.15.4. I my
> Host Controller supports Power Management.  =


That's with a SIS southbridge, right?  With both EHCI and OHCI?

> I tried selective =

> suspend/resume and it worked properly.  Also my Host Controller supports
> remote wake up.  So i tried testing remote wake up.  But it did not
> work.  Then i tried the same with the standard ( OHCI controller of my
> laptop ).  It did not work as wel.

You should include specifics of how you tested, and the failure mode...

Also the "lspci -vv" output, and the relevant parts of kernel config.
(Presumably CONFIG_PM is defined, also CONFIG_USB_SUSPEND...)  And to
be most useful, the "lsusb -v" output for the devices you're using as
wakeup event sources.  (Not all USB devices behave yet for suspend/resume,
or issue wakeup events.)

Note that remote wakeup -- from e.g. a system standby or suspend-to-RAM
state -- on x86 hardware probably involves ensuring that /proc/acpi/wakeup
lists the USB controllers as wakeup sources.


> Then i changed my laptop and tried testing remote wakeup and it worked
> properly with the OHCI controller and also with my Host Controller. =


That is, using a different southbridge?  And different BIOS, with
different ACPI support?  Again, you'd need to provide specifics.

Congratulations!!  So far, every time I've tested remote wakeup on
Linux, the ACPI code broke during the resume process ... that is, if
it managed to enter a "standby" or "suspend-to-ram" state in the first
place (again, ACPI problems).  I know that USB was doing the right
thing, since that can be unit tested outside of system sleep states.

  =

> So does this mean that there is something wrong with the ACER Aspire
> 3003LC laptop ?
> Or is there something on which remote wake up depends on besides the
> Host Controller and the device ( supporting remote wake up ) ?

My first guess would be you're seeing ACPI breakage, or perhaps you're
not setting things up correctly.  If you really did the same tests
on both laptops, I'd be more inclined to suspect ACPI ... especially
since that's where the problems have always been in my testing.

- Dave
