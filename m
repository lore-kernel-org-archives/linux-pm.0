From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH update 2x] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 16)
Date: Fri, 14 Aug 2009 18:08:29 +0900
Message-ID: <aec7e5c30908140208j1498c134j46bef043f60f6c55__15786.2736298286$1250241018$gmane$org@mail.gmail.com>
References: <200908081625.57333.rjw@sisk.pl> <200908092313.05541.rjw@sisk.pl>
	<200908132256.42941.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908132256.42941.rjw@sisk.pl>
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

On Fri, Aug 14, 2009 at 5:56 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Introduce core framework for run-time PM of I/O devices (rev=
. 16)
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

I've now tested v16 with my SuperH Mobile platform device Runtime PM
implementation. All seems fine and my patches for patches for drivers
such as i2c master, fbdev, v4l2 and uio behave as expected.

Acked-by: Magnus Damm <damm@igel.co.jp>

The patch "PM: Runtime PM v15 - Platform Device Bus Support" works
well with v16 and does not need any update.

Cheers,

/ magnus
