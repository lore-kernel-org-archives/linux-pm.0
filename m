From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RESEND] thermal: Add QPNP PMIC temperature alarm driver
Date: Wed, 24 Sep 2014 23:30:57 +0300
Message-ID: <1411590657.9536.1.camel@mm-sol.com>
References: <1410793383-30097-1-git-send-email-iivanov@mm-sol.com>
	 <20140915153052.GB27076@developer> <1411570570.18580.72.camel@iivanov-dev>
	 <20140924182410.GD27076@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140924182410.GD27076@developer>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Collins <collinsd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-09-24 at 14:24 -0400, Eduardo Valentin wrote:
> Hello Ivan,
> 
> On Wed, Sep 24, 2014 at 05:56:10PM +0300, Ivan T. Ivanov wrote:
> > On Mon, 2014-09-15 at 11:30 -0400, Eduardo Valentin wrote:
> > > Hey Ivan,
> > > 
> > > Please give us at least a two weeks time frame before resending your
> > > patches.
> > 
> > Hi Eduardo, 
> > 
> > Should I wait for more comments or I can post updated
> > version of this patch?
> > 
> 
> Please, if you have a new version, I would prefer you send it as V2. I
> am specially interested about the cooling parts of it, and the DT usage.

I really don't know what to say about cooling, there is no cooling.
It is supposed that system just shut down, in case of overheat, 
I believe.

Regards,
Ivan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
