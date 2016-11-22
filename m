From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/3] thermal: handle get_temp() errors properly
Date: Tue, 22 Nov 2016 14:27:13 -0800
Message-ID: <20161122222712.GA53509@google.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <20161119034158.GA26405@localhost.localdomain>
 <20161119053014.GA58324@google.com>
 <1479801145.2360.24.camel@intel.com>
 <20161122110045.GB2018@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161122110045.GB2018-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 03:00:47AM -0800, Eduardo Valentin wrote:
> On Tue, Nov 22, 2016 at 03:52:25PM +0800, Zhang Rui wrote:
> > On Fri, 2016-11-18 at 21:30 -0800, Brian Norris wrote:
> > > On Fri, Nov 18, 2016 at 07:41:59PM -0800, Eduardo Valentin wrote:
> > > > I would prefer we consider the patch I sent
> > > > some time ago:
> > > > https://patchwork.kernel.org/patch/7876381/
> > > Honestly I didn't look that deeply into the framework here (and I
> > > also
> > > don't use CONFIG_THERMAL_EMULATION), I was just fixing something that
> > > was obviously wrong.
> 
> Yeah, but that is why we need people to look the code considering all
> features. :-)

Well, there are bugfixes and there are features. My patch fixed the bug
in the simplest way possible; it didn't break CONFIG_THERMAL_EMULATION
any further than it already was, and it'll still work if get_temp()
doesn't return an error.

I'd say your patch is essentially adding a feature, and IMO that's not
the best way to fix a bug. You can fix the bug and *then* add the
feature.

Anyway, I'm not going to tell you how to run your subsystem. If your
patch goes through, that's probably just as well.

[...]

> > hmmm, I forgot why I missed this one in the end.
> > Eduardo,
> > would you mind refresh and resend the patch?
> 
> Yeah sure. I have at least three extra patch sets on thermal core on
> my queue. But I would like to get first the thermal sysfs reorg in
> first. This fix is one of the changes that will go on top of the thermal
> sysfs reorg.

So, the bugfix depends on feature work? I guess I'll check back in
another year to see what the status of the bugfix is :)

Brian
