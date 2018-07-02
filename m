From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
Date: Mon, 2 Jul 2018 13:21:51 -0700
Message-ID: <20180702202151.GK533219@devbig577.frc2.facebook.com>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: hdegoede@redhat.com, rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 02, 2018 at 12:08:45PM -0700, Srinivas Pandruvada wrote:
> From: Srinivas <srinivas.pandruvada@linux.intel.com>
> 
> One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend.
> 
> Several of these system don't have traditional ACPI S3, so it is
> important that they enter SLP_S0 state, to avoid draining battery even
> during suspend even with out of the box Linux installation.
> 
> SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
> user has to either use scsi-host sysfs or tools like powertop to set
> the sata-host link_power_management_policy to min_power.
> 
> This change sets by default link power management policy to min_power
> for some platforms.  To avoid regressions, the following conditions
> are used:
> - The kernel config is already set to use med_power_with_dipm or deeper
> - System is a modern standby system using ACPI low power idle flag
> - The platform is not blacklisted for Suspend to Idle and suspend
> to idle is used instead of S3
> This combination will make sure that systems are fairly recent and
> since getting shipped with modern standby standby, the DEVSLP function
> is already validated.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Seems sane to me.  Hans, what do you think?

Thanks.

-- 
tejun
