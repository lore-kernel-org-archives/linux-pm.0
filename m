From: 640E9920 <640e9920@gmail.com>
Subject: Re: platform specific pm_qos parameters
Date: Wed, 23 Dec 2009 08:23:48 -0800
Message-ID: <20091223162348.GA16543@mgross-laptop>
References: <000601ca804d$ce010190$6a0304b0$@org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1540457481949346728=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <000601ca804d$ce010190$6a0304b0$@org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ai Li <aili@codeaurora.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============1540457481949346728==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2009 at 06:51:38PM -0700, Ai Li wrote:
> Subject: [linux-pm] platform specific pm_qos parameters
> From: Ai Li <aili@codeaurora.org>
> To: mgross@linux.intel.com, linux-pm@lists.linux-foundation.org
> Date: Fri, 18 Dec 2009 18:51:38 -0700
>=20
> Hi,
>=20
> We are interested in using pm_qos_params to reduce power consumption
> on our embedded devices while maintaining satisfactory performance.
> One example of the QoS parameters is bus bandwidth.  We want to slow
> down the buses dynamically to a lower level and yet provide enough
> bandwidth to the system.
>=20
> On our devices, different product families can have different type of
> buses and different number of buses.  I remember that folks were
> asking about platform specific pm_qos parameters some time ago.  It
> seems a natural fit for us to create a different set of bandwidth QoS
> for each platform.

My initial reaction is why can't we come up with a good abstraction that
would work for the product families?  I think its ok for a pm-qos option
to exist but not be used on every architecture.

>=20
> I haven't seen much discussion recently on platform specific
> pm_qos_params.  Are people still open to the idea?  I also would like
> to help working on it.

I worry that this is the road to hell.

If the platform specific pm-qos parameter is accessed by any platform
independent driver code then its a big failure and leads to code that
will give me a rash to look at.

So one requirement for platform specific pm-qos parameters I have is
that such parameters shall only be accessible from platform specific
code and not from any platform independent stuff.  (I don't think this
is possible in C, so I'll need more convincing to not block this idea.)

I welcome help coming up with good pm-qos abstractions for the multiple
bus bandwidth problem above.  Having a nice discussion about the problem
space would be good start, then we can propose some possible
abstractions and prototype some implementations.

It also is important to provide some application specific motivation as
to why the buses you are calling out can not self throttle without
causing issues.  I once had a graphics bus example in mind but I've been
told that graphics drivers have the data needed to do effective
throttling and they already do so.  Therefore I shouldn't bother with
such parameters.

I don't know if I believe that but I don't feel like arguing with
graphics experts too much on the matter without a specific application
where the need for such a parameter could be used.  i.e. I need a
graphics driver author or graphics Si vendor to step up and tell us they
could do a lot better with power if a pm-qos parameter for graphics bus
bandwidth existed.

So do you see my issue?

I hope I'm not scaring you off.  I want to do more with pm-qos but it
takes collaboration to make it happen.  Today, I feel adding platform
specific PM-QOS would put off solving the problems by enabling device
specific parameters that would be forever out of tree and delay the
collaboration needed to move forward.

--mgross

ps, sorry for using my wonky email address, I'm away form the
linux.intel.com server until Jan.

>=20
> ~Ai
>=20
>=20
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksyRBQACgkQhK5OsmQOmSB66gCfaireeilU1BZtwRw0LC0EcmO2
ZycAnjIQH8enWQ4mTTb86wLxiXEeCfZH
=f266
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

--===============1540457481949346728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1540457481949346728==--
