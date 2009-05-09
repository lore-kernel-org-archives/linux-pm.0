From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 09 May 2009 11:10:28 +0200
Message-ID: <4A054884.3060503__44281.1158056886$1241860458$gmane$org@s5r6.in-berlin.de>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz>
	<Pine.LNX.4.64.0905070925500.8967@hp9800.localdomain>
	<Pine.LNX.4.64.0905071101000.8967@hp9800.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0905071101000.8967@hp9800.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenneth Crudup <kenny@panix.com>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Kenneth Crudup wrote:
> Oh, and I can hit "ESC" in the middle of suspending with TuxOnIce and
> back out of it if I'd changed my mind for whatever reason.
> 
> There are(/were) competing ieee1394 OHCI drivers and competing Bluetooth
> USB HCI drivers, and that's just off the top of my head- so having
> competing suspend/resume methods won't be anything new. Let the market
> decide which is best.

The case of two 1394 driver stacks isn't fully comparable.  I supported 
the addition of the second stack with the intent to replace the existing 
one after a transition period, and in the hope that the ratio of 
available maintainer manpower : size and complexity of the codebase 
would improve considerably.  Because that was/is the single fundamental 
problem in Linux 1394 driver land.

(Besides, how well is infrastructure like the suspend--resume framework 
comparable to drivers?)
-- 
Stefan Richter
-=====-=-=== -=-= -==-=
http://arcgraph.de/sr/
