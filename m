From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/9] OMAP1 / PM: Use generic clock
	manipulation routines for runtime PM
Date: Mon, 16 May 2011 20:26:26 +0200
Message-ID: <201105162026.27009.rjw__41898.0242488489$1305573593$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104242343.41456.rjw@sisk.pl>
	<87mxindk7m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87mxindk7m.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, May 16, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Convert OMAP1 to using the new generic clock manipulation routines
> > and a device power domain for runtime PM instead of overriding the
> > platform bus type's runtime PM callbacks.  This allows us to simplify
> > OMAP1-specific code and to share some code with other platforms
> > (shmobile in particular).
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Thanks!
