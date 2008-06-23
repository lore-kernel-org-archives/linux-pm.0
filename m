From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH]ACPI: Fix CMOS time error after waking up
	by	/proc/acpi/alarm
Date: Mon, 23 Jun 2008 11:10:51 +0200
Message-ID: <20080623091051.GA1917__18706.9534826607$1214212357$gmane$org@elf.ucw.cz>
References: <42DFA526FC41B1429CE7279EF83C6BDC0148CB4C@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC0148CB4C@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Chen, Huacai" <huacai.chen@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-06-19 21:52:02, Chen, Huacai wrote:
> From: Huacai Chen <huacai.chen@intel.com>
> 
> When writing /proc/acpi/alarm to wakeup up in adjust mode, this patch
> read the "century" filed and add it to the "year" field before writing.
> This avoids the CMOS time error (2000 years decrement) after waking up.
> 
> Signed-off-by: Huacai Chen <huacai.chen@intel.com>

Probably word-wrapped,

> ---
> diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
> index 224c57c..2a85783 100644
> --- a/drivers/acpi/sleep/proc.c
> +++ b/drivers/acpi/sleep/proc.c
> @@ -315,8 +315,11 @@ acpi_system_write_alarm(struct file *file,
>  		cmos_bcd_write(day, acpi_gbl_FADT.day_alarm,
> rtc_control);
>  	if (acpi_gbl_FADT.month_alarm)
>  		cmos_bcd_write(mo, acpi_gbl_FADT.month_alarm,
> rtc_control);
> -	if (acpi_gbl_FADT.century)
> +	if (acpi_gbl_FADT.century){

and you definitely want ") {" here.

It probably should go to Len and RTC maintainers?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
