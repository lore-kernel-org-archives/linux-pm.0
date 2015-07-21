From: Mason <slash.tmp@free.fr>
Subject: Re: Using a temperature sensor with 1-bit output for CPU throttling
Date: Tue, 21 Jul 2015 13:49:24 +0200
Message-ID: <55AE31C4.9030100@free.fr>
References: <553F6E85.5090402@free.fr> <5540E0E1.6080504@free.fr> <20150429163605.GM3054@e104805> <55AE0C7F.40506@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <55AE0C7F.40506@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-pm@vger.kernel.org

On 21/07/2015 11:10, Mason wrote:

> I don't understand this behavior from the governor:
>=20
> [   27.557494] thermal thermal_zone0: last_temperature=3D0, current_t=
emperature=3D51000
> [   27.583626] thermal thermal_zone0: Trip0[type=3D1,temp=3D70000]:tr=
end=3D1,throttle=3D0
> [   27.590961] thermal cooling_device0: cur_state=3D0
> [   27.595672] thermal cooling_device0: old_target=3D-1, target=3D-1
> [   27.601473] thermal cooling_device0: zone0->target=3D4294967295
> [   27.607263] thermal cooling_device0: set to state 0
>=20
> [   40.643340] thermal thermal_zone0: last_temperature=3D51000, curre=
nt_temperature=3D46000
> [   40.669930] thermal thermal_zone0: Trip0[type=3D1,temp=3D70000]:tr=
end=3D2,throttle=3D0
> [   40.677217] thermal cooling_device0: cur_state=3D0
> [   40.681873] thermal cooling_device0: old_target=3D-1, target=3D4
> [   40.687579] thermal cooling_device0: zone0->target=3D4
> [   40.692669] thermal cooling_device0: set to state 4
>=20
> The first temperature read =3D 51=C2=B0C (below the 70=C2=B0C trip po=
int).
> Next read =3D 46=C2=B0C (still below the trip point) and even though
> the governor claims throttle=3D0, it sets the cooling state to 4
> (so minimal frequency if I understand correctly).

Never mind. This is due to a bug that was fixed almost a year ago.
(commit 26bb0e9a1a938ec98ee07aa76533f1a711fba706)

I've requested the fix be back-ported to linux-3.14.y
http://thread.gmane.org/gmane.linux.kernel.stable/143070

Regards.

