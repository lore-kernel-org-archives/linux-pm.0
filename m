From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH update x2] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 13)
Date: Fri, 7 Aug 2009 16:45:31 +0900
Message-ID: <aec7e5c30908070045t6214ce68kcecdc835c2ab7bff__3692.8724185147$1249631339$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.0908061257490.2937-100000@iolanthe.rowland.org>
	<200908062353.14822.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908062353.14822.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 7, 2009 at 6:53 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Introduce core framework for run-time PM of I/O devices (rev=
. 13)
>
> Introduce a core framework for run-time power management of I/O
> devices. =A0Add device run-time PM fields to 'struct dev_pm_info'
> and device run-time PM callbacks to 'struct dev_pm_ops'. =A0Introduce
> a run-time PM workqueue and define some device run-time PM helper
> functions at the core level. =A0Document all these things.
>
> Special thanks to Alan Stern for his help with the design and
> multiple detailed reviews of the pereceding versions of this patch
> and to Magnus Damm for testing feedback.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

I've rebased my series of patches to v13. My platform device Runtime
PM code for SuperH works well with drivers for i2c, uio and fbdev with
v13. Thank you. I'll post a SuperH specific patch set some time next
week.

Anyway, I'm not far from an "Acked-by", but please look at the following se=
ries:

[PATCH 00/05] PM: Runtime PM v13 for Platform Devices 20090807

Maybe there is some code in there that you can include in v14? Let me know!

Cheers,

/ magnus
