From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 3/4] devfreq_cooling: let the driver supply the dynamic
 power every time we need it
Date: Thu, 17 Nov 2016 15:26:47 +0000
Message-ID: <20161117152646.GA10620@e105217-lin.cambridge.arm.com>
References: <20160915144425.5443-1-lukasz.luba@arm.com>
 <20160915144425.5443-4-lukasz.luba@arm.com>
 <20161117031357.GA4852@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752897AbcKQRwV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Nov 2016 12:52:21 -0500
Content-Disposition: inline
In-Reply-To: <20161117031357.GA4852@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, javi.merino@arm.com, orjan.eide@arm.com

Hi Eduardo,

Thank you for looking at the patchset.

On Wed, Nov 16, 2016 at 07:13:58PM -0800, Eduardo Valentin wrote:
> On Thu, Sep 15, 2016 at 03:44:24PM +0100, Lukasz Luba wrote:
> > The devfreq cooling implementation uses precalculated power table for caching
> > power values for each device state. The power table is used everytime the
> > thermal subsystem asks for the dynamic power, power2state, etc. There is no
> > mechanism to provide the data in real-time from drivers' function registered as
> > 'get_dynamic_power'. The power value can change in runtime, so the driver should
> > choose one of the options (during the registration) what the thermal framework
> > should do:
> > o Use pre-calculated power table
> > o Use direct call to driver's 'get_dynamic_power' and 'power2state'
> > registered functions
> > 
> > With this patch, the driver can choose if the precalculated power table should
> > be used or a direct call to registered functions 'get_dynamic_power' and
> > 'power2state', to get more accurate values.
> 
> I see this change is doing several minor changes. Can it be split into
> smaller patches?
> - add feature flags. This change is not so clear if this is the best
>   approach either, as it is a feature flag of a single feature.
Yes, currently there is only one feature and the feature flag is passed as
an argument. Maybe a better place for the flag would be in
struct devfreq_cooling_power.
The flag could potentially be reused is future.
> - several changes in function signature, removing voltage parameter.
> 
I will split the commit and sent a v2 version.

Regards,
Lukasz
