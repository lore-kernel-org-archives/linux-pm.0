From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Fri, 16 Nov 2007 11:10:27 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711161058170.2738-100000__21337.8211287365$1195229510$gmane$org@iolanthe.rowland.org>
References: <20071116003836.GA24490@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071116003836.GA24490@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 15 Nov 2007, Greg KH wrote:

> > The offending -mm patch is
> > gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
> > 
> > 2.6.24-rc2-mm1 minus it works just fine; PROVE_LOCKING shows nothing new when
> > the patch is applied.
> 
> Thanks for tracking this down.  Alan, any thoughts?

It's a driver problem somewhere.  Probably not one of the most common 
drivers because I don't see the same problem here (but then I'm not 
testing -mm).

The thing to do is figure out which driver is causing the problem.
Jiri, try enabling CONFIG_DEBUG_DRIVER.  If there's also a config 
option to prevent the console from being suspended, set it as well.  
Then you should be able to tell which driver is making trouble.

Alan Stern
