From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3] PM: In kernel power management domain_pm created for
 async schedules
Date: Thu, 4 Jan 2018 10:25:15 +0100
Message-ID: <20180104092515.GB26245@kroah.com>
References: <CAJZ5v0j2RPzdCzAp3ofjpmnFhMUym691TBS54OvQpw=fidS9Ew@mail.gmail.com>
 <20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
 <20171206141238.GB11339@kroah.com>
 <3785462.Nrr6Y8ermz@aspire.rjw.lan>
 <20171213084612epcms5p7755822fff34c87907de2236923e82305@epcms5p7>
 <CGME20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p6>
 <20180104085900epcms5p6e6c7f3e8c0262e110dcd2fd3498fcd61@epcms5p6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbeADJZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jan 2018 04:25:12 -0500
Content-Disposition: inline
In-Reply-To: <20180104085900epcms5p6e6c7f3e8c0262e110dcd2fd3498fcd61@epcms5p6>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vikas Bansal <vikas.bansal@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anuj Gupta <anuj01.gupta@samsung.com>

On Thu, Jan 04, 2018 at 08:59:00AM +0000, Vikas Bansal wrote:
> Sender : Rafael J. Wysocki <rafael@kernel.org>
> 
> Date : 2017-12-14 03:56 (GMT+5:30)
> 
> >
> 
> > On Wed, Dec 13, 2017 at 9:46 AM, Vikas Bansal <vikas.bansal@samsung.com>
> wrote:
> >>
> >> Sender : Rafael J. Wysocki <rjw@rjwysocki.net>
> >> Date   : 2017-12-06 19:48 (GMT+5:30)
> >>
> >>>
> >>> Also it is not clear to me if this fixes a mainline kernel issue,
> >>> because the changelog mentions a driver doing something odd, but it
> >>> doesn't say which one it is and whether or not it is in the tree.
> >>
> >> No, this driver is not part of mainline yet.
> >
> > So please submit it along with the driver that needs it, whenever that
> > one is ready.
> >
> > Thanks,
> > Rafael
> 
> I am not sure when that driver will be submitted to open source and I even
> don't know whether final implementation of driver will have async_schedules or
> not. I just found one optimization in PM core because of that driver. If there
> is any issue with patch, please let me know. I will correct.

We can't take the patch without the driver at the same time, sorry.

greg k-h
