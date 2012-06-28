From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] acpi: intel_idle : break dependency
	between modules
Date: Thu, 28 Jun 2012 17:26:48 +0530
Message-ID: <4FEC4680.1090006@linux.vnet.ibm.com>
References: <201206271506.29034.trenn@suse.de>
	<1340873202-2476-1-git-send-email-daniel.lezcano@linaro.org>
	<4FEC3EF7.5020208@linux.vnet.ibm.com> <4FEC3FAB.20706@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FEC3FAB.20706@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 06/28/2012 04:57 PM, Daniel Lezcano wrote:
> On 06/28/2012 01:24 PM, Srivatsa S. Bhat wrote:
>> On 06/28/2012 02:16 PM, Daniel Lezcano wrote:
>>> When the system is booted with some cpus offline, the idle
>>> driver is not initialized. When a cpu is set online, the
>>> acpi code call the intel idle init function. Unfortunately
>>> this code introduce a dependency between intel_idle and acpi.
>>>
>>> This patch is intended to remove this dependency by using the
>>> notifier of intel_idle. This patch has the benefit of
>>> encapsulating the intel_idle driver and remove some exported
>>> functions.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>>
>> Looks good to me.
> 
> Thanks for the review Srivatsa.
> 
> Shall I consider it as an acked-by ?
> 

Sure, go ahead! :-)

Regards,
Srivatsa S. Bhat
