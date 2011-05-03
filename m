From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Print a warning if firmware is
	requested when tasks are frozen
Date: Tue, 3 May 2011 19:14:53 +0200
Message-ID: <201105031914.53972.rjw__43912.1461626657$1304444208$gmane$org@sisk.pl>
References: <201105030044.51661.rjw@sisk.pl> <15997.1304437643@localhost>
	<1304438196.1788.19.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1304438196.1788.19.camel@Joe-Laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Valdis.Kletnieks@vt.edu, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 03, 2011, Joe Perches wrote:
> On Tue, 2011-05-03 at 11:47 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 03 May 2011 13:02:08 +0200, "Rafael J. Wysocki" said:
> > > It's useful, but I'd rather do
> > >  		dev_info(device, "firmware: %s will not be loaded\n", name);
> > That works too.  :)
> 
> A higher KERN_<LEVEL> like dev_alert or dev_err might be better.

Hmm, fair enough.  I'll use dev_err() in the final version.

Thanks,
Rafael
