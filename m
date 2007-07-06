From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync filesystems from
	within the freezer
Date: Fri, 6 Jul 2007 09:02:53 +0200
Message-ID: <200707060902.55090.rjw__209.294763817702$1183705005$gmane$org@sisk.pl>
References: <200707041658.59588.rjw@sisk.pl> <200707052231.27780.rjw@sisk.pl>
	<20070705220046.GC3881@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705220046.GC3881@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Friday, 6 July 2007 00:00, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The syncing of filesystems from within the freezer is generally not needed.
> > Change freeze_processes() so that it doesn't execute sys_sync() and make the
> > suspend and hibernation code path sync filesystems independently of the freezer.
> 
> Yes, we can do that, but ... why?

I think that sync and the freezer are different things and shouldn't be mixed in
such a way as they are now.

> Does it actually fix FUSE?

It should prevent the freezer from deadlocking.

> Miklos claims sync is nop on FUSE...? 

In that case there shouldn't be any deadlock, but a freezer failure. :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
