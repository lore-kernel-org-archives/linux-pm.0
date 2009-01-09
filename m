From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Regression] USB wakeup problem on Toshiba Portege
	R500
Date: Fri, 9 Jan 2009 10:55:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901091055050.10951-100000__27572.2446888269$1231516673$gmane$org@netrider.rowland.org>
References: <200901081955.12021.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901081955.12021.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 8 Jan 2009, Frans Pop wrote:

> Rafael J. Wysocki wrote:
> > On Thursday 08 January 2009, Oliver Neukum wrote:
> >> Am Thursday 08 January 2009 17:36:12 schrieb Rafael J. Wysocki:
> >> You are making a very persuasive argument for reverting it.
> >> But what about laptops that only have a USB keyboard?
> > 
> > Well, up to and including 2.6.28 they needed to echo 'enable' to the USB
> > controllers' /sys/devices/.../power/wakeup files, so if the patch is
> > reverted, they won't be worse off than they were day before
> > yesterday. :-) 
> > 
> > Perhaps we can choose the default depending on whether or not any HID
> > devices are attached to given controller?
> 
> Is "resume on keyboard activity" really all that needed? Both my laptops 
> and my desktop resume fine after pressing the power button.
> 
> Also consider the following cases:
> - laptop has been suspended with external USB mouse connected
>   - mouse is moved (accidentally or because it is in the way of a coffee
>     cup)
>   - mouse cable is removed before putting the laptop in a bag for
>     transport
> - laptop is in docking station with USB mouse/kbd connected to that
>   - again, mouse gets moved for some reason
>   - laptop is undocked while suspended
>   - or the reverse: laptop gets docked
> 
> IMO it is not desirable that the system gets resumed as a result of any of 
> those actions. I'm not complete sure that it would in all those cases, 
> but have they been considered?
> 
> And in general I've always been in favor of things only happening 
> automagically if I've explicitly asked for that, and not by default.

I don't mind reverting the "automatically enable PCI wakeup" commit.  But 
we should first come to a definite policy for kernel default wakeup 
settings, rather than deciding things piecemeal for different subsystems.

My proposal:

	Devices and events that are clearly associated with system
	wakeup should be enabled by default.  For example: Power
	button and laptop lid.

	All other devices capable of waking up the system should be
	disabled by default.  This presumably includes every PCI
	device.  If users want keyboard or mouse events to cause
	a system resume then they will have to configure their
	desktop management program to enable it.

	Devices not capable of directly waking the system can be
	enabled.  This includes things like USB devices, which
	have to pass a wakeup request through their parent and
	therefore can't wake up the system unless the parent is
	also enabled for wakeup.

Alan Stern
