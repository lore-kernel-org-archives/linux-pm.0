From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] drivers/cpufreq: include <module.h> for modular
 exynos-cpufreq.c code
Date: Mon, 15 Jun 2015 23:28:13 -0400
Message-ID: <CAP=VYLpWLUbuq0C6hAKhhpRr8Kv4jv1EgAwKvsuxHmFKFHQw3w@mail.gmail.com>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
 <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
 <5110473.q5rJrrjs9a@vostro.rjw.lan> <557F6567.1070901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <557F6567.1070901@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 15, 2015 at 7:53 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 16.06.2015 08:47, Rafael J. Wysocki wrote:
>> On Wednesday, June 03, 2015 05:18:18 PM Paul Gortmaker wrote:
>>> This file is built off of a tristate Kconfig option ("ARM_EXYNOS_CPUFREQ")
>>> and also contains modular function calls so it should explicitly include
>>> module.h to avoid compile breakage during pending header shuffles.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Cc: Kukjin Kim <kgene@kernel.org>
>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-samsung-soc@vger.kernel.org
>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>
>> I'm assuming that this will go in via the Samsung tree.
>>
>>
>>> ---
>>>
>>> [ patch will be appended to the implicit include fixup series, see:
>>>   https://lkml.kernel.org/r/1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com
>>>   for the original series posting.]
>
> Paul, will you handle the patch or should it go through Samsung tree?

My fault for not explicitly stating the obvious...  If I don't keep the
patch locally (or at least a version of it) then we can introduce a
compile bisection fail.  So I will keep all patches locally unless there
is a rebase where I can (also) rebase and drop said pach since it
has become common history of the shared baseline...

Paul.
--

>
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
