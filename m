From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 00/13] power: bq24257: Add support for bq24250/bq24251
Date: Thu, 10 Sep 2015 15:26:16 +0300
Message-ID: <20150910122616.GB21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441757557-7266-1-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 08, 2015 at 07:12:24PM -0500, Andreas Dannenberg wrote:
> This patch series extends the driver to also support bq24250/bq24251.
> 
> The bq24250/251/257 devices have a very similar feature set and are
> virtually identical from a control register point of view so it made
> sense to extend the existing driver rather than submitting a new driver.
> In addition to the new device support the driver is also extended to
> allow access to some device features previously hidden. Basic and
> potentially dangerous charger config parameters affecting the actual
> charging of the Li-Ion battery are only configurable through firmware
> rather than sysfs properties. However some newly introduced properties
> are exposed through sysfs properties as access to them may be desired
> from userspace. For example, it is now possible to manually configure
> the maximum current drawn from the input source to accommodate different
> chargers (0.5A, 1.5A, 2.0A and so on) based on system knowledge a
> userspace application may have rather than rely on the auto-detection
> mechanism that may not work in all possible scenarios.
> 
> Note that most patches have dependencies on other patches in the series.
> 
> v2:
> - Aligned DT bindings better with existing "ti,*" charger bindings
> - Dropped patch that improperly reported a missing battery as a dead
>   battery
> - Fixed (hopefully, that is -- still waiting for my test platform)
>   issue with how the private ACPI driver_data used to identify which
>   bq2425x device to use
> - Removed boolean DT/ACPI properties mostly by replacing them with more
>   intelligent handling in the driver
> - Rework/clarification of DT bindings doc
> - Renamed/refactored filenames/symbols from bq24257 to bq2425x to
>   better reflect that multiple devices are covered. Despite initial
>   hesitation I feel this is a good opportunity for some clean-up as
>   the driver is still very new in the Kernel so the change should be
>   low risk. This also addresses one of Andrew Davis' feedback items.
>   Plus, it makes for a nice alignment with the existing bq2415x_charger
>   driver.
I can't say I fully agree with this rename but, on the other hand, since you
work for the chip manufacturer, you probably know better what other chips
(if any), with the same naming scheme, are due to be released and make
sure they are registry compatible. Otherwise, it'll be fun.

For the entire patchset, please run it through 'checkpatch --strict'.
There are some minor style issues that are worth fixing.

Regarding the DT patch (on which I'll comment separately, after I go
through the entire patchset), make sure you put it before the code
implementing the binding [1].

[1] Documentation/devicetree/bindings/submitting-patches.txt

laurentiu

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
