From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] ACPI Suspend: Enable ACPI during resume if
	SCI_EN is	not set
Date: Wed, 8 Oct 2008 13:39:34 +0200
Message-ID: <20081008113933.GC1651__29723.5082056888$1223484780$gmane$org@ucw.cz>
References: <200810040005.06220.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200810040005.06220.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2008-10-04 00:05:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI Suspend: Enable ACPI during resume if SCI_EN is not set
> 
> On some machines, like for example MSI Wind U100, the BIOS doesn't
> enable ACPI before returning control to the OS, which sometimes
> causes resume to fail.  This is against the ACPI specification,
> which clearly states that "When the platform is waking from an S1, S2
> or S3 state, OSPM assumes the hardware is already in the ACPI mode
> and will not issue an ACPI_ENABLE", but it won't hurt to check the
> SCI_EN bit and enable ACPI during resume from S3 if this bit is not
> set.
> 
> Fortunately, we already have acpi_enable() for that, so use it in the
> resume code path, before executing _BFS, in analogy with the
> resume-from-hibernation code path.
> 
> NOTE: We aren't supposed to set SCI_EN directly, because it's owned
> by the hardware.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
