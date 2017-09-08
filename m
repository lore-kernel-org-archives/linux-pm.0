From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity values for bq27421
Date: Fri, 8 Sep 2017 19:44:00 +0200
Message-ID: <584BDB47-100E-4DB6-B5F5-A701FFC8C096@goldelico.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com> <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com> <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com> <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com> <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com> <CAKvHMgT6AHfjnXvD5jeWP_9wAm_GQNJxm=Nm1jH32NeaVZjdYw@mail.gmail.com> <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com> <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com> <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com> <20170908174033.GC23140@pali>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908174033.GC23140@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-pm@vger.kernel.org


> Am 08.09.2017 um 19:40 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
>=20
> On Friday 08 September 2017 19:38:37 H. Nikolaus Schaller wrote:
>> and here is the result:
>>=20
>>> root@letux:~# dmesg|fgrep bq27
>>> [   10.391235] bq27xxx_battery_setup
>>> [   10.391265] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
>>> [   10.393798] (NULL device *): hwmon: 'bq27500-1-0' is not a valid =
name attribute, please fix
>=20
> Hi! IIRC hwmon name cannot contain '-'. Use '_' instead.

Yes. I'd like to see it fixed as well...

AFAIR it is a general problem outside of battery drivers and IMHO there =
is some note somewhere.
Nobody "uses" a '-'. It is some logic that automatically creates node =
names which hwmon rejects.

BR,
Nikolaus
