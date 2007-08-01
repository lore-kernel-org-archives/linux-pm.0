From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] CONFIG_PM_LEGACY = compiler warnings for
	deprecation ... solution?
Date: Wed, 1 Aug 2007 12:57:25 +0200
Message-ID: <200708011257.25835.rjw__47915.4848064811$1185965378$gmane$org@sisk.pl>
References: <20070801050806.4A8BEDA820@mailserver8.hushmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070801050806.4A8BEDA820@mailserver8.hushmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: postfail@hushmail.com
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 1 August 2007 07:08, Scott Thompson wrote:
> w/ CONFIG_PM_LEGACY .config option set, you get following batch of
> compile errors because it marks the functions as 'deprecated'. w/o 
> it set, it just uses stubs. compiler warnings for refernece (from 
> 2.6.23-1, though appears to have been around since at least 2.6.11 
> from another mail list post).
> 
> However, since these functions are required if you have
> CONFIG_PM_LEGACY option marked...
> 
> I propose that within the include/linux/pm_legacy.h file, functions
> in the CONFIG_PM_LEGACY aren't marked 'deprecated' and functions
> outside the #if are marked deprecated.  Then the handful of calls
> (12 or so) that actually call the pm_legacy apis can get wrapped in
> the CONFIG_PM_LEGACY flag.
> 
> This is basically already being done in one case since as of
> 2.6.20.1 the pm_register function is only used in
> drivers/serial/68328serial.c.
> 
> The pm_send_all is not wrapped around all uses yet, but that is
> pretty easy to patch.  Then the compile will actually complain
> should someone try to call it and not wrap w/ the CONFIG_PM_LEGACY
> ifdef.
> 
> Happy to hear thoughts or other solutions.

We are going to remove the legacy PM altogether, AFAICS, although there still
are some obstacles.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
