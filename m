From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/8] PM / Domains: Bunch of small improvements and fixes
Date: Wed, 28 Jun 2017 00:51:45 +0200
Message-ID: <4345431.pLgQ8x6N6R@aspire.rjw.lan>
References: <20170612151748.7380-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48386 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753886AbdF0W7L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 18:59:11 -0400
In-Reply-To: <20170612151748.7380-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 12, 2017 05:17:40 PM Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1:
> =================
> 1. Patch 2/8: Follow Ulf's advice and use genpd_lookup_dev() which also
>    solves risk of calling this for non-genpd (thus I added Ulf's
>    Reported-by).
> 
> Description:
> ============
> Except adding lockdep assert to domains list mutex (3/8), all patches
> are independent.  Including the fixes for unsafe loop iteration.
> 
> The last patch is RFC as this brings small overhead.

I've applied the [1/8] from this set, but I realize that some other patches in
it have been ACKed by Ulf, so can you please resend those with the tags?

Unless, of course, they depend on the ones that have not been ACKed still.

Thanks,
Rafael
