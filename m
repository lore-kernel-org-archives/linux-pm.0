From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [444/2many] MAINTAINERS - SUSPEND TO RAM:
Date: Mon, 13 Aug 2007 14:17:26 -0700
Message-ID: <1187039846.10249.319.camel__1423.96659725836$1187040047$gmane$org@localhost>
References: <46bffbd5.kKrnXsYdLyNKojxF%joe@perches.com>
	<200708132252.55738.rjw@sisk.pl> <1187038670.10249.307.camel@localhost>
	<200708132322.16316.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708132322.16316.rjw@sisk.pl>
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
Cc: torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-08-13 at 23:22 +0200, Rafael J. Wysocki wrote:
> > What about arch/x86_64/kernel/acpi.c ?
> Well, there's no such file in current -git.
> > F:	arch/x86_64/kernel/acpi.c
> Please remove the above

SUSPEND TO RAM:
P:	Pavel Machek
M:	pavel@suse.cz
P:	Rafael J. Wysocki
M:	rjw@sisk.pl
L:	linux-pm@lists.linux-foundation.org
S:	Maintained
F:	arch/x86_64/kernel/acpi/
F:	arch/i386/kernel/acpi/
F:	drivers/base/power
F:	kernel/power/
