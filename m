From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with PM_FREEZE
Date: Tue, 27 Sep 2005 22:58:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509272236580.15378-100000@netrider.rowland.org>
References: <1127863145.4802.40.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============074123475183147214=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1127863145.4802.40.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============074123475183147214==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 28 Sep 2005, Nigel Cunningham wrote:

> Yes, that's true. If the usb modules are loaded when suspending and not
> loaded when resuming or vice versa, you'll get inconsistencies:
> 
> State at suspend	State at resume		Image state
> 
> Built in		Built in		Freeze->Freeze
> Loaded modules	Unloaded modules	Undefined->Freeze
> Unloaded modules	Loaded modules		Freeze->Undefined

This table is misleading.  Better to describe it like this:

	If the image doesn't contain USB drivers, the device state
	doesn't matter.

	If the image does contain USB drivers and the boot kernel
	did not meddle with the device states, then the devices
	will be suspended even though the image thinks they are
	frozen.

	If the image does contain USB drivers and the boot kernel
	did meddle with the device states, then the devices probably
	will not be resumable by the image kernel.  They will have
	to be rediscovered.

> I guess there are three possible solutions:
> 1) Leave things as they are and say it is the user's problem if they
> make the state inconsistent.
> 2) Keep knowledge of the device states across the atomic restore and use
> that information in deciding what to do in device resume/powerup.
> 3) Make device drivers handle the situation properly without knowledge
> of what state the hardware is really in (or check the real state - where
> possible - and rely on that in deciding what to do).
> 
> 2 seems to me to make for the most reliable solution.

No.  The best answer is to

	(A) tell the boot kernel that the impending freeze is for a
	restore-from-disk, so that it can wipe out the state of any
	devices it has changed, and

	(B) tell the image kernel that it is resuming from disk, so
	that it can know that the devices are really suspended even
	though its internal records say they are frozen.

Better than (A) would be to tell the boot kernel that it _is_ only a boot 
kernel, so that its drivers will know not to mess up the state of any 
devices.  This would have the side effect of making it impossible to 
reload an image from a USB drive, but that's pretty much unavoidable 
anyway.

Alan Stern


--===============074123475183147214==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============074123475183147214==--
