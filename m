From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Subject: Re: [PATCH v4 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
Date: Wed, 20 Aug 2014 15:05:13 +0300
Message-ID: <20140820120513.GA76825@sandfort.unics.fi>
References: <1408100430-29461-1-git-send-email-mperttunen@nvidia.com>
 <20140819140955.GA50475@sandfort.unics.fi>
 <CAC-25o-bLeDYpTgPy5UOvBGJ7k7HJkBM3YcCRPSZHBkyxugULA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAC-25o-bLeDYpTgPy5UOvBGJ7k7HJkBM3YcCRPSZHBkyxugULA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "edubezval@gmail.com" <edubezval@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Juha-Matti Tilli <jtilli@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, LKML <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 19, 2014 at 10:33:13AM -0400, edubezval@gmail.com wrote:
> > The temperature readings look sane and do vary with load, but I think
> > they're a bit different than what NVIDIA's internal soc_therm driver
> =

> hmm..  Based on a single sample?

Now I have more than one sample. I wrote a test program to load the
CONFIG2 registers with the values NVIDIA's internal driver sets and also
with the values the patch sets. The difference on my development board
is between 3 and 4 degrees C, with the patch giving hotter readings than
the downstream driver. This is repeatable; I have made about ten test
runs and every time I can observe the difference.

As a matter of fact, I believe there are two other bugs in the patch in
addition to the --i error handling bug.

Firstly, shifted_ft seems to be read from the wrong register. It should
be read from FUSE_TSENSOR8_CALIB (and it's read from there in the
downstream driver), but Mikko's code erroneously reads it from
FUSE_SPARE_REALIGNMENT_REG_0. So, the downstream code has fields like
this:
FUSE_TSENSOR8_CALIB =3D zero-padding | shifted_ft | base_ft | base_cp
FUSE_SPARE_REALIGNMENT_REG_0 =3D zero-padding | shifted_cp

While the patch has the fields like that:
FUSE_TSENSOR8_CALIB =3D zero-padding | base_ft | base_cp
FUSE_SPARE_REALIGNMENT_REG_0 =3D zero-padding | shifted_ft | zero-padding =
=A0shifted_cp

Note the illogical zero-padding in the middle of
FUSE_SPARE_REALIGNMENT_REG_0 according to the patch.

As a result of that, the patch reads shifted_ft as 0 on my system even
though it should read -2, which is the value the downstream driver
reads. This also suggests that the patch is reading the incorrect
location as it gets all zeroes. This is the major reason for the
differing temperature readings between the downstream code and this
driver.

Secondly, .tsample_ate should be 480, not 481.

I communicated a patch to fix these issues to Mikko; he'll surely send a
version 5 of the patch with these issues fixed back to these mailing
lists.

As Mikko already noticed, yet another difference is that
div64_s64_precise is used in the downstream code instead of div_s64. I'm
not sure if that should be included in the code: it would mean higher
precision, but it would make the code more complicated. The difference
between div64_s64_precise and div_s64 is anyway small so either way is
fine with me.

Other than these issues, the code has been both tested by me and
reviewed by me and in my opinion it seems to have good code clarity and
be a good addition to the kernel, once the --i bug, the .tsample_ate bug
and the shifted_ft bug are fixed.
