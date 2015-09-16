From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
Date: Thu, 17 Sep 2015 07:44:53 +0900
Message-ID: <55F9F0E5.7000805@kernel.org>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <20150908024659.GF26760@linux> <55EE5C79.2030604@samsung.com>
 <20150908042017.GJ26760@linux> <55EE6892.3010304@samsung.com>
 <20150908051053.GA18554@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150908051053.GA18554@linux>
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
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, Thomas Abraham <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Moon <linux.amoon@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: linux-pm@vger.kernel.org

On 09/08/15 14:10, Viresh Kumar wrote:
> On 08-09-15, 13:48, Krzysztof Kozlowski wrote:
>> Somehow my mind stuck on solving Exynos4x12 cpufreq issues.
>>
>> Right, it should go through Rafael's, probably except DTS patch (4/4)
>> because it depends on previous DTS changes. These changes are still in
>> arm-soc, not in Linus' tree [0].
> 
> That's bad :(
> 
> Anyway, 4/4 is kind of independent to this series, in the sense that
> it wouldn't harm even if it gets applied separately.
> 
> So, go ahead and apply 4/4 to Samsung's tree and rest of this can be
> picked by Rafael.
> 
Applied 4/4 into samsung tree, thanks.

- Kukjin
