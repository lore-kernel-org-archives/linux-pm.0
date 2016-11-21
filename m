From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Set EPP/EPB to 0 in performance
 mode
Date: Mon, 21 Nov 2016 09:27:18 -0800
Message-ID: <1479749238.6544.147.camel@linux.intel.com>
References: <1479438902-167977-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0iC2MesdO58+d1J4u1F5UYGtcPZArXWkiY5cptF=bxntw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1435 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753309AbcKUR1T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 12:27:19 -0500
In-Reply-To: <CAJZ5v0iC2MesdO58+d1J4u1F5UYGtcPZArXWkiY5cptF=bxntw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Sat, 2016-11-19 at 00:26 +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 18, 2016 at 4:15 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:

[...]

> > +                       if (cpu_data->policy ==
> > CPUFREQ_POLICY_PERFORMANCE) {
> 
> Why don't we simply save the EPP/EPB here, ->

We can, but we loose the ability to restore to the default power on
configuration. For other control limits, users have ability to look at
the sysfs and set the limits back to power on default. Since we don't
have any other way to look at go back to default EPP, once save and
restore. So if this behavior is not important, then this can be done.

Thanks,
Srinivas
