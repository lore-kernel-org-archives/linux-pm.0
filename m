From: Greg KH <greg@kroah.com>
Subject: Re: usb-make-the-autosuspend-workqueue-thread-freezable.patch
Date: Sat, 19 May 2007 09:45:04 -0700
Message-ID: <20070519164504.GA10675__42344.6381850683$1179600684$gmane$org@kroah.com>
References: <Pine.LNX.4.44L0.0705191110340.8729-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705191110340.8729-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, Avuton Olrich <avuton@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, May 19, 2007 at 11:16:44AM -0400, Alan Stern wrote:
> Greg:
> 
> The patch in $SUBJECT (already in your development tree) fixes a problem
> with system suspend in 2.6.22-rc1, as described in
> 
> 	http://bugzilla.kernel.org/show_bug.cgi?id=8498
> 
> (For people on the PM development list, it's worth pointing out that all
> the patch does is make a particular kernel thread freezable.)
> 
> Can you please expedite getting it sent up to Linus?

Will do, I have a number of USB bugfixes to go to Linus, just been
traveling too much.  Next week I'll be able to get to it...

thanks,

greg k-h
