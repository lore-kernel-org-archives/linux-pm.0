From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
 for device PM.
Date: Tue, 26 Apr 2011 06:17:37 -0700
Message-ID: <20110426131737.GA13597__3683.12147115848$1303824651$gmane$org@suse.de>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<1303781471-2477-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261347.21811.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104261347.21811.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, kyungmin.park@samsung.com, MyungJoo Ham <myungjoo.ham@samsung.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 26, 2011 at 01:47:21PM +0200, Rafael J. Wysocki wrote:
> Moreover, I'm not sure if kernel subsystems (including drivers) should really
> decide when to generate wakeup signals in the first place.  Generally,
> user space decides what devices should wake up the system from sleep and the
> kernel should follow.  So, there shouldn't be any wakeup signals enabled
> beyond what user space has requested.

The RTC wakeup signals are ok though, right?  Userspace is the one
asking for that from what I can tell.

> To conclude, I'm not sure about the approach.  In particular, I'm not sure
> if the benefit is worth the effort and the resulting complications (ie. the
> possibility of having to deal with wakeup signals not requested by user
> space) seem to be a bit too far reaching.
> 
> Greg, what do you think?

I agree with you in that I don't think that this type of feature is
valid at the moment.

I don't understand why our current situation doesn't work, what are we
lacking that is needed for these systems that we have not seen before?

What is the root problem that this is trying to solve?

thanks,

greg k-h
