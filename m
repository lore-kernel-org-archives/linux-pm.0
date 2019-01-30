From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Date: Wed, 30 Jan 2019 10:57:52 +0530
Message-ID: <20190130052752.v2zujifnkm3o7krf@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190117131631.GA14385@localhost.localdomain>
 <CAJZ5v0jFqXGf_G2v1VNXSxyiDzgeFY8OKUFu2tQ8Wso3dBS+_w@mail.gmail.com>
 <20190118123900.GJ14385@localhost.localdomain>
 <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
 <CA+mqd+7EqERei8eekAsVxa_bJUYETyO3T76L8Q_sV=C9rwiy3g@mail.gmail.com>
 <20190128140441.yetyx7hgtdoyk4mn@e107158-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128140441.yetyx7hgtdoyk4mn@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com" <CAJZ5v0gtjq9Nh0WHbMzY+3Z3o5NWiWhP=QEXxzjVe3ta32z7=Q@mail.gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Matthias Kaehlcke <mka@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28-01-19, 14:04, Qais Yousef wrote:
> But we have no way to enforce this, no? I'm thinking if frequency can be
> constrained in PM QoS framework, then we will end up with some drivers that
> think it's a good idea to use it and potentially end up breaking this "should
> not work against schedutil and similar".
> 
> Or did I miss something?
> 
> My point is that if we introduce something too generic we might end up
> encouraging more users and end up with a complex set of rules/interactions and
> lose some determinism. But I could be reading too much into it :-)

People are free to use notifiers today as well and there is nobody
stopping them. A new framework/layer may actually make them more
accountable as we can easily record which all entities have requested
to impose a freq-limit on CPUs.

-- 
viresh
