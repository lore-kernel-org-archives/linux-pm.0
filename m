From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] PM / Domains / shmobile fixes
Date: Thu, 14 Jul 2011 21:34:40 +0200
Message-ID: <201107142134.40432.rjw__23733.5331542001$1310672114$gmane$org@sisk.pl>
References: <201107132352.59801.rjw@sisk.pl>
	<CANqRtoTLO=DqehwanGdE+rgxL_ofa5YCJjsx47doHzwZDP4Ocw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CANqRtoTLO=DqehwanGdE+rgxL_ofa5YCJjsx47doHzwZDP4Ocw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 14, 2011, Magnus Damm wrote:
> On Thu, Jul 14, 2011 at 6:52 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > The following three patches fix a couple of issues in the code currently
> > in my pm-domains branch at:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains
> >
> > [1/3] - Use genpd_queue_power_off_work() for queuing up the powering off
> >        of A4LC (this avoids attempting to queue up a work item while it is
> >        pending).
> >
> > [2/3] - Make the generic PM domains code react to -EBUSY returned from a
> >        PM domain's .power_down() callback (needed for [3/3]).
> >
> > [3/3] - Return -EBUSY from the A4LC's .power_down() callback to indicate that
> >        the domain hasn't been powered down on purpose and remove the confusing
> >        (and now redundant) pm_genpd_poweron(A4LC) from pd_power_down_a3rv().
> 
> All patches above look great, thanks a lot for your help!
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks!

Rafael
