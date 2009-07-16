From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 8/8] i8042: support device async suspend &
	shutdown
Date: Thu, 16 Jul 2009 09:45:18 +0800
Message-ID: <1247708718.26272.138.camel__28021.3088532493$1247708842$gmane$org@rzhang-dt>
References: <1247643522.26272.83.camel@rzhang-dt>
	<87k52a6x62.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k52a6x62.fsf@basil.nowhere.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-07-15 at 18:46 +0800, Andi Kleen wrote:
> Zhang Rui <rui.zhang@intel.com> writes:
> 
> > i8042 controller support device async actions.
> >
> > If boot option "dev_async_action" is added,
> > i8042 controller and its child devices can be
> > suspended/resumed/shutdown asynchronously.
> >
> 
> From a quick look at the i8042 driver it still 
> seems to do a lot of slow actions without actually sleeping
> or worse holding locks. e.g. the delay loop in i8042_flush()
> 
> Did you measure how long that one takes?
> 
> Due to the locks even preempt kernels couldn't do
> something during that time.
> 
> The spinlocks are probably needed when the code is executed
> during interrupts, but perhaps the suspend variant
> could use a different code path.
> 
> Perhaps it only makes sense to do this when this 
> code is converted to sleep during delays too?
> 
most of the psmouse suspend/shutdown time was cost by a ps2 reset
command.
In my test, the serio2 (psmouse) total suspend time is 0.42s, while
the psmouse_reset takes 0.4s.

i.e.
drivers/input/serio/libps2.c

int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int
command)
{
...
/*
 * The reset command takes a long time to execute.
 */
timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);

timeout = wait_event_timeout(ps2dev->wait,
			!(ps2dev->flags & PS2_FLAG_CMD1), timeout);
...
}

so the patch could save suepend/shutdown time a lot, without any other
changes in psmouse driver.

thanks,
rui
