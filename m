From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 8/8] i8042: support device async suspend &
	shutdown
Date: Wed, 15 Jul 2009 12:46:45 +0200
Message-ID: <87k52a6x62.fsf__29047.9242605672$1247654864$gmane$org@basil.nowhere.org>
References: <1247643522.26272.83.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1247643522.26272.83.camel@rzhang-dt> (Zhang Rui's message of
	"Wed, 15 Jul 2009 15:38:42 +0800")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Zhang Rui <rui.zhang@intel.com> writes:

> i8042 controller support device async actions.
>
> If boot option "dev_async_action" is added,
> i8042 controller and its child devices can be
> suspended/resumed/shutdown asynchronously.
>

>From a quick look at the i8042 driver it still 
seems to do a lot of slow actions without actually sleeping
or worse holding locks. e.g. the delay loop in i8042_flush()

Did you measure how long that one takes?

Due to the locks even preempt kernels couldn't do
something during that time.

The spinlocks are probably needed when the code is executed
during interrupts, but perhaps the suspend variant
could use a different code path.

Perhaps it only makes sense to do this when this 
code is converted to sleep during delays too?

-Andi


-- 
ak@linux.intel.com -- Speaking for myself only.
