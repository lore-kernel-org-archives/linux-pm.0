From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [RFC v0 0/2] Introduce on-chip interconnect API
Date: Wed, 22 Mar 2017 20:32:56 -0700
Message-ID: <20170323033256.GA6007@tyrael.amer.corp.natinst.com>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
 <20170303062145.zpa4oblwgx2ecgv7@rob-hp-laptop>
 <7e7c29a7-af04-04a8-cb76-0c406f8f855c@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0244272658897000214=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7e7c29a7-af04-04a8-cb76-0c406f8f855c@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, khilman@baylibre.com, mturquette@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, davidai@quicinc.com, devicetree@vger.kernel.org, skannan@codeaurora.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============0244272658897000214==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 05:41:54PM +0200, Georgi Djakov wrote:
> On 03/03/2017 08:21 AM, Rob Herring wrote:
> > On Wed, Mar 01, 2017 at 08:22:33PM +0200, Georgi Djakov wrote:
> > > Modern SoCs have multiple processors and various dedicated cores (vid=
eo, gpu,
> > > graphics, modem). These cores are talking to each other and can gener=
ate a lot
> > > of data flowing through the on-chip interconnects. These interconnect=
 buses
> > > could form different topologies such as crossbar, point to point buse=
s,
> > > hierarchical buses or use the network-on-chip concept.
> > >=20
> > > These buses have been sized usually to handle use cases with high data
> > > throughput but it is not necessary all the time and consume a lot of =
power.
> > > Furthermore, the priority between masters can vary depending on the r=
unning
> > > use case like video playback or cpu intensive tasks.
> > >=20
> > > Having an API to control the requirement of the system in term of ban=
dwidth
> > > and QoS, so we can adapt the interconnect configuration to match thos=
e by
> > > scaling the frequencies, setting link priority and tuning QoS paramet=
ers.
> > > This configuration can be a static, one-time operation done at boot f=
or some
> > > platforms or a dynamic set of operations that happen at run-time.
> > >=20
> > > This patchset introduce a new API to get the requirement and configur=
e the
> > > interconnect buses across the entire chipset to fit with the current =
demand.
> > > The API is NOT for changing the performance of the endpoint devices, =
but only
> > > the interconnect path in between them.
> > >=20
> > > The API is using a consumer/provider-based model, where the providers=
 are
> > > the interconnect controllers and the consumers could be various drive=
rs.
> > > The consumers request interconnect resources (path) to an endpoint an=
d set
> > > the desired constraints on this data flow path. The provider(s) recei=
ve
> > > requests from consumers and aggregate these requests for all master-s=
lave
> > > pairs on that path. Then the providers configure each participating i=
n the
> > > topology node according to the requested data flow path, physical lin=
ks and
> > > constraints. The topology could be complicated and multi-tiered and i=
s SoC
> > > specific.
> > >=20
> > > Below is a simplified diagram of a real-world SoC topology. The inter=
connect
> > > providers are the memory front-end and the NoCs.
> > >=20
> > > +----------------+    +----------------+
> > > | HW Accelerator |--->|      M NoC     |<---------------+
> > > +----------------+    +----------------+                |
> > >                         |      |                    +------------+
> > >           +-------------+      V       +------+     |            |
> > >           |                +--------+  | PCIe |     |            |
> > >           |                | Slaves |  +------+     |            |
> > >           |                +--------+     |         |   C NoC    |
> > >           V                               V         |            |
> > > +------------------+   +------------------------+   |            |   =
+-----+
> > > |                  |-->|                        |-->|            |-->=
| CPU |
> > > |                  |-->|                        |<--|            |   =
+-----+
> > > |      Memory      |   |         S NoC          |   +------------+
> > > |                  |<--|                        |---------+    |
> > > |                  |<--|                        |<------+ |    |   +-=
-------+
> > > +------------------+   +------------------------+       | |    +-->| =
Slaves |
> > >    ^     ^    ^           ^                             | |        +-=
-------+
> > >    |     |    |           |                             | V
> > > +-----+  |  +-----+    +-----+  +---------+   +----------------+   +-=
-------+
> > > | CPU |  |  | GPU |    | DSP |  | Masters |-->|       P NoC    |-->| =
Slaves |
> > > +-----+  |  +-----+    +-----+  +---------+   +----------------+   +-=
-------+
> > >          |
> > >      +-------+
> > >      | Modem |
> > >      +-------+
> > >=20
> > > This RFC does not implement all features but only main skeleton to ch=
eck the
> > > validity of the proposal. Currently it only works with device-tree an=
d platform
> > > devices.
> > >=20
> > > TODO:
> > >  * Constraints are currently stored in internal data structure. Shoul=
d PM QoS
> > >  be used instead?
> > >  * Rework the framework to not depend on DT as frameworks cannot be t=
ied
> > >  directly to firmware interfaces. Add support for ACPI?
> >=20
> > I would start without DT even. You can always have the data you need in
> > the kernel. This will be more flexible as you're not defining an ABI as
> > this evolves. I think it will take some time to have consensus on how to
> > represent the bus master view of buses/interconnects (It's been
> > attempted before).
> >=20
> > Rob
> >=20
>=20
> Thanks for the comment and for discussing this off-line! As the main
> concern here is to see a list of multiple platforms before we come
> up with a common binding, i will convert this to initially use platform
> data. Then later we will figure out what exactly to pull into DT.

This is great stuff, I had whipped up something similar for a technology
that some of our devices use called RFNoC but got stuck when looking at
the bindings. I'll see if I can squeeze my stuff into the framework and
give you some feedback.

Cheers,

Moritz

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY00HmAAoJEL5CEHepFqovFpwH/2Z67FL7hXLfe/AooIod9nfO
m+CnL0i1E5k9RJUFaGuw5ivxbEl+PVQLuJ8898duN76MnhP89TStpFdtL76QCsk6
TZnMeCpdHpAUSxm8f4LR2hD2ogUW8sWr4CFAutdq2U5JuRyXlpbnCzEdfOHjbMLd
USOUApcUrjILdS0WwPr49aiI9CnCX3rVjCiLLJWD3FX3xswg8h9Lt2z1a2HXXOZR
RTu4o+tEC1i7vyQdgGZHgS8w2TokfUfomwRkoisTRAy9tG15gBc00r9YEPxUsY7y
ynzKSTdJ3pgn/nx9SCn99YoHHV0eQgs9D44+O9Iu5s6TlTDL3CbYE5Ond7doP28=
=hjYR
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


--===============0244272658897000214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0244272658897000214==--
