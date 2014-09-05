From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: [PATCH 3.10.y+] PM / sleep: Use valid_state() for platform-dependent
 sleep states only
Date: Fri, 05 Sep 2014 08:29:09 +0200
Message-ID: <54095835.7000207@gmail.com>
References: <1849024.CHOUso6H2K@vostro.rjw.lan> <1409865665-5375-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409865665-5375-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-pm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 09/04/2014 11:21 PM, Brian Norris wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> [Upstream commit 43e8317b0bba1d6eb85f38a4a233d82d7c20d732]
> 
> Use the observation that, for platform-dependent sleep states
> (PM_SUSPEND_STANDBY, PM_SUSPEND_MEM), a given state is either
> always supported or always unsupported and store that information
> in pm_states[] instead of calling valid_state() every time we
> need to check it.
> 
> Also do not use valid_state() for PM_SUSPEND_FREEZE, which is always
> valid, and move the pm_test_level validity check for PM_SUSPEND_FREEZE
> directly into enter_state().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: <stable@vger.kernel.org> # 3.10+: 27ddcc6596e5: PM / sleep: Add state field to pm_states[] entries
> Cc: <stable@vger.kernel.org> # 3.10+
> ---
> This is a backport request for these two commits upstream:
> 
>     27ddcc6596e5 PM / sleep: Add state field to pm_states[] entries
>     43e8317b0bba PM / sleep: Use valid_state() for platform-dependent sleep states only
> 

Wouldn't it be cleaner to have 2 separate backports then ?

Thanks for the backport anyways.
