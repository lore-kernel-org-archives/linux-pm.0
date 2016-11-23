From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Set EPP/EPB to 0 in
 performance mode
Date: Tue, 22 Nov 2016 17:20:22 -0800
Message-ID: <1479864022.20426.12.camel@linux.intel.com>
References: <1479858269-175501-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0i_PkFDYze-vwc=u2fY2HhjPL02ZG1xkTE2ksaQQVoecA@mail.gmail.com>
         <CAJZ5v0h5Qx-_p2wfAqDjEt4jQ6h86mHCSfuRaewqumGgONGidQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12994 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756070AbcKWBXQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 20:23:16 -0500
In-Reply-To: <CAJZ5v0h5Qx-_p2wfAqDjEt4jQ6h86mHCSfuRaewqumGgONGidQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Wed, 2016-11-23 at 01:53 +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 23, 2016 at 1:42 AM, Rafael J. Wysocki <rafael@kernel.org
> > wrote:
> > 
> > 
[...]

> > > invalid */
> > > +                       if (cpu_data->epp_saved < 0)
> > > +                               goto skip_epp;
> > > +
> This can be avoided too I suppose if epp_saved is initialized with
> the
> initial value of the EPP.
This is not only for initialization, but transient MSR read failures
later (which shouldn't happen, but for the completeness). So if you
weren't able to read for some unknown reason, then you shouldn't
restore.

Thanks,
Srinivas

> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
