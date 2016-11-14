From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM / OPP: fix debug/error messages in dev_pm_opp_of_get_sharing_cpus()
Date: Mon, 14 Nov 2016 01:22:59 +0100
Message-ID: <1769217.kBcRBT41fV@vostro.rjw.lan>
References: <1476947569-23552-1-git-send-email-yamada.masahiro@socionext.com> <20161020191858.GC26139@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55604 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750890AbcKNAP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:15:26 -0500
In-Reply-To: <20161020191858.GC26139@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On Thursday, October 20, 2016 12:18:58 PM Stephen Boyd wrote:
> On 10/20, Masahiro Yamada wrote:
> > These log messages are wrong because _of_get_opp_desc_node() returns
> > an operating-points-v2 node.
> > 
> > Commit a6eed752f5fb ("PM / OPP: passing NULL to PTR_ERR()") fixed
> > static checker warnings, and reworded the messages at the same time
> > (but the latter was not mentioned in the git-log).
> > 
> > Restore the correct messages.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Applied.

Thanks,
Rafael

