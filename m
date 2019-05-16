From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH 0/8] Add cpufreq and cci devfreq for mt8183, and SVS
 support
Date: Thu, 16 May 2019 20:23:46 +0800
Message-ID: <1558009426.29944.1.camel@mtksdaap41>
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <20190516092328.4n7kuqw7bxokhdjp@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190516092328.4n7kuqw7bxokhdjp@vireshk-i7>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, srv_heupstream@mediatek.com, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, fan.chen@mediatek.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2019-05-16 at 14:53 +0530, Viresh Kumar wrote:
> On 16-05-19, 17:08, Andrew-sh.Cheng wrote:
> > From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> > 
> > MT8183 supports CPU DVFS and CCI DVFS, and LITTLE cpus and CCI are in the same voltage domain.
> > So, this series is to add drivers to handle the voltage coupling between CPU and CCI DVFS.
> > 
> > For SVS support, add OPP_EVENT_ADJUST_VOLTAGE and corresponding reaction.
> 
> No version information here or what has changed. That doesn't help.
> 
> I believe this is V3.
> 
> Don't resend it but please mention the changes in reply now. Thanks.
Yes, this is patch v3

Change since v2:
- Separate cpufreq modification into 3 patches.
- Modify dt-binding for more HW information.
- Refine cci devfreq coding style.
- patch 6 ~ patch 8 are for SVS support

> 
> > Andrew-sh.Cheng (7):
> >   cpufreq: mediatek: change to regulator_get_optional
> >   cpufreq: mediatek: add clock enable for intermediate clock
> >   cpufreq: mediatek: Add support for mt8183
> >   dt-bindings: devfreq: add compatible for mt8183 cci devfreq
> >   devfreq: add mediatek cci devfreq
> >   cpufreq: mediatek: add opp notification for SVS support
> >   devfreq: cci devfreq register opp notification for SVS support
> > 
> > Stephen Boyd (1):
> >   PM / OPP: Support adjusting OPP voltages at runtime
> > 
> >  .../bindings/devfreq/mt8183-cci-devfreq.txt        |  20 ++
> >  drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
> >  drivers/cpufreq/mediatek-cpufreq.c                 |  88 +++++-
> >  drivers/devfreq/Kconfig                            |  10 +
> >  drivers/devfreq/Makefile                           |   1 +
> >  drivers/devfreq/mt8183-cci-devfreq.c               | 310 +++++++++++++++++++++
> >  drivers/opp/core.c                                 |  78 ++++++
> >  include/linux/pm_opp.h                             |  11 +
> >  8 files changed, 517 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
> >  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> > 
> > -- 
> > 2.12.5
> 
