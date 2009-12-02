From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Maybe we can make no_console_suspend fine grained?
Date: Wed, 02 Dec 2009 19:34:26 +0200
Message-ID: <1259775266.4314.10.camel__6802.535421639$1259775450$gmane$org@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Currently, if the no_console_suspend isn't set, as soon as system begins
the suspend, at core printk level output is suppressed.

However, I want to have a simple and clean way to have all console
messages in the memory, because on my laptop memory isn't cleared on
reboots.

My first approach was just to put printk buffer at predefined address.
This wasn't favored by kernel developers, and even I myself found this
to be not such great solution.

Other approach is to create a console driver, however it won't be used
by printk ether during suspend and resume.

So, maybe we can add a flag that console should always be used,
regardless of no_console_suspend?
(This is the particular console is safe for that purpose)

I can even make the new console pm aware, thus make is possible to avoid
collisions between  every stage of the hibernation.
( Which happen today because resume kernel overwrites the printk
predefined buffer, and that is annoying because my system works just
fine now, but I want to keep that feature on)

Best regards,
Maxim Levitsky
