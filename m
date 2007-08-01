From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Suspend without the freezer
Date: Wed, 1 Aug 2007 16:16:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708011607570.3174-100000@iolanthe.rowland.org>
References: <200708012108.24061.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708012108.24061.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007, Rafael J. Wysocki wrote:

> > I don't think removal during suspend poses a serious problem.  It can
> > never lead to a situation where a suspended parent has an unsuspended
> > child, which is what we need to avoid.
> 
> With our current design, removal during resume, before the device is put back
> onto dpm_active, may lead to nasty problems.  I haven't analysed that in
> detail, but at least generally it seems highly suspicious to me.

In the patch set I posted, device removal during suspend or resume is 
blocked.  The PM core acquires every device's semaphore at the start of 
the suspend and doesn't release it until the end of the resume -- and I 
added a line to device_pm_remove() to lock the semaphore.

My best guess is that allowing removal at these times wouldn't hurt
anything.  But if the device is on one of the lists other than
dpm_active, taking it off would mean the PM core never gets a chance to
unlock the device's semaphore and could lead to hangups later.  So I
disallowed it.

Alan Stern
