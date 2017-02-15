From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 6/9] arm, arm64: factorize common cpu capacity default
 code
Date: Wed, 15 Feb 2017 15:35:41 -0800
Message-ID: <20170215233541.GA7403@kroah.com>
References: <20170209092525.6654-1-juri.lelli@arm.com>
 <20170209092525.6654-7-juri.lelli@arm.com>
 <20170210142857.GA18321@kroah.com>
 <CAL_JsqKLiQ2cSffadMWbN2PkqBOiA-6Mx5YVMCehVQNpy7YqrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKLiQ2cSffadMWbN2PkqBOiA-6Mx5YVMCehVQNpy7YqrQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, peterz@infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dietmar.eggemann@arm.com, Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Morten Rasmussen <morten.rasmussen@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 15, 2017 at 05:17:05PM -0600, Rob Herring wrote:
> On Fri, Feb 10, 2017 at 8:28 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> + *
> >> + * Copyright (C) 2016, ARM Ltd.
> >> + * Written by: Juri Lelli, ARM Ltd.
> >> + *
> >> + * This file is subject to the terms and conditions of the GNU General Public
> >> + * License.  See the file "COPYING" in the main directory of this archive
> >> + * for more details.
> >
> > So, v2 only?  Please be specific.  Even better yet, use a SPDX header if
> > you want to, those are always nice.
> 
> Sorry to hijack this thread, but you're recommending SPDX now? You
> seemed pretty negative on it last time it came up[1]. Or was that just
> in context of the churn of converting existing files?

It was in the context of someone trying to tell someone else to do the
work for them of converting all of the existing files to use SPDX.  I've
never refused a patch from someone adding SPDX identifiers to the
kernel, in fact, _I'm_ the only one that has ever used such an
identifier on a kernel file :)

> Personally, I like the use of SPDX tags over free form license text
> and would like to encourage it for dts files.

Sure, go ahead, I'd encourage it.

thanks,

greg k-h
