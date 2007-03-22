From: Stefan Seyfried <seife@suse.de>
Subject: Re: [linux-pm] [PATCH] introduce
	/sys/power/disk_powerdown_mode
Date: Thu, 22 Mar 2007 14:13:01 +0100
Message-ID: <20070322131301.GD11160@suse.de>
References: <1174468981.3769.8.camel@johannes.berg>
	<1174482773.4230.19.camel@johannes.berg>
	<20070321131709.GA5788@elf.ucw.cz> <200703211501.37164.rjw@sisk.pl>
	<20070321220858.GE6057@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070321220858.GE6057@elf.ucw.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Suspend-devel list <suspend-devel@lists.sourceforge.net>, linux-pm <linux-pm@lists.osdl.org>, seife@novell.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 21, 2007 at 11:08:58PM +0100, Pavel Machek wrote:
 
> (Stefan, we are talking about changing /sys/power/disk during _read_
> so it shows list of available options as well as current one. I do not
> expect that to break anything, but... if I'm wrong, just shout).

I don't think it will break anything for me, and if it does, it should
be pretty easy to fix. So just go ahead.

But thanks for the warning in advance anyway :-)
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out." 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
