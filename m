From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: New whitelist.c and more stuff
Date: Mon, 30 Nov 2009 00:01:09 +0100
Message-ID: <200911300001.09108.rjw__46310.0154106089$1259535694$gmane$org@sisk.pl>
References: <3096bd910911191606r1843a5a2l497a9aab7b8b52ba@mail.gmail.com>
	<20091121234541.GE1411@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091121234541.GE1411@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 22 November 2009, Pavel Machek wrote:
> Hi!
> 
> > this is an email-pack with many things:
> > 
> > A new database file: whitelist_2009111900.{c|csv} This file includes
> > de updates from 3/aug to now. One change and some new machines.
> > 
> > I include too a new database file: whitelist_nodup.c, is the old
> > (original, actual in git) whitelist.c file (without the new machines)
> > and without duplicates.
> > 
> > I add a new version of the dbcheck tool and the new perl scripts to
> > the database management:
> > 
> > wlc2csv.pl:   C -> CSV
> > wlcsv2c.pl    CSV -> C
> > 
> > Please, send me your comments about this files and the other three
> > patchs. Include the new database in the git.
> > Sorry for the email size.
> 
> Looks ok to me. Rafael now has git tree, so he's the only one who can
> apply it.

Alternatively, you could create a git tree for me to pull from.

> ...and... perhaps we should delete email address from the sources, and
> replace it with pointer to web page?

Yes, some documentation will have to be changed.

Thanks,
Rafael
