From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sun, 25 Dec 2005 09:53:03 +0100
Message-ID: <20051225085303.GF2183@elf.ucw.cz>
References: <Pine.LNX.4.50.0512231544530.28944-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0512242115030.9591-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============61138153630040692=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512242115030.9591-100000@netrider.rowland.org>
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

--===============61138153630040692==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> At this point I'm starting to feel like the proverbial 
> "man-in-the-middle".  Recently I submitted a patch adding

Rock and a hard place?

> suspend/resume 
> support to the usblp driver.  Greg objected to it because it added 
> explicit checks for whether the driver was suspended before starting up 
> I/O operations.  He said that such checks did not belong in USB drivers, 
> they belonged in the USB core.  (You can read his original comments in
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=113418897301873&w=2
> 
> .)  So now what should we do?
> 
> 	Require userspace to rmmod usblp before suspending?

No.

> 	Add suspend and resume methods to usblp, but make it so they
> 	only cancel outstanding I/O, while relying on usbcore to fail
> 	any new I/O requests?

It is not *that* bad, actually. In system suspend/resume cases, no new
I/O requests can happen, because userspace is frozen. Because of
runtime suspend, you should handle I/O errors properly, but you should
handle I/O errors properly, anyway, so... looks like a solution to me.

> Neither of those feels good to me.  The only other options I can think of 
> are:
> 
> 	Unbind usblp in lieu of suspending it.

If this can be done in reasonable ammount of not-too-ugly code, why
not? I think that even Patrick can be convinced by nice patch.

> 	Make usblp check whether it is suspended before submitting any
> 	I/O requests.

Ugly.

								Pavel
-- 
Thanks, Sharp!

--===============61138153630040692==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============61138153630040692==--
