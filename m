From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 18 Feb 2011 19:28:05 +0100
Message-ID: <201102181928.05911.rjw__5680.42558520592$1298053829$gmane$org@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<AANLkTikRUZRh0YnP8nYTKFnFeUiJbK5xKvHHjn_S+gZE@mail.gmail.com>
	<AANLkTinsPqFcodH0w7LQeFEY+amodNH4CneRCRhhbKaz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinsPqFcodH0w7LQeFEY+amodNH4CneRCRhhbKaz@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rabin Vincent <rabin@rab.in>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, February 18, 2011, Rabin Vincent wrote:
> On Thu, Feb 17, 2011 at 20:55, Rabin Vincent <rabin@rab.in> wrote:
> > This will solve the platform vs AMBA bus, but shouldn't we really be
> > aiming for consistent behaviour between these and the other busses such
> > as I2C and SPI, which are also usually commonly used on the same
> > platforms and are using GENERIC_PM_OPS?
> >
> > Should we be auditing all platform drivers and then switch platform to
> > the GENERIC_PM_OPS?
> >
> > Or should the two points (1) and (2) be not handled in the bus at all
> > and be left to individual drivers (in which case we should audit i2c and
> > spi and change GENERIC_PM_OPS)?
> 
> How about something like the below?  If we have something like this, we
> can just switch platform to GENERIC_PM_OPS and add the
> pm_runtime_want_interaction() (or something better named) call to the
> i2c and spi drivers using runtime PM.

Why don't we make platform_bus_type behave along the lines of generic ops
instead?

Rafael
