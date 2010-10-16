From: Len Brown <lenb@kernel.org>
Subject: cpuidle_state.power_usage and
	cpuidle_device.power_specified
Date: Fri, 15 Oct 2010 21:22:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010152054060.2971@localhost.localdomain>
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
To: Ai Li <aili@codeaurora.org>
Cc: linux-pm@lists.linux-foundation.org, Magnus Damm <damm@opensource.se>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Ai,

With the introduction of cpuidle_device.power_specified in

commit 71abbbf856a0e70ca478782505c800891260ba84
(cpuidle: extend cpuidle and menu governor to handle dynamic states)

large positive numbers are now shown in sysfs
rather than the power numbers specified by
acpi_idle, intel_idle, and sh_idle.

I expect the intent of the patch was actually to set the default
to power_specified=1 for the drivers where really do specify
power_usage rather than to override every driver, yes?

But it has been on my clean-up list to delete power_usage from
both intel_idle and acpi_idle anyway -- and I'd offer the same
change to sh_idle, since it appears to be of no value there
either.  I planned to then to delete power_usage from
cpuidle itself.

But you have changed menu_select from assuming
that states are in order of increasing power savings,
to doing an exhaustive search of all states to find
the one with the lowest power_usage that satisfies constraints.

Does your platform set cpuidle_device.power_specified,
or is it using the small negative integers for power_usage
that you have bestowed upon the other architectures?

Do you intend to modify power_usage at run-time, even
when the new CPUIDLE_FLAG_IGNORE flag is available?

thanks,
Len Brown, Intel Open Source Technology Center
