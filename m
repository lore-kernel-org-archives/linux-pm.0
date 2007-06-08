From: Martin Magnusson <martin@eyra.se>
Subject: Re: s2disk hangs on "Suspending console(s)"
Date: Fri, 08 Jun 2007 13:15:08 +0200
Message-ID: <46693A3C.4060303@eyra.se>
References: <4668F973.5050401@eyra.se> <200706081205.46994.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200706081205.46994.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> On Friday, 8 June 2007 08:38, Martin Magnusson wrote:
>> Hello. I hope this list is the right forum to post questions like this. 
>> If not, please excuse me.
>>
>> I'm having trouble hibernating my Dell Latitude D800, running Ubuntu 
>> 7.04 and uswsusp version 0.3~cvs20060928-6ubuntu3.
>>
>> It works around maybe 25% of the time, but when it doesn't work, I get 
>> the following output (using loglevel >=10):
>>
>> [timestamp] Disabling non-boot CPUs
>> [timestamp] Stopping tasks... done
>> suspend: Snapshotting system
>> [timestamp] Shrinking memory... done (113204 pages freed)
>> [timestamp] Freed 452816 kbytes in 52.79 s (8.57 MB/s)
>> [timestamp] Suspending console(s)

Rafael J. Wysocki wrote:
> Now, we've had a couple of similar reports recently and one of them seems
> to indicate a problem with libata (http://lkml.org/lkml/2007/6/3/106).
> 
> Have you built the kernel yourself or do you use a distro one?

I use the distro kernel: 2.6.20-16-generic.

/Martin

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
