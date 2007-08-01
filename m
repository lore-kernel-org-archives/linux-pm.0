From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mm 3/3] Freezer: Measure freezing time
Date: Wed, 1 Aug 2007 16:53:33 -0700
Message-ID: <20070801165333.7f93c4a6.akpm__19901.5242666521$1186067502$gmane$org@linux-foundation.org>
References: <200708012328.23939.rjw@sisk.pl> <200708012336.40388.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708012336.40388.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007 23:36:39 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +	do_gettimeofday(&end);
> +	elapsed_csecs64 = timeval_to_ns(&end) - timeval_to_ns(&start);
> +	do_div(elapsed_csecs64, NSEC_PER_SEC / 100);
> +	elapsed_csecs = elapsed_csecs64;

I'd have thought that we had enough timeval library code by now to
not need to open-code things like this.

<looks around>

No, it seems that we don't.  So people keep on open-coding the same
thing, or inventing private code which shouldn't be.

<notices net/dccp/dccp.h>

What the hell is all that stuff doing in there?
