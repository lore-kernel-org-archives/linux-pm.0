From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspend, followed by immediate resume
Date: Fri, 2 May 2008 11:00:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805021059490.2323-100000@iolanthe.rowland.org>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080501214437.0ae618c5@osprey.hogchain.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 1 May 2008, Jay Cliburn wrote:

> I'm trying to get wake-on-lan working on the network driver I maintain
> (atl1), but I can't get my system to suspend to memory long enough to
> test it.  Seems that my system suspends and immediately wakes up again
> without any intervention on my part.  This is with kernel 2.6.25.1, but
> I've always encountered this phenomenon, going back to 2.6.21 when the
> driver was merged into mainline.  I've finally resolved to get to the
> bottom of it, and I'm hoping linux-pm can help.
> 
> To suspend, I execute
> 
> echo mem > /sys/power/state
> 
> and the system actually suspends (as far as I can tell), but within a
> few seconds it wakes up without any intervention on my part.  I've
> included dmesg that shows the event, my kernel config (that has
> CONFIG_DEBUG_PM=y), and lspci -vvxxx.
> 
> I'd appreciate any help.  Please cc me in your response, since I'm not
> subscribed to linux-pm.

Have you tried unplugging your USB mouse before suspending?

Alan Stern
