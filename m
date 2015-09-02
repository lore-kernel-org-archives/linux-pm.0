From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 2 Sep 2015 13:36:39 +0530
Message-ID: <20150902080639.GA26744@linux>
References: <20150811080023.GB5509@linux>
 <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux>
 <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux>
 <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux>
 <20150826120628.GZ19409@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150826120628.GZ19409@x1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 26-08-15, 13:06, Lee Jones wrote:
> On Wed, 12 Aug 2015, Viresh Kumar wrote:
> 
> > On 11-08-15, 16:17, Lee Jones wrote:
> > > This would work if we only had a single variable to contend with, but
> > > what I showed you in my previous example is that we have 3 variables
> > > to consider; cut (version), pcode and substrate.
> > > 
> > > Using the two (simple) examples I provided, how would your suggestion
> > > look in our case?
> > 
> > So the solution I gave is for picking the microvolt based on pcode.
> > The other two (cut, substrate) aren't about picking microvolt, but if
> > the OPP is available or not. Right?
> 
> 'pcode', 'cut' and 'substrate' all determine whether a given set of
> OPPs an be used on the running platform.  I do not believe that you
> can differentiate between them. 
> 
> > If these terms are generic enough, then we can add something similar
> > to what you have added..
> 
> If it makes it easier, you can treat them as version numbers 2.2.1
> <pcode.cut.substrate>, but I don't see how this can help.  Obviously
> this becomes more difficult when you add wild cards to the OPPs, where
> a particular OPP would be suitable for all cuts for example.
> 
> If you still think you can come up with a generic method to lay out
> CPUFreq OPP nodes that will satisfy all vendors and not be a mass of
> 10's of separate nodes, then great.  Again, I'm struggling to see how
> that might be possible.
> 
> What I believe we shouldn't do, is have this blocked forever for the
> sake of adding a couple of vendor properties however.

I agree and can understand the pain you are feeling..

@Rob/Stephen: Please close this thread soon and let Lee get his work
done :)

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
