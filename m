From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] NET/r8169: Rework suspend and resume
Date: Sun, 5 Apr 2009 23:59:31 +0200
Message-ID: <200904052359.31629.rjw__11515.3980128982$1238969013$gmane$org@sisk.pl>
References: <200904052040.04752.rjw@sisk.pl>
	<20090405223318.5a494e4e@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090405223318.5a494e4e@neptune.home>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bruno =?iso-8859-1?q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: NetDev <netdev@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>
List-Id: linux-pm@vger.kernel.org

On Sunday 05 April 2009, Bruno Pr=E9mont wrote:
> On Sun, 05 April 2009 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > =

> > The recent changes of the PCI PM core allow us to simplify the
> > suspend and resume handling in a number of device drivers, since they
> > don't need to carry out the general PCI PM operations, such as
> > changing the power state of the device, during suspend and resume any
> > more.
> > =

> > Simplify the suspend and resume callbacks of r8169 using the
> > observation that the PCI PM core can take care of some operations
> > carried out by the driver.
> > =

> > Additionally, make the shutdown callback of r8169 only put the device
> > into a low power state if the system is going to be powered off
> > (kexec is known to have problems with network adapters that are put
> > into low power states on shutdown).
> > =

> > This patch has been tested on MSI Wind U100.
> =

> Tested against 2.6.29.1 on my Commell LE-365 and suspend (S3) + WoL
> still works as expected.
> =

> 02:08.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>                      RTL-8169 Gigabit Ethernet [10ec:8169] (rev 10)

Thanks for testing!

Best,
Rafael
