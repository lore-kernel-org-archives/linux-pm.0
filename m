From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 17:11:51 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5074D068A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> Note that you don't need to replace one device with another having the
> same PID/VID.  It could be the very same device but with new media
loaded.
> That would be just as bad.

Yes, I see your point this time.  Thanks.  If I'm hooking up to a modem
inside a phone via an internal transceiver-less link it has a chance,
but not so well with a USB card reader.

Completely generalized solutions in the power domain seem pretty hard to
come by.  You end up with 'if this class of device and not that class of
device' when you try and optimize.  One way of slicing it up is with
discrete sets...kind of like operating point parameters :)

Regards,
Richard W.
