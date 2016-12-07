From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 00/12] PM / OPP: Use kref and move away from RCU locking
Date: Thu, 8 Dec 2016 00:14:03 +0100
Message-ID: <CAJZ5v0hRTv+s5XoLYaKd_aRO-s0bMsmpF2s38YU7SHfOeiBw0A@mail.gmail.com>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 7, 2016 at 11:37 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> You can pretty much ignore this series until all other OPP cleanup/fixes
> get merged. I am posting these to get early reviews from Stephen as
> these patches have been lying with me for almost a week now. And I am
> also _not_ pushing these for 4.10-rc1. It all depends on how the reviews
> go.

So please stop sending this now if you will.

The amount of list noise you've just generated is well above what I'm
able to deal with today, so I'm going to ignore all of your patches
sent since yesterday (maybe except for the revert one as that should
be easy to handle).

This also means they are not going into 4.10-rc, so please don't
resend them before the merge window opens at least.

Thanks,
Rafael
