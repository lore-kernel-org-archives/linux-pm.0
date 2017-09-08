From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [RFT][PATCH v3 0/3] i2c: designware: Runtime PM aware system
 sleep handling
Date: Fri, 8 Sep 2017 09:34:00 +0200
Message-ID: <20170908073400.6nczopcvw7ykc7re@sig21.net>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <3958866.l2qnKDbinI@aspire.rjw.lan>
 <20170906091646.oqkcul7oxddf3yr6@sig21.net>
 <4508230.n88h0dPXoy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4508230.n88h0dPXoy@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 06, 2017 at 11:55:01AM +0200, Rafael J. Wysocki wrote:
> Well, we'll need to address the S0ix thing, but that will require some
> investigation.
> 
> Can you please open a bug entry for that at bugzilla.kernel.org
> (against Power Management -> Hibernation/Suspend) and CC it to me
> so that it doesn't fall of the radar?

The Cc of this mail is rather long, just in case someone
is interested to know I filed bug #196861 "S0ix enablement on Intel Atom"
https://bugzilla.kernel.org/show_bug.cgi?id=196861
