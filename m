From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Wed, 16 Dec 2009 20:26:00 +0100
Message-ID: <200912162026.00991.rjw__26449.1248447031$1260991590$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912161018100.2909-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912161018100.2909-100000@iolanthe.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 16 December 2009, Alan Stern wrote:
> On Wed, 16 Dec 2009, Rafael J. Wysocki wrote:
> 
> > I measured the total time of suspending and resuming devices as shown by the
> > code added by this patch:
> > http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=commitdiff_plain;h=c1b8fc0a8bff7707c10f31f3d26bfa88e18ccd94;hp=087dbf5f079f1b55cbd3964c9ce71268473d5b67
> > on two boxes, HP nx6325 and MSI Wind U100 (hardware-wise they are quite
> > different and the HP was running 64-bit kernel and user space).
> 
> > I carried out 5 consecutive suspend-resume cycles (started from under X) on
> > each box in each case, and the raw data are here (all times in milliseconds):
> > http://www.sisk.pl/kernel/data/async-suspend.pdf
> 
> I'd like to see much more detailed data.  For each device, let's get 
> the device name, the parent's name, and the start time, end time, and 
> duration for suspend or resume.  The start time should be measured when 
> you have finished waiting for the children.  The end time should be 
> measured just before the complete_all().

I'm going to use the Arjan's patch + script to chart the suspend/resume times
for individual devices.  I can send you the raw data, though.

Rafael
