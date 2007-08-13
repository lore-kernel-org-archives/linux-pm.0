From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [444/2many] MAINTAINERS - SUSPEND TO RAM:
Date: Mon, 13 Aug 2007 23:22:15 +0200
Message-ID: <200708132322.16316.rjw@sisk.pl>
References: <46bffbd5.kKrnXsYdLyNKojxF%joe@perches.com>
	<200708132252.55738.rjw@sisk.pl>
	<1187038670.10249.307.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1187038670.10249.307.camel@localhost>
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
To: Joe Perches <joe@perches.com>
Cc: torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, 13 August 2007 22:57, Joe Perches wrote:
> On Mon, 2007-08-13 at 22:52 +0200, Rafael J. Wysocki wrote:
> > +F:	drivers/base/power
> > +F:	arch/x86_64/kernel/acpi
> > +F:	arch/i386/kernel/acpi/
> 
> What about arch/x86_64/kernel/acpi.c ?

Well, there's no such file in current -git.

> Perhaps:
> 
> SUSPEND TO RAM:
> P:	Pavel Machek
> M:	pavel@suse.cz
> P:	Rafael J. Wysocki
> M:	rjw@sisk.pl
> L:	linux-pm@lists.linux-foundation.org
> S:	Maintained
> F:	arch/x86_64/kernel/acpi.c

Please remove the above

> F:	arch/x86_64/kernel/acpi/
> F:	arch/i386/kernel/acpi/
> F:	drivers/base/power
> F:	kernel/power/
> 
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
