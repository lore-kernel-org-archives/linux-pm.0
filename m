From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Mon, 23 Apr 2012 14:30:39 -0400
Message-ID: <1335205839.28106.108.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204231228370.1612-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204231228370.1612-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2012-04-23 at 12:29 -0400, Alan Stern wrote:
> On Sun, 22 Apr 2012, Andrey Rahmatullin wrote:
> 
> > > All right.  Maybe you posted this information earlier in the thread, 
> > > but it's easier to ask again than try to find it.  What output do you 
> > > get from "lspci -nv -s 1a.0"?
> > 00:1a.0 0c03: 8086:1c2d (rev 05) (prog-if 20 [EHCI])
> >         Subsystem: 1043:1147
> >         Flags: bus master, medium devsel, latency 0, IRQ 16
> >         Memory at dfe08000 (32-bit, non-prefetchable) [size=1K]
> >         Capabilities: [50] Power Management version 2
> >         Capabilities: [58] Debug port: BAR=1 offset=00a0
> >         Capabilities: [98] PCI Advanced Features
> >         Kernel driver in use: ehci_hcd
> 
> Steve, what about you?  Do you get the same thing?
> 

00:1a.0 0c03: 8086:1c2d (rev 05) (prog-if 20 [EHCI])
	Subsystem: 1043:1157
	Flags: bus master, medium devsel, latency 0, IRQ 16
	Memory at dfc08000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
	Kernel driver in use: ehci_hcd

Almost, the Subsystem is 1157 instead of 1147. But the rest looks alike.

-- Steve
