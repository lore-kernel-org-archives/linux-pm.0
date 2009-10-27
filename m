From: "Dasgupta, Romit" <romit@ti.com>
Subject: Re: [PATCH] PM: Fixes warning on suspend errors
Date: Tue, 27 Oct 2009 20:00:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE0DCA79__23798.3188745149$1256654032$gmane$org@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE0DC96A@dbde02.ent.ti.com>
	<Pine.LNX.4.44L0.0910270936450.2882-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0910270936450.2882-100000@iolanthe.rowland.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Ok. Then the following is the refined and probably more appropriate one.



This fixes the point where we need to complete the power transition when 
device suspend fails.

Signed-off-by: Romit Dasgupta <romit@ti.com>
---

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e0dc407..3d0b26a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -444,6 +444,7 @@ static void dpm_resume(pm_message_t state)
 
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
+	transition_started = false;
 	while (!list_empty(&dpm_list)) {
 		struct device *dev = to_device(dpm_list.next);





> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Alan Stern
> Sent: Tuesday, October 27, 2009 7:08 PM
> To: Dasgupta, Romit
> Cc: Hilman, Kevin; rjw@sisk.pl; linux-pm@lists.linux-foundation.org; linux-
> omap@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [linux-pm] [PATCH] PM: Fixes warning on suspend errors
> 
> On Tue, 27 Oct 2009, Dasgupta, Romit wrote:
> 
> > Hi,
> >      I get the following errors when I choose devices in /sys/power/pm_test. It
> also shows that if 'dpm_suspend_start' fails somewhere down the line then
> the kernel does not reset the 'transition_started' variable and we can get
> warning similar to below. IMHO 'dpm_resume_noirq' is not the right place for
> setting this variable. Please see the patch below which fixes the issue.
> 
> > Fixes the location where we decide that our power transition is complete.
> > Signed-off-by: Romit Dasgupta <romit@ti.com>
> > ---
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index e0dc407..6b9e991 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -365,7 +365,6 @@ void dpm_resume_noirq(pm_message_t state)
> >  	struct device *dev;
> >
> >  	mutex_lock(&dpm_list_mtx);
> > -	transition_started = false;
> >  	list_for_each_entry(dev, &dpm_list, power.entry)
> >  		if (dev->power.status > DPM_OFF) {
> >  			int error;
> > @@ -529,6 +528,7 @@ static void dpm_complete(pm_message_t state)
> >  		put_device(dev);
> >  	}
> >  	list_splice(&list, &dpm_list);
> > +	transition_started = false;
> >  	mutex_unlock(&dpm_list_mtx);
> >  }
> 
> The second hunk is okay, but the first hunk isn't.  We want to set
> transition_started to false as soon as devices start resuming, because
> once a resume has begun it's okay to add new devices.
> 
> Alan Stern
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
