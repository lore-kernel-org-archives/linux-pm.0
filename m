From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
Date: Thu, 14 Feb 2019 11:28:55 -0800
Message-ID: <20190214192855.GD117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-5-mka@chromium.org>
 <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cwchoi00@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Thu, Feb 14, 2019 at 11:17:36PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> As I commented on the first patch, it is not possible to call some codes
> according to the intention of each governor between 'devfreq_moniotr_*()'
> and some codes which are executed before or after 'devfreq_moniotr_*()'
> 
> For example, if some governor requires the following sequence,
> after this patch, it is not possible.
> 
> case DEVFREQ_GOV_xxx:
>         /* execute some code before devfreq_monitor_xxx() */
>         devfreq_monitor_xxx()
>         /* execute some code after devfreq_monitor_xxx() */

As for the suspend/resume case I agree that the patch introduces this
limitation, but I'm not convinced that this is an actual problem.

For governor_start(): why can't the governor execute the code
before polling started, does it make any difference to the governor
that a work is scheduled?

For governor_stop(): why would the governor require polling to be
active during stop? If it needs update_devfreq() to run (called by
devfreq_monitor()) it can call it directly, instead of waiting for the
monitor to run at some later time.

Cheers

Matthias
