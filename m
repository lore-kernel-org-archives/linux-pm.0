From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 3/4] devfreq_cooling: let the driver supply the dynamic
 power every time we need it
Date: Wed, 16 Nov 2016 19:13:58 -0800
Message-ID: <20161117031357.GA4852@localhost.localdomain>
References: <20160915144425.5443-1-lukasz.luba@arm.com>
 <20160915144425.5443-4-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34657 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753778AbcKQDOD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2016 22:14:03 -0500
Received: by mail-pf0-f196.google.com with SMTP id y68so10844216pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Nov 2016 19:14:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160915144425.5443-4-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, javi.merino@arm.com, orjan.eide@arm.com

On Thu, Sep 15, 2016 at 03:44:24PM +0100, Lukasz Luba wrote:
> The devfreq cooling implementation uses precalculated power table for caching
> power values for each device state. The power table is used everytime the
> thermal subsystem asks for the dynamic power, power2state, etc. There is no
> mechanism to provide the data in real-time from drivers' function registered as
> 'get_dynamic_power'. The power value can change in runtime, so the driver should
> choose one of the options (during the registration) what the thermal framework
> should do:
> o Use pre-calculated power table
> o Use direct call to driver's 'get_dynamic_power' and 'power2state'
> registered functions
> 
> With this patch, the driver can choose if the precalculated power table should
> be used or a direct call to registered functions 'get_dynamic_power' and
> 'power2state', to get more accurate values.

I see this change is doing several minor changes. Can it be split into
smaller patches?
- add feature flags. This change is not so clear if this is the best
  approach either, as it is a feature flag of a single feature.
- several changes in function signature, removing voltage parameter.


