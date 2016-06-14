From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Tue, 14 Jun 2016 21:31:17 +1000
Message-ID: <1465903877.30200.9.camel@au1.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
Reply-To: benh@au1.ibm.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575FE64C.9080107@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, maddy@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

=09
 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
=09
=09
 <1465854492.3022.30.camel@au1.ibm.com>
	 <575FE64C.9080107@linux.vnet.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset=3D"UTF-8"
X-Mailer: Evolution 3.20.3 (3.20.3-1.fc24)=20
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2016-06-14 at 16:41 +0530, Shreyas B Prabhu wrote:
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0psscr_val =3D kcalloc(dt_idle_states, sizeof(*psscr_val),
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0rc =3D of_property_read_u64_array(power_mgt,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"ibm,cpu-idle-sta=
te-psscr",
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0psscr_val, dt_idl=
e_states);
> >=C2=A0
> > Here, psscr val is only one u64 ... shouldn't you kmalloc sizeof(..=
) *
> > dt_idle_states ?
>=20
> I'm using kcalloc here since checkpatch script suggested kcalloc over
> kzalloc for allocating memory for arrays.
> I'll also include a patch to use kcalloc throughout the file for
> uniformity in next version. I was originally planning to post that
> cleanup separately.

Ah ok, I missed the use of kcalloc (I didn't even know its existence),
my brain just read kmalloc :-)

Still, I find it inconsistent that you allocate here while you use the
stack for the names. Any reason for that ?

Cheers,
Ben.
