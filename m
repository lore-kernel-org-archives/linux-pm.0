From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 3/4] PM / devfreq: Add devfreq_governor_start/stop()
Date: Thu, 14 Feb 2019 10:32:57 -0800
Message-ID: <20190214183257.GB117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-4-mka@chromium.org>
 <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
 <CAGTfZH1w=T+TY=bpqwHwLnxgzykcfrEv09iZuoUWwKFDAHK7Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGTfZH1w=T+TY=bpqwHwLnxgzykcfrEv09iZuoUWwKFDAHK7Zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cwchoi00@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Thu, Feb 14, 2019 at 11:32:40PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> When I contributed the something to devfreq.c, if the newly added functions
> are internal/static, just added the function without 'devfreq_' prefix
> in order to distinguish them from the exported function as following:
> - find_available_min_freq()
> - find_available_max_freq()
> - set_freq_table()
> 
> So, the governor_start/stop are the static function used only in devfreq.c,
> in order to sustain the consistency of function naming, I recommened
> that changes them as following:
> - devfreq_governor_start -> governor_start
> - devfreq_governor_stop -> governor_stop

Sounds good, I'll update this in the next version.

Thanks

Matthias
