From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Mon, 3 Oct 2005 15:46:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510031519290.5909-100000@iolanthe.rowland.org>
References: <20051003181857.A7DA4EA569@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82453429097273867=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051003181857.A7DA4EA569@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============82453429097273867==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 3 Oct 2005, David Brownell wrote:

> > This patch adds support for named power states to the USB device drivers.  
> > It's fairly simple and well-contained because USB devices have only two 
> > states: on and suspended.  Even so, the confusion over which field in 
> > dev->power.power_state should represent the true state remains.
> 
> Hmm, what confusion is that?  You may have mentioned it elsewhere.

The confusion is over whether the current power state is indicated by 
dev->power.power_state.state or dev->power.power_state.name.  (Never mind 
the possibility that the actual power level might be indicated by 
something else entirely, like pcidev->current_state or usbdev->state!)

There are many places in the PM core and in usbcore where decisions about 
whether or not to call suspend or resume methods are based on the value of 
dev->power.power_state.state.  For example, if power_state.state is 0, the 
runtime_resume function in runtime.c won't do anything.

But with named states, it makes more sense to look at power_state.name
instead.  The name field does a much better job of representing the state
the device is currently in, whereas the event field really represents the
reason for entering that state (i.e., the event that triggered the state
transition).

The problem is made even worse by the way runtime_resume() and 
runtime_suspend() assign their own values to dev->power.power_state, 
overwriting whatever the driver may have put there.  I should have taken 
out those assignments; they really don't do any good.

> There are two different notions of "device" inside USB.  One is that
> of a "usb_interface" ... something that doesn't actually have any
> kind of power state, it's only got "driver has quiesced".
> 
> The other is that of "usb_device", which can have real power states
> when CONFIG_USB_SUSPEND is defined.  But otherwise, it's got the
> same "quiesced or not" dimension as a usb_interface.

That's not what I was talking about.  The distinction between "device" and 
"interface" doesn't matter to the PM core.

Alan Stern


--===============82453429097273867==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82453429097273867==--
