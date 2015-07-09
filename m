From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Thu, 9 Jul 2015 10:47:04 +0530
Message-ID: <20150709051704.GL1805@linux>
References: <1435717005-20012-1-git-send-email-pi-cheng.chen@linaro.org>
 <1435717005-20012-3-git-send-email-pi-cheng.chen@linaro.org>
 <20150708113455.GF1805@linux>
 <CALx668Xp051A-BBGwwNxpiQCt318Bh5fnA5jcAXBg-9vPcqpvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALx668Xp051A-BBGwwNxpiQCt318Bh5fnA5jcAXBg-9vPcqpvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 09-07-15, 09:55, Pi-Cheng Chen wrote:
> That's what I did in previous version. But the reason I use the device-
> driver model is to handle the defer probing issue. Since there's no
> arch/arm64/mach-mediatek/ directory to hold the device registration
> code anymore, no device tree way to match cpufreq driver
> (please correct me if there's any), and initcall seems not handle
> defer probing either, therefore I put both device and driver
> registration in this function. I know it's crappy. :(
> Do you have any suggestion to do it right and handle defer probing
> properly?

Sounds reasonable. Just add proper comment in code to explain that.

-- 
viresh
