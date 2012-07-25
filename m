From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [linux-pm] [PATCH 50/52] Thermal: Make Thermal trip points
	writeable
Date: Wed, 25 Jul 2012 11:15:59 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5916B222@BGSMSX101.gar.corp.intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
	<c56f5c0342dfee11a1a13d2f5bb7618de5b17590.1343187618.git.len.brown@intel.com>
 <201207251313.11061.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201207251313.11061.rjw@sisk.pl>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Durgadoss R <dugardoss.r@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,


> -----Original Message-----
> From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-
> bounces@lists.linux-foundation.org] On Behalf Of Rafael J. Wysocki
> Sent: Wednesday, July 25, 2012 4:43 PM
> To: Len Brown; Zhang, Rui
> Cc: linux-acpi@vger.kernel.org; linux-pm@lists.linux-foundation.org; Durgadoss
> R; linux-kernel@vger.kernel.org; Brown, Len
> Subject: Re: [linux-pm] [PATCH 50/52] Thermal: Make Thermal trip points
> writeable
> 
> On Wednesday, July 25, 2012, Len Brown wrote:
> > From: Durgadoss R <dugardoss.r@intel.com>
> >
> > Some of the thermal drivers using the Generic Thermal Framework
> > require (all/some) trip points to be writeable. This patch makes
> > the trip point temperatures writeable on a per-trip point basis,
> > and modifies the required function call in thermal.c. This patch
> > also updates the Documentation to reflect the new change.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> 
> There was a broken build report related to this patch (or a previous version
> of it):
> 
> http://marc.info/?l=linux-kernel&m=134294496105083&w=2
> 
> Do I think correctly that it has been fixed already?

Yes you are right. It has been fixed in this patch.

Thanks,
Durga
