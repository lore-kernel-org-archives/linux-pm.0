From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / runtime: Drop usage count for suppliers at device
 link removal
Date: Sun, 27 May 2018 12:18:05 +0200
Message-ID: <CAJZ5v0gGLvKS6yDuBokJzm2gAhM=VMSaz5frvWq=eRPkAD-z6g@mail.gmail.com>
References: <1527150816-8459-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527150816-8459-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Jon Hunter <jonathanh@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 24, 2018 at 10:33 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In the case consumer device is runtime resumed, while the link to the
> supplier is removed, the earlier call to pm_runtime_get_sync() made from
> rpm_get_suppliers() does not get properly balanced with a corresponding
> call to pm_runtime_put(). This leads to that suppliers remains to be
> runtime resumed forever, while they don't need to.
>
> Let's fix the behaviour by calling rpm_put_suppliers() when dropping a
> device link. Not that, since rpm_put_suppliers() checks the
> link->rpm_active flag, we can correctly avoid to call pm_runtime_put() in
> cases when we shouldn't.
>
> Reported-by: Todor Tomov <todor.tomov@linaro.org>
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Rafael, I am not sure if this is safe from locking point of view. The device
> link write lock has been taken when pm_runtime_drop_link() is called, hence I
> assume calling rpm_put_suppliers() should be fine!? If not, can you please
> advise how to change?

Holding the lock should be sufficient for the list to be stable, so
AFAICS it is OK.

Thanks,
Rafael
