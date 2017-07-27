From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is
 used
Date: Thu, 27 Jul 2017 09:13:51 +0530
Message-ID: <20170727034351.GF352@vireshk-i7>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
 <276e68a1-edfe-961b-e387-7855f409557b@arm.com>
 <CAHKzcEMDRE5_dA11f9C19FHaMNcTFfj8=tEbOnMG92TtfyUz9w@mail.gmail.com>
 <592bc7b8-615d-5d80-f328-eabdfe6c3828@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35781 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdG0Dn4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 23:43:56 -0400
Received: by mail-pf0-f171.google.com with SMTP id e75so181239pfj.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2017 20:43:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <592bc7b8-615d-5d80-f328-eabdfe6c3828@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 26-07-17, 15:08, Sudeep Holla wrote:
> CPUs won't be unregistered on hotplug path

You sure? I don't you will get confused with this as you already know
all this, but I will still write it down for the sake of clarity.

We aren't talking about offlining a CPU here, but a real physical
hotplug. Why should the kernel keep a device structure for a device if
it isn't physically present on the system?

acpi_processor_remove() removes the CPU device and I thought it was
all related to that hotplug.

Am I missing something ?

> and hence I can't figure out
> why get_cpu_device would fail if all the CPUs were registered on boot.
> Just trying to understand the scenario and how it differs from normal
> hotplug case.

-- 
viresh
