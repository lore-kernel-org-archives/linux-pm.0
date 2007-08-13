From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] [444/2many] MAINTAINERS - SUSPEND TO RAM:
Date: Mon, 13 Aug 2007 13:57:50 -0700
Message-ID: <1187038670.10249.307.camel@localhost>
References: <46bffbd5.kKrnXsYdLyNKojxF%joe@perches.com>
	<200708132252.55738.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708132252.55738.rjw@sisk.pl>
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

On Mon, 2007-08-13 at 22:52 +0200, Rafael J. Wysocki wrote:
> +F:	drivers/base/power
> +F:	arch/x86_64/kernel/acpi
> +F:	arch/i386/kernel/acpi/

What about arch/x86_64/kernel/acpi.c ?

Perhaps:

SUSPEND TO RAM:
P:	Pavel Machek
M:	pavel@suse.cz
P:	Rafael J. Wysocki
M:	rjw@sisk.pl
L:	linux-pm@lists.linux-foundation.org
S:	Maintained
F:	arch/x86_64/kernel/acpi.c
F:	arch/x86_64/kernel/acpi/
F:	arch/i386/kernel/acpi/
F:	drivers/base/power
F:	kernel/power/
