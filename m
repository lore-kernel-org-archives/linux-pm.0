From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/5] power: domain: add pm_genpd_exit
Date: Wed, 9 Dec 2015 10:54:57 +0000
Message-ID: <20151209105457.GG8644@n2100.arm.linux.org.uk>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
 <1449251148-19344-2-git-send-email-eric@anholt.net>
 <5665599A.4060509@nvidia.com>
 <7h8u54lqbv.fsf@deeprootsystems.com>
 <20151209104752.GB1036@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151209104752.GB1036@omega>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 09, 2015 at 11:47:58AM +0100, Alexander Aring wrote:
> Example: the error case is while probing, how we react on a -EBUSY there
> "in an error case" -> simple ignore it? But then nobody see that the use
> of this function is wrong.

The proper way to deal with functionality that can only be registered
but never removed is to report the error, but never fail during probing,
and never allow removal (empty removal function.)

If you return a failure code during probe, you end up in an inconsistent
situation where you have facilities registered, but resources that those
facilities require will be undone when probe() returns a failure, and
that can potentially lead to kernel oops or scribbling over someone
elses device or memory.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
