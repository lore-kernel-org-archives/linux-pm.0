From: Daniel Drake <ddrake@brontes3d.com>
Subject: Re: [linux-pm] Dangers of touching disk
	between	suspend and resume
Date: Tue, 28 Nov 2006 14:43:23 -0500
Message-ID: <1164743003.31456.1.camel@systems03.lan.brontes3d.com>
References: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
	<Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
	<20061128163757.GM14640@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061128163757.GM14640@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Stefan Seyfried <seife@suse.de>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@osdl.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-11-28 at 17:37 +0100, Stefan Seyfried wrote:
> He just has to look at the end of the first page of the swap partition
> for the signature :-)
> 
> So it is a good idea to tell the engineer to do "mkswap" on the swap
> partition before putting the disk into the replacement hardware.

Thanks for the responses, makes sense. I'm happy with having to recreate
swap when performing repair tasks like this.

-- 
Daniel Drake
Brontes Technologies, A 3M Company


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
