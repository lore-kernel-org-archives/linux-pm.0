From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: System suspend states and device driver suspend() callback
Date: Fri, 16 Aug 2013 13:32:32 +0200
Message-ID: <17024788.0xFN8jEV59@vostro.rjw.lan>
References: <CADRPPNSD+uj_t5+qbNW29y7SuJkB_vMck-DGFJFV4A0AmPC6pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADRPPNSD+uj_t5+qbNW29y7SuJkB_vMck-DGFJFV4A0AmPC6pQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 16, 2013 04:06:26 PM Li Yang wrote:
> Hi Guys,
>=20
> Is there a standard way for the device drivers to know if the system
> is going to =E2=80=9Cstandby=E2=80=9D mode or =E2=80=9Cmem=E2=80=9D m=
ode when the suspend() callbacks
> are called?

No, there's none.

What do you need that for?

Rafael
