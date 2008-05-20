From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/7] ACPI Hibernation: Use ACPI hardware
	signature
Date: Tue, 20 May 2008 17:17:48 +0200
Message-ID: <20080520151748.GA2067__33520.4105046161$1211296783$gmane$org@elf.ucw.cz>
References: <200805200129.19904.rjw@sisk.pl> <200805200131.33913.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805200131.33913.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Shaohua Li <shaohua.li@intel.com>
> 
> ACPI defines a hardware signature. BIOS calculates the signature
> according to hardware configure, if hardware changes, the signature
> will change, in this case, S4 resume should fail.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> Acked-by: Pavel Machek <pavel@suse.cz>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

I guess I'm quite late to the party, but... could we make this use
acpi_sleep= command line option, and related variable?

That brings advantage of existing /proc/sys interface, so that s2disk
could do blacklist in userspace, and easily...

									Pavel

> @@ -152,6 +152,11 @@ and is between 256 and 4096 characters. 
>  			s3_beep is for debugging; it makes the PC's speaker beep
>  			as soon as the kernel's real-mode entry point is called.
>  
> +	acpi_s4_nosigcheck [HW,ACPI] S4 hardware signature
> +			ACPI will ignore the S4 hardware signature
> +			default: The hardware signature is checked during
> +			         resume from S4.
> +
>  	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
>  			Format: { level | edge | high | low }
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
