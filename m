From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Allow an irq-safe parent to be runtime suspended
Date: Fri, 01 Dec 2017 14:52:07 +0100
Message-ID: <16620063.rk7vuB3HEa@aspire.rjw.lan>
References: <1510924566-16112-1-git-send-email-ulf.hansson@linaro.org> <CAPDyKFq+5mAWyr+4y0F8WCevD5myZ-cbM=Np7rFvYWUPiViCug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61963 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752565AbdLANwi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 08:52:38 -0500
In-Reply-To: <CAPDyKFq+5mAWyr+4y0F8WCevD5myZ-cbM=Np7rFvYWUPiViCug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>

On Friday, December 1, 2017 8:35:50 AM CET Ulf Hansson wrote:
> On 17 November 2017 at 14:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > When pm_runtime_irq_safe() is a called for a child device, it's assumed
> > that the parent is never also irq-safe. Therefore, is the parent runtime
> > resumed and the usage counter increased for it, as to avoid having an
> > irq-safe child waiting for non-irq-safe parent.
> >
> > Improve this behaviour by taking into account that the parent could also be
> > irq-safe. In such case let's allow it to be runtime suspended.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Rafael, I noticed you applied this for next, but I realized that I
> have overlooked a couple of more things that needs to be taken care
> of.
> 
> Can you please drop this version? I will re-spin a new version soon.

Will do, thanks!

Rafael
