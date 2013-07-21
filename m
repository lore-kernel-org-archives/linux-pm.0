From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [lm-sensors] [RESEND PATCH V1 0/9] thermal: introduce DT thermal
 zone build
Date: Sun, 21 Jul 2013 03:14:37 -0700
Message-ID: <20130721101437.GB24303@roeck-us.net>
References: <1374074248-31690-1-git-send-email-eduardo.valentin@ti.com>
 <20130717220942.GB990@roeck-us.net> <51E7F341.8020508@ti.com>
 <20130718211154.GB4110@roeck-us.net> <51E9413C.2080007@ti.com>
 <51E98941.2090306@wwwdotorg.org> <51E98BD3.8000307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51E98BD3.8000307-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 19, 2013 at 02:56:19PM -0400, Eduardo Valentin wrote:
> On 19-07-2013 14:45, Stephen Warren wrote:
> > On 07/19/2013 07:38 AM, Eduardo Valentin wrote:
> >> On 18-07-2013 17:11, Guenter Roeck wrote:
> >>> On Thu, Jul 18, 2013 at 09:53:05AM -0400, Eduardo Valentin
> >>> wrote:
> >>>> Hello Guenter,
> >>>>
> >>>> On 17-07-2013 18:09, Guenter Roeck wrote:
> >>>>> On Wed, Jul 17, 2013 at 11:17:19AM -0400, Eduardo Valentin
> >>>>> wrote:
> >>>>>> Hello all,
> >>>>>>
> >>>>>> As you noticed, I am working in a way to represent thermal
> >>>>>> data using device tree [1]. Essentially, this should be a
> >>>>>> way to say what to do with a sensor and how to associate
> >>>>>> (cooling) actions with it.
> >>>>>>
> >>>>> Seems to me that goes way beyond the supposed scope of
> >>>>> devicetree data. Devicetree data is supposed to describe
> >>>>> hardware, not its configuration or use. This is clearly a use
> >>>>> case.
> >>>>
> >>>> Thanks for rising your voice here. It is important to know what
> >>>> hwmon ppl think about this.
> >>>>
> >>> Sorry, I don't know what ppl stands for.
> >>>
> >>>>>
> >>>>> Guenter
> >>>>
> >>>> As your answers to the series are giving same argument, I chose
> >>>> to answer on patch 0. I would be happier if you could elaborate
> >>>> a bit more on your concern, specially if you take hwmon cap
> >>>> here, and give your view with that perspective.
> >>>>
> >>>> I also considered that this work could be abusing of DT
> >>>> purposes. But let me explain why I still think it makes sense
> >>>> to have it.
> >>>>
> >>> Ultimately, you are making my point here. If you considered it,
> >>> did you ask devicetree experts for an opinion ? Did you discuss
> >>> the subject on the devicetree-discuss mailing list ? If so, what
> >>> was the result ?
> >>
> >> Although I have asked, I didn't get any feedback. 
> >> https://lkml.org/lkml/2013/4/11/760
> >>
> >> But now I am requesting feedback in a formal (patch) way.
> >>
> >> Consider this patch series as official request for (devicetree
> >> experts and everyone involved) opinions.
> > 
> > I might suggest (a) sending the email "To" the DT maintainer, rather
> > than just CC'ing him, (b) perhaps start a new thread just to present
> > the proposed DT binding, and get feedback on that. A thread with a new
> > subject like "[RFC] DT binding for thermal zones" might get more
> > attention than a patch submission; the subject line of this patch
> > doesn't stand much (since it implies to me it's more about build
> > issues than DT bindings even though it does mention DT).
> > 
> 
> OK. I will do that.  Sounds reasonable. Resending this series as RFC
> again, but now addressed to DT folks.
> 
It might help to not just send the series, but to start a thread to discuss
the proposed bindings.

Guenter
