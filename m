From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/10] PM / OPP: Fixes and cleanups
Date: Thu, 8 Dec 2016 09:33:49 +0530
Message-ID: <20161208040349.GD24152@vireshk-i7>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
 <CAJZ5v0i6cFreyr2XsiK8f9eUqKH45K+_Z0GPsZLZJfJyV7VW8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36516 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbcLHEFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 23:05:10 -0500
Received: by mail-pg0-f43.google.com with SMTP id f188so168782872pgc.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 20:03:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i6cFreyr2XsiK8f9eUqKH45K+_Z0GPsZLZJfJyV7VW8A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>

On 08-12-16, 01:07, Rafael J. Wysocki wrote:
> On Wed, Dec 7, 2016 at 5:41 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Hi,
> >
> > This series fixes a memory leak (first patch) and does some cleanups to
> > the OPP core.
> >
> > It is based of pm/bleeding-edge branch.
> 
> BTW, please don't post patches based on bleeding-edge.  That branch is
> volatile (which you should be aware of) and it is not guaranteed that
> the patches will apply to anything else going forward.
> 
> It simply is not reasonable to expect that reviewers will pull my
> bleeding-edge branch just in order to review your patches (which may
> become inapplicable going forward anyway).

Sure. Will take care of it from now on. Thanks.

-- 
viresh
