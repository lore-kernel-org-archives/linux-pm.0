From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Mon, 9 Apr 2012 10:14:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204091007350.1429-100000@iolanthe.rowland.org>
References: <CAJiQ=7D8QbV45euE1VN0ENpCMUESMMgeUr6gKwK3g+8-PUyTcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJiQ=7D8QbV45euE1VN0ENpCMUESMMgeUr6gKwK3g+8-PUyTcQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 8 Apr 2012, Kevin Cernekee wrote:

> In embedded applications, there are a number of situations in which it
> is useful to completely disable a host controller in order to conserve
> power.  Some typical scenarios include:

<SNIP>

> Looking through Linus' head of tree, I see:
> 
> USB runtime PM seems to focus on the individual USB devices, and does
> not allow for dynamically suspending the entire host controller
> AFAICT.

That is not correct.  USB host controllers _can_ be suspended.  (Not 
all of them; many of the platform drivers don't implement controller 
suspend.  But some of them do, and almost all of the PCI-based drivers 
do.)

> USB used to allow writing "suspend" to the power/control file, but
> that no longer seems to be the case as of 2.6.32.

Correct.

>  In general I don't
> see any facility where the application can explicitly tell the PM core
> to suspend a device (incurring a potential loss of functionality, such
> as hot plug/unplug detection).

Right; there is no way to do this.  The OS will suspend a device only 
when it believes it is safe to do so.

<SNIP>

> So, my questions are:
> 
> a) Is SATA/USB/MMC host controller suspension something that can be
> accomplished within the existing runtime PM framework?

Not only _can_ it be accomplished, it already _has_ been accomplished 
(for USB at least, I'm not familiar with the others).

> b) If not, what is the best way to modify the runtime PM framework so
> that it can support these use cases?

No changes to the framework are needed.  If a subsystem or driver
doesn't support runtime suspend then support has to be added at the 
subsystem or driver level.

> c) Is this something you would even want in mainline?

Yes.  People are already working on this stuff.

> d) Or should I just go back to using "rmmod"?

I don't see how rmmod will save any power.

Alan Stern
