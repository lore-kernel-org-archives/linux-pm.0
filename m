From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/20] Introduce new cpufreq helper macros
Date: Tue, 15 Apr 2014 11:31:49 +0530
Message-ID: <CAKohpomB5fSDS4inMrxfE57r+N22yVJskgK+wUXL8UGcXqdZow@mail.gmail.com>
References: <534C4E14.3080509@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <534C4E14.3080509@semaphore.gr>
Sender: linux-doc-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "David S. Miller" <davem@davemloft.net>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15 April 2014 02:37, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> This patch set introduces two freq_table helper macros which
> can be used for iteration over cpufreq_frequency_table and
> makes the necessary changes to cpufreq core and drivers that
> use such an iteration procedure.
>
> The motivation was a usage of common procedure to iterate over
> cpufreq_frequency_table across all drivers and cpufreq core.
>
> This was tested on a x86_64 platform.
> Patches 4-17 compiled successfully but unfortunately I was not
> able to compile test patches 18-20.

Mostly okay, just some Nitpicks..

Please rearrange your patches this way:
- First patch just adds the wrappers
- Second one makes changes to drivers/cpufreq/, i.e. include all core
and drivers
  changes into a single patch here as the logs are exactly same.
- Then framework by framework, as we may need Acks/Reviews by them
  separately..

So, probably just 5-7 would do.
