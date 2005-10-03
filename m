From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Mon, 03 Oct 2005 11:18:57 -0700
Message-ID: <20051003181857.A7DA4EA569@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509301627170.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32400846921612536=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509301627170.4470-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============32400846921612536==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> This patch adds support for named power states to the USB device drivers.  
> It's fairly simple and well-contained because USB devices have only two 
> states: on and suspended.  Even so, the confusion over which field in 
> dev->power.power_state should represent the true state remains.

Hmm, what confusion is that?  You may have mentioned it elsewhere.

There are two different notions of "device" inside USB.  One is that
of a "usb_interface" ... something that doesn't actually have any
kind of power state, it's only got "driver has quiesced".

The other is that of "usb_device", which can have real power states
when CONFIG_USB_SUSPEND is defined.  But otherwise, it's got the
same "quiesced or not" dimension as a usb_interface.

- Dave


--===============32400846921612536==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32400846921612536==--
