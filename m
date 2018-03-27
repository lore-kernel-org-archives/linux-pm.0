From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 10/10] dt-bindings: thermal: Remove
 "cooling-{min|max}-level" properties
Date: Tue, 27 Mar 2018 06:46:15 -0700
Message-ID: <20180327134613.GA10890@localhost.localdomain>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
 <20180312043815.GW6842@vireshk-i7>
 <1521550190.2781.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521550190.2781.3.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 20, 2018 at 08:49:50PM +0800, Zhang Rui wrote:
> On 一, 2018-03-12 at 10:08 +0530, Viresh Kumar wrote:
> > On 09-02-18, 14:28, Viresh Kumar wrote:
> > > 
> > > The "cooling-min-level" and "cooling-max-level" properties are not
> > > parsed by any part of kernel currently and the max cooling state of
> > > a
> > > CPU cooling device is found by referring to the cpufreq table
> > > instead.
> > > 
> > > Remove the unused bindings.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/thermal/thermal.txt | 16 +----
> > > -----------
> > >  1 file changed, 1 insertion(+), 15 deletions(-)
> > @Zhang/Eduardo: Can you please pick this patch (10/10) as almost
> > everything else
> > is already lined up for 4.17 ?
> 
> I think Eduardo should have reviewed all the DT thermal patches in the
> list, but I didn't see his response about this one.
> 
> Eduardo,
> did you miss this one?

just applied and sending it in my pull request.

> 
> thanks,
> rui
> > 
