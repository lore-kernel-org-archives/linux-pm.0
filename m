From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [RFC RESEND PATCH 6/7] soc: mediatek: add MT8183 dvfsrc support
Date: Wed, 09 Jan 2019 16:38:41 -0800
Message-ID: <154708072159.15366.10685577152949535083@swboyd.mtv.corp.google.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-7-git-send-email-henryc.chen@mediatek.com>
 <154655691363.15366.15223653253336032554@swboyd.mtv.corp.google.com>
 <1546859353.6818.132.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1546859353.6818.132.camel@mtksdaap41>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Henry Chen <henryc.chen@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Quoting Henry Chen (2019-01-07 03:09:13)
> On Fri, 2019-01-04 at 07:08 +0800, Stephen Boyd wrote:
> > Quoting Henry Chen (2019-01-02 06:09:57)
> > > +       val = dvfsrc_read(dvfsrc, DVFSRC_INT);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_INT_CLR, val);
> > > +       dvfsrc_write(dvfsrc, DVFSRC_INT_CLR, 0x0);
> > > +       if (val & DVFSRC_IRQ_TIMEOUT_EN)
> > > +               dev_warn(dvfsrc->dev, "timeout at spm = %x", val);
> > > +
> > 
> > Do you need to handle the irq at all? It looks like you are cleaning up
> > something and then complaining if there's a timeout, but otherwise
> > nothing goes on so perhaps the irq can just be ignored and nobody will
> > be the wiser?
> 
> ok, it only for alarm system a timeout message. 

Well if it's some timeout do you need to fail some dvfs operation if it
times out? Or take the whole system down in that scenario?
