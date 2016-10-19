From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] Switch to the DT cpufreq policy on the Integrator
Date: Wed, 19 Oct 2016 12:14:24 +0200
Message-ID: <6720864.e2sjvVVhdQ@wuerfel>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 19, 2016 11:59:09 AM CEST Linus Walleij wrote:
> 
> If people are happy with this approach and approve of the patches
> I'd like an ACK from the cpufreq people and then merge the whole set
> through ARM SoC.
> 

I don't see any hard dependency here, so I'd suggest to merge the
two cpufreq patches through the subsystem tree, and the ARM patches
through arm-soc.

The patches look fine.

Removing the custom driver of course means that we break machines
with old .dtb files, so we could consider leaving the driver in
place, but probably there is no need for integrator.

	Arnd
