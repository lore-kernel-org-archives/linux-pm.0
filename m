From: Puthikorn Voravootivat <puthik@google.com>
Subject: Re: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
Date: Mon, 19 Mar 2018 23:19:00 +0000
Message-ID: <CANCcNXfOGJZR4Bn5Aj-MM9GOkpArSMG=r_hLnNqyuHhSnink4w@mail.gmail.com>
References: <20180309121549.630-1-harry.pan@intel.com> <56dfa209-0592-90f5-bd96-5e5df28abd2a@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56dfa209-0592-90f5-bd96-5e5df28abd2a@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.pan@intel.com
Cc: linux-kernel@vger.kernel.org, gs0622@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, Benson Leung <bleung@google.com>, bleung@chromium.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 19, 2018 at 4:14 PM Benson Leung <bleung@google.com> wrote:

> +puthik@google.com

> On 03/09/2018 04:15 AM, Harry Pan wrote:
> > Cannon Lake microarchitecture is similar to Kaby Lake in terms of
> > RAPL, this patch enables CNL RAPL support.
> >
> > Signed-off-by: Harry Pan <harry.pan@intel.com>
Tested-by: Puthikorn Voravootivat <puthik@chromium.org>
> > ---
> >  drivers/powercap/intel_rapl.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/powercap/intel_rapl.c
b/drivers/powercap/intel_rapl.c
> > index 35636e1d8a3d..295d8dcba48c 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -1162,6 +1162,7 @@ static const struct x86_cpu_id rapl_ids[]
__initconst = {
> >       RAPL_CPU(INTEL_FAM6_SKYLAKE_X,          rapl_defaults_hsw_server),
> >       RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,    rapl_defaults_core),
> >       RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,   rapl_defaults_core),
> > +     RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,  rapl_defaults_core),
> >
> >       RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,   rapl_defaults_byt),
> >       RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,       rapl_defaults_cht),
> >

> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
