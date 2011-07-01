From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 19:32:33 +0800
Message-ID: <BANLkTimRRZ9Ld5rtpQMT3PhmOCn+qOxBcQ__14372.832401614$1309520025$gmane$org@mail.gmail.com>
References: <87k4c3dktm.fsf@ti.com> <87vcvmaml6.fsf@ti.com>
	<201107010233.12377.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107010233.12377.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Jul 1, 2011 at 8:33 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> In theory it is possible that a subsystem (e.g. bus type) will enable
> runtime PM for devices without drivers and will (for example) put them
> into low power states until the drivers are loaded. =A0Then, it makes
> sense for the core to prevent such transitions from racing with .probe().
>
> I'm not sure if this happens in practice, though, but also I'm not sure
> whether or not that's used by USB. =A0Moreover, even if that doesn't happ=
en
> right now, it may start to happen at one point.

It should be used by USB, for example, uvcvideo driver has enabled
auto suspend already:

    - rmmod uvcvideo

    - usb video class device auto suspended

    - modprobe uvcvideo       #driver_probe_device()


thanks,
-- =

Ming Lei
