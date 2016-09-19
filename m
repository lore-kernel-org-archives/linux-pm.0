From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
Date: Mon, 19 Sep 2016 10:44:28 +0800
Message-ID: <1474253068.23153.2.camel@intel.com>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
         <20160608195241.GA6805@rob-hp-laptop>
         <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leo Li <pku.leo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jia Hongtao <hongtao.jia-3arQi8VN3Tc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 三, 2016-09-14 at 11:40 -0500, Leo Li wrote:
> On Wed, Jun 8, 2016 at 2:52 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > 
> > On Tue, Jun 07, 2016 at 11:27:34AM +0800, Jia Hongtao wrote:
> > > 
> > > For different types of SoC the sensor id and endianness may vary.
> > > "#thermal-sensor-cells" is used to provide sensor id information.
> > > "little-endian" property is to tell the endianness of TMU.
> > > 
> > > Signed-off-by: Jia Hongtao <hongtao.jia-3arQi8VN3Tc@public.gmane.org>
> > > ---
> > > Changes for V2:
> > > * Remove formatting chnages.
> > > 
> > >  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7
> > > +++++++
> > >  1 file changed, 7 insertions(+)
> > Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Hi Zhang Rui,
> 
> Since you have applied the driver patch, can you also apply the
> binding patch?  The binding is supposed to go with the driver.
> 

Do you mean I should take both patch 1/7 and 7/7? I can not see the
other patches in this patch set.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
