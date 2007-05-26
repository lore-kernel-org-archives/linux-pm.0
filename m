From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: fw-ohci breaks suspend-to-RAM
Date: Sat, 26 May 2007 22:10:42 +0200
Message-ID: <200705262210.43365.rjw__7832.68878371945$1180209982$gmane$org@sisk.pl>
References: <200705181207.45868.marcus@better.se>
	<200705210725.55299.marcus@better.se>
	<tkrat.522e284271bb5d02@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tkrat.522e284271bb5d02@s5r6.in-berlin.de>
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
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

On Saturday, 26 May 2007 14:14, Stefan Richter wrote:
> Marcus Better wrote:
> > Now it hangs on the second suspend to RAM (at suspend, not resume).
> 
> Unless Kristian implements something better before release, we might go
> with the following patch.  Does it abort s2ram as I intend?
> 
> (It does not abort APM suspend, but on the APM notebook I tested with
> 2.6.20 and the new firewire drivers, I could unload and reload fw-ohci
> after APM resume without problem.  I still have no machine which
> supports s2ram, and the APM machine is too slow to do driver development
> on it.  I might try to install suspend2 for hibernate-to-swapfile on a
> reasonable machine, but not earlier than in two weeks.  Therefore don't
> expect anything better than the below from me anytime soon.)

Actually you can try swsusp too (the built-in stuff).  As far as the handling
of devices is concerned it's pretty much equivalent to suspend2 and you don't
need to patch the kernel in order to use it.

Greetings,
Rafael
