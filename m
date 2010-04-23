From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Fri, 23 Apr 2010 12:43:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004231242460.1777-100000__17586.8717408322$1272041086$gmane$org@iolanthe.rowland.org>
References: <20100423084349.GC1573@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100423084349.GC1573@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 23 Apr 2010, Pavel Machek wrote:

> Hi!
> 
> > Add a misc device, "suspend_blocker", that allows user-space processes
> > to block auto suspend. The device has ioctls to create a suspend_blocker,
> > and to block and unblock suspend. To delete the suspend_blocker, close
> > the device.
> > 
> > Signed-off-by: Arve Hj??nnev??g <arve@android.com>
> 
> > --- a/Documentation/power/suspend-blockers.txt
> > +++ b/Documentation/power/suspend-blockers.txt
> > @@ -95,3 +95,20 @@ if (list_empty(&state->pending_work))
> >  else
> >  	suspend_block(&state->suspend_blocker);
> >  
> > +User-space API
> > +==============
> > +
> > +To create a suspend_blocker from user-space, open the suspend_blocker device:
> > +    fd = open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
> > +then call:
> > +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_INIT(strlen(name)), name);
> 
> 
> This seems like very wrong idea -- it uses different ioctl number for
> each length AFAICT.

How about specifying the name by an ordinary write() call instead of
by an ioctl()?

Alan Stern
