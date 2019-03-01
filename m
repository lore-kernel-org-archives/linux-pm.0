From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 7/7] drivers: firmware: psci: Announce support for OS
 initiated suspend mode
Date: Fri, 01 Mar 2019 09:28:19 -0800
Message-ID: <155146129938.16805.4528027710288083607@swboyd.mtv.corp.google.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-8-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190228135919.3747-8-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Ulf Hansson (2019-02-28 05:59:19)
> PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
> Platform Coordinated mode, which is the default and mandatory mode, while
> support for the OS initiated (OSI) mode is optional.
> 
> In some cases it's interesting for the user/developer to know if the OSI
> mode is supported by the PSCI FW. Therefore, let's print a message to the
> log, if that is the case.

I don't see anything wrong with the patch besides the potential for the
logs to wrap and the informational message to be lost, but would it be
possible to express the PSCI features that are supported in sysfs at
/sys/firmware/psci/ somehow? It may be useful for a user to know that
their firmware has PSCI support and that it has a certain set of
features available, like OSI vs. PC, or both. I don't know of any use
that userspace would have though, besides maybe the CPU state residency
counters being used by some sort of statistics collecting program or
just plain knowing that certain PSCI features are present, so perhaps it
could just be done in debugfs for now until a real user exists.
