From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/10] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Sun, 6 Dec 2015 07:56:04 +0530
Message-ID: <20151206022604.GW3430@ubuntu>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
 <20151205035444.GR3430@ubuntu> <3776700.7KBsWa2Q4V@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3776700.7KBsWa2Q4V@amdc1976>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, Anand Moon <linux.amoon@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Ben Gamari <ben@smart-cactus.org>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05-12-15, 08:49, Bartlomiej Zolnierkiewicz wrote:
> Why I appreciate Ben's work this not exactly the same thing as
> the above patchset lacks critical CLK_RECALC_NEW_RATES bugfix and
> few other minor fixes.

I am not saying that these are exactly same, code wise, but you are
both targeting to solve the same problem.

> > And the comments given there applies to you as well.
> 
> Yes, sure.  That's why I wrote that this is work-in-progress
> and put the TODO in the cover letter.

As I mentioned there, you need to migrate to cpufreq-dt instead of
arm-big-little now.

-- 
viresh
