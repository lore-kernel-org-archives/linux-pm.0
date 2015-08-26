From: Eduardo Valentin <edubezval@gmail.com>
Subject: [ANNOUNCE] Report of the thermal micro-conference in LPC 2015 -
 Seattle, WA
Date: Wed, 26 Aug 2015 16:49:07 -0700
Message-ID: <20150826225430.GA1780@localhost.localdomain>
References: <20150327000245.GA29752@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36851 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbHZXtM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 19:49:12 -0400
Content-Disposition: inline
In-Reply-To: <20150327000245.GA29752@developer.hsd1.ca.comcast.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
Cc: Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, cyndis@lakka.kapsi.fi, kapileshwar.singh@arm.com, l.majewski@samsung.com, geert+renesas@glider.be, srinivas.pandruvada@linux.intel.com, wxt@rock-chips.com, LKML <linux-kernel@vger.kernel.org>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 26, 2015 at 08:02:49PM -0400, Eduardo Valentin wrote:
> Hello all,
>=20
>=20

<cut>

> A initial proposal for the topics to be discussed are:
> . Closed loop control governors
> . Sensor API
> . Thermal class: split of temperature sensor device and thermal driver
> . Improvements on OF-thermal
> . Devfreq vs. clock cooling
> . Power model based policies
> . User space tools
> . User space governors
>=20

I want to thank you all who was present in Linux Plumbers 2015 this year
for the thermal MC. Also, I want to thank the LPC organization to
opening up the space, infrastructure, and time slot to make the first
thermal mc within this event.

I am writing a short summary of the discussion we had during the MC
for those that were not present. You may find the MC minute note
in Etherpad [1]. You may also find the slide set of each presentation in
LPC webpage [2].

Key attendees:
- Rui Zhang
- Len Brown
- Rafael J. Wysocki
- Srinivas Pandruvada
- Kristen Accardi
- Javi Merino
- Punit Agrawal
- Kapileshwar Singh
- Lina Iyer
- Eduardo Valentin

We started with a brief overview of the subsystem. I described the
concepts involved and how they are represented in the subsystem:
thermal zones, thermal sensors, trip points, cooling devices, and
thermal governors. I also gave a snapshot of the supported SoCs. To open
the discussion for the following presentations, I introduced the current
open items. The list was restricted compared to our original proposal
(above). Therefore, the MC focused more on the sensor API, thermal zone
representation, and tools.

On the sensor API, there were several proposals. First, there is an
agreement within the community (at least those in the audience) that
there is a need to have the representation of more than one sensor per
zone. Use cases of extrapolating hotspots on package or on device
surfaces are the typical application of this needed support.

Still in the sensor API, specially what concerns the interactions with
userspace, there is also an consensus that monitoring temperature from
userspace using the thermal subsystem may be not optimal. Overhead and
latencies are the main concerns. However, we do have thermal management
solutions in userspace that needs to be supported. (open source) Examples
of them are thermald, iTux, and DPTF. The proposal to improve in this
front is to add a thermal -> iio bridge [3]. The audience also did not
presented any resistance on this proposal.

Related to the sensor API is the thermal topology representation. There
are two major proposals here. First is to have a hierarchical
representation of thermal zones. The hierarchy would be reflected in the
sysfs representation of thermal. The hierarchy is linked to have multiple
temperature sources into a single thermal zone, except that the source
could be another thermal zone. This point brings up the idea of having
aggregation functions on the temperature inputs. Examples of common
aggregation functions are: maximum temperature, moving average window,
linear extrapolation (linear coefficients). The idea would be to allow
switching the aggregation function from userspace.

The second proposal on thermal topology, on top of having hierarchical
representation, would be to also add the knowledge of which devices the
thermal zone covers. The motivation here is to have an API to get
a temperature of a device using its struct device *. This type of query
is useful while computing estimation of leakage power, for instance. We
would need to have a list of struct device * within the thermal zone device
struct. However, if you think about it, a device may also be covered
by multiple thermal zones. Therefore, we may end up with a many to many
relationship.

We also had a presentation on assertion based thermal testing. The
presented tool is able to produce automated testing using assertions
on top of tracing produced by the thermal framework. The tool has been
used to compare system behavior on the same workload across different
thermal management solutions (say, between thermal governors). The tool
has also been used to profile EAS behavior. I personally like the fact
that the building blocks we have today inside the kernel enables us to
deploy such kind of tools.

The last, but not least, discussion was around the link between thermal
and EAS. The idea is to close the loop and improve performance. Idea is
to have thermal governor (such as power allocator) to talk to the
scheduler, and use the thermal limit as a notion of capacity. However,
at this point, not much data on which clear use cases the improvement
would be seen. It would interesting to know the performance
improvements, and also, the power and thermal benefits.

I hope we keep having such opportunities to get the thermal community to
discuss the current challenges and how we can better enhance the
existing solutions.

BR,

Eduardo Valentin


[1] - https://etherpad.openstack.org/p/LPC2015_Thermal
[2] - http://linuxplumbersconf.org/2015/ocw/events/LPC2015/tracks/477
[3] - http://www.spinics.net/lists/linux-iio/msg20696.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV3lBtAAoJEMLUO4d9pOJWFVUH/07R/2O8/BPHIfuiLSGh9/FT
hrDpznRKWnzPZNBqH+nnSj5QJlFgAEJJa1boDV0Ld2+m999ferjsfmLZakS8r4El
b2LITGqhxeGYmBu8zdwgXV97nSEdubsW/HsQF58bL8rCUoZEl/w3vCtNPyJyqlMF
7/PGyiyIJ5PbbaO6SSYXEEfWXx6nQUNKkQ2UnuBGwWd2rDFjXK60Ebl0tXuPrpFy
GWI5YhF+O6DXi0ID2KN21sYsaVEWxMLt7INqwylTtOmGsFiA4TdgHoUYfm5SIHpe
by99vQcGdAqLNfhNRyGMUp8oxXni1BNgbeukEJqrT1v9M7rJ56KWzufYgKDb+rs=
=cBfP
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
