From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: int3403_driver_init needs over 330 ms to finish
Date: Wed, 14 Mar 2018 15:32:24 +0800
Message-ID: <1521012744.2087.13.camel@intel.com>
References: <b6cf267e-3042-1226-cb06-1b7fc26ed122@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b6cf267e-3042-1226-cb06-1b7fc26ed122@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-pm@molgen.mpg.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 二, 2018-03-13 at 20:39 +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Booting the Dell XPS 13 9370 with Linux 4.16-rc4+ and
> `initcall_debug`, 
> shows it is shown that int3403_driver_init needs over 330 ms to run.
> 
>      [    2.524839] initcall int3403_driver_init+0x0/0x1000 
> [int3403_thermal] returned 0 after 333972 usecs
> 
I guess most of the time are spent in evaluating ACPI ASL code.
But anyway, please create a bugzilla report and attach both dmesg and
acpidump there.

thanks,
rui
> Please find all Linux messages attached.
> 
> Is there a way to reduce that time?
> 
> 
> Kind regards,
> 
> Paul
