From: Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Re: [RFT][PATCH v2 2/2] PM / QoS: Fix device resume latency framework
Date: Fri, 3 Nov 2017 19:28:07 -0700
Message-ID: <20171104022806.GA29203@intel.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan>
 <2520927.XkLgALY3I0@aspire.rjw.lan>
 <36826935.bDl2WuZxgq@aspire.rjw.lan>
 <aea02edb-b112-18db-6de5-f10e9a43846d@intel.com>
Reply-To: ramesh.thomas@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:52705 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdKDCev (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Nov 2017 22:34:51 -0400
Content-Disposition: inline
In-Reply-To: <aea02edb-b112-18db-6de5-f10e9a43846d@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Alex Shi <alex.shi@linaro.org>

On 2017-11-03 at 09:39:08 -0700, Reinette Chatre wrote:
> Hi Rafael,
> 
> I started to test this but found myself triggering one of the warnings:
> 
> On 11/3/2017 4:50 AM, Rafael J. Wysocki wrote:
> > --- linux-pm.orig/include/linux/pm_qos.h
> > +++ linux-pm/include/linux/pm_qos.h
> > @@ -28,16 +28,19 @@ enum pm_qos_flags_status {
> >  	PM_QOS_FLAGS_ALL,
> >  };
> >  
> > -#define PM_QOS_DEFAULT_VALUE -1
> > +#define PM_QOS_DEFAULT_VALUE	(-1)
> 
> PM_QOS_DEFAULT_VALUE is -1 ...
> 
> 
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/qos.c
> > +++ linux-pm/drivers/base/power/qos.c
> > @@ -139,6 +139,9 @@ static int apply_constraint(struct dev_p
> >  
> >  	switch(req->type) {
> >  	case DEV_PM_QOS_RESUME_LATENCY:
> > +		if (WARN_ON(value < 0))
> > +			value = 0;
> > +
> 
> ... causing me to hit this WARN_ON because apply_constraint() is called by __dev_pm_qos_remove_request() with the value parameter set to PM_QOS_DEFAULT_VALUE.

That value does not get used if action is PM_QOS_REMOVE_REQ. May be just pass
0 or PM_QOS_RESUME_LATENCY_DEFAULT_VALUE everywhere apply_constraint is called
with PM_QOS_REMOVE_REQ action.
