From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 1/5] PM / Runtime: Add getter for quering the IRQ safe
 option
Date: Thu, 25 Sep 2014 09:28:09 +0200
Message-ID: <1411630089.8568.7.camel@AMDC1943>
References: <1411566612-32277-1-git-send-email-k.kozlowski@samsung.com>
 <1411566612-32277-2-git-send-email-k.kozlowski@samsung.com>
 <20140924175302.GB1231@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20140924175302.GB1231@amd>
Sender: linux-doc-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On =C5=9Bro, 2014-09-24 at 19:53 +0200, Pavel Machek wrote:
> On Wed 2014-09-24 15:50:08, Krzysztof Kozlowski wrote:
> > Add a simple getter pm_runtime_is_irq_safe() for quering whether ru=
ntime
> > PM IRQ safe was set or not.
> >=20
> > Various bus drivers implementing runtime PM may use choose to suspe=
nd
> > differently based on IRQ safeness status of child driver (e.g. do n=
ot
> > unprepare the clock if IRQ safe is not set).
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Are you sure this is good interface?
>=20
> "Tell me if another function works this or that way".
>=20
> That's certainly not traditional interface, and it seems dangerous to
> me. Callbacks now have different semantic requirements based on value
> of some flag...

Yes... but to me that semantic change looks similar to the PM runtime
code which behaves differently when the flag is set. Some PM runtime
functions might sleep or might not... depending on the flag.

> Would it be possible to have two sets of callbacks, one irq safe and
> one not?

That would require changing the callbacks during probe of each driver.
It is possible - I'm fine with that. However we still would need some
kind of interface for selecting the callbacks according to irq safe
status - something like pm_runtime_is_irq_safe():

static int amba_probe(struct device *dev)
{
=2E..
	if (pm_runtime_is_irq_safe())
		dev->driver->pm =3D &amba_pm_irq_safe;
	else
		dev->driver->pm =3D &amba_pm;

Best regards,
Krzysztof


