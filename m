From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: intermittent suspend problem
Date: Thu, 30 Jul 2009 22:38:04 +0200
Message-ID: <200907302238.04319.rjw@sisk.pl>
References: <877hxqflyv.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <877hxqflyv.fsf@tac.ki.iif.hu>
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
To: linux-pm@lists.linux-foundation.org
Cc: Ferenc Wagner <wferi@niif.hu>
List-Id: linux-pm@vger.kernel.org

On Thursday 30 July 2009, Ferenc Wagner wrote:
> Hi,

Hi,

> Right now I'm running v2.6.31-rc4-169-g967e4bf and it produced
> something I've never seen before (neither on 2.6.30 nor 2.6.31-rc3).
> The hibernation process froze like this:
> 
> Looking for splash system... Splashy ERROR: Cannot read XML File <</etc/splashy/config.xml>> Exiting...
> Splashy ERROR: libsplashy: No config file found at (null)
> splashy_init: error -1none
> s2disk: Snapshotting system
> s2disk: System snapshot ready. Preparing to write
> s2disk: Image size: 240872 kilobytes
> s2disk: Free swap: 1333596 kilobytes
> s2disk: Saving 60217 image data pages (press backspace to abort) ... 100% done (60217 pages)
> s2disk: Compression ratio -63208.85
> S|
> 
> Basically, it looked like it simply neglected to switch off the
> machine (ThinkPad R50e), switching it off and later on manually
> resulted in a perfect resume from the written image.  However, the
> next suspend to RAM failed with this:
> 
> [66105.285713] Freezing user space processes ... (elapsed 0.02 seconds) done.
> [66105.313558] Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> 
> where the machine froze with its suspend led blinking.  After a clean
> restart, I couldn't reproduce either problem.  Sorry for being of so
> little use, but I decided to report it, who knows...

Thanks for the report.  I'm observing a hibernation issue where the machine
hangs on the second attempt to hibernate 100% of the time.  It looks like it
may be related to what you've observed.

Best,
Rafael
