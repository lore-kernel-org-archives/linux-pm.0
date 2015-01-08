From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver
 if MCPM is unavailable
Date: Thu, 08 Jan 2015 14:46:15 +0530
Message-ID: <54AE4ADF.3030307@arm.com>
References: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>
 <54AE459B.8010703@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54AE459B.8010703@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Thursday 08 January 2015 02:23 PM, Daniel Lezcano wrote:
> On 01/08/2015 07:29 AM, Sudeep Holla wrote:
>> If big.LITTLE driver is initialized even when MCPM is unavailable,
>> we get the below warning the first time cpu tries to enter deeper
>> C-states.
>
> Can you elaborate why MCPM could be unavailable when the tc2 pm code
> registers the mcpm platform ops before the cpuidle driver ?
>
>
I can think of 3 possible scenarios. Let me know if these make sense.

1. If the firmware settings in Vexpress configuration files are set to
    boot in legacy mode, but MCPM is enabled in the kernel.
2. If some failure occurs during MCPM initialization
3. For example, if CCI is not accessible as in some Exynos boards [1],
    we don't want to wait till mpcm_cpu_suspend ?

Regards,
Sudeep

[1] 
https://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg39624.html
