From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v4 00/10] Better compatible for the rockchip thermal and support RK3368 SoCs
Date: Sat, 21 Nov 2015 17:41:47 +0100
Message-ID: <1718129.opDY4sItVM@phil>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com> <20151112182950.GB4361@localhost.localdomain> <20151112183119.GA5289@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151112183119.GA5289-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 12. November 2015, 10:31:20 schrieb Eduardo Valentin:
> On Thu, Nov 12, 2015 at 10:29:52AM -0800, Eduardo Valentin wrote:
> > On Mon, Nov 09, 2015 at 12:48:52PM +0800, Caesar Wang wrote:
> > > Thank you all for providing inputs and comments on previous versions of
> > > this patchset.
> > > Especially thanks to the (Eduardo, Dmitry, Heiko,....).
> > > 
> > > This series patchs are working for RK3368 on Rockchip platform.
> > 
> > Do you have any results on existing support? Is the driver still in one
> > piece for rk3288?
> > 
> > I am planing to send your series in next rc cycles. It won't appear in
> > linux-next until merge window finishes.
> 
> To be more specific, only patches 1-7. DT bindings go via the right
> machine tree.

after seeing these 7 patches in your next-branch, I've now applied the 3
dts patches to my dts64 branch for 4.5 as well.


Thanks
Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
