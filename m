From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/4] PM / Loss: power loss management
Date: Thu, 19 May 2011 22:52:46 +0200
Message-ID: <201105192252.46836.rjw__23772.4138227806$1305838424$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1105191021220.1900-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1105191021220.1900-100000@iolanthe.rowland.org>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Raffaele Recalcati <raffaele.recalcati@bticino.it>, linux-pm@lists.linux-foundation.org, Raffaele Recalcati <lamiaposta71@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, May 19, 2011, Alan Stern wrote:
> On Thu, 19 May 2011, Davide Ciminaghi wrote:
> 
> > I'm not completely sure about this. What we wanted to do was to avoid powering
> > down the mmc while it is physically writing data into its internal memory.
> > If we force a sync when the power loss warning event warning happens,
> > it is very difficult to be able to guarantee that all buffered data will be 
> > written before power actually dies. So we preferred to follow another strategy:
> > let the mmc finish any running write operation, and then stop its request 
> > queue. If power really goes down, then we hope that the file system journal 
> > will fix things on next boot (yes, some data could get lost, but the fs should
> > still be mountable). On the other hand, if power resumes, nothing bad should 
> > happen for user space processes.
> 
> You could consider a totally different approach.
> 
> Each platform will have a different set of high-power devices it wants
> to turn off when a power-loss warning occurs.  So instead of changing
> the core PM interface, you could add a new "power_loss" notifier list.  
> Only the most critical drivers would need to listen for notifications, 
> and this could be different drivers on different platforms.

Moreover, it would allow not only drivers, but also filesystems (for
one example) to get notifications.

Thanks,
Rafael
