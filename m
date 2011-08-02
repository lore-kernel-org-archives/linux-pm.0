From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/13] PM: QoS: rename pm_qos_params files to
	pm_qos
Date: Tue, 2 Aug 2011 11:47:36 +0200
Message-ID: <201108021147.36233.rjw__17473.5909713947$1312278421$gmane$org@sisk.pl>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<201107292357.48969.rjw@sisk.pl>
	<CAORVsuX1iXnQS5LZeKb7nJa1_QCmnHDpDZBWyQab6rcLqig=TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAORVsuX1iXnQS5LZeKb7nJa1_QCmnHDpDZBWyQab6rcLqig=TQ@mail.gmail.com>
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
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 02, 2011, Jean Pihet wrote:
> Rafael,
> 
> 2011/7/29 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> The PM QoS implementation files are better named
> >> kernel/pm_qos.c and include/linux/pm_qos.h.
> >>
> ...
> 
> >>  create mode 100644 include/linux/pm_qos.h
> >>  delete mode 100644 include/linux/pm_qos_params.h
> >
> > That I agree with.
> >
> >>  create mode 100644 kernel/pm_qos.c
> >>  delete mode 100644 kernel/pm_qos_params.c
> >
> > As I said, please move that file to kernel/power and call it qos.c.
> Ok
> 
> >
> > That said the device interface should be located in drivers/base/power
> > to follow our current conventions.
> By device interface I understand the following:
> - the user space API (per-device sysfs entry),
> - the in-kernel device specific PM QoS API. If needed, cf. comments on
> [04/13] about that.
> 
> Is that correct?

Yes, it is.

I think that the definitions of the dev_pm_qos_*() funtions mentioned
in there may go into drivers/base/power/qos.c and they can call functions
from kernel/power/qos.c.

Thanks,
Rafael
