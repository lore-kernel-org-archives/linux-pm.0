From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 08/13] power: bq24257: Add charge type setting support
Date: Thu, 10 Sep 2015 16:56:22 +0300
Message-ID: <20150910135622.GJ21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-9-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441757557-7266-9-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 08, 2015 at 07:12:32PM -0500, Andreas Dannenberg wrote:
> The bq2425x devices support charging with a configurable charge current
> i_chg or a specific fixed low-current in what's called Low Charge mode.
> This patch exposes access to the Low Charge mode through a POWER_
> SUPPLY_PROP_CHARGE_TYPE sysfs property value of POWER_SUPPLY_CHARGE_
> TYPE_TRICKLE. It also allows to completely disable charging if desired
> by setting the property to POWER_SUPPLY_CHARGE_TYPE_NONE. Normal
> charging with the configured i_chg current is activated through
> POWER_SUPPLY_CHARGE_TYPE_FAST (default).
> 
> Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>

I have some questions here. Are there any cases in the wild, when
userspace selects the charging type (apart from testing purposes)? And
if yes, how is userspace supposed to detect/decide when to switch from
trickle to fast?

I have the strange feeling that we're adding properties that will never
be used... Other people's opinions are welcomed too.

laurentiu
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
