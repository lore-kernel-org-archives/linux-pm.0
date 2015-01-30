From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
Date: Fri, 30 Jan 2015 09:44:47 +0530
Message-ID: <CAKohpokstCHezi0-Vp=-WJn4Zrpnj0oELjw6jzkY_0976h3V8w@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org>
	<54CADEAE.2090305@oracle.com>
	<CAKohpo=uFZ0BwZ1FLSBpht3Yi1B73LpHDu00Rqk2P3TbzCYsoQ@mail.gmail.com>
	<54CAE80C.4060406@oracle.com>
	<CAKohponF_fqoDj_g4kZuoYa=gz9G_yRn67eJoWT6mnPkejWkjw@mail.gmail.com>
	<54CAEABB.4060508@oracle.com>
	<CAKohpomdf1eZveqw+GCzcuPJnW4BpMYqGebhRR5=mc0ome0vFg@mail.gmail.com>
	<54CAFE88.2080508@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <54CAFE88.2080508@oracle.com>
Sender: stable-owner@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "# 3.13.x" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30 January 2015 at 09:16, ethan zhao <ethan.zhao@oracle.com> wrote:
>  You mean the policy is shared by all CPUs, so PPC notification about one

A policy may or maynot be shared by multiple CPUs. It all depends on your
systems configuration. All CPUs which share clock line, share a policy.

You can verify that from /sys/devices/system/cpu/cpu*/related_cpus. This
gives the CPUs that share policy.

>  CPU should update all CPU's policy, right ? even the requested CPU is
> shutting  down.

CPUs sharing policy have a single policy structure. And so policy would
be updated for all CPUs that share the poilcy. Even if some cpu goes down,
the policy might still be up and running.

--
viresh
