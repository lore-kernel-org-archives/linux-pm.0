From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v14 0/2] Kryo CPU scaling driver
Date: Wed, 30 May 2018 10:08:19 +0200
Message-ID: <CAJZ5v0gwtu-ptPskMeiXqWcRLhaGvvFVRyi-kX=nw_s6if7XGg@mail.gmail.com>
References: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527250067-1256-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 25, 2018 at 2:07 PM, Ilia Lin <ilialin@codeaurora.org> wrote:
> [v14]
>  * Addressed comment from Sudeep about DT compatible
>  * Added MAINTAINERS entry

This causes a build issue to occur in my bleeding-edge branch.

Does it depend on anything new in arm-soc?

Thanks,
Rafael
