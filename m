From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] devfreq: Add COMPILE_TEST for build coverage
Date: Tue, 12 Jul 2016 19:11:56 +0900
Message-ID: <CAJ0PZbSqqJBZYSTqwLD9h2yjrTfaRbCGzAThh5Tg1FnWWjq51w@mail.gmail.com>
References: <1467035939-31799-1-git-send-email-k.kozlowski@samsung.com> <5773AE62.90206@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5773AE62.90206@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 29, 2016 at 8:17 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 06/27/2016 03:58 PM, Krzysztof Kozlowski wrote:
>> The SoC-specific devfreq and event drivers can be build tested on all
>> architectures.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>>
>> Success of compilation tested on ARM, ARM64, i386, x86_64 and powerpc
>> architectures (allyesconfigs).
>> ---
>>  drivers/devfreq/Kconfig       | 4 ++--
>>  drivers/devfreq/event/Kconfig | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
> Hi all,
>
> The patchset depends "clk: Provide notifier stubs when
> !COMMON_CLKclk-notify" [1] which you can get by merging clk-notify
> branch of clk tree:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-notify
>
> Can you pull while applying?
>

It is temporarily pulled at a branch "testing/kozlowki". Anyway, at
which version is this "clk-notify" being merged?


Cheers,
MyungJoo
