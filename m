From: "Chidambaram, Praveen" <pchidamb@codeaurora.org>
Subject: RFC: Deadlock in Hotplug and CPUFreq interaction.
Date: Tue, 26 Oct 2010 11:17:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010260944550.9583@pchidamb-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I am running into a deadlock situation with hotplug and CPUFreq. I 
need to be able to prevent hotplug when changing the cpu frequency of 
my CPU to ensure that the workqueue I post to, doesnt get migrated 
during the cpu frequency change in the target function. I cannot 
change frequency in the interrupt context as it involves mutexes (in 
the clk_set_rate function and also in the regulator functions).

When the CPU is hotplugged, the hotplug notifications of CPU_PREPARE, 
CPU_UP are handled by CPUFreq to engage the sysfs nodes and also 
initialize the governor. The governor mutex is held before the target 
function is called. Now, if there was another thread, changing the 
frequency of another CPU, it will hold the governor mutex and then 
call the target function and will wait on the hotplug lock.

Thread1 : Change cpu freq core0 > holds governor mutex > calls target 
function > waits on get_online_cpus()

Thread2 : Hotplug core1 > calls get_online_cpus() holds hotplug mutex 
> calls notifiers > Calls CPUFreq notification handlers > waits on 
governor mutex.

I would like to suggest an try_get_online_cpus() that does a 
mutex_trylock(). Are there better ways to overcome this issue?

Thanks,
Praveen

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
