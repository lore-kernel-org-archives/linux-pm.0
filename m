From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] cpufreq: qoriq: Register cooling device based on device
 tree
Date: Tue, 24 Nov 2015 09:24:23 -0800
Message-ID: <20151124172422.GA14845@localhost.localdomain>
References: <1448348129-46675-1-git-send-email-hongtao.jia@freescale.com>
 <1448374697.27264.308.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448374697.27264.308.camel-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Jia Hongtao <hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 24, 2015 at 08:18:17AM -0600, Scott Wood wrote:
> On Tue, 2015-11-24 at 14:55 +0800, Jia Hongtao wrote:
> > Register the qoriq cpufreq driver as a cooling device, based on the
> > thermal device tree framework. When temperature crosses the passive trip
> > point cpufreq is used to throttle CPUs.
> > 
> > Signed-off-by: Jia Hongtao <hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Reviewed-by: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> When did I add "Reviewed-by" to this?

This is typically why I prefer seeing people emailing their reviewed-by
and acked-by to the mailing list in reply to the patch itself, instead
of getting a patch with all the honors already added. :-/

> 
> -Scott
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
