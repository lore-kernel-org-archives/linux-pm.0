From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
Date: Wed, 26 Aug 2015 07:46:59 +0530
Message-ID: <20150826021659.GD8784@linux>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <CALx668VWg2xVxzy8P7f5QFWRzm+TDJXUghL-_rbvRLsLYjtnng@mail.gmail.com>
 <1617873.VRHfat3V76@vostro.rjw.lan>
 <CALx668UvkYhLoU8rxLG70RqTzsnaiV5-ybDYTKqb4MEJS8pmRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALx668UvkYhLoU8rxLG70RqTzsnaiV5-ybDYTKqb4MEJS8pmRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 26-08-15, 09:25, Pi-Cheng Chen wrote:
> The [3/3] is based on Mediatek SoC maintainer tree[1] and the patch which
> introduce a new clock type[2] consumed by MT8173 cpufreq driver. So it will
> cause some conflicts if it goes through your tree. I am not sure how this
> should be handled, but should it be merged through Mediatek SoC maintainer
> tree?

Just get that applied to MTK tree, it doesn't have any dependency on
rest of the patches for build/boot. The only thing is that cpufreq
wouldn't work and it will work as soon as Rafael's and MTK's trees are
merged by Linus.

-- 
viresh
