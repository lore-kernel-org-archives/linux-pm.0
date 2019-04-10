From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/4] PM / core: Introduce dpm_async_fn() helper
Date: Wed, 10 Apr 2019 10:15:17 +0200
Message-ID: <1823590.m8T6rWHPoh@aspire.rjw.lan>
References: <20190316045928.31934-1-tiny.windzz@gmail.com> <20190316045928.31934-2-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190316045928.31934-2-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, March 16, 2019 5:59:25 AM CEST Yangtao Li wrote:
> When we want to execute device pm functions asynchronously, we'll
> do the following for the device:
> 
>   1) reinit_completion(&dev->power.completion);
>   2) Check if the device enables asynchronous suspend.
>   3) If necessary, execute the corresponding function asynchronously.
> 
> There are a lot of such repeated operations here, in fact we can avoid
> this. So introduce dpm_async_fn() to have better code readability and
> reuse.
> 
> And use this function to do some cleanup.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

I'm queuing up this one, but the [2-4/4] are not convincing.

Thanks!
