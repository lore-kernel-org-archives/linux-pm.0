From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 15:22:07 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5074D04EE@dlee02.ent.ti.com>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> > > No, it is because USB enabled prevents cpu from sleeping; it is
> > > actually well known.
> >
> > I vaguely recall hearing the why.  It has some DMAs which are going
on
> > and I suppose the processor must service the completions.
> > Now, if you coordinated with the USB device some how, you could try
> > > and
> =

> If I coordinated with USB device somehow, I'd know when it is possible
> to shutoff usb bus. This can be done locally at usb driver, no need
> for big framework. Just someone needs to write that code.

There are two sides to this in the case for the embedded processor I'm
using.

-A- you have to put the USB bus into suspend mode.
	- This will lower the throughput of the device on the other end.
The frequency of entering this state should not interfere with my active
use case.

-B- After I've put down the USB device, I now can program the internal
SOC bus wrapper for the USB to allow idling of the interconnect.  I also
need to associate the USB remote wake interrupt with a wake up interrupt
to restart my interconnect.  All devices on that interconnect must be in
the same state for the big savings to happen.

Certainly for this embedded system, not coordinating the device states
means I can't get the big power savings.

Now, programming up millions of combinations is not feasible.  However
you can profile your usage and target common use cases.  Playing MP3 and
reading a document for instance.

Thanks,
Richard W.
