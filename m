From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [RFC][PATCH 1/2] PM / Runtime: Support for generic
 I/O power domains
Date: Wed, 4 May 2011 17:43:19 +0900
Message-ID: <BANLkTimbUQ9-U9yPkCspf=dL0JfyXqbSng__26290.5660122216$1304498773$gmane$org@mail.gmail.com>
References: <201104290154.12966.rjw@sisk.pl> <201104290154.56145.rjw@sisk.pl>
	<BANLkTinsKELoZAZgu0wzT_fQc1kWnd-EVg@mail.gmail.com>
	<201104292211.03702.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104292211.03702.rjw@sisk.pl>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 30, 2011 at 5:11 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Well, not really. =A0There are a few things to consider.
>
> First, in general, there may be devices that have a real parent and belong
> to a power domain at the same time, so we can't "steal" the parent
> pointers from them.

Ah. right we only have one parent per device. Ok, setting a power
domain as a device's parent is not going to work for some devices.


However, I have some other questions.

1. pm_genpd_runtime_suspend and pm_genpd_runtime_resume are opened to
outside (not static and "extern"ed). Are devices supposed to call
pm_genpd_runtime_* directly? Shouldn't they be hidden so that devices
are forced to turn on/off power domains with runtime_pm framework
only? Is there any reason to expose them?

2.  If we can assure that related clocks are not turned on when a
power domain is shutting down, it'd be nice.
I guess it would be sufficient to let it "WARN" at
gov->power_down_ok(). Is it the intention of governor?


Thank you! I also think this is going to help us a lot, too :)

- MyungJoo
-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
