From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] PM / OPP: compatible is an optional property
Date: Fri, 23 Sep 2016 10:45:26 +0530
Message-ID: <20160923051526.GB17336@vireshk-i7>
References: <be2c4fb0bb58f5b29facbc6f5aaf3dca13cf209e.1474450324.git.viresh.kumar@linaro.org>
 <483bea3c-a1b4-ce5d-e720-d69fc943ab50@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <483bea3c-a1b4-ce5d-e720-d69fc943ab50@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-09-16, 12:24, Stephen Boyd wrote:
> On 09/21/2016 02:32 AM, Viresh Kumar wrote:
> > It was never compulsory to have a compatible string in the OPP table.
> > Fix the documentation to mark it optional.
> >
> > Also update its description a bit.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Why? I'd prefer the compatible string to be required so we know what
> sort of node it is.

Okay, the code doesn't have any checks for it then and that needs to be fixed.

Just for my clarity, for platforms with special OPP bindings and so a different
compatible string like: "operating-points-v2-XYZ", should the compatible string
contain both "operating-points-v2" and the above one? It would be easier to
check for "operating-points-v2" in that case from core code.

-- 
viresh
