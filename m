From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 20/20] cpufreq: scmi: add support for fast frequency switching
Date: Wed, 08 Nov 2017 01:24:47 +0100
Message-ID: <4588325.776kYim3Ci@aspire.rjw.lan>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com> <1509720477-18936-21-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509720477-18936-21-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, November 3, 2017 3:47:57 PM CET Sudeep Holla wrote:
> The cpufreq core provides option for drivers to implement fast_switch
> callback which is invoked for frequency switching from interrupt context.
> 
> This patch adds support for fast_switch callback in SCMI cpufreq driver
> by making use of polling based SCMI transfer. It also sets the flag
> fast_switch_possible.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

I'm assuming that this material will go in along with the rest of the series
through a different tree.

Thanks,
Rafael
