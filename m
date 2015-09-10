From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 03/13] power: bq24257: Allow manual setting of input
 current limit
Date: Thu, 10 Sep 2015 15:50:29 +0300
Message-ID: <20150910125029.GE21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-4-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441757557-7266-4-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 08, 2015 at 07:12:27PM -0500, Andreas Dannenberg wrote:
> A new optional device property called "ti,current-limit" is introduced
> to allow disabling the D+/D- USB signal-based charger type auto-
> detection algorithm used to set the input current limit and instead to
> use a fixed input current limit.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Reviewed-by: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
