From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH -mm 1/6] Freezer: Do not sync filesystems
Date: Tue, 10 Jul 2007 01:31:45 +0100
Message-ID: <20070710003145.GA4624@srcf.ucam.org>
References: <200707092229.08898.rjw@sisk.pl> <200707092231.46808.rjw@sisk.pl>
	<20070709231209.GF1967@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070709231209.GF1967@elf.ucw.cz>
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
Cc: Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 10, 2007 at 01:12:09AM +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The syncing of filesystems from within the freezer is generally not needed.
> > Also, if FUSE implements sync, this will cause the freezer to deadlock with it.
> 
> While this is right, I do not think it is good enough reason for a
> change. I mean, sync there currently hurts noone....

It's a problem if you have an ext3 filesystem loopback mounted from a 
fuse filesystem...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
