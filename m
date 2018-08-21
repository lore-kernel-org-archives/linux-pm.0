From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 2/5] cpuidle: menu: Record tick delta value in struct menu_device
Date: Tue, 21 Aug 2018 10:34:34 +0200
Message-ID: <1736901.g9hLg0e4yF@aspire.rjw.lan>
References: <1534090171-14464-1-git-send-email-leo.yan@linaro.org> <1534090171-14464-3-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534090171-14464-3-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ramesh Thomas <ramesh.thomas@intel.com>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, August 12, 2018 6:09:28 PM CEST Leo Yan wrote:
> Since the tick delta is used in multiple places in menu_select(), it's
> better to use single one variable to record this value; furthermore, for
> more readable we can refactor the code to split a separate function to
> making decision for stopping tick, which also needs to use tick delta
> value as one metric for consideration.

I don't quite agree that allocating more per-CPU memory for readability
sake is a good idea, sorry.

Thanks,
Rafael
