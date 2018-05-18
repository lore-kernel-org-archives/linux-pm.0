From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / runtime: Fixup reference counting of device link
 suppliers at probe
Date: Fri, 18 May 2018 10:58:20 +0200
Message-ID: <CAJZ5v0ikXsWdXq-h8rWLd-vfzi-gFmxyHmOGvRvDUoJHC3L2XA@mail.gmail.com>
References: <1526633329-31729-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526633329-31729-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 18, 2018 at 10:48 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In the driver core, before it invokes really_probe() it runtime resumes the
> suppliers for the device via calling pm_runtime_get_suppliers(), which also
> increases the runtime PM usage count for each of the available supplier.
>
> This makes sense, as to be able to allow the consumer device to be probed
> by its driver. However, if the driver decides to add a new supplier link
> during ->probe(), hence updating the list of suppliers,

Do any of the existing drivers do that?

> the following call to pm_runtime_put_suppliers(), invoked after really_probe()
> in the driver core, we get into trouble.
