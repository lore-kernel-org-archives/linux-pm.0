From: Len Brown <lenb@kernel.org>
Subject: Re: Wrong commit in the ACPI release branch
Date: Mon, 13 Dec 2010 15:11:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012131507120.16730__33021.2929904976$1292271166$gmane$org@x980>
References: <201012112329.35080.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201012112329.35080.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jan Beulich <jbeulich@novell.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 11 Dec 2010, Rafael J. Wysocki wrote:

> http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h=091aad6af4ab29af693ced5d6970ceee9d5981c8
> 
> (ACPI: eliminate unused variable warning for !ACPI_SLEEP)
> is actually wrong, because it's going to break compilation for
> (!CONFIG_PM_SLEEP && CONFIG_PM_RUNTIME).

That's funny, that config builds for me.
It got through my 399 kernel build test, as well as linux-next.

If you have a .config that breaks, please send it to me.

> I haven't seen it before, let alone acking it or something like this, so I wonder
> why it's being pushed directly to Linus?

it fixes an unused variable warning if !CONFG_ACPI_SLEEP, per the commit 
message.

thanks,
Len Brown, Intel Open Source Technology Center
