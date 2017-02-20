From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/6] PM / domain: Save/restore performance state at
 runtime suspend/resume
Date: Mon, 20 Feb 2017 14:48:48 +0530
Message-ID: <20170220091848.GQ21911@vireshk-i7>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
 <cover.1486611268.git.viresh.kumar@linaro.org>
 <21383233a44afe5e5144fadb82867a0a890db46f.1486611268.git.viresh.kumar@linaro.org>
 <m21suw4bfp.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m21suw4bfp.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 17-02-17, 15:58, Kevin Hilman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > With runtime PM, the devices get suspended while the system is up and
> > running in order to save power. At such times, it is important to
> > re-evaluate the required performance state of the domain, in order to
> > choose a lower state if possible.
> >
> > This patch updates the genpd suspend/resume callbacks to do that.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Doesn't this assume that a device in the domain would need to change
> performance state while runtime suspended.  How would that happen?
> 
> Rather than adding this here, I would think that drivers would instead
> remove any QoS requests before going into runtime suspend, which would
> trigger an update before runtime suspending.

Okay, lets leave it for the drivers, at least for the time being. I
will drop this patch.

-- 
viresh
