From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sat, 17 Nov 2007 21:37:18 +0100
Message-ID: <200711172137.18784.rjw__22008.1700863831$1195330878$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0711161058170.2738-100000@iolanthe.rowland.org>
	<473F03DF.4020306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <473F03DF.4020306@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 17 of November 2007, Jiri Slaby wrote:
> On 11/16/2007 05:10 PM, Alan Stern wrote:
> > On Thu, 15 Nov 2007, Greg KH wrote:
> > 
> >>> The offending -mm patch is
> >>> gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
> >>>
> >>> 2.6.24-rc2-mm1 minus it works just fine; PROVE_LOCKING shows nothing new when
> >>> the patch is applied.
> >> Thanks for tracking this down.  Alan, any thoughts?
> > 
> > It's a driver problem somewhere.  Probably not one of the most common 
> > drivers because I don't see the same problem here (but then I'm not 
> > testing -mm).
> > 
> > The thing to do is figure out which driver is causing the problem.
> > Jiri, try enabling CONFIG_DEBUG_DRIVER.  
> 
> Sadly no output.
> 
> > If there's also a config 
> > option to prevent the console from being suspended, set it as well.  
> 
> no_suspend_console kernel parameter has no effect (why?).

I'm not sure.

Please try to set CONFIG_PM_VERBOSE.
