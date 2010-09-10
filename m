From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM / Wakeup: Introduce wakeup source
 objects and event statistics (was: Re: Wakeup-events implementation)
Date: Fri, 10 Sep 2010 11:21:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009101119060.1651-100000__10022.6381015547$1284132142$gmane$org@iolanthe.rowland.org>
References: <201009080151.43047.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009080151.43047.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 8 Sep 2010, Rafael J. Wysocki wrote:

> +struct wakeup_source *wakeup_source_create(const char *name)
> +{
> +	struct wakeup_source *ws;
> +
> +	ws = kzalloc(sizeof(*ws), GFP_KERNEL);
> +	if (!ws)
> +		return NULL;
> +
> +	if (name) {
> +		int len = strlen(name);
> +		char *s = kzalloc(len + 1, GFP_KERNEL);
> +		if (s) {
> +			strncpy(s, name, len);
> +			ws->name = s;
> +		}
> +	}
> +
> +	return ws;
> +}

Forget what I wrote earlier; it was stupid.  Just use kstrdup.

Alan Stern
