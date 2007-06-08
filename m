From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2disk hangs on "Suspending console(s)"
Date: Fri, 8 Jun 2007 12:05:46 +0200
Message-ID: <200706081205.46994.rjw@sisk.pl>
References: <4668F973.5050401@eyra.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4668F973.5050401@eyra.se>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Martin Magnusson <martin@eyra.se>
Cc: suspend-devel@lists.sourceforge.net, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 8 June 2007 08:38, Martin Magnusson wrote:
> Hello. I hope this list is the right forum to post questions like this. 
> If not, please excuse me.
> 
> I'm having trouble hibernating my Dell Latitude D800, running Ubuntu 
> 7.04 and uswsusp version 0.3~cvs20060928-6ubuntu3.
> 
> It works around maybe 25% of the time, but when it doesn't work, I get 
> the following output (using loglevel >=10):
> 
> [timestamp] Disabling non-boot CPUs
> [timestamp] Stopping tasks... done
> suspend: Snapshotting system
> [timestamp] Shrinking memory... done (113204 pages freed)
> [timestamp] Freed 452816 kbytes in 52.79 s (8.57 MB/s)
> [timestamp] Suspending console(s)
> 
> Then, the computer hangs, and I have to reboot. I have 512 MB of RAM and 
> my swap partition /dev/hda5 is 1 GB. My uswsusp.conf currently looks 
> like this:
> 
> # /etc/uswsusp.conf(8) -- Configuration file for s2disk/s2both
> resume device = /dev/hda5
> compress = y
> image size = 10000001 #242932285
> #RSA key file = /etc/uswsusp.key
> shutdown method = platform
> suspend loglevel = 12
> max loglevel = 12
> 
> Any ideas on what to do, or how to do more troubleshooting?

This is a kernel problem, so you should report it to one of the kernel-related
mailing lists (linux-pm, for example, CC-ed).

Now, we've had a couple of similar reports recently and one of them seems
to indicate a problem with libata (http://lkml.org/lkml/2007/6/3/106).

Have you built the kernel yourself or do you use a distro one?

Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
