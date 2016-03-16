From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi: Allow new dynamics attributes to be added
 to acpi_cpufreq_attr
Date: Wed, 16 Mar 2016 11:53:14 +0700
Message-ID: <20160316045314.GD16250@vireshk-mac-ubuntu>
References: <1456945994-5616-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <f73d4b3690f7166730bafa2e0d7b5b9dcf29f2de.1456983554.git.viresh.kumar@linaro.org>
 <CAJZ5v0i1HxQha52+G+G_1RC2Gv7Fr7Wifohhx8pqkh-MXbo6Zg@mail.gmail.com>
 <20160309094126.GJ23015@vireshk-mac-ubuntu>
 <CAJZ5v0i6Lv+-A4ZC3JOtr8FNcXYn1copS4C8oEmLrh+1eXT0MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33195 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934475AbcCPExU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 00:53:20 -0400
Received: by mail-pf0-f179.google.com with SMTP id 124so58971133pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Mar 2016 21:53:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i6Lv+-A4ZC3JOtr8FNcXYn1copS4C8oEmLrh+1eXT0MQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09-03-16, 14:13, Rafael J. Wysocki wrote:
> On Wed, Mar 9, 2016 at 10:41 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 03-03-16, 18:29, Rafael J. Wysocki wrote:
> >> Srinivas, can you please take this and rebase your patch on top of it?
> >>  Or if you prefer, I can take it into my linux-next branch.
> >
> > Right, so you need to apply this patch as Srinivas already sent a separate patch
> > for his stuff, rebased over this.
> 
> I know, but I'm deferring that one as we aren't entirely sure about
> the approach yet.

I might have missed, but what are we not sure about here ? I thought, all three
of us agreed that this is a good idea ..

-- 
viresh
