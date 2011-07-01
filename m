From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/10 v6] PM / Domains: Support for generic
	I/O PM domains
Date: Fri, 01 Jul 2011 11:27:22 -0700
Message-ID: <87fwmpyhyt.fsf__9063.03618471629$1309544894$gmane$org@ti.com>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106252324.13454.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 25 Jun 2011 23:24:13 +0200")
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Hi,
>
> Well, one more update. :-)
>
> This is the 6th version of the patchset adding support for generic I/O PM
> domains.  The majority of patches have had some small fixes here and there
> to make things work when CONFIG_PM_RUNTIME is unset.  In addition to that,
> to make the shmobile code introduced by the last patch work for
> CONFIG_PM_RUNTIME unset I had to add patches [8-9/10].  Patch [7/10]
> adds wakeup support that was missing from the previous version and I
> decided not to push patch [1/10] for 3.0 after all.

For everything but the shmobile specifics, which I didn't look at too
closely, and the changes for [7/10] that we agreed on:

Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks!

Kevin
