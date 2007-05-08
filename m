From: Greg KH <greg@kroah.com>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ..)
Date: Mon, 7 May 2007 19:57:52 -0700
Message-ID: <20070508025752.GB28166@kroah.com>
References: <Pine.LNX.4.44L0.0705061751230.21407-100000@netrider.rowland.org>
	<200705061837.36969.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705061837.36969.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sun, May 06, 2007 at 06:37:36PM -0700, David Brownell wrote:
> On Sunday 06 May 2007, Alan Stern wrote:
> > It sounds good to me.  Now if only it were possible to get rid of those
> > pesky sysdevs...
> 
> Other than lack of patches ... is there a reason??
> I thought that sysdevs were no longer needed.

I would love to get rid of them, patches gladly accepted :)

thanks,

greg k-h
