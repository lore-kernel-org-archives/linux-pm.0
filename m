From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Sat, 18 Dec 2010 13:54:57 +0100
Message-ID: <201012181354.58077.rjw__43219.5325302475$1292677053$gmane$org@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201012180001.25263.rjw@sisk.pl>
	<20101218010454.GA2430@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101218010454.GA2430@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, December 18, 2010, Mark Brown wrote:
> On Sat, Dec 18, 2010 at 12:01:25AM +0100, Rafael J. Wysocki wrote:
> > On Friday, December 17, 2010, Mark Brown wrote:
> 
> > > 	if (pm) {
> > > 		if (pm_runtime_suspended(dev))
> > > 			return 0;
> > > 		else
> > > 			return pm->suspend ? pm->suspend(dev) : 0;
> > > 	}
> 
> > > 	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> > > }
> 
> > > Ideally the if (pm) block could just be factored out into the pm core as
> > > there's nothing I2C-specific about that at all.  Possibly even the whole
> > > logic surrounding fall back to legacy, though that smells a bit.
> 
> > No, the legacy is i2c-specific.
> 
> SPI and platform (the first two buses I looked at) both seem to have
> legacy suspend operations too?  Clearly the bus would need to provide an
> op to invoke the legacy call but the logic which prioritises the pm_ops
> over the legacy operation is generic.

Well, the problem with that is the driver would need to tell the generic call
what the legacy routine is and there's no, er, generic way to do that.

In the i2c case, for example, there is struct i2c_driver that contains the
->suspend() and ->resume() pointers, so the bus type driver _knows_ how to
get there, but the PM core doesn't have this information.

Thanks,
Rafael
