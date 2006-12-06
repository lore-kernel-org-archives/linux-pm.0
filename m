From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [linux-pm] [PATCH -mm 1/2]: PM: Fix handling	of
	stopped tasks
Date: Wed, 06 Dec 2006 11:07:28 +1100
Message-ID: <1165363648.19284.5.camel@nigel.suspend2.net>
References: <200612032318.29030.rjw@sisk.pl>
	<200612052203.43977.rjw@sisk.pl> <20061205221948.GA1723@elf.ucw.cz>
	<200612052318.18192.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612052318.18192.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi.

On Tue, 2006-12-05 at 23:18 +0100, Rafael J. Wysocki wrote:
> > > It happens because we shouldn't count the stopped task as freezeable any
> > > more after we've set PF_FREEZE for it and we can fix that by adding
> > > 
> > > 	if (p->state == TASK_STOPPED && freezing(p))
> > > 		continue;
> > 
> > No, I'd actually like to force stopped task into refrigerator.
> 
> Well, we'd have to send SIGCONT to them for this purpose and then stop them
> back again during the resume.  Doesn't sound nice ...

I agree with Rafael. Contingencies for handling them being restarted by
other means is one thing, but restarting tasks that were stopped is
wrong. Who knows what work they might do between the SIGCONT and
freezing that (and this is the key point) the user doesn't want them to
do?

Regards,

Nigel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
