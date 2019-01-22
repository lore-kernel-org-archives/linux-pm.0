From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v13 0/8] Introduce on-chip interconnect API
Date: Tue, 22 Jan 2019 16:45:20 +0200
Message-ID: <2ac9b994-ecbf-05fd-5c01-7ecd0089c744@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
 <20190122124204.GA26969@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122124204.GA26969@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, dianders@chromium.org, abailon@baylibre.com, maxime.ripard@bootlin.com, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, henryc.chen@mediatek.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 1/22/19 14:42, Greg KH wrote:
> On Wed, Jan 16, 2019 at 06:10:55PM +0200, Georgi Djakov wrote:
[..]
> 
> All now queued up, thanks.
> 
> greg k-h

Hi Greg,

Thanks for considering these patches! Actually i have a branch named
icc-next [1] which is pulled into linux-next. I will drop these same
patches to avoid conflicts.

If all is well, i was wondering how to proceed with follow-up patches.
Some consumers of this API are already floating on the lists. How about
sending you a pull request before the merge window with the collected
patches?

Thanks,
Georgi

1. https://git.linaro.org/people/georgi.djakov/linux.git/log/?h=icc-next
