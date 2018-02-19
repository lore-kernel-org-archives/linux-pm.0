From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 10/10] dt-bindings: thermal: Remove
 "cooling-{min|max}-level" properties
Date: Mon, 19 Feb 2018 12:01:24 -0600
Message-ID: <20180219180124.22rcnjoyvv3qw3cl@rob-hp-laptop>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
 <20180218232906.jkpymin3a4qxjhnc@rob-hp-laptop>
 <20180219034338.GI28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180219034338.GI28462@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 19, 2018 at 09:13:38AM +0530, Viresh Kumar wrote:
> On 18-02-18, 17:29, Rob Herring wrote:
> > On Fri, Feb 09, 2018 at 02:28:10PM +0530, Viresh Kumar wrote:
> > > The "cooling-min-level" and "cooling-max-level" properties are not
> > > parsed by any part of kernel currently and the max cooling state of a
> > > CPU cooling device is found by referring to the cpufreq table instead.
> > 
> > What about non-CPU devices? A fan for example.
> 
> Even they aren't using these properties. The gpio-fan binding[1] for
> example uses the "gpio-fan,speed-map" property instead to find the
> number of states it supports.

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>
