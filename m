From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 04 Jul 2007 07:16:24 +1000
Message-ID: <1183497385.3388.6.camel__24086.0641039491$1183497760$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<1183441887.10386.77.camel@localhost.localdomain>
	<200707031508.45595.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707031508.45595.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-03 at 15:08 +0200, Rafael J. Wysocki wrote:
> On Tuesday, 3 July 2007 07:51, Benjamin Herrenschmidt wrote:
> > On Tue, 2007-07-03 at 05:29 +0100, Matthew Garrett wrote:
> > > Suspend to RAM on a machine with / on a fuse filesystem turns out to be 
> > > a screaming nightmare - either the suspend fails because syslog (for 
> > > instance) can't be frozen, or the machine deadlocks for some other 
> > > reason I haven't tracked down. We could "fix" fuse, or alternatively we 
> > > could do what we do for suspend to RAM on other platforms (PPC and APM) 
> > > and just not use the freezer.
> > 
> > The main reason for deadlocks is because we do a sys_sync() after the
> > freeze, which we shouldn't do.
> 
> So why don't we remove the sys_sync() from freeze_processes() instead?

Or rather, move it to before freeze_processes() so that you get at least
some level of sync'ing just in case you never wake up. Not perfect
(things may still get dirty) but it will help the immediate issue.

Ben.
