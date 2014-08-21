From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 01/11] kernel: Add support for kernel restart handler
 call chain
Date: Wed, 20 Aug 2014 21:08:37 -0700
Message-ID: <CAD=FV=UEyCgA+v6JK20Oos=SF4YEEMARB4JEvGJZwL25WaX6kg@mail.gmail.com>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
	<1408495538-27480-2-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1408495538-27480-2-git-send-email-linux@roeck-us.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>, Jonas Jensen <jonas.jensen@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tomasz Figa <t.figa@samsung.com>, "linux-doc@vger.kernel.org" <linux-doc@vge>
List-Id: linux-pm@vger.kernel.org

Guenter,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Various drivers implement architecture and/or device specific means
> to restart (reset) the system. Various mechanisms have been implemented
> to support those schemes. The best known mechanism is arm_pm_restart,
> which is a function pointer to be set either from platform specific code
> or from drivers. Another mechanism is to use hardware watchdogs to issue
> a reset; this mechanism is used if there is no other method available
> to reset a board or system. Two examples are alim7101_wdt, which currently
> uses the reboot notifier to trigger a reset, and moxart_wdt, which registers
> the arm_pm_restart function.
>
> The existing mechanisms have a number of drawbacks. Typically only one scheme
> to restart the system is supported (at least if arm_pm_restart is used).
> At least in theory there can be multiple means to restart the system, some of
> which may be less desirable (for example one mechanism may only reset the CPU,
> while another may reset the entire system). Using arm_pm_restart can also be
> racy if the function pointer is set from a driver, as the driver may be in
> the process of being unloaded when arm_pm_restart is called.
> Using the reboot notifier is always racy, as it is unknown if and when
> other functions using the reboot notifier have completed execution
> by the time the watchdog fires.
>
> Introduce a system restart handler call chain to solve the described problems.
> This call chain is expected to be executed from the architecture specific
> machine_restart() function. Drivers providing system restart functionality
> (such as the watchdog drivers mentioned above) are expected to register
> with this call chain. By using the priority field in the notifier block,
> callers can control restart handler execution sequence and thus ensure that
> the restart handler with the optimal restart capabilities for a given system
> is called first.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v7: Rebased to v3.17-rc1
> v6: Use atomic notifier call chain
> v5: Function renames:
>     register_restart_notifier -> register_restart_handler
>     unregister_restart_notifier -> unregister_restart_handler
>     kernel_restart_notify -> do_kernel_restart
> v4: Document and suggest values for notifier priorities
> v3: Add kernel_restart_notify wrapper function to execute notifier.
>     Improve documentation.
>     Move restart_notifier_list into kernel/reboot.c and make it static.
> v2: No change.
>
>  include/linux/reboot.h |  3 ++
>  kernel/reboot.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
