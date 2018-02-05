From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] Revert "cpuidle: Make drivers initialize polling state"
Date: Mon, 5 Feb 2018 16:04:45 +0200
Message-ID: <20180205140445.GH5453@intel.com>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com>
 <CAJZ5v0gj6GT=kuQvTZifktuK887_o98t4voUUK0i_90Hnw0Tpg@mail.gmail.com>
 <CAJZ5v0jKQh-YyjNjCuVqnj_oiPZ+HLLSftd4ECRJ1ZgPiroxSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jKQh-YyjNjCuVqnj_oiPZ+HLLSftd4ECRJ1ZgPiroxSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 04, 2018 at 10:18:07AM +0100, Rafael J. Wysocki wrote:
> On Sun, Feb 4, 2018 at 10:12 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Jan 22, 2018 at 5:27 PM, Ville Syrjala
> > <ville.syrjala@linux.intel.com> wrote:
> >> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >>
> >> This reverts commit 1b39e3f813b4685c7a30ae964d5529a1b0e3a286.
> >>
> >> Makes my P3 machine oops somewhere in cpuidle. I suspect
> >> CONFIG_ACPI=n may have something to do with this.
> >
> > And if you don't do CONFIG_ACPI=n, does it still oops?

Don't think I actually tried that. I can give it a whirl tonight.

I think this machine should actually have ACPI, but it inherited
the .config from a P2 machine that did not. Apparently I was too
lazy to change .config when I swapped in the "new" machine.

> >
> > Anyway, there are later changes depending on this one, so reverting it
> > won't work in general.
> >
> > Let me look deeper at this.
> 
> What's there in /sys/devices/system/cpu/cpuidle/current_driver on your
> system with the problematic commit reverted?

# cat /sys/devices/system/cpu/cpuidle/current_driver
apm_idle

-- 
Ville Syrjälä
Intel OTC
