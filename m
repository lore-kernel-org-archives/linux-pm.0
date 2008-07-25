From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Suspend-devel] TAP (and TUN?) devices not working
	after resume
Date: Thu, 24 Jul 2008 20:50:32 -0700
Message-ID: <48894D88.9010104__11663.1546909504$1216996506$gmane$org@qualcomm.com>
References: <20080714154720.791f6640@symphony> <200807141812.45264.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807141812.45264.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, netdev@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, James Le Cuirot <chewi@aura-online.co.uk>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



Rafael J. Wysocki wrote:
> On Monday, 14 of July 2008, James Le Cuirot wrote:
>> Hi,
> 
> Hi,
> 
>> uswsusp works great on my machine except for one thing. I use a TAP
>> device for QEMU and after resuming from suspend, it doesn't work
>> anymore until I delete it and recreate it. This is rather annoying
>> because if I have QEMU open, it means I have to close it before
>> recreating the interface and then boot Windows up again. I use OpenVPN
>> to create/delete the interface but I think that's all it does. The rest
>> is done by the kernel. So I'm guessing something's up with the TUN/TAP
>> driver or uswsusp itself. I'm using version 0.8. Sorry if this has
>> already been fixed.
> 
> This is a kernel problem, adding kernel-related CCs.

I bet it's flow control related. I've fixed a bug in flow control handling for
persistent devices recently.
btw Does it still happen with >= 2.6.26 ?

I'll play with some test code on my laptop and see if I can reproduce this issue.

Max
