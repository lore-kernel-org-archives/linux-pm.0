From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] PM / Runtime: document autosuspend-helper side
 effects
Date: Mon, 10 Apr 2017 09:36:03 -0700
Message-ID: <20170410163603.GG5339@atomide.com>
References: <20170410113825.17399-1-johan@kernel.org>
 <20170410113825.17399-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170410113825.17399-2-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Johan Hovold <johan@kernel.org> [170410 04:41]:
> Document the fact that the autosuspend delay and enable helpers may
> change the power.usage_count and resume or suspend a device depending on
> the values of power.autosuspend_delay and power.use_autosuspend.
> 
> Note that this means that a driver must disable autosuspend before
> disabling runtime pm on probe errors and on driver unbind if the device
> is to be suspended upon return (as a negative delay may otherwise keep
> the device resumed).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Tony Lindgren <tony@atomide.com>
