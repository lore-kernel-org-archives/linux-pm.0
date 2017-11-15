From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3] cpupower : Fix cpupower working when cpu0 is offline
Date: Wed, 15 Nov 2017 08:22:09 -0700
Message-ID: <2289b9f8-d533-3fa4-1524-22613dcc520a@kernel.org>
References: <20171115084002.23887-1-huntbag@linux.vnet.ibm.com>
Reply-To: shuah@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171115084002.23887-1-huntbag@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11/15/2017 01:40 AM, Abhishek Goel wrote:
> cpuidle_monitor used to assume that cpu0 is always online which is not
> a valid assumption on POWER machines. This patch fixes this by getting
> the cpu on which the current thread is running, instead of always using
> cpu0 for monitoring which may not be online.
> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>  tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Thanks. I will queue this for 4.15-rc2

-- SHuah
