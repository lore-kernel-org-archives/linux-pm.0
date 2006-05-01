From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Mon, 1 May 2006 14:58:37 -0700
Message-ID: <200605011458.38383.david-b@pacbell.net>
References: <200604271412.k3RECVA2009467@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============42946323858052127=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604271412.k3RECVA2009467@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

--===============42946323858052127==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 27 April 2006 7:12 am, Scott E. Preece wrote:
> 
> Let me recast the question a little.
> 
> Quite aside from the utility of having names that are meaningful to a
> human reader unfamiliar with a particular device, is the problem of
> supporting a system-level power policy on top of devices that have
> different device-level power states.

Related:  handling the interactions between system and device power
states.  System states commonly constrain device states, e.g. by rules
like "clocks X, Y, and Z are unavailable in system states B and C".

I have an API proposal for that particular problem, but there are
similar ones in other areas, like the available power.  (Maybe some
of the supplies have less power available -- or none! -- or switch to
lower voltage modes.)


> So, is the sum of this conversation to this point that it simply isn't
> possible to come up with a set of names and attributes that are
> meaningful across devices?

Possible is one thing; you can always define an ever-growing set of
attributes.  But would it be useful ... or a nightmare to manage,
when scaling over all platforms that Linux handles?  I lean towards
the latter.


> Or might it be possible to map the set of 
> special conditions (like the "NoSoftReset" below) to a common vocabulary
> that a device could expose to power management and that a generic,
> cross-platform power management facility could map to system states and
> transitions?

There will be some common features, sure, but I'm skeptical about the
notion of a generic cross-platform wunderfacility.

And there are other options.  My current favorite is still to expose
device-specific power states purely for test/debug, and expect the
kernel to handle everything correctly.

(We do need a better notion of drivers interacting with a system-wide
power manager.  Currently there IS no such notion, and it's a huge
hole.)


> In my domain (consumer devices) it's not such a big deal, because we
> pick the devices and can write code [albeit with some effort that we
> would rather not expend] to control each device appropriately in the
> context of the system's projected use cases. However, even in our domain
> we're beginning to need to deal with USB OTG devices being added, and it
> would be useful to be able to handle them at least somewhat
> intelligently based on attributes that they expose.

Heh.  OTG, yes.  I've put some thought into that.  There happen to be
a few different models to consider ... for example, sometimes there are
separate controllers for host and peripheral roles, as well as an OTG
controller coupled to a transceiver (maybe external/interchangeable);
and sometimes it's all integrated (e.g. host vs peripheral is just
different modes working with the same FIFO/SIE silicon).

Again, I don't see any need to expose a userspace API for those.

- Dave


--===============42946323858052127==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============42946323858052127==--
