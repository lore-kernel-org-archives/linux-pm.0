From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] PM / OPP: compatible is an optional property
Date: Fri, 23 Sep 2016 14:55:12 -0500
Message-ID: <20160923195510.GA8699@rob-hp-laptop>
References: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
 <483bea3c-a1b4-ce5d-e720-d69fc943ab50@codeaurora.org>
 <20160923051526.GB17336@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160923051526.GB17336@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 23, 2016 at 10:45:26AM +0530, Viresh Kumar wrote:
> On 22-09-16, 12:24, Stephen Boyd wrote:
> > On 09/21/2016 02:32 AM, Viresh Kumar wrote:
> > > It was never compulsory to have a compatible string in the OPP table.
> > > Fix the documentation to mark it optional.
> > >

NAK.

> > > Also update its description a bit.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > ---
> > 
> > Why? I'd prefer the compatible string to be required so we know what
> > sort of node it is.

Agreed.

> Okay, the code doesn't have any checks for it then and that needs to be fixed.

Why? The kernel is not a DT validator.
 
> Just for my clarity, for platforms with special OPP bindings and so a different
> compatible string like: "operating-points-v2-XYZ", should the compatible string
> contain both "operating-points-v2" and the above one? It would be easier to
> check for "operating-points-v2" in that case from core code.

That would imply operating-points-v2-XYZ has extra properties or is 
different in some way. If an OS only understanding operating-points-v2 
will work, then yes it should have both. If not, then no.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
