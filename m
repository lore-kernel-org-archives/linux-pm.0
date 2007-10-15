From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Question about suspending a system
Date: Mon, 15 Oct 2007 14:43:12 +0200
Message-ID: <38b2ab8a0710150543k6d35ae12h6dceef96acb00a71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

I'm trying to see how I could implement Suspend To Ram on my system
that embed a SH4 processor.

I'm almost completely new to this area so please forgive me if the
question is dumb. I read the documentation in Documentation/power and
must admit that I don't get all of it :)

So my question is that when we suspend the system, it seems that all
IRQs are masked and I'm a bit suprise since the event that should wake
up the system is an interrupt. This mask is done by
arch_suspend_disable_irqs() and none of the arch is overriding this
stub. If I'm right, how the system should be waked up ?

Anther point is that the device that consumes a lot on the system is
the hard drive. I can decrease its power consumption by stopping its
motor by using "hdparm" but it still consumes too much. So for now I'm
thinking of stopping to power it up completely. But I don't know it's
going to be easy to resume the hard drive. Does anybody have another
idea or have already experience such trick ?

Thanks
-- 
Francis
