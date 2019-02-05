From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V4 00/20] Tegra210 DFLL support
Date: Tue, 05 Feb 2019 14:27:28 -0800
Message-ID: <154940564864.169292.12172524763781613917@swboyd.mtv.corp.google.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190125134617.GE22565@ulmo>
 <0a7abeee-1b78-4f90-e94f-43c19eddb9b1@nvidia.com>
 <20190128075442.GA18124@ulmo>
 <a2cf3ccd-658a-e004-1e66-d4f9cf1026f1@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a2cf3ccd-658a-e004-1e66-d4f9cf1026f1@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joseph Lo <josephl@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Joseph Lo (2019-01-31 18:49:38)
> On 1/28/19 3:54 PM, Thierry Reding wrote:
> > 
> > the same applies for clk patches. Stephen's acked all of them and I
> > think all of the series is good to go. How about if I pick up these
> > up in the Tegra tree and let this all cook in linux-next for a week
> > or so and then send you a pull request with these? Stephen already
> > picked up a couple of fixes for clk/tegra, but I don't think any of
> > those would conflict with this series.
> > 
> > All of that said, Joseph confirmed that there are no dependencies
> > between these subsystem subseries, so if you'd prefer to pick up the
> > patches into your respective trees, I have no objections to that.
> > 
> > Thierry
> > 
> 
> Hi Rafael, Stephen,
> 
> Gental ping. Please let Thierry know if the cpufreq and DFLL clock 
> related changes can go through Tegra tree.
> 
> I know Rafael did say [1] it's okay to go through Tegra tree in earlier 
> comment.
> 

I am happy with the plan. Thanks!
