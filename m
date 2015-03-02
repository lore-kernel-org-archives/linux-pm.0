From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v2 1/1] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Mon, 02 Mar 2015 16:11:55 +0000
Message-ID: <54F48BCB.7070505@nexus-software.ie>
References: <1424880737-12119-1-git-send-email-boon.leong.ong@intel.com> <1424880737-12119-2-git-send-email-boon.leong.ong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424880737-12119-2-git-send-email-boon.leong.ong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ong Boon Leong <boon.leong.ong@intel.com>, rui.zhang@intel.com, edubezval@gmail.com, hock.leong.kweh@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 25/02/15 16:12, Ong Boon Leong wrote:

> +config INTEL_QUARK_DTS_THERMAL
> +	tristate "Intel Quark DTS thermal driver"
> +	depends on X86 && IOSF_MBI

Since the change is in RC-1 suggest
depends on X86_INTEL_QUARK
you can skip this though it's not important.

Tested works for me:

root@clanton:~# cat /sys/class/thermal/thermal_zone0/temp
62

Apply finger to die directly - doesn't burn but it's a bit uncomfortable

root@clanton:~# cat /sys/class/thermal/thermal_zone0/temp
56

Remove finger

root@clanton:~# cat /sys/class/thermal/thermal_zone0/temp
60
root@clanton:~# cat /sys/class/thermal/thermal_zone0/temp
61
root@clanton:~# cat /sys/class/thermal/thermal_zone0/temp

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
