From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 09:18:15 -0700
Message-ID: <87fx1uo3so.fsf__34683.9189100594$1273853951$gmane$org@deeprootsystems.com>
References: <20100513191717.GA3428@atomide.com>
	<Pine.LNX.4.44L0.1005131729510.1731-100000@iolanthe.rowland.org>
	<20100513214739.GM3428@atomide.com>
	<AANLkTilL2mvqpwirTfJRWZFdrFJvSihnaY8-xao4pLpH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilL2mvqpwirTfJRWZFdrFJvSihnaY8-xao4pLpH@mail.gmail.com>
	(Magnus Damm's message of "Fri\, 14 May 2010 12\:25\:26 +0900")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linus Walleij <linus.walleij@ericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> writes:

> Still not sure how the system wide suspend is different from Runtime
> PM and CPUidle from the hardware perspective...

At least on OMAP and other embedded SoCs I'm familiar with, there is
no difference from the hardware perspecitve.

However, I understand that on ACPI-based systems, there are low-power
that are only reachable via system-wide suspsend since ACPI does not
provide the kernel with fine-grained control to hit those states
during idle.

That being said, I don't think this should be an issue since
opportunistic suspend is currently targetted primarily at embedded HW
which has much more fine-grained power control than traditional
ACPI-based systems.

To me the only real difference between system-wide suspend and runtime
PM + CPUidle is the freezing of userspace.

As has been discussed elsewhere in this discussion, any alternative
solution must address the freezing/idling of userspace.  

Kevin
