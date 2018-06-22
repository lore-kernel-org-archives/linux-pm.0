From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] power: vexpress: fix corruption in notifier
 registration
Date: Fri, 22 Jun 2018 13:47:17 +0100
Message-ID: <044c6de2-fc9d-37a7-90f4-8d77dc4961c3@arm.com>
References: <1529322007-4637-1-git-send-email-sudeep.holla@arm.com>
 <1529337272-11799-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1529337272-11799-1-git-send-email-sudeep.holla@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sebastian Reichel <sre@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On 18/06/18 16:54, Sudeep Holla wrote:
> Vexpress platforms provide two different restart handlers: SYS_REBOOT
> that restart the entire system, while DB_RESET only restarts the
> daughter board containing the CPU. DB_RESET is overridden by SYS_REBOOT
> if it exists.
> 
> notifier_chain_register used in register_restart_handler by design
> relies on notifiers to be registered once only, however vexpress restart
> notifier can get registered twice. When this happen it corrupts list
> of notifiers, as result some notifiers can be not called on proper
> event, traverse on list can be cycled forever, and second unregister
> can access already freed memory.
> 
> So far, since this was the only restart handler in the system, no issue
> was observed even if the same notifier was registered twice. However
> commit 6c5c0d48b686 ("watchdog: sp805: add restart handler") added
> support for SP805 restart handlers and since the system under test
> contains two vexpress restart and two SP805 watchdog instances, it was
> observed that during the boot traversing the restart handler list looped
> forever as there's a cycle in that list resulting in boot hang.
> 
> This patch fixes the issues by ensuring that the notifier is installed
> only once.
> 


Can you pick this up ? Without this patch, my Vexpress TC2 hangs in the
boot.

-- 
Regards,
Sudeep
