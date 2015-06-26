From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with CPUIDLE_FLAG_TIMER_STOP set in periodic mode
Date: Fri, 26 Jun 2015 16:23:57 +0200
Message-ID: <2128915.HHL0NLglLy@vostro.rjw.lan>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com> <CAJZ5v0hiKVN7Nvc4w3BP9uWmvdUkX6T+DUGh6OSZWPTrpwcyjA@mail.gmail.com> <558B7715.1060802@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558B7715.1060802@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, shreyas@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Thursday, June 25, 2015 09:05:49 AM Preeti U Murthy wrote:
> On 06/25/2015 05:36 AM, Rafael J. Wysocki wrote:
> > On Thu, Jun 25, 2015 at 12:06 AM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> >> On Wed, 2015-06-24 at 15:50 +0200, Rafael J. Wysocki wrote:
> >>> 4.2 material I suppose?
> >>
> >> And stable. Without this, if you configure without TICK_ONESHOT, the
> >> machine will hang.
> > 
> > OK, which -stable?  All of them or any specific series?
> 
> This needs to go into stable/linux-3.19.y,
> stable/linux-4.0.y, stable/linux-4.1.y.

So essentially 3.19+.  OK, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
