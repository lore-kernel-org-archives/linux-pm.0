From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] the generic thermal layer enhancement
Date: Thu, 31 May 2012 13:54:44 +0800
Message-ID: <1338443684.1472.237.camel@rui.sh.intel.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
	 <20120530125035.GA17379@srcf.ucam.org>
	 <1338436491.1472.223.camel@rui.sh.intel.com>
	 <20120531035821.GA1587@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120531035821.GA1587@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amit.kachhap@linaro.org
List-Id: linux-pm@vger.kernel.org

On =E5=9B=9B, 2012-05-31 at 04:58 +0100, Matthew Garrett wrote:
> On Thu, May 31, 2012 at 11:54:51AM +0800, Zhang Rui wrote:
> > On =E4=B8=89, 2012-05-30 at 13:50 +0100, Matthew Garrett wrote:
> > > The existing algorithm provides a generic mechanism for=20
> > > balancing performance and thermal output, with the only requireme=
nt=20
> > > being that the platform provide constants that represent the heat=
ing and=20
> > > cooling properties of the system.
> > >=20
> > I'm not sure if this could work on their platforms. So I'm just loo=
king
> > for an easier way to handle this, i.e. make generic thermal layer
> > simple, and provide the flexibility for platform drivers to do thei=
r own
> > tricks.
>=20
> If it's not possible for a platform to use the existing generic appro=
ach=20
> then we should certainly provide a way for them to handle that, but=20
> first I'd like to see evidence that it's impossible for them to use t=
he=20
> existing generic approach. This kind of conversation is better with r=
eal=20
> world examples :)

Agreed.

Amit, do you have any update on this? :)

>=20
> > > > G4. Multiple passive trip points
> > >=20
> > > It would be good to have an explanation of the use case here. If =
it's=20
> > > acceptable for the device to be at the lower passive trip point, =
why are=20
> > > we slowing it down at all?
> > >=20
> > acceptable does not equal comfortable?
> > Say, I'd like to use the computer at 30C skin temperature.
> > I'm okay with the temperature at 50C, but it would be nice if it ca=
n be
> > lower, even if the system would be slower, but not too slow (T-stat=
e).
> > If the temperature is higher than 60, it is not usable for me, I'll=
 wait
> > for a while, the system can do everything they want do cool the sys=
tem
> > down (but hibernate/shutdown would be not a good idea at this time
> > because it is hot enough for some hardware damage).
>=20
> Ok, that seems reasonable.
>=20
Great!

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
