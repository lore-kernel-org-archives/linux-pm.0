From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 00/10] PM / OPP: Fixes and cleanups
Date: Thu, 8 Dec 2016 01:07:49 +0100
Message-ID: <CAJZ5v0i6cFreyr2XsiK8f9eUqKH45K+_Z0GPsZLZJfJyV7VW8A@mail.gmail.com>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35737 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbcLHAIu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 19:08:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so14178wme.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 16:07:50 -0800 (PST)
In-Reply-To: <cover.1481085478.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Wed, Dec 7, 2016 at 5:41 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> This series fixes a memory leak (first patch) and does some cleanups to
> the OPP core.
>
> It is based of pm/bleeding-edge branch.

BTW, please don't post patches based on bleeding-edge.  That branch is
volatile (which you should be aware of) and it is not guaranteed that
the patches will apply to anything else going forward.

It simply is not reasonable to expect that reviewers will pull my
bleeding-edge branch just in order to review your patches (which may
become inapplicable going forward anyway).

Thanks,
Rafael
