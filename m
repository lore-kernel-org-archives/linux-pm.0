From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Date: Thu, 14 Feb 2019 18:31:54 +0100
Message-ID: <CAJZ5v0gHvZwUuhOepgsUZ3OZZ4X4iGTA3LXOwMi3SYVj7F=iYA@mail.gmail.com>
References: <20190213122105.14270-1-e.velu@criteo.com> <ae38f70b-f352-8567-2dac-5f6c7723a668@criteo.com>
 <CAJZ5v0geHMDMLqg98BZEGLjNrSRy3juB9y54ots357wVeK-shQ@mail.gmail.com> <8158d558-bbcd-fabe-6c8a-8de840807dc0@criteo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8158d558-bbcd-fabe-6c8a-8de840807dc0@criteo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erwan Velu <e.velu@criteo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Erwan Velu <erwanaliasr1@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 14, 2019 at 5:42 PM Erwan Velu <e.velu@criteo.com> wrote:
>
>
> Le 14/02/2019 à 11:22, Rafael J. Wysocki a écrit :
> > I've queued it up with some manual changes.  No need to update.
>
> As this could help troubleshooting platforms and as some commits like
> the PSS one on Proliant servers were backported to stable, I would
> surely make sense to backport it to the other stable.
>
> I know this is only a trivial print patch but as my initial issue
> started with some of the 4.14 serie, it could be nice to have it too.

You can always request -stable to pick up a patch once it's got to the mainline.

I'm not going to mark it as -stable material, though, as it is not a
fix strictly speaking.
