From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/7] drivers: firmware: psci: Announce support for OS
 initiated suspend mode
Date: Mon, 4 Mar 2019 11:25:43 +0100
Message-ID: <CAPDyKFodEYc+9UoROhH-wWYYZPBnMTu1ZhkCM9gSHDrYTq=MFA@mail.gmail.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-8-ulf.hansson@linaro.org>
 <155146129938.16805.4528027710288083607@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155146129938.16805.4528027710288083607@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Mar 2019 at 18:28, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Ulf Hansson (2019-02-28 05:59:19)
> > PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
> > Platform Coordinated mode, which is the default and mandatory mode, while
> > support for the OS initiated (OSI) mode is optional.
> >
> > In some cases it's interesting for the user/developer to know if the OSI
> > mode is supported by the PSCI FW. Therefore, let's print a message to the
> > log, if that is the case.
>
> I don't see anything wrong with the patch besides the potential for the
> logs to wrap and the informational message to be lost, but would it be
> possible to express the PSCI features that are supported in sysfs at
> /sys/firmware/psci/ somehow? It may be useful for a user to know that
> their firmware has PSCI support and that it has a certain set of
> features available, like OSI vs. PC, or both. I don't know of any use
> that userspace would have though, besides maybe the CPU state residency
> counters being used by some sort of statistics collecting program or
> just plain knowing that certain PSCI features are present, so perhaps it
> could just be done in debugfs for now until a real user exists.

Having a sysfs interface for PSCI, allowing users to know a little bit
more about what the FW supports/version/etc sound like a great idea to
me.

There is already quite some prints being made by psci during boot, so
perhaps having sysfs allows us to drop some of these.

Mark, what do you think? Is it something you think we should do? I can
offer my help to implement this, if you think it's a good idea.

Stephen, thanks for reviewing!

Kind regards
Uffe
