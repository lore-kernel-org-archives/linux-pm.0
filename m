From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 18/18] cpufreq: scmi: add support for fast frequency
 switching
Date: Wed, 9 Aug 2017 15:43:01 +0530
Message-ID: <20170809101301.GB29383@vireshk-i7>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-19-git-send-email-sudeep.holla@arm.com>
 <20170809042825.GI28857@vireshk-i7>
 <0f89f543-39a9-30a5-4976-0c447f5fe843@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0f89f543-39a9-30a5-4976-0c447f5fe843@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>, Alexey Klimov <alexey.klimov@arm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09-08-17, 11:09, Sudeep Holla wrote:
> Firmware needs to serialize or override based on the timing of the two
> consecutive requests.

Maybe add a comment over that routine and detail its working a bit? Like its not
synchronous, etc. I expect that you would also add a callback with SCMI, so that
the cpufreq driver is notified when frequency is changed ?

-- 
viresh
