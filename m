From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/2] PM / OPP: introduce an OPP power estimation helper
Date: Mon, 22 Jan 2018 10:42:37 +0530
Message-ID: <20180122051237.GE2421@vireshk-i7>
References: <20180119094549.5468-1-quentin.perret@arm.com>
 <20180119094549.5468-2-quentin.perret@arm.com>
 <CAJWu+opFktdGqGMxjAr6Fudt90Ecqe2KEZ76wS8wFZ07P071Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46528 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeAVFMj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 00:12:39 -0500
Received: by mail-pf0-f193.google.com with SMTP id y5so6216249pff.13
        for <linux-pm@vger.kernel.org>; Sun, 21 Jan 2018 21:12:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJWu+opFktdGqGMxjAr6Fudt90Ecqe2KEZ76wS8wFZ07P071Sg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Quentin Perret <quentin.perret@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Todd Kjos <tkjos@google.com>

On 19-01-18, 15:36, Joel Fernandes wrote:
> Does this need to be a separate static function? There's only one user
> of the function in the C file and it adds more LOC.

I would prefer it that way too, i.e. a separate routine for this stuff.

-- 
viresh
