From: Rabin Vincent <rabin@rab.in>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Sat, 19 Feb 2011 00:55:28 +0530
Message-ID: <AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV__20865.3291142129$1298057222$gmane$org@mail.gmail.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<AANLkTikRUZRh0YnP8nYTKFnFeUiJbK5xKvHHjn_S+gZE@mail.gmail.com>
	<AANLkTinsPqFcodH0w7LQeFEY+amodNH4CneRCRhhbKaz@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102181928.05911.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 18, 2011 at 23:58, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, February 18, 2011, Rabin Vincent wrote:
>> On Thu, Feb 17, 2011 at 20:55, Rabin Vincent <rabin@rab.in> wrote:
>> > This will solve the platform vs AMBA bus, but shouldn't we really be
>> > aiming for consistent behaviour between these and the other busses such
>> > as I2C and SPI, which are also usually commonly used on the same
>> > platforms and are using GENERIC_PM_OPS?
>> >
>> > Should we be auditing all platform drivers and then switch platform to
>> > the GENERIC_PM_OPS?
>> >
>> > Or should the two points (1) and (2) be not handled in the bus at all
>> > and be left to individual drivers (in which case we should audit i2c a=
nd
>> > spi and change GENERIC_PM_OPS)?
>>
>> How about something like the below? =A0If we have something like this, we
>> can just switch platform to GENERIC_PM_OPS and add the
>> pm_runtime_want_interaction() (or something better named) call to the
>> i2c and spi drivers using runtime PM.
>
> Why don't we make platform_bus_type behave along the lines of generic ops
> instead?

At least drivers/spi/omap2_mcspi.c, drivers/video/sh_mobile_lcdcfb.c and
drivers/watchdog/omap_wdt.c are some pm_runtime-using drivers which seem
to do different things in their runtime vs normal suspend/resume
routines, so forcing platform into the active-on-resume behaviour of the
generic ops may make some use cases impossible.  Conversion of more OMAP
drivers to runtime pm appears to be ongoing so I'd imagine we'd be
seeing more of this.  Perhaps Kevin or Magnus will have a comment here.
The same thing applies to AMBA drivers.

Looking at the i2c drivers using runtime pm in comparison, they all seem
to be using straightforward UNIVERSAL_PM_OPS-style code with the runtime
and the system sleep doing the same things.  So maybe we do need to
treat platform/AMBA different from the I2C/SPI group?
