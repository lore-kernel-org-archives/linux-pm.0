From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: menu: Replace data->predicted_us with local
 variable
Date: Mon, 1 Oct 2018 16:46:43 +0200
Message-ID: <0b2fb127-b48e-e047-b5e3-4eb6107ec361@linaro.org>
References: <2889908.NE4FqvqlhV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2889908.NE4FqvqlhV@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 01/10/2018 11:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The predicted_us field in struct menu_device is only accessed in
> menu_select(), so replace it with a local variable in that function.
> 
> With that, stop using expected_interval instead of predicted_us to
> store the new predicted idle duration value if it is set to the
> selected state's target residency which is quite confusing.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
