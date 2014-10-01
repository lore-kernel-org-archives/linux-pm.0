From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] thermal: Add QPNP PMIC temperature alarm driver
Date: Wed, 01 Oct 2014 14:36:28 +0300
Message-ID: <1412163388.26751.39.camel@iivanov-dev>
References: <1411651825-14240-1-git-send-email-iivanov@mm-sol.com>
		  <54254C4E.3070807@smartplayin.com> <1411998865.5395.5.camel@iivanov-dev>
		 <542A31DF.7020402@smartplayin.com> <1412062606.5395.10.camel@iivanov-dev>
	 <542B088A.1050601@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <542B088A.1050601-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Collins <collinsd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-09-30 at 12:46 -0700, Stephen Boyd wrote:
> On 09/30/14 00:36, Ivan T. Ivanov wrote:
> > On Tue, 2014-09-30 at 10:00 +0530, Kiran Padwal wrote:
> >>
> >> I have Linaro cross tool chain with version-4.8.3 and I am simply doing "make zImage" without any option.
> > Hm, no warnings with arm-unknown-linux-gnueabi-gcc (GCC) 4.6.3 and
> > arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.9-2014.09, but
> > indeed arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.8-2014.03.
> >
> > I will say that this is false positive :-). Please update your tool-chain.
> 
> Hopefully you're joking. Once this merges someone will find the warning
> and complain. Telling them to upgrade their compiler isn't going to work.

If it is known to be buggy why not?

> 
> I wonder if checking for rc != 0 instead of rc < 0 would silence the
> warning? 

No. Anyway, will find some way to silence this warning.

Thanks,
Ivan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
