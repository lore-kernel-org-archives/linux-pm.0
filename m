From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
Date: Fri, 28 Aug 2015 16:06:16 +0200
Message-ID: <22538895.vrRgZUmQTV@vostro.rjw.lan>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org> <20150826021659.GD8784@linux> <CALx668V2herrp6XOtCDR7nNvFhd7DLLMjXmr86cjfCOQ_cgmrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALx668V2herrp6XOtCDR7nNvFhd7DLLMjXmr86cjfCOQ_cgmrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 26, 2015 02:53:39 PM Pi-Cheng Chen wrote:
> On Wed, Aug 26, 2015 at 10:16 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 26-08-15, 09:25, Pi-Cheng Chen wrote:
> >> The [3/3] is based on Mediatek SoC maintainer tree[1] and the patch which
> >> introduce a new clock type[2] consumed by MT8173 cpufreq driver. So it will
> >> cause some conflicts if it goes through your tree. I am not sure how this
> >> should be handled, but should it be merged through Mediatek SoC maintainer
> >> tree?
> >
> > Just get that applied to MTK tree, it doesn't have any dependency on
> > rest of the patches for build/boot. The only thing is that cpufreq
> > wouldn't work and it will work as soon as Rafael's and MTK's trees are
> > merged by Linus.
> 
> Thanks for your explanation.
> 
> @Rafael, Would you please apply [1,2] to your tree?

Applied, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
