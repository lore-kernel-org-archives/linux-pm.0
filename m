From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [patch/rft 2.6.17-rc2] swsusp
 resume must not device_suspend()
Date: Tue, 25 Apr 2006 09:50:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604250947260.5330-100000@iolanthe.rowland.org>
References: <200604241429.52022.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============49515017230953795=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604241429.52022.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============49515017230953795==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 24 Apr 2006, David Brownell wrote:

> I've noticed a bunch of problem reports that go like this:
> 
>  - boot system with some USB devices attached
>  - echo disk > /sys/power/state
>  - ... later resume ...
>  - now those USB devices don't work right
>  - unplug them/replug them, all is OK
> 
> I recently observed this myself and tracked down one problem.  The solution
> involves what kexec() does in much the same situation:  before starting a
> new kernel, most hardware needs to be reset.  Today, swsusp will suspend it
> instead, which is the root cause of the problem.
> 
> This seems like something that might need to sit in the MM tree for
> a while, as it's a longstanding bug and the fix could shake loose driver
> goofs.  Luckily there's a partial workaround already in wide use:  link
> drivers as modules if they use true suspend states (like all USB HCDs),
> don't link them statically into the kernel image.
> 
> That workaround is partial because when BIOS takes over a controller, the
> resume() method has to handle that nasty case too!  Last I checked, all
> the USB HCDs do handle that case; and few drivers other than those HCDs
> would ever need to worry about such issues.

We might have been able to avoid some of these problems with USB devices
if we had been a bit more careful.  In particular, it wouldn't hurt to
have usb_resume_device() verify that the upstream port is enabled and not
suspended in the non-CONFIG_USB_SUSPEND case.

Alan Stern


--===============49515017230953795==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============49515017230953795==--
