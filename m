From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Wed, 23 May 2018 17:16:14 +0530
Message-ID: <CAKohponruWpcjuSDg-=ZbZ1=qm2iPZs36mfKYJ3nQZREkc3JCw@mail.gmail.com>
References: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org>
 <1527068454-28921-2-git-send-email-ilialin@codeaurora.org>
 <3f1ca60e-7aa8-fccc-ab1c-4b7c37731cce@arm.com> <002901d3f286$198878b0$4c996a10$@codeaurora.org>
 <CAKohponbpErCeTYu9iQm_-dupz5SUr+TKsYXzqmmARB-pq95iA@mail.gmail.com> <002b01d3f28a$0d033900$2709ab00$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <002b01d3f28a$0d033900$2709ab00$@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 23 May 2018 at 17:04,  <ilialin@codeaurora.org> wrote:
> You are right. I already checked that in the code...
> However, with module_init() the driver fails on reading the nvmem.

And why is it failing ?
