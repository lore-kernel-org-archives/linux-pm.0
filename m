From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 8/8] ACPI PM: Add DMI quirk list for ACPI
	1.0	suspend ordering
Date: Thu, 10 Jul 2008 13:37:07 +0200
Message-ID: <20080710113707.GG15412__19147.6010870703$1215717634$gmane$org@elf.ucw.cz>
References: <200807100152.17755.rjw@sisk.pl> <200807100207.03636.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807100207.03636.rjw@sisk.pl>
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
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-07-10 02:07:02, Rafael J. Wysocki wrote:
> From: Carlos Corbacho <carlos@strangeworlds.co.uk>
> Subject: ACPI PM: Add DMI quirk list for ACPI 1.0 suspend ordering
> 
> There are a few BIOS' that we know of already that need to use the
> ACPI 1.0 suspend order. This appears to be only be a small minority of
> mostly nVidia based systems.
> 
> Based on observation of Windows behaviour, it's clear that Windows is
> also doing maintaining its own list of broken hardware that needs this
> workaround.
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
