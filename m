From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Armada DRM: bridge with componentized devices
Date: Tue, 15 Jan 2019 01:04:02 +0100
Message-ID: <CAJZ5v0grEWD0d51DCcEXuS+9tbyWERBPv1wOCqznEuXEFmbvmQ@mail.gmail.com>
References: <20190108132150.GT11171@n2100.armlinux.org.uk>
 <2c9477a3-c1b6-c92a-622f-66a57ec14ddd@samsung.com>
 <20190108150735.GU11171@n2100.armlinux.org.uk>
 <98c3d41f-2143-93d7-a372-1242b30ad335@samsung.com>
 <CAJZ5v0jOY44u77O8RuDJL+b3uD6u_Meco7Gv6RUmiPtSbwpciA@mail.gmail.com>
 <20190109093052.GX11171@n2100.armlinux.org.uk>
 <CAKMK7uEvDdLn761MjQ3A9HhAd3SPtebOykb9F_1zWP4+-v8ocA@mail.gmail.com>
 <CAJZ5v0hz1CoW=-s38vS261id9MzwgC9_-RGYiJDmvUgczg5sWA@mail.gmail.com>
 <20190111143213.GB2392@n2100.armlinux.org.uk>
 <CAJZ5v0hXJAQDLiM_5zO9HDk3DT3vjJVTfqXMK-YvrkqVazU-vw@mail.gmail.com>
 <20190111144938.GC2392@n2100.armlinux.org.uk>
 <CAJZ5v0gFiUx5tZUbhO9-kuDU9B3h13wEvaEf86j8td=3CajnRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000d0ee39057f73e6dd"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAJZ5v0gFiUx5tZUbhO9-kuDU9B3h13wEvaEf86j8td=3CajnRw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Linux PM <linux-pm@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, DRI Development <dri-devel@lists.freedesktop.org>, Peter Rosin <peda@axentia.se>
List-Id: linux-pm@vger.kernel.org

--000000000000d0ee39057f73e6dd
Content-Type: text/plain; charset="UTF-8"

[CC Lukas and linux-pm]

On Mon, Jan 14, 2019 at 1:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jan 11, 2019 at 3:49 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:

[cut]

> >
> > This thread is discussing how to deal with Armada DRM, its use of the
> > component helper, TDA998x's hybrid use of the component helper and
> > DRM bridges.
> >
> > Currently, DRM bridges register into the DRM system and are added to
> > a global list of bridges.  When a DRM driver binds, it looks up the
> > DRM bridge and attaches to it.  There is no way in generic DRM code
> > for the DRM driver to know if the DRM bridge is unbound from DRM,
> > consequently a DRM driver may continue trying to call functions in
> > the DRM bridge driver using memory that has already been freed.
> >
> > We had similar issues with imx-drm, and a number of years ago at a
> > kernel summit, this was discussed, and I proposed a system which is
> > now known as the component helper.  This handles the problem of a
> > multi-component system.
> >
> > However, DRM bridge was already established, and there appears to be
> > no desire to convert DRM bridges and DRM drivers to use the component
> > helper.
> >
> > We are presently in the situation where Armada DRM is incompatible
> > with the DRM bridges way of doing things, and making it compatible
> > essentially means introducing potential use-after-free bugs into the
> > code.
> >
> > Device links in their stateful form appear to provide an alternative
> > to the component helper, in that a stateful device link will remove
> > consumers of a resource when the supplier is going away - which is
> > exactly the problem which the component helper is solving.  The
> > difference is that device links look like being a cleaner solution.
> >
> > Just like the component helper, a stateful link would unbind the
> > consumer of a resource when the supplier goes away - which is exactly
> > the behaviour we're wanting.
> >
> > The problem is that the connection between various drivers is only
> > really known when the drivers obtain their resources, and the
> > following can happen:
> >
> > supplier                consumer
> >
> > probe()
> >  alloc
> >                         probe()
> >  publish
> >                         obtain supplier's resource
> >  return
> >
> > Where things go wrong is if a stateful link is created when the
> > consumer obtains the suppliers resource before the supplier has
> > finished probing - which from what's been said is illegal.
>
> It just doesn't work (which means "invalid" rather than "illegal" I
> guess, but whatever :-)).
>
> Admittedly, the original design didn't take this particular case into
> account and I'm not actually sure how it can be taken into account
> either.
>
> If the link is created by the consumer in the scenario above, its
> status will be updated twice in a row after the consumer probe returns
> and after the supplier probe returns.  It looks like this update would
> need to work regardless of the order it which this happened which
> sounds somewhat challenging.  I would need to think about that.

So if I'm not mistaken it can be made work with the help of the
(completely untested) attached patch (of course, the documentation
would need to be updated too).

The key observation here is that it should be fine to create a link
from the consumer driver's probe while the supplier is still probing
if the consumer has some way to find out that the supplier is
functional at that point (like when it has published itself already in
your example above).  The initial state of the link can be "consumer
probe" in that case and I don't see a reason why that might not work.

--000000000000d0ee39057f73e6dd
Content-Type: text/x-patch; charset="US-ASCII"; name="device-links-extension.patch"
Content-Disposition: attachment; filename="device-links-extension.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jqwzlm230>
X-Attachment-Id: f_jqwzlm230

LS0tCiBkcml2ZXJzL2Jhc2UvY29yZS5jIHwgICAxOSArKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYmFz
ZS9jb3JlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL2Jhc2UvY29yZS5j
CisrKyBsaW51eC1wbS9kcml2ZXJzL2Jhc2UvY29yZS5jCkBAIC0yNjAsNiArMjYwLDE3IEBAIHN0
cnVjdCBkZXZpY2VfbGluayAqZGV2aWNlX2xpbmtfYWRkKHN0cnUKIAkJbGluay0+c3RhdHVzID0g
RExfU1RBVEVfTk9ORTsKIAl9IGVsc2UgewogCQlzd2l0Y2ggKHN1cHBsaWVyLT5saW5rcy5zdGF0
dXMpIHsKKwkJY2FzZSBETF9ERVZfUFJPQklORzoKKwkJCS8qCisJCQkgKiBBIGNvbnN1bWVyIGRy
aXZlciBjYW4gY3JlYXRlIGEgbGluayB0byBhIHN1cHBsaWVyCisJCQkgKiB0aGF0IGFsc28gaXMg
cHJvYmluZyBhcyBsb25nIGFzIGl0IGtub3dzIHRoYXQgdGhlCisJCQkgKiBzdXBwbGllciBpcyBh
bHJlYWR5IGZ1bmN0aW9uYWwgKGZvciBleGFtcGxlLCBpdCBoYXMKKwkJCSAqIGp1c3QgYWNxdWly
ZWQgc29tZSByZXNvdXJjZXMgZnJvbSB0aGUgc3VwcGxpZXIpLgorCQkJICovCisJCQlsaW5rLT5z
dGF0dXMgPSBjb25zdW1lci0+bGlua3Muc3RhdHVzID09IERMX0RFVl9QUk9CSU5HID8KKwkJCQkJ
RExfU1RBVEVfQ09OU1VNRVJfUFJPQkUgOgorCQkJCQlETF9TVEFURV9ET1JNQU5UOworCQkJYnJl
YWs7CiAJCWNhc2UgRExfREVWX0RSSVZFUl9CT1VORDoKIAkJCXN3aXRjaCAoY29uc3VtZXItPmxp
bmtzLnN0YXR1cykgewogCQkJY2FzZSBETF9ERVZfUFJPQklORzoKQEAgLTQ3NCw2ICs0ODUsMTQg
QEAgdm9pZCBkZXZpY2VfbGlua3NfZHJpdmVyX2JvdW5kKHN0cnVjdCBkZQogCQlpZiAobGluay0+
ZmxhZ3MgJiBETF9GTEFHX1NUQVRFTEVTUykKIAkJCWNvbnRpbnVlOwogCisJCS8qCisJCSAqIExp
bmtzIGNyZWF0ZWQgZHVyaW5nIGNvbnN1bWVyIHByb2JlIG1heSBiZSBpbiB0aGUgImNvbnN1bWVy
CisJCSAqIHByb2JlIiBzdGF0ZSB0byBzdGFydCB3aXRoIGlmIHRoZSBzdXBwbGllciBpcyBzdGls
bCBwcm9iaW5nCisJCSAqIHdoZW4gdGhleSBhcmUgY3JlYXRlZC4gIFNraXAgdGhlbSBoZXJlLgor
CQkgKi8KKwkJaWYgKGxpbmstPnN0YXR1cyA9PSBETF9TVEFURV9DT05TVU1FUl9QUk9CRSkKKwkJ
CWNvbnRpbnVlOworCiAJCVdBUk5fT04obGluay0+c3RhdHVzICE9IERMX1NUQVRFX0RPUk1BTlQp
OwogCQlXUklURV9PTkNFKGxpbmstPnN0YXR1cywgRExfU1RBVEVfQVZBSUxBQkxFKTsKIAl9Cg==
--000000000000d0ee39057f73e6dd
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--000000000000d0ee39057f73e6dd--
