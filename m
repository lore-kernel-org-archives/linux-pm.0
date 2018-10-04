From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/6] cpuidle: menu: Do not update last_state_idx in
 menu_select()
Date: Thu, 4 Oct 2018 16:57:32 +0200
Message-ID: <20181004145732.GC1881@mai>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <1940908.mNKd7HXT40@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1940908.mNKd7HXT40@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 02, 2018 at 11:45:07PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is not necessary to update data->last_state_idx in menu_select()
> as it only is used in menu_update() which only runs when
> data->needs_update is set and that is set only when updating
> data->last_state_idx in menu_reflect().
> 
> Accordingly, drop the update of data->last_state_idx from
> menu_select() and get rid of the (now redundant) "out" label
> from it.
> 
> No intentional behavior changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
