From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
Date: Wed, 22 Jun 2016 11:53:32 +0200
Message-ID: <3668897.kYSEflAvDO@wuerfel>
References: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@lists.codethink.co.uk, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 22, 2016 10:33:03 AM CEST Ben Dooks wrote:
> The use of __raw IO accesors is not endian safe and should be used
> sparingly. The relaxed variants should be as lightweight and also
> are endian safe.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 

Why not use the normal readl/writel() here instead of the relaxed version?

Either one should work here, but in general I'd recommend using the
non-relaxed version unless code is particularly performance sensitive.

The main argument for that is to not let people get used to using
_relaxed() all the time because it causes some very hard to debug
problems in the cases where you actually need the barriers.

	Arnd
