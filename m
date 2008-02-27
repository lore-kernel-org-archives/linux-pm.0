From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fundamental flaw in system suspend,
	exposed by freezer removal
Date: Thu, 28 Feb 2008 07:36:10 +1100
Message-ID: <1204144570.15052.256.camel__42005.9112403125$1204144861$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0802251010330.2133-100000@iolanthe.rowland.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802251010330.2133-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 2008-02-25 at 10:39 -0500, Alan Stern wrote:
> Ongoing efforts to remove the freezer from the system suspend and
> hibernation code ("system sleep" is the proper catch-all term) have
> turned up a fundamental flaw in the Power Management subsystem's
> design.  In brief, we cannot handle the race between hotplug addition
> of new devices and suspending all existing devices.

 .../...

Yup, old problem, I think I've said a long time ago that it's the
reponsibility of bus drivers (such as USB khub) to stop issuing device
additions when suspend is in progress. It might be possible to still do
removal tho.

> The only possible solution is to have the drivers themselves be
> responsible for preventing calls to device_add() or device_register()  
> during a system sleep.  (It's also necessary to prevent driver binding,
> but this isn't a major issue.) 

Agreed.

>  The most straightforward approach is to
> add a new pair of driver methods: one to disable adding children and
> one to re-enable it.  Of course this would represent a significant
> addition to the Power Management driver interface.

No, I think the global notifier is plenty for now. Later on, we can
re-add early-suspend, late-resume, or we can finally turn the whole
thing into a recursive call tree where the parents are the ones calling
the children suspend :-) But for now, I think the global notifier is
enough.

Cheers,
Ben.
