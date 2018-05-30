From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v14 0/2] Kryo CPU scaling driver
Date: Wed, 30 May 2018 14:45:35 +0530
Message-ID: <20180530091535.bzvhg4bvn32mqwgq@vireshk-i7>
References: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
 <CAJZ5v0gwtu-ptPskMeiXqWcRLhaGvvFVRyi-kX=nw_s6if7XGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwtu-ptPskMeiXqWcRLhaGvvFVRyi-kX=nw_s6if7XGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilia Lin <ilialin@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30-05-18, 10:08, Rafael J. Wysocki wrote:
> On Fri, May 25, 2018 at 2:07 PM, Ilia Lin <ilialin@codeaurora.org> wrote:
> > [v14]
> >  * Addressed comment from Sudeep about DT compatible
> >  * Added MAINTAINERS entry
> 
> This causes a build issue to occur in my bleeding-edge branch.
> 
> Does it depend on anything new in arm-soc?

He already sent a v15 and the changelog suggest he fixed that build
issue.

-- 
viresh
