From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: lock the thermal zone when switching governors
Date: Mon, 8 Dec 2014 10:31:33 -0400
Message-ID: <20141208143131.GA4613@developer>
References: <1416931233-14650-1-git-send-email-javi.merino@arm.com>
 <20141203191109.GA22781@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:61099 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbaLHObo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Dec 2014 09:31:44 -0500
Received: by mail-qc0-f173.google.com with SMTP id i17so3528104qcy.4
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2014 06:31:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203191109.GA22781@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

Hello,


On Wed, Dec 03, 2014 at 07:11:09PM +0000, Javi Merino wrote:
> Ping
> 
> On Tue, Nov 25, 2014 at 04:00:33PM +0000, Javi Merino wrote:
> > Currently, userspace can request a governor change while the governor
> > itself is running.  Grab the thermal zone lock when changing the
> > governor to prevent this race.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

But I believe Rui has already merged this one. Just for the record
anyways.

> > ---
> >  drivers/thermal/thermal_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 43b90709585f..c1901961f8c0 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -757,6 +757,7 @@ policy_store(struct device *dev, struct device_attribute *attr,
> >  	snprintf(name, sizeof(name), "%s", buf);
> >  
> >  	mutex_lock(&thermal_governor_lock);
> > +	mutex_lock(&tz->lock);
> >  
> >  	gov = __find_governor(strim(name));
> >  	if (!gov)
> > @@ -766,6 +767,7 @@ policy_store(struct device *dev, struct device_attribute *attr,
> >  	ret = count;
> >  
> >  exit:
> > +	mutex_unlock(&tz->lock);
> >  	mutex_unlock(&thermal_governor_lock);
> >  	return ret;
> >  }
> > -- 
> > 1.9.1
> > 
> 
