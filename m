From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 00/14] PM: SoC idle support using PM domains
Date: Wed, 27 Jul 2016 09:06:05 -0600
Message-ID: <20160727150605.GE1369@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <m260rsuk5q.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m260rsuk5q.fsf@baylibre.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 26 2016 at 16:08 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Hi all,
>>
>> Changes since RFC-v3:
>> - Reorganize the patches. Documentations have their own patch.
>> - Moved code around with PSCI OS initiated so they would not have compiler
>>   errors in other configuration.
>> - Minor bug fixes with genpd power_on functionality.
>> - Rebased on top of 4.7-rc1
>
>This is looking good.  I've had a quick look through this, as well as
>tested it on apq8016-sbc (dragon 410c.)
>
Thanks Kevin.


>Seems the main thing left to resolve is the DT description.
>
I am inclining to have the DT description point to arm,idle-state as
suggested by Mark. I will change this in my next revision.

Thanks for your time.

Lina
