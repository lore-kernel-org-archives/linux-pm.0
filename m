From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: intermittent suspend problem again
Date: Wed, 2 Dec 2009 22:41:05 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0912022238100.23464__32173.9226034426$1259869677$gmane$org@uplift.swm.pp.se>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <87638qw2zy.fsf@tac.ki.iif.hu>
	<87skbtve5w.fsf@tac.ki.iif.hu> <200912022233.16138.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912022233.16138.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 Dec 2009, Rafael J. Wysocki wrote:

> Then I guess we do something that confuses your machine's BIOS or it's a 
> timing-related issue (ie. there has to be a substantial delay between 
> the hibernation and restore to trigger the problem).  Or both.

I don't know if it's related, but on 2.6.31.something (ubuntu 9.10 stock 
kernel) I have intermittent suspend/resume problems on my Thinkpad X200, 
and I get the problems much more frequent when running on batteries than 
when I'm running with the power cable plugged in. Just saying that this 
might be something to test as well.

Link to "my" bug on launchpad:

<https://bugs.launchpad.net/ubuntu/+source/linux/+bug/473876>

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
