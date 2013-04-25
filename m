From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] cpuidle: add maintainer entry
Date: Thu, 25 Apr 2013 14:09:11 +0200
Message-ID: <CACRpkdaA8uG5jYyYTbuvzZNRr47EhWHFMLLz+jbiE3FPC1vjmA@mail.gmail.com>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
 <87k3nr50n4.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87k3nr50n4.fsf@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Daniel Lezcano <daniel.lezcano@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Paul Mackerras <paulus@samba.org>, Joseph Lo <josephl@nvidia.com>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Len Brown <lenb@kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, "Nori, Sekhar" <nsekhar@ti.com>, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Simon Horman <horms@verge.net.au>, Ben Dooks <ben-linux@fluff.org>, Simon Horman <horms+renesas@verge.net.au>, Andrew Victor <linux@m>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 24, 2013 at 6:55 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Rafael,
>
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>
> [...]
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 61677c3..effa0f3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2206,6 +2206,13 @@ S:     Maintained
>>  F:   drivers/cpufreq/
>>  F:   include/linux/cpufreq.h
>>
>> +CPUIDLE DRIVERS
>> +M:   Rafael J. Wysocki <rjw@sisk.pl>
>> +L:   linux-pm@vger.kernel.org
>> +S:   Maintained
>> +F:   drivers/cpuidle/*
>> +F:   include/linux/cpuidle.h
>
> What do you think about having Daniel listed here as a co-maintainer?

I second that. He will bring useful embedded knowledge to the
subsystem.

Yours,
Linus Walleij
