From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use
 correct compatibles
Date: Sun, 30 Oct 2016 21:50:53 -0500
Message-ID: <20161031025053.t2nxazou35vnna7y@rob-hp-laptop>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
 <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
 <7hh980taqp.fsf@baylibre.com>
 <68dc67d1-b443-f7b1-6229-0ac54e403d61@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <68dc67d1-b443-f7b1-6229-0ac54e403d61@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>, ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 26, 2016 at 09:57:35AM +0100, Sudeep Holla wrote:
> 
> 
> On 25/10/16 21:49, Kevin Hilman wrote:
> > Lina Iyer <lina.iyer@linaro.org> writes:
> > 
> > > Update domain-idle-state binding to use "domain-idle-state" compatible
> > > from Documentation/devicetree/bindings/arm/idle-states.txt.
> > > 
> > > Cc: <devicetree@vger.kernel.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > With no current users for this, I don't see the point of adding a
> > compatible now.
> > 
> > IMO, this should wait and be added with the identified user we can
> > discuss it then.
> > 
> 
> No, IMO it needs to be used for the proposed SoC idle/genpd solution.
> 
> I understand the nodes that are "arm,idle-state" compatible can be used
> for this new SoC hierarchical idle management, but it was never defined
> for that use originally. So this new feature must be advertised by the
> firmware with the presence of "domain-idle-state".
> 
> Yes we might have other ways to detect that but I have already seen that
> broken on the reference platform, so we need alternate/DT way to specify
> that.
> 
> Not all existing "arm,idle-state" compatible nodes will be capable of
> supporting this new SoC idle feature. It's just better and safer for a
> new feature getting added that relies on DT to have a new compatible.

Or perhaps you should describe something new rather than trying to 
graft in what's there. This combination of compatible strings looks a 
bit odd to me. Though, I've not really spent much time thinking about 
this.

Rob
