From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Wed, 28 Dec 2005 21:02:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512282052150.3218-100000@netrider.rowland.org>
References: <Pine.LNX.4.50.0512271300560.4933-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46640251481484418=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512271300560.4933-100000@monsoon.he.net>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============46640251481484418==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 27 Dec 2005, Patrick Mochel wrote:

> I don't think that the tree should be assumed to be frozen. I just think
> that we should try to avoid doing a full add or remove of a device (or
> really, any object) while in a suspend or resume transition.
> 
> During normal system operation, how does a USB device get removed? Does it
> happen via the USB hub thread? Forgive me for asking a question that's
> probably been asked countless times, but is this thread running during a
> suspend transition?

USB device creation and removal is handled by the khubd thread.  That 
thread gets frozen along with everything else during suspends.

> Would it be possible to simply mark the device as 'removed' and ignore it
> until we resumed, and then clean it up (hotplug events and everything)?

Internally that's what the USB core does do.  When we know that a device
has gone away during a sleep transition (generally because the USB host
controller has lost power while it was suspended), the device structure is
marked with USB_STATE_NOTATTACHED.  All future I/O operations to it will
fail, future resume requests will return 0 without actually doing
anything, and future suspend requests will fail.  When the khubd thread is
eventually unfrozen, it goes through the device unregistration procedure.

Note that USB device drivers do not receive any special notification when
a device goes to NOTATTACHED.  Of course they can find out for themselves
by checking the state field in the device structure, but I'm not aware of
any drivers actually doing so.  If asked to perform I/O (to write out a
memory image, for example), they would simply generate a bunch of I/O
errors.

Alan Stern


--===============46640251481484418==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46640251481484418==--
