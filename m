From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] pm: remove bus_type
	suspend_late()/resume_early() V2
Date: Sat, 23 May 2009 14:25:50 -0700
Message-ID: <20090523212550.GA23127__11399.7143264443$1243115783$gmane$org@suse.de>
References: <20090521082754.1020.73349.sendpatchset@rx1.opensource.se>
	<200905232258.27407.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905232258.27407.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, May 23, 2009 at 10:58:26PM +0200, Rafael J. Wysocki wrote:
> On Thursday 21 May 2009, Magnus Damm wrote:
> > From: Magnus Damm <damm@igel.co.jp>
> > 
> > Remove the ->suspend_late() and ->resume_early() callbacks
> > from struct bus_type V2. These callbacks are legacy stuff
> > at this point and since there seem to be no in-tree users
> > we may as well remove them. New users should use dev_pm_ops.
> 
> I'd like to apply this patch as is.
> 
> Greg, is it fine with you?

Yes, please feel free to apply this to your tree:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

or do you want me to take it in mine?  If so, no problem, just let me
know, and resend it.

thanks,

greg k-h
