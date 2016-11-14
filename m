From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 6ea8c546f3655 breaks thermal management on thinkpad x60 and t40p
Date: Mon, 14 Nov 2016 20:54:55 +0100
Message-ID: <CAJZ5v0i7KDDuQX0itjnuEpHCpb+JdOQVHNzzpv_v4BwwwbW2-Q@mail.gmail.com>
References: <20161104083849.GA32688@amd> <20161104085830.GA4089@amd>
 <1478268311.26953.17.camel@intel.com> <20161104204439.GA2581@amd>
 <20161104221600.GA7007@amd> <1478301649.7947.3.camel@intel.com>
 <20161105133719.GA3933@amd> <1478354115.19557.17.camel@intel.com> <20161114190343.GB20770@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114190343.GB20770@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Robert Moore <Robert.Moore@intel.com>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, acpi_power-processor@kernel-bugs.osdl.org, rankincj@yahoo.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Lv <lv.zheng@intel.com>, regressions@leemhuis.info, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 14, 2016 at 8:03 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> Bisection was not fun, but I've got the result:
>
> # first bad commit: [6ea8c546f3655a81f82672f24b66dad6095bdd07] ACPICA:
> FADT support cleanup

Bob?

> I've reverted the patch on top of 4.9-rc4, and thermal management now works.
>
> More details are in https://bugzilla.kernel.org/show_bug.cgi?id=187311
>
> As this breaks thermal management on both thinkpad X60 and T40p, can
> I ask for a revert?
>
> If you have other ideas, I can test them, but as this is just a
> cleanup, it can wait for 4.10...

Right.

Besides, we're in the -rc6 time frame now, so I'll queue up a revert.

Thanks,
Rafael
