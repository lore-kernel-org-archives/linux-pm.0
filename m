From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 15:07:52 +0200
Message-ID: <200707031507.52875.rjw@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<1183441748.10386.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183441748.10386.75.camel@localhost.localdomain>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 07:49, Benjamin Herrenschmidt wrote:
> On Tue, 2007-07-03 at 05:29 +0100, Matthew Garrett wrote:
> > Suspend to RAM on a machine with / on a fuse filesystem turns out to be 
> > a screaming nightmare - either the suspend fails because syslog (for 
> > instance) can't be frozen, or the machine deadlocks for some other 
> > reason I haven't tracked down. We could "fix" fuse, or alternatively we 
> > could do what we do for suspend to RAM on other platforms (PPC and APM) 
> > and just not use the freezer.
> > 
> > Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> (And with much pleasure :-)

Clashes with some code already in -mm.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
