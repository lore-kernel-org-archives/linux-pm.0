From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpupower: Fix bug where return value was not used
Date: Sat, 24 Jun 2017 01:03:18 +0200
Message-ID: <11633691.tH8W96l7QX@aspire.rjw.lan>
References: <20170620065708.21434.80154.stgit@Diesel2540.amd.com> <20170620070241.21434.57148.stgit@Diesel2540.amd.com> <6275735.KfbznezEp5@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58950 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753900AbdFWXKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2017 19:10:39 -0400
In-Reply-To: <6275735.KfbznezEp5@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>, linux-pm@vger.kernel.org

On Friday, June 23, 2017 04:00:57 PM Thomas Renninger wrote:
> On Tuesday, June 20, 2017 02:07:37 AM Sherry Hurwitz wrote:
> > Save return value from amd_pci_get_num_boost_states
> > and remove redundant setting of *support
> > 
> > Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
> 
> Acked-by: Thomas Renninger <trenn@suse.com>
> Reviewed-by: Thomas Renninger <trenn@suse.com>
> whatever is more appropriate or both...
> 
> Thanks, good catch!
> 
> Rafael can you queue this an the next one, please?

I'll do that.

Thanks,
Rafael
