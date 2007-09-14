From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Resend][PATCH -mm] Hibernation: Enter platform
 hibernation state in a consistent way (rev. 4)
Date: Fri, 14 Sep 2007 16:37:17 -0700
Message-ID: <20070914163717.8a0cb637.akpm__17549.0951551639$1189813109$gmane$org@linux-foundation.org>
References: <200709121314.09676.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709121314.09676.rjw@sisk.pl>
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
Cc: Stefan Becker <Stefan.Becker@nokia.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Sep 2007 13:14:08 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +	if (!hibernation_ops)
> +		return -ENOSYS;
> +
> +	/*
> +	 * We have cancelled the power transition by running
> +	 * hibernation_ops->finish() before saving the image, so we should let
> +	 * the firmware know that we're going to enter the sleep state after all
> +	 */
> +	error = hibernation_ops->start();
> +	if (error)
> +		return error;
> +
> +	suspend_console();
> +	error = device_suspend(PMSG_SUSPEND);
> +	if (error)
> +		return error;
> +
> +	error = hibernation_ops->prepare();
> +	if (error)
> +		goto Resume_devices;
> +
> +	error = disable_nonboot_cpus();
> +	if (error)
> +		goto Finish;
> +
> +	local_irq_disable();
> +	error = device_power_down(PMSG_SUSPEND);
> +	if (!error) {
> +		hibernation_ops->enter();
> +		/* We should never get here */
> +		while (1);
>  	}
> +	local_irq_enable();
> +

Confused.  afacit there's no way for the caller of this function to know
whether or not suspend_console() was called, so the error recovery doesn't
know whether or not to run resume_console().  How does all that work?
