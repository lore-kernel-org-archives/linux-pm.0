From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: RE: on-ness
Date: Mon, 24 Apr 2006 16:32:54 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5055F11C0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1467363760901359=="
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
To: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

--===============1467363760901359==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

> Are they?  Does "off" imply the device will have been reset the next
> time it goes to "on"?  If not, there would seem to be two "off"
states.
> Or maybe more ... PCI_D0 is probably "on", but all of the other PCI
> device states seem to be variants of "off", not of "on".

That would seem device specific.  It would seem that applying a reset
when moving from "off" (especially that mapped to PCI_D3) would seem
reasonable.  As I was told, the rest of the PCI defined states D1-D3 are
non-functional.  So they are all OFF states.  If just happens that in D3
you can safely physically remove the device.  The current pseudo export
of these non-functional states doesn't seem so useful.  Having some
fuzzy level of idleness seems much better.

The point of the idle states Len was floating attempts to define a level
of on-ness/idleness.  As it turns out there was a nice correlation to
some ACPI states.  Numbering them seems reasonable, else your just
wasting effort translating 'state0, state1, state2, ...', keeping the
naming convention simple '0,1,2,..0xffff' would seem to lend itself to
code sharing of necessary class/device specific translation code.
 
> Actually the wakeup characteristics are orthogonal, there are
per-device
> bits controlling whether a device can and should do the wakeup.  We
don't
> for example treat "PCI_D3hot with wakeup" as a distinct state.

In my current hack attempts I am trying to associate a 'device' D2 state
with a local device sleep with an async wake up enabled.  In this state
a devices accesses are locked out until the device wake up event
happens.  This async wake can be from a device specific wake up or from
an associated timer resource.  Current DPM enabled OMAP sprinkles
suspend lock outs inside of drivers which re-suspend queued waiters and
suspends new requests if the device is in a locked out state.  From many
devices this creates a device which just reacts with a higher latency.


Regards,
Richard W.


--===============1467363760901359==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1467363760901359==--
