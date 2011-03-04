From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] ACPI / PM: Merge do_suspend_lowlevel()
 into acpi_save_state_mem()
Date: Fri, 4 Mar 2011 16:38:50 +0100
Message-ID: <20110304153850.GG1358__40854.7476203696$1299253558$gmane$org@ucw.cz>
References: <201102072316.41270.rjw@sisk.pl> <201102072321.37565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102072321.37565.rjw@sisk.pl>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2011-02-07 23:21:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The function do_suspend_lowlevel() is specific to x86 and defined in
> assembly code, so it should be called from the x86 low-level suspend
> code rather than from acpi_suspend_enter().
> 
> Merge do_suspend_lowlevel() into the x86's acpi_save_state_mem() and
> change the name of the latter to acpi_suspend_lowlevel(), so that the
> function's purpose is better reflected by its name.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Ack.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
