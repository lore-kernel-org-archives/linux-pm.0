From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] the generic thermal layer enhancement
Date: Wed, 30 May 2012 13:50:35 +0100
Message-ID: <20120530125035.GA17379@srcf.ucam.org>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1338367742.1472.128.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amit.kachhap@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 30, 2012 at 04:49:02PM +0800, Zhang Rui wrote:

> G1. supporting multiple cooling states for active cooling devices.

Sounds fine.

> G2. introduce cooling states range for a certain trip point

Again, no problem here.

> G3. kernel thermal passive cooling algorithm

>     Currently, tc1 and tc2 are hard requirements for kernel passive
>     cooling. But non-ACPI platforms do not have this information
>     (please correct me if I'm wrong).
>     Say, for the patches here
>     http://marc.info/?l=linux-acpi&m=133681581305341&w=2
>     They just want to slow down the processor when current temperature
>     is higher than the trip point and speed up the processor when the
>     temperature is lower than the trip point.

Just slowing the CPU down above a certain temperature is a pretty awful 
approach to passive cooling. You want to maximise performance while 
staying within your thermal envelope, so you need a more advanced 
approach. The existing algorithm provides a generic mechanism for 
balancing performance and thermal output, with the only requirement 
being that the platform provide constants that represent the heating and 
cooling properties of the system.

I don't fundamentally object to adding support for platform-specific 
passive formulae, but I'd like an explanation for how they're better 
than the existing one.

> G4. Multiple passive trip points

It would be good to have an explanation of the use case here. If it's 
acceptable for the device to be at the lower passive trip point, why are 
we slowing it down at all?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
