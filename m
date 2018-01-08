From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [BUG] s2idle: Surface Pro 3 suspend/resume issues
Date: Mon, 08 Jan 2018 16:37:50 +0800
Message-ID: <1515400670.2578.18.camel@intel.com>
References: <85be1584-5260-e7e1-2eda-23607f5a93c2@mrs.ro>
         <d1c1bab6e2b343abf9105a892dc06c49@mrs.ro>
         <1515399224.2578.17.camel@intel.com>
         <f9aed3f0e77fc7d3f663fb913e1bb5aa@mrs.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755009AbeAHIh4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jan 2018 03:37:56 -0500
In-Reply-To: <f9aed3f0e77fc7d3f663fb913e1bb5aa@mrs.ro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valentin Manea <linux-pm@mrs.ro>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Mon, 2018-01-08 at 08:21 +0000, Valentin Manea wrote:
> On 2018-01-08 08:13, Zhang Rui wrote:
> > 
> > On Mon, 2018-01-08 at 07:55 +0000, Valentin Manea wrote:
> > > 
> > > Again with correct linux-pm
> > > 
> > > Hi,
> > > 
> > >    Somewhere between 4.12 and 4.13 the s2idle doesn't work
> > > anymore on
> > > the
> > > Surface Pro 3.
> > will you please be more specific about the symptom?
> > what command do you use to do s2idle, and how do you wake it up?
> Sure, sorry for not being more specific. I tried both the DE(KDE) 
> suspend functionality but also:
> echo memory  > /sys/power/state
> and the behaviour is the same: display goes dark, system is not 
> responding - the power button which previously wakes up the system 
> doesn't work anymore. It needs a hard reset from this point
> 
> The home button has a slight vibration when device is fully running,
> in 
> this state the vibration doesn't happen at all so I suppose it went 
> through some sleep stages.
> 
> For reference I tried with iommu=off booting because of another bug
> that 
> made the rounds but that never helped. The problem seems to be in the
> 3 
> patches I mentioned in my top email
> 
> > 
> > 
> > 
> > BTW, does the problem still exists in the latest upstream kernel?
> Yep, no changes. System still needs a hard reset after suspending to 
> idle.

in latest upstream kernel, does it work if you use rtcwake instead?
say, "rtcwake -m freeze -s 20"

thanks,
rui
> > 
> > 
> > thanks,
> > rui
> Thanks,
> Valentin
> 
