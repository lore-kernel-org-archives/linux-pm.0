From: ethan zhao <ethan.zhao@oracle.com>
Subject: Re: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting
 kobject
Date: Mon, 02 Feb 2015 09:54:23 +0800
Message-ID: <54CED8CF.9060407@oracle.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org> <54CADEAE.2090305@oracle.com> <CAKohpo=uFZ0BwZ1FLSBpht3Yi1B73LpHDu00Rqk2P3TbzCYsoQ@mail.gmail.com> <54CAE80C.4060406@oracle.com> <CAKohponF_fqoDj_g4kZuoYa=gz9G_yRn67eJoWT6mnPkejWkjw@mail.gmail.com> <54CAEABB.4060508@oracle.com> <CAKohpomdf1eZveqw+GCzcuPJnW4BpMYqGebhRR5=mc0ome0vFg@mail.gmail.com> <54CAFE88.2080508@oracle.com> <CAKohpokstCHezi0-Vp=-WJn4Zrpnj0oELjw6jzkY_0976h3V8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:24889 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbbBBByk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 20:54:40 -0500
In-Reply-To: <CAKohpokstCHezi0-Vp=-WJn4Zrpnj0oELjw6jzkY_0976h3V8w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "# 3.13.x" <stable@vger.kernel.org>

Viresh,

On 2015/1/30 12:14, Viresh Kumar wrote:
> On 30 January 2015 at 09:16, ethan zhao <ethan.zhao@oracle.com> wrote:
>>   You mean the policy is shared by all CPUs, so PPC notification about one
> A policy may or maynot be shared by multiple CPUs. It all depends on your
> systems configuration. All CPUs which share clock line, share a policy.
>
> You can verify that from /sys/devices/system/cpu/cpu*/related_cpus. This
> gives the CPUs that share policy.
>
>>   CPU should update all CPU's policy, right ? even the requested CPU is
>> shutting  down.
> CPUs sharing policy have a single policy structure. And so policy would
> be updated for all CPUs that share the poilcy. Even if some cpu goes down,
> the policy might still be up and running.
  Let' me check ACPI spec and BIOS to match your implementation.

  About that patch you suggested, there is another question left pending:

  Policy will be freed only when that's last CPU shutting down, how does it
  happen when system booting ?

  The description of the patch would be wrong (the Xen_bus call stack) --
  Did the xen_bus shut down every CPU till the last during booting ?

  Thanks,
  Ethan
>
> --
> viresh

