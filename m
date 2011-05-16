From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 8/9] OMAP1 / PM: Use generic clock
	manipulation routines for runtime PM
Date: Mon, 16 May 2011 12:16:13 +0200
Message-ID: <87mxindk7m.fsf__35704.7139354565$1305541055$gmane$org@ti.com>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
	<201104242330.13607.rjw@sisk.pl> <201104242343.41456.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104242343.41456.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun, 24 Apr 2011 23:43:41 +0200")
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
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Convert OMAP1 to using the new generic clock manipulation routines
> and a device power domain for runtime PM instead of overriding the
> platform bus type's runtime PM callbacks.  This allows us to simplify
> OMAP1-specific code and to share some code with other platforms
> (shmobile in particular).
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Kevin Hilman <khilman@ti.com>
