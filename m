From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at
 start
Date: Wed, 24 Aug 2016 16:44:40 +0200
Message-ID: <57BDB2D8.4080507@linaro.org>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
 <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <michael.neuling@au1.ibm.com>, Paul Mackerras <paulus@samba.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/19/2016 12:26 AM, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently all the idle states registered by a cpu-idle driver are
> enabled by default. This patch adds a mechanism which allows the
> driver to hint if an idle-state should start in a disabled state. The
> cpu-idle core will use this hint to appropriately initialize the
> usage->disable knob of the CPU device idle state.

Why do you need to do that ?

> The state can be enabled at run time by echo'ing a zero to the sysfs
> "disable" control file.

... for each cpu.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
