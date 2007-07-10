From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 4/6] Freezer: Prevent new tasks from
	inheriting TIF_FREEZE set
Date: Tue, 10 Jul 2007 08:03:42 +0200
Message-ID: <200707100803.43799.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <200707092234.55437.rjw@sisk.pl>
	<20070709232113.GG1967@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070709232113.GG1967@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 10 July 2007 01:21, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Tasks should go to the refrigerator only if explicitly requested to do that by
> > the freezer and not as a result of inheriting the TIF_FREEZE flag set from the
> > parent.  Make it happen.
> 
> Umm, what prevents userspace task from escaping freezer this way? Does
> tasklist_lock prevent new tasks and thus this race?

I think so.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
