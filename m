From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
Date: Wed, 11 Sep 2013 14:09:35 +0530
Message-ID: <CAKohpomA0s_gCZncbfGK9YN3HhRuoswQ5xo71=A3a7t_PbEKOw@mail.gmail.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
	<CAKohponZ+FnzqXYMbBzbun0-1iQMi2fS4syrEBC_MdF41vLCeA@mail.gmail.com>
	<Pine.LNX.4.64.1309101656150.16010@axis700.grange>
	<CAKohpomBBKLhNemVUpUHAftGhPJJe+ZB7T_9UYLD7LwpR1nK0g@mail.gmail.com>
	<Pine.LNX.4.64.1309101740120.16010@axis700.grange>
	<CAKohpomK7Y_6aLMA3B+hZrtgYq9U89ihgkbvYWA3BsKN3gJD3g@mail.gmail.com>
	<Pine.LNX.4.64.1309101853170.16010@axis700.grange>
	<CAKohpokaHU0V86DPB7nEQ8ndwu_mJ_x_Uz47XPHZeyAW3hcP_w@mail.gmail.com>
	<Pine.LNX.4.64.1309111015190.26942@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33097 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab3IKIjh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 04:39:37 -0400
Received: by mail-qc0-f180.google.com with SMTP id p19so4895988qcv.39
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2013 01:39:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1309111015190.26942@axis700.grange>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On 11 September 2013 13:45, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> I'd rather wait until Rafael is convinced, then we'll see.

Okay.. I have just sent a mail to Rafael about that, see if you
are convinced with what I wrote :)

--
viresh
