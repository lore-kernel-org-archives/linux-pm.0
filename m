From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 3/4] PM / devfreq: Add devfreq_governor_start/stop()
Date: Thu, 14 Feb 2019 10:30:09 -0800
Message-ID: <20190214183009.GA117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-4-mka@chromium.org>
 <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cwchoi00@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 14, 2019 at 11:12:55PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> Looks good to me for making the function to remove the duplicate code.
> But,  When I just tested the kernel build, following warnings occur
> about devfreq_governor_stop().
> 
> In file included from ./include/linux/devfreq.h:16:0,
>                  from drivers/devfreq/devfreq.c:23:
> drivers/devfreq/devfreq.c: In function ‘devfreq_governor_stop’:
> drivers/devfreq/devfreq.c:619:17: warning: format ‘%s’ expects
> argument of type ‘char *’, but argument 4 has type ‘int’ [-Wformat=]
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>                  ^
> ./include/linux/device.h:1380:22: note: in definition of macro ‘dev_fmt’
>  #define dev_fmt(fmt) fmt
>                       ^
> drivers/devfreq/devfreq.c:619:3: note: in expansion of macro ‘dev_warn’
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>    ^
> drivers/devfreq/devfreq.c:619:17: warning: format ‘%d’ expects a
> matching ‘int’ argument [-Wformat=]
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>                  ^
> ./include/linux/device.h:1380:22: note: in definition of macro ‘dev_fmt’
>  #define dev_fmt(fmt) fmt
>                       ^
> drivers/devfreq/devfreq.c:619:3: note: in expansion of macro ‘dev_warn’
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",

For some reason the warnings don't pop up in my 4.19 build and I
missed them when compile testing upstream :(

I'll fix the format string in the next version.

Thanks for the review and build test!

Matthias
