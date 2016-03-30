From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Wed, 30 Mar 2016 23:58:41 +0200
Message-ID: <56FC4C11.40405@intel.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8327 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbcC3V6q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 17:58:46 -0400
In-Reply-To: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>, =?UTF-8?Q?J=c3=b6rg_Otte?= <jrg.otte@gmail.com>, Linux PM List <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>

On 3/30/2016 11:41 PM, Sedat Dilek wrote:
> Hi,
>
> I am using Intel-PState-Driver here with v4.6-rc1 and Intel-SandyBridge-CPU.
>
> Here are my turbostat results attached.
>
> $ cd $BUILD_DIR
> $ LC_ALL=C make -C tools/ turbostat
>
> $ sudo ./turbostat -i 1 --msr=0x199 --debug --out
> /tmp/turbostat-i-1-msr-0x199-debug.txt
>
> Will try <https://patchwork.kernel.org/patch/8702071/>.
>
> Please see attached files.

Thanks for the report.

The address of linux-pm in your original message was incorrect.  Can you 
please resend the turbostat output in reply to this message?

Thanks,
Rafael

