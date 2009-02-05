From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 03/13] PM: Implement wakelock api.
Date: Thu, 5 Feb 2009 10:24:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902051019330.2746-100000@iolanthe.rowland.org>
References: <1233802226-23386-4-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233802226-23386-4-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?utf-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Feb 2009, [utf-8] Arve Hj=C3=B8nnev=C3=A5g wrote:

> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -116,6 +116,25 @@ config SUSPEND_FREEZER
>  =

>  	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
>  =

> +config HAS_WAKELOCK
> +	bool
> +
> +config WAKELOCK
> +	bool "Wake lock"
> +	depends on PM && RTC_CLASS
> +	default n
> +	select HAS_WAKELOCK
> +	---help---
> +	  Enable wakelocks. When user space request a sleep state the
> +	  sleep request will be delayed until no wake locks are held.

You know, when submitting multiple patches it is customary to break the =

code up in such a way that intermediate forms (where some of the =

patches have been applied but not all of them) will compile and run =

correctly.  This is so that people will be able to carry out bisection =

searches while looking for other bugs.

Right here we see that you introduce CONFIG_WAKELOCK in patch 03/13, =

but it gets used already in patch 01/13.  That's not good.

One other thing -- this may be a standard Kconfig idiom, but what =

reason is there for CONFIG_HAS_WAKELOCK?  Does it get used anywhere?  =

It if does, couldn't CONFIG_WAKELOCK be used instead?

Alan Stern
