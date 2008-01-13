From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: b43_suspend problem
Date: Sun, 13 Jan 2008 16:37:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801131634380.28667-100000@netrider.rowland.org>
References: <200801131816.15278.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801131816.15278.mb@bu3sch.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Buesch <mb@bu3sch.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de, Larry Finger <larry.finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Sun, 13 Jan 2008, Michael Buesch wrote:

> > Besides, if you're going to register the device right back again during 
> > the subsequent resume, then why go to the trouble of unregistering it 
> > during suspend?  Why not just leave it registered the whole time and 
> > avoid all the complication (and excess meaningless uevents)?
> 
> Well, because not doing it complicates code :)
> Currently suspend/resume calls the same code as init/exit.
> The b43 init/exit code is really complicated, compared to other
> drivers, due to dozens of hardware versions. So I just avoided
> having yet other codepaths for suspend/resume. But I will add
> a flag to the device structure that's used to avoid unregistering stuff.

Instead of adding an extra flag you should refactor the code.  Have a
common "enable" subroutine that can be called for both init and resume,
and a common "disable" subroutine that can be called for both exit and
suspend.  Then the method routines themselves will contain only the
portions unique to their particular functions, making them shorter and
simpler.

Alan Stern
