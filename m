From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 10/13] power: bq24257: Add various device-specific
 sysfs properties
Date: Thu, 10 Sep 2015 17:13:32 +0300
Message-ID: <20150910141331.GL21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-11-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441757557-7266-11-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 08, 2015 at 07:12:34PM -0500, Andreas Dannenberg wrote:
> This patch adds support to enable/disable some device specific features
> through device properties at boot time or sysfs properties at runtime
> depending on whether they should be accessible during runtime or not.
> The use of those features is be optional however they might be helpful
> in certain scenarios:
> 
> * High-impedance mode enable/disable (through sysfs r/w)
> * Sysoff enable/disable (through sysfs r/w)
> * 2X Timer enable/disable (through "ti,safety-timer-2x-enable" dev
>   property)
> 
> If not explicitly modified those settings are left at their device-
> specific power-on defaults. Refer to the respectice device datasheets
> for more information:
> 
> http://www.ti.com/product/bq24250
> http://www.ti.com/product/bq24251
> http://www.ti.com/product/bq24257
> 
> Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>

I'm OK with adding these properties, but I'll wait for your explanation
on the mutex patch since I really don't think you need it, except for
protecting chip state data.

laurentiu
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
