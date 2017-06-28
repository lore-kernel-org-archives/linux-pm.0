From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 0/8] PM / Domains: Bunch of small improvements and
 fixes
Date: Wed, 28 Jun 2017 16:48:24 +0200
Message-ID: <20170628144824.yw4ykeawnbr4jikc@kozik-lap>
References: <20170612151748.7380-1-krzk@kernel.org>
 <4345431.pLgQ8x6N6R@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35022 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdF1Os2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 10:48:28 -0400
Content-Disposition: inline
In-Reply-To: <4345431.pLgQ8x6N6R@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 28, 2017 at 12:51:45AM +0200, Rafael J. Wysocki wrote:
> On Monday, June 12, 2017 05:17:40 PM Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Changes since v1:
> > =================
> > 1. Patch 2/8: Follow Ulf's advice and use genpd_lookup_dev() which also
> >    solves risk of calling this for non-genpd (thus I added Ulf's
> >    Reported-by).
> > 
> > Description:
> > ============
> > Except adding lockdep assert to domains list mutex (3/8), all patches
> > are independent.  Including the fixes for unsafe loop iteration.
> > 
> > The last patch is RFC as this brings small overhead.
> 
> I've applied the [1/8] from this set, but I realize that some other patches in
> it have been ACKed by Ulf, so can you please resend those with the tags?
> 
> Unless, of course, they depend on the ones that have not been ACKed still.

Sure, I'll re-spin with acks.

Best regards,
Krzysztof
