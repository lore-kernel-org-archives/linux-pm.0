From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 0/2]: SMP-safe freezer
Date: Sun, 3 Dec 2006 23:18:28 +0100
Message-ID: <200612032318.29030.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
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
To: pm list <linux-pm@lists.osdl.org>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches are designed to make the task freezer SMP-safe.

The first patch is a controversial one, as Pavel doesn't like it, but I have
no other idea how the freezing of stopped tasks could be handled to avoid
the problems that it has now.  I did my best to explain everything in the
changelog.

The second patch is basically needed to make the freezer avoid races with
other tasks when modifying the other tasks' flags.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
