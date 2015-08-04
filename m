From: pang.xunlei@zte.com.cn
Subject: Re: [PATCH] cpuidle/coupled: Init cpuidle_device::safe_state_index
Date: Tue, 4 Aug 2015 13:19:09 +0800
Message-ID: <OFA0431BB2.32FC38F1-ON48257E97.001AEA8F-48257E97.001D3D28@zte.com.cn>
References: <1437654681-20893-1-git-send-email-xlpang@126.com> <55BF955E.1030801@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BF955E.1030801@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

Daniel Lezcano <daniel.lezcano@linaro.org> wrote 2015-08-04 AM 12:22:54:
> Re: [PATCH] cpuidle/coupled: Init cpuidle_device::safe_state_index
> 
> On 07/23/2015 02:31 PM, Xunlei Pang wrote:
> > From: Xunlei Pang <pang.xunlei@zte.com.cn>
> >
> > cpuidle_device::safe_state_index need to be initialized before use,
> > so assign the driver's safe_state_index to it.
> >
> > Signed-off-by: Xunlei Pang <pang.xunlei@zte.com.cn>
> > ---
> >   drivers/cpuidle/cpuidle.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index e8e2775..ed5c8efe 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -585,6 +585,8 @@ int cpuidle_register(struct cpuidle_driver *drv,
> >          */
> >         if (coupled_cpus)
> >            device->coupled_cpus = *coupled_cpus;
> > +
> > +      device->safe_state_index = drv->safe_state_index;
> 
> Hey, good catch. We are lucky the safe_state_index is always zero.
> 
> I think we can simplify the code by removing the safe_state_index from 
> the cpuidle_device structure and use the one in the cpuidle_driver 
> structure in coupled.c

Will do, thanks!

Regards,
-Xunlei

--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (and any attachment transmitted herewith) is privileged and confidential and is intended for the exclusive use of the addressee(s).  If you are not an intended recipient, any disclosure, reproduction, distribution or other dissemination or use of the information contained is strictly prohibited.  If you have received this mail in error, please delete it and notify us immediately.
