From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 7/8] ACPI hibernation: Utilize hardware
	signature
Date: Thu, 10 Jul 2008 10:34:23 +0200
Message-ID: <20080710083423.GD5629__20715.8936922953$1215679082$gmane$org@elf.ucw.cz>
References: <200807100152.17755.rjw@sisk.pl> <200807100205.52308.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807100205.52308.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> Subject: ACPI hibernation: Utilize hardware signature
> 
> ACPI defines a hardware signature.  BIOS calculates the signature
> according to hardware configure and if hardware changes while
> hibernated, the signature will change.  In that case, S4 resume
> should fail.
> 
> Still, there may be systems on which this mechanism does not work
> correctly, so it is better to provide a workaround for them.  For
> this reason, add a new switch to the acpi_sleep= command line
> argument allowing one to disable hardware signature checking.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
