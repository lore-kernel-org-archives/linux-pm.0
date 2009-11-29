From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: New whitelist.c and more stuff
Date: Sun, 29 Nov 2009 23:59:50 +0100
Message-ID: <200911292359.50757.rjw__12494.447726249$1259535612$gmane$org@sisk.pl>
References: <3096bd910911191606r1843a5a2l497a9aab7b8b52ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <3096bd910911191606r1843a5a2l497a9aab7b8b52ba@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rodolfo (kix)" <kix@kix.es>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 20 November 2009, Rodolfo (kix) wrote:
> Hi,

Hi,

> this is an email-pack with many things:
> 
> A new database file: whitelist_2009111900.{c|csv} This file includes
> de updates from 3/aug to now. One change and some new machines.

OK, I'll merge this one first and add the one you've sent later on top of it.

> I include too a new database file: whitelist_nodup.c, is the old
> (original, actual in git) whitelist.c file (without the new machines)
> and without duplicates.
> 
> I add a new version of the dbcheck tool and the new perl scripts to
> the database management:
> 
> wlc2csv.pl:   C -> CSV
> wlcsv2c.pl    CSV -> C

Do you want me to put these two files into the git tree?

> Please, send me your comments about this files and the other three
> patchs. Include the new database in the git.
> Sorry for the email size.

No problem.

Thanks,
Rafael
