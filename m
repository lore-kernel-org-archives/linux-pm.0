From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFC][PATCH] swsusp: warn about USB devices in
	documentation
Date: Mon, 20 Feb 2006 15:30:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0602201526330.28136-100000@netrider.rowland.org>
References: <Pine.LNX.4.50.0602201151350.13570-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============017656767501055715=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602201151350.13570-100000@monsoon.he.net>
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
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============017656767501055715==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 20 Feb 2006, Patrick Mochel wrote:

> > And if the computer can wake up in response to USB events, then obviously
> > the USB controller _is_ receiving some power.
> 
> True, and I apologize if I misunderstood your initial question. By "up", I
> thought you meant fully powered and functional.

No; in the context of this thread I merely meant suspend-power was
present.  Pavel had said that a machine which supplies any USB power at
all during swsusp is broken.  I was trying to show this isn't so.

> But yes, the USB ports may receive enough power to recognize a wakeup plug
> event, but it does ultimately depend on the platform and what they choose
> to implement.
> 
> On x86 platforms, ther is no definitive answer. The ACPI spec mentions it
> (section A.2.5), but does not require it. Windows might require that
> feature, and if they do, that will make it more common on x86 platforms..

We can but hope...  :-)

Alan Stern


--===============017656767501055715==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============017656767501055715==--
