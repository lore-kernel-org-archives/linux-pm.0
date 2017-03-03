From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH] PM / OPP: Documentation: Fix opp-microvolt in examples
Date: Fri, 03 Mar 2017 23:43:09 +0100
Message-ID: <2085253.6mAybrNraj@aspire.rjw.lan>
References: <e527318dc8b5a1acf260499c65cf025732d9fc51.1488365712.git.viresh.kumar@linaro.org> <756a9b97-ba24-4cc2-7236-b3bd94d74f6f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <756a9b97-ba24-4cc2-7236-b3bd94d74f6f-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Friday, March 03, 2017 09:28:05 AM Stephen Boyd wrote:
> On 03/01/2017 03:09 AM, Viresh Kumar wrote:
> > The triplet present in "opp-microvolt" property should be in the order
> > <target min max>, while all the examples have it in the order
> > <min target max>.
> >
> > Fix it.
> >
> > Luckily all of the users of "opp-microvolt" property have applied brain
> > instead of copying the examples from documentation and none of the
> > actual dts files have it wrong.
> >
> > Reported-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> Did you want a fixes tag too? Sure it's just documentation.

It's in the Linus' tree already.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
