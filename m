From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH] cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs
Date: Thu, 17 Sep 2015 08:03:03 +0900
Message-ID: <55F9F527.6010606@kernel.org>
References: <1441731732-8624-1-git-send-email-b.zolnierkie@samsung.com> <5636818.tTEsh48iXg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5636818.tTEsh48iXg@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/09/15 10:14, Rafael J. Wysocki wrote:
> On Tuesday, September 08, 2015 07:02:12 PM Bartlomiej Zolnierkiewicz wrote:
>> CONFIG_PM ifdefs are superfluous and can be removed.
> 
> I guess Kukjin can apply this one?
> 
Applied, thanks.

- Kukjin
