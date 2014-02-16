From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
Date: Sun, 16 Feb 2014 09:39:56 +0800
Message-ID: <20140216013956.GV4451@sirena.org.uk>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RI0j69zTdciYrvy/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392128273-8614-4-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Martin <dave.martin-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mark Hambleton <mark.hambleton-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman@linaro.o>
List-Id: linux-pm@vger.kernel.org


--RI0j69zTdciYrvy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2014 at 02:17:53PM +0000, Lorenzo Pieralisi wrote:

> +According to the Server Base System Architecture document (SBSA, [3]), t=
he
> +power states an ARM CPU can be put into are identified by the following =
list:

> +1 - Running
> +2 - Idle_standby
> +3 - Idle_retention
> +4 - Sleep
> +5 - Off

> +ARM platforms implement the power states specified in the SBSA through p=
ower
> +management schemes that allow an OS PM implementation to put the process=
or in
> +different idle states (which include states 1 to 4 above; "off" state is=
 not
> +an idle state since it does not have wake-up capabilities, hence it is n=
ot
> +considered in this document).

This is explicitly talking about SBSA - is there any restriction with
regard to non-SBSA systems?  I can't think of any right now and this
seems purely informational but it might be worth mentioning that
non-SBSA systems might potentially have other states if the intention is
to allow that.

> +- state node
> +
> +	Description: must be child of either the cpu-idle-states node or
> +		     a state node.
> +
> +	The state node name shall be "stateN", where N =3D {0, 1, ...} is
> +	the node number; state nodes which are siblings within a single common
> +	parent node must be given a unique and sequential N value, starting
> +	from 0.

This came up with the CPU bindings as well but I'm really not convinced
that making the naming of the nodes important is great - it's not normal
for DT and it makes the usual enumeration code not work.  Can we not
just have a property for state number in the node instead and allow the
name to be anything?  It seems we even have the index property
already...

> +	- compatible
> +		Usage: Required
> +		Value type: <stringlist>
> +		Definition: Must be "arm,cpu-idle-state".

Do we really need this given that the location in the tree is fixed -
what would we extend it with in future?

> +	- index
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: It represents an idle state index, starting from 2.
> +			    Index 0 represents the processor state "running"
> +			    and index 1 represents processor mode
> +			    "idle_standby", entered by executing a wfi
> +			    instruction (SBSA,[3]); indexes 0 and 1 are
> +			    standard ARM states that need not be described.

=2E..but other numbers are valid.

> +	- entry-method
> +		Usage: Required
> +		Value type: <stringlist>
> +		Definition: Describes the method by which a CPU enters the
> +			    idle state. This property is required and must be
> +			    one of:
> +
> +			    - "arm,psci-cpu-suspend"
> +			      ARM PSCI firmware interface, CPU suspend
> +			      method[2].
> +
> +			    - "[vendor],[method]"
> +			      An implementation dependent string with
> +			      format "vendor,method", where vendor is a string
> +			      denoting the name of the manufacturer and
> +			      method is a string specifying the mechanism
> +			      used to enter the idle state.

Might be worth reversing these - arm,psci-cpu-suspend is just an example
of a (hopefully very widely used) vendor method.  Given that everyone is
supposed to be using PSCI might it even be worth making it the default
and the property optional?

> +	- power-state
> +		Usage: See definition.
> +		Value type: <u32>
> +		Definition: Depends on the entry-method property value.
> +			    If entry-method is "arm,psci-cpu-suspend":
> +				# Property is required and represents
> +				  psci-power-state parameter. Please refer to
> +				  [2] for PSCI bindings definition.

Should we just have the entry method nodes define their own properties
for this stuff?  I guess this goes back to the comment I made on some
other binding that it might be cleaner to have an explicit PSCI binding
rather than put PSCI explicitly in indiidual bindings.

> +	- entry-latency
> +		Usage: Required
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing worst case latency
> +			    in microseconds required to enter the idle state.

Why is this defined as an array?

> +	- cache-state-retained
> +		Usage: See definition
> +		Value type: <none>
> +		Definition: if present cache memory is retained on power down,
> +			    otherwise it is lost.

Might be better to define which caches?

> +		STATE1: state1 {
> +			compatible =3D "arm,cpu-idle-state";

Even if we stick with the node name being meaningful it'd be nice to
replace the STATEN here with a meaningful state name to improve
legibility. =20

--RI0j69zTdciYrvy/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTABbpAAoJELSic+t+oim9GhgP/1w6ypJcGw0z7VT5rRHp5+mI
DZOuktiMOsbKLdEsnakkokYHy01pXeVLjFr0RVM9Q8oX1BzL+Kq3OuhvMLv1kg/T
C/Oq1XPtrbCLtdrsp0jsPtlLAy6yvP/oIvFDGSToqO8R+7Rgd+cEPUd5O1u+QTwN
RsH8U1A9piipE8z+NUFXwX4pB2TbIwKUyK8kRV0uyafeBTdzAxAmKFKoLkAiI7T+
4Q8uqF7f8AFpr1AIT1X/CYMkxgeVKAbkaOnoWXa2Cx0Xdb8ve508i81ad0caRiXZ
MoJAHMjMP29UijWpFoY1+3IVlu0Fo6/9drJc/qL8sfF83naM2JtO2QQwCzp0QxQZ
lprC1YY7flct3NI7jpqeqBMqnB7iI87pugAIHdOes0S8Q0CYbDAwiYl0qqhq8pbS
9P4Ts2iee1+7S4vDBiuVGVuuknfJ9qOnt0H27NDKsmeVgFEMVYlU1c1L4CPP9c2z
60XmmwLUDiJu4qgP2t/R/q7RysXLHrEIctEqnFu68bHuQWvtBKg/Vgdkqej9DBIW
TaPNAoESStkYh09H36kHQAYAR0A8Xegt+lQ0liZTo1zrRZ3u8a0gjlAAXxCsSEk6
s1RgYSrTw0MpV1HK3VnmEmTQK88pfj/QuBACFLH20kanFb7/PsCOUlJRhm04q81b
qEWXR+35AyLhJrTcjCbO
=JpF2
-----END PGP SIGNATURE-----

--RI0j69zTdciYrvy/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
