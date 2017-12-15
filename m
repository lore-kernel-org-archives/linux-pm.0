From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 01/11] dt-bindings: thermal: Describe Armada AP806
 and CP110
Date: Fri, 15 Dec 2017 11:52:30 +0100
Message-ID: <20171215115230.6fb83cb6@xps13>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
        <20171214103011.24713-2-miquel.raynal@free-electrons.com>
        <20171215082759.7t24ka3lpkulcb7r@tarshish>
        <20171215093203.74b7a59c@xps13>
        <87po7gmlcs.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87po7gmlcs.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Baruch and Gregory,

On Fri, 15 Dec 2017 09:44:19 +0100
Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi Miquel,
>  
>  On ven., déc. 15 2017, Miquel RAYNAL
> <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > Hello Baruch,
> >
> > On Fri, 15 Dec 2017 10:27:59 +0200
> > Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> >  
> >> Hi Miquel
> >> 
> >> On Thu, Dec 14, 2017 at 11:30:01AM +0100, Miquel Raynal wrote:  
> >> > +- marvell,thermal-zone-name: The name to identify the thermal
> >> > zone
> >> > +                             within the sysfs, useful when
> >> > multiple
> >> > +                             thermal zones are registered (AP,
> >> > CPx...).    
> >> 
> >> I don't think that would be acceptable. DT is about describing the
> >> hardware. sysfs is a Linux implementation detail which is not tied
> >> to any specific hardware. If this is accepted, the property should
> >> be named 'linux,thermal-zone-name'.  
> >
> > You are right the sysfs mention should not appear in the
> > description.

Actually, you are right for all of it, this property should not
exist, sorry for my too quick answer.

> >
> > Otherwise for the naming I'm not sure "linux," is a valid prefix in
> > that case.  

Thank you both for your explanations, I was also wrong about the prefix.

> 
> Actually the choice between linux or marvell make me realize that
> there is something wrong. Having a name associated to a device is
> something pretty usual with the device tree, however it is as the
> class device level, such as clock-names, line-name, or
> regulator-name. So in my opinion if we want to support naming from
> device tree it would be done for all the thermal device not just for
> the Marvell one.
> 
> However I don't think we need it. For example for the clocks we
> created the name dynamically using of the base address of the
> register to keep them unique.

I was convinced that dev_name's would be the same but after trying it on
a 8040-DB, using dev_name(&pdev->dev) gives:

    f06f808c.thermal
    f2400078.thermal
    f4400078.thermal

which I found meaningful enough.

I will drop the property and use dev_name instead. I still need your
help to solve one problem though: how to make the distinction between
using "armada_thermal" (the previous name) and dev_name() ? If I don't
it kind of breaks userspace, doesn't it ?

Thank you,
Miquèl

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
