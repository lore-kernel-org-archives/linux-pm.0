From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5] ACPI / Sleep: Check low power idle constraints for debug only
Date: Tue, 22 Aug 2017 15:08:44 +0200
Message-ID: <2237482.YGg0anG1lD@aspire.rjw.lan>
References: <1502846219-19192-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1502846219-19192-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 16, 2017 3:16:59 AM CEST Srinivas Pandruvada wrote:
> For SoC to achieve its lowest power platform idle state a set of hardware
> preconditions must be met. These preconditions or constraints can be
> obtained by issuing a device specific method (_DSM) with function "1".
> Refer to the document provided in the link below.
> 
> Here during initialization (from attach() callback of LPS0 device), invoke
> function 1 to get the device constraints. Each enabled constraint is
> stored in a table.
> 
> The devices in this table are used to check whether they were in required
> minimum state, while entering suspend. This check is done from platform
> freeze wake() callback, only when /sys/power/pm_debug_messages attribute
> is non zero.
> 
> If any constraint is not met and device is ACPI power managed then it
> prints the device information to kernel logs.
> 
> Also if debug is enabled in acpi/sleep.c, the constraint table and state
> of each device on wake is dumped in kernel logs.
> 
> Since pm_debug_messages_on setting is used as condition to check
> constraints outside kernel/power/main.c, pm_debug_messages_on is changed
> to a global variable.
> 
> Link: http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied, thanks!

