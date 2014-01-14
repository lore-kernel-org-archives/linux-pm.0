From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/menu: Fail cpuidle_idle_call() if no idle state
 is acceptable
Date: Tue, 14 Jan 2014 13:07:32 +0530
Message-ID: <52D4E93C.3050503@linux.vnet.ibm.com>
References: <20140114060516.6109.14901.stgit@preeti.in.ibm.com>
 <52D4E07E.204@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <52D4E07E.204@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: deepthi@linux.vnet.ibm.com, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, tuukka.tikkanen@linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/14/2014 12:30 PM, Srivatsa S. Bhat wrote:
> On 01/14/2014 11:35 AM, Preeti U Murthy wrote:
>> On PowerPC, in a particular test scenario, all the cpu idle states were disabled.
>> Inspite of this it was observed that the idle state count of the shallowest
>> idle state, snooze, was increasing.
>>
>> This is because the governor returns the idle state index as 0 even in
>> scenarios when no idle state can be chosen. These scenarios could be when the
>> latency requirement is 0 or as mentioned above when the user wants to disable
>> certain cpu idle states at runtime. In the latter case, its possible that no
>> cpu idle state is valid because the suitable states were disabled
>> and the rest did not match the menu governor criteria to be chosen as the
>> next idle state.
>>
>> This patch adds the code to indicate that a valid cpu idle state could not be
>> chosen by the menu governor and reports back to arch so that it can take some
>> default action.
>>
> 
> That sounds fair enough. However, the "default" action of pseries idle loop
> (pseries_lpar_idle()) surprises me. It enters Cede, which is _deeper_ than doing
> a snooze! IOW, a user might "disable" cpuidle or set the PM_QOS_CPU_DMA_LATENCY
> to 0 hoping to prevent the CPUs from going to deep idle states, but then the
> machine would still end up going to Cede, even though that wont get reflected
> in the idle state counts. IMHO that scenario needs some thought as well...
> 

I checked the git history and found that the default idle was changed (on purpose)
to cede the processor, in order to speed up booting.. Hmm..

commit 363edbe2614aa90df706c0f19ccfa2a6c06af0be
Author: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date:   Fri Sep 6 00:25:06 2013 +0530

    powerpc: Default arch idle could cede processor on pseries


Regards,
Srivatsa S. Bhat
