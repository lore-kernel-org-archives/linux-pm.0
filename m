From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 14:47:19 +0200
Message-ID: <1180356439.4242.95.camel@lov.localdomain>
References: <200705272229.21263.rjw@sisk.pl>
	<20070527220412.GC22687@srcf.ucam.org>
	<1180304166.3131.66.camel@lov.localdomain>
	<200705280943.54312.rjw@sisk.pl>
	<20070528111554.GF18807@elf.ucw.cz>
	<1180351493.4242.31.camel@lov.localdomain>
	<6BFA837E-47D4-487F-9D71-FA83D6D865E5@cam.ac.uk>
	<1180353095.4242.57.camel@lov.localdomain>
	<BDEF3C8A-D237-44C4-84E0-2218DFAE0E77@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BDEF3C8A-D237-44C4-84E0-2218DFAE0E77@cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael-Luke Jones <mlj28@cam.ac.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-05-28 at 13:26 +0100, Michael-Luke Jones wrote:
> On 28 May 2007, at 12:51, Kay Sievers wrote:
> 
> > Either the whole idea of userspace firmware-loading should be  
> > considered
> > as a problem impossible to do right because of its unsolvable side
> > effects. Or at least releasing loaded firmware should be the exception
> > for drivers which can be sure, that the firmware is not needed in
> > situations we try to work around here.
> 
> I don't believe that it is impossible. What is needed is some  
> thought, and maybe a loose spec.

Hehe, let's see. :)

> We need to think about safe ways of solving a simple problem: what to  
> do when userspace is unable to respond to a kernel uevent request. We  
> now have a timeout, whether it be handled synchronously or in the  
> background. I don't think either solution is good enough.
> 
> [RFC] Possible Plan:
> 
> 1) request_firmware() should stick around unmodified but be marked  
> __deprecated.
> 
> 2) request_firmware_nowait() as it stands should probably be removed.  
> After all, it only has 2 in-kernel users at the moment.

We should probably leave the whole firmware class alone, add something
new, and convert the current users. 

> 3) uevent interface should be notified when userspace handlers are /  
> are not available so that events can be queued to be handled when  
> userspace does turn up and re-register a hotplug event handler.

Uevents are queued by the netlink socket buffer. If userspace can't
receice them (udevd) while it's frozen, they will just be handled (in
the right order) when userspace runs again. We can queue up thousands of
events, and it should already work that way for a long time now.

> 4) request_firmware_async() introduced: asynchronous firmware loading  
> interface built on basis of 3, such that problems at early boot and  
> suspend / resume are avoided. Also request_firmware_async() taught to  
> retain firmware in memory by default such that subsequent calls do  
> not require a call to userspace if userspace is unavailable.

Something like this makes sense, yes.

> 6) Documentation on correct firmware loading behaviour for driver  
> authors written, together with migration notes for existing users of  
> request_firmware().
> 
> 7) Existing uses of request_firmware() converted.
> 
> *Grumble ahead*
> Unfortunately, I don't properly understand the uevent interface, so  
> some of the above may be inaccurate.

The event emission in the kernel and the userspace side is probably
fine. Two years ago, benh already run into exactly the same suspend
problems, and I think I addressed the problems on the uevent side.

> This is *not* my fault as there  
> is no decent documentation (and btw, telling me to write the  
> documentation is not the answer to that problem).

Sure, we always need at least one working example before we can even
tell what's the right way to do it. :)

Kay
