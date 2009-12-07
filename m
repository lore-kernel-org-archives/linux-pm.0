From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 22:15:26 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912062204431.3560__13561.3859900788$1260166584$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912060953190.4442-100000@netrider.rowland.org>
	<1260158279.27069.181.camel@rzhang1-desktop>
	<alpine.LFD.2.00.0912062122460.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912062122460.3560@localhost.localdomain>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 6 Dec 2009, Linus Torvalds wrote:
> 
> And drivers that want to do things asynchronously don't need to register 
> or worry: all they do is literally [...]

Side note: for specific bus implementations, you obviously don't have to 
even expose the choice. Things like the whole "suspend_late" and 
"resume_early" phases don't make sense for USB devices, and the USB core 
layer don't even expose those to the various USB drivers.

The same is true of the prepare_suspend/suspend split I'm proposing: I 
suspect that for something like USB, it would make most sense to just do 
normal node suspend in prepare_suspend, which would do everything 
asynchronously. Only USB hub devices would get involved at the later 
'suspend()' phase.

So I'm not suggesting that "all drivers" would necessarily even need 
changing in order to take advantage of asynchronous behavior.

You could change just the _core_ USB layer would do everything 
automatically for USB devices, and now USB devices would automatically 
suspend asynchronously not because the generic device layer knows about 
it, but because the USB bus layer chose to do that "async_run()" on the 
leaf node suspend functions (or rather: a helper function that calls the 
leaf-node suspend, and then does the 'up_read()' call on the parent 
lock: the actual usb driverrs would never know about any of this).

				Linus
