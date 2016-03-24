From: Matthew McClintock <mmcclint@codeaurora.org>
Subject: Re: [PATCH 14/17] cpufreq: ipq4019: add cpufreq driver
Date: Thu, 24 Mar 2016 10:42:57 -0500
Message-ID: <C5B27D64-0C56-4815-BC0A-023C7A955032@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org> <1458770712-10880-15-git-send-email-mmcclint@codeaurora.org> <20160324064410.GH22062@vireshk-i7>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160324064410.GH22062@vireshk-i7>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, qca-upstream.external@qca.qualcomm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, open list <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mar 24, 2016, at 1:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> On 23-03-16, 17:05, Matthew McClintock wrote:
>> Add cpufreq driver for ipq4019 SoC. This driver simply instantiates
>> cpufreq-dt.
>> 
>> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
>> ---
>> drivers/cpufreq/Kconfig.arm       |  9 +++++++++
>> drivers/cpufreq/Makefile          |  1 +
>> drivers/cpufreq/ipq4019-cpufreq.c | 35 +++++++++++++++++++++++++++++++++++
>> 3 files changed, 45 insertions(+)
>> create mode 100644 drivers/cpufreq/ipq4019-cpufreq.c
> 
> I have just sent a patchset and cc'd you:
> "[PATCH 0/3] cpufreq: dt: Create platform device from generic code"
> 
> and so this patch may get replaced now.

Cool, thanks. I will look at re-spinning with your changes.

-M
