From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V2 5/6] PM / domain: Save/restore performance state at runtime suspend/resume
Date: Fri, 17 Feb 2017 15:58:18 -0800
Message-ID: <m21suw4bfp.fsf@baylibre.com>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
        <cover.1486611268.git.viresh.kumar@linaro.org>
        <21383233a44afe5e5144fadb82867a0a890db46f.1486611268.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21383233a44afe5e5144fadb82867a0a890db46f.1486611268.git.viresh.kumar@linaro.org>
        (Viresh Kumar's message of "Thu, 9 Feb 2017 09:11:51 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> With runtime PM, the devices get suspended while the system is up and
> running in order to save power. At such times, it is important to
> re-evaluate the required performance state of the domain, in order to
> choose a lower state if possible.
>
> This patch updates the genpd suspend/resume callbacks to do that.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Doesn't this assume that a device in the domain would need to change
performance state while runtime suspended.  How would that happen?

Rather than adding this here, I would think that drivers would instead
remove any QoS requests before going into runtime suspend, which would
trigger an update before runtime suspending.

Kevin
