From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 11/20] power_supply: Change ownership from driver to core
Date: Thu, 26 Feb 2015 12:31:13 +0100
Message-ID: <1424950273.19456.7.camel@AMDC1943>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
 <1424692061-30624-12-git-send-email-k.kozlowski@samsung.com>
 <20150226004522.GB885@earth> <20150226061438.GB7331@fury.dvhart.com>
 <1424950097.19456.4.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-reply-to: <1424950097.19456.4.camel@AMDC1943>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, platform-driver-x86@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On czw, 2015-02-26 at 12:28 +0100, Krzysztof Kozlowski wrote:
> On =C5=9Bro, 2015-02-25 at 22:14 -0800, Darren Hart wrote:
> > On Thu, Feb 26, 2015 at 01:45:22AM +0100, Sebastian Reichel wrote:
>=20
> (...)
>=20
> > > I would like to merge this via the power supply subsystem. Some o=
f
> > > the files being patched are not under my maintainence, though. It
> > > would be nice if I get an Acked-By from their maintainers.
> > >=20
> > > As far as I can see this patch is currently missing feedback from=
:
> > >=20
> > > arch/x86/platform/olpc: x86 Maintainers
> > > drivers/acpi: Rafael J. Wysocki, Len Brown
> > > drivers/hid: Jiri Kosina
> > > drivers/platform/x86: Darren Hart
> >=20
> > For compal-laptop.c:
> >=20
> > Acked-by: Darren Hart <dvhart@linux.intel.com>

(previous mail sent by mistake)

Hi Darren,

Could you also look at my other fixes sent few days ago:
https://lkml.org/lkml/2015/2/20/158
compal-laptop: Check return value of power_supply_register

It touches the same line so the patchset power-supply-rework depends on
it to avoid conflicts. If the fix looks OK, maybe it could go through
Sebastian's tree with your ack?

Best regards,
Krzysztof
