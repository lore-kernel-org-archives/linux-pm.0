From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 5/6] dt-bindings: cpufreq: move Mediatek cpufreq
 dt-bindings document to proper place
Date: Mon, 8 May 2017 14:19:47 +0800
Message-ID: <1494224387.9662.10.camel@mtkswgap22>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
         <1493997974-17699-6-git-send-email-sean.wang@mediatek.com>
         <20170508041827.GC17010@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170508041827.GC17010@vireshk-i7>
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2017-05-08 at 09:48 +0530, Viresh Kumar wrote:
> On 05-05-17, 23:26, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > The old place is Documentation/devicetree/bindings/clock/ that would
> > let people hard to find how to use Mediatek cpufreq driver, so moving
> > it to the new place as other cpufreq dirvers are done would be better.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  | 83 ----------------------
> >  .../bindings/cpufreq/cpufreq-mediatek.txt          | 83 ++++++++++++++++++++++
> >  2 files changed, 83 insertions(+), 83 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> 
> Please generate patches with:
> 
> git format-patch -C -M --thread=shallow
> 
> You would be required to resend this patch at least to let us see what has
> changed.
> 

Hi Viresh,

Okay, I will do it with you provided command again. 

What I did for the patch is just "git mv
Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt"
and no any changing data in the content.

thanks for your feedback

	Sean



