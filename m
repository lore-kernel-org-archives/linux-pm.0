From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 9/9] cpufreq: drivers: Free frequency tables after
 being used
Date: Tue, 7 Jun 2016 00:45:26 +0200
Message-ID: <CAJZ5v0jFQmK77DB3w0KhM3JLPKbLsJhGqhcUmF7Bc3wuY_ANTQ@mail.gmail.com>
References: <cover.1464960877.git.viresh.kumar@linaro.org> <feba34c6ee8ddc639507f569b737c1b525c7f139.1464960877.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <feba34c6ee8ddc639507f569b737c1b525c7f139.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Keguang Zhang <keguang.zhang@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, linux-mips@linux-mips.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 3, 2016 at 3:35 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The cpufreq core doesn't use these tables anymore after
> cpufreq_table_validate_and_show() has returned.  And so these can be
> freed early.

That doesn't look particularly efficient.

The driver has to allocate memory first and populate it and then the
core needs to allocate more memory again to store the same information
in it, but perhaps in a different order and then the driver can free
the memory allocated before right away.  It looks like there's one
excessive memory allocation here, so maybe the core can simply sort
the frequency table in place and overwrite the invalid entries in the
process?
