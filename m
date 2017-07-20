From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: Re: [PATCH] devfreq: Convert to using %pOF instead of full_name
Date: Thu, 20 Jul 2017 05:25:53 +0000
Message-ID: <20170720052553epcms1p24dc190a0d51f2e447a76e417e519bd28@epcms1p2>
References: <596EB809.7050605@samsung.com>
        <20170718214339.7774-17-robh@kernel.org>
        <CGME20170718214411epcas2p43fc1475c80245889737ba9e731497e38@epcms1p2>
Reply-To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <596EB809.7050605-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

> On 2017년 07월 19일 06:42, Rob Herring wrote:

> > Now that we have a custom printf format specifier, convert users of

> > full_name to use %pOF instead. This is preparation to remove storing

> > of the full path string for each node.

> > 

> > Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> > Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> > Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> > Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> > Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> > ---

> >  drivers/devfreq/devfreq-event.c | 4 ++--

> >  1 file changed, 2 insertions(+), 2 deletions(-)

> > 

> > diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c

> > index 8648b32ebc89..d67242d87744 100644

> > --- a/drivers/devfreq/devfreq-event.c

> > +++ b/drivers/devfreq/devfreq-event.c

> > @@ -277,8 +277,8 @@ int devfreq_event_get_edev_count(struct device *dev)

> >  						sizeof(u32));

> >  	if (count < 0) {

> >  		dev_err(dev,

> > -			"failed to get the count of devfreq-event in %s node\n",

> > -			dev->of_node->full_name);

> > +			"failed to get the count of devfreq-event in %pOF node\n",

> > +			dev->of_node);

> >  		return count;

> >  	}

> > 

> 

> Reviewed-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> 



Acked-by: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>






--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
