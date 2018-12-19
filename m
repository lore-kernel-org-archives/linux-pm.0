From: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V3 11/20] cpufreq: tegra124: do not handle the CPU rail
Date: Wed, 19 Dec 2018 14:24:09 +0800
Message-ID: <312ac6e6-0480-b638-a26b-311013929c2c@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-12-josephl@nvidia.com>
 <CAJZ5v0h0n2AXERvXFX_dQWMUw_89ap_LgB6dUK0ThJgZ+unkkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJZ5v0h0n2AXERvXFX_dQWMUw_89ap_LgB6dUK0ThJgZ+unkkQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 12/18/18 5:37 PM, Rafael J. Wysocki wrote:
> On Tue, Dec 18, 2018 at 10:13 AM Joseph Lo <josephl@nvidia.com> wrote:
>>
>> The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
>> rail. So this driver shouldn't handle for the CPU clock switching from
>> DFLL to other PLL clocks. It was designed to work on DFLL clock only,
>> which handle the frequency/voltage scaling in the background.
>>
>> This patch removes the driver dependency of the CPU rail, as well as not
>> allow it to be built as a module and remove the removal function. So it
>> can keep working on DFLL clock.
>>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I'm assuming that this entire series will go in via arm-soc, so I
> won't be picking up the cpufreq patches from it.
> 
> Please let me know if that is not what you want.
> 
> Thanks,
> Rafael
> 

Hi Rafael,

Thanks, will check with Thierry.

Joseph
