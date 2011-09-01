From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/5] PM: Generic PM domains and device PM QoS
Date: Thu, 1 Sep 2011 17:28:20 +0200
Message-ID: <CAORVsuVJEbLRXLuQFUh3_rDf+DfNFpOhEuBr33SRKqxBos=6Bw__22750.1336289153$1314930064$gmane$org@mail.gmail.com>
References: <201108310017.03103.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108310017.03103.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael,

On Wed, Aug 31, 2011 at 12:17 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> This patchset illustrates how device PM QoS may be used along with
> PM domains in my view.
>
> Actually, it consists of two parts. =A0Namely, patches [1-3/5] seem to be
> suitable for 3.2, unless somebody hates them,
The patches [1-3/5] are ok (reviewed only) excepted some remarks I have.

> but patches [4-5/5] are
> total RFC. =A0They haven't been tested, only compiled, so the use of them
> is not encouraged (they may kill your dog or make your cat go wild, or
> do something equally nasty, so beware).
That looks like a disclaimer ;p

> Their purpose is to illustrate
> an idea that I'd like to discuss at the PM miniconference during the
> LPC.
There is some code for OMAP that dynamically updates the worst case
values for devices activation and de-activation;
cf._omap_device_activate and _omap_device_deactivate in
arch/arm/plat-omap/omap_device.c. The idea is to start with reference
figures (worst case measured on board) at boot and then update the
worst case values at runtime.
Based on the PM QoS values and the worst case latency values the next
power domains states can be determined. Unfortunately this is not
(yet) implemented.

I am wondering if the patches [4-5/5] are meant to replace the OMAP
code, which would be really nice.

>
> [1/5] - Split device PM domain data into a "base" and additional fields
> =A0 =A0 =A0 =A0(one need_restore field at the moment, but the subsequent =
patches
> =A0 =A0 =A0 =A0add more fields).
>
> [2/5] - Make runtime PM always release power.lock if power.irq_safe is se=
t.
>
> [3/5] - Add function for reading device PM QoS values safely.
>
> [4/5] - Add governor function for stopping devices.
>
> [5/5] - Add generic PM domain power off governor function.
>
> Thanks,
> Rafael
>
>

Regards,
Jean
