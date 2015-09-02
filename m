From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/13] power: bq24257: Add support for bq24250/bq24251
Date: Wed, 2 Sep 2015 11:07:54 +0300
Message-ID: <20150902080754.GE12822@lpalcu-desk>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 31, 2015 at 09:10:22PM -0500, Andreas Dannenberg wrote:
> This patch series extends the driver to also support bq24250/bq24251. Most
> patches have dependencies on other patches in the series but I left them spread
> out so that one can better understand the change history. However I can
> certainly fold them together and resubmit if needed.
> 
> The bq24250/251/257 devices have a very similar feature set and are virtually
> identical from a control register point of view so it made sense to extend the
> existing driver rather than submitting a new driver. In addition to the new
> device support the driver is also extended to allow access to some device
> features previously hidden. As per offline discussion with Laurentiu the basic
> and potentially dangerous charger config parameters affecting the actual
> charging of the Li-Ion battery are still only configurable through firmware
> rather than sysfs properties. However some newly introduced properties are
> exposed through sysfs properties as access to them may be desired from
> userspace. For example, it is now possible to manually configure the maximum
> current drawn from the input source to accommodate different chargers (0.5A,
> 1.5A, 2.0A and so on) based on system knowledge a userspace application may
> have rather than rely on the auto-detection mechanism that may not work in
> all possible scenarios.
> 
> Laurentiu-- I've spent quite some time testing the driver however the one piece
> I could not test was the ACPI integration due to lack of suitable HW. For this
> do you think you could give this a quick try?  I'm particularly interested if
> the private driver data from the bq24257_acpi_match[] structure gets properly
> passed down into bq24257_probe(). 
I'll comment on this on the patch itself.

> Also if you could recommend an embedded HW platform that I could
> generally use to test ACPI support I'd appreciate that (MinnowBoard
> MAX?).
I suppose you could use a Minnow Max quite well, if you wish. It has I2C
pins available on the Low Speed Expansion connector and you could easily
connect an EVB to it. You'll need to override the ACPI tables though, in
order to add your own device description.

laurentiu
 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
