From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: export suspend_set_ops,
	suspend_valid_only_mem
Date: Mon, 30 May 2011 16:00:51 +0200
Message-ID: <201105301600.51839.rjw__27415.7774787911$1306765497$gmane$org@sisk.pl>
References: <1306542839-5688-1-git-send-email-khilman@ti.com>
	<201105281101.13691.rjw@sisk.pl>
	<BANLkTi=pQEp=_RpNyJ9o=mxjA+PMhgTKZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=pQEp=_RpNyJ9o=mxjA+PMhgTKZQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, May 30, 2011, Jean Pihet wrote:
> Rafael,

Hi,

> On Sat, May 28, 2011 at 11:01 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, May 28, 2011, Kevin Hilman wrote:
> >> Some platforms wish to implement their PM core suspend code as
> >> modules.  To do so, these functions need to be exported to modules.
> >
> > Hmm.  What happens if the module is not loaded and the user attempts to
> > suspend?
> In that case suspend_ops is NULL and suspending has no effect
> (pm_suspend returns -ENODEV).
> Note that this also happens after the module unload.
> 
> Is that the expected behavior?

Yes, kind of, thanks.

Take care,
Rafael
