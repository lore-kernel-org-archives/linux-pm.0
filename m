From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] intel_pstate updates for v3.14-rcX
Date: Tue, 18 Feb 2014 23:27:11 +0100
Message-ID: <2705558.gK5sRhMz43@vostro.rjw.lan>
References: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com> <5303C2C2.8040605@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5303C2C2.8040605@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: linux-pm@vger.kernel.org, dirk.j.brandewie@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 18, 2014 12:29:54 PM Dirk Brandewie wrote:
> Hi Rafael,

Hi,

> On 02/12/2014 10:01 AM, dirk.brandewie@gmail.com wrote:
> > From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> >
> > Based on v3.14-rc2
> >
> > Patch 1 removes energy reporting the patch from Maurizio Lambardi
> >   intel_pstate: fix race condition in intel_pstate_init() can be dropped.
> >
> 
> Any reason why patches 2-5 did not make rc3 other than timing?
> 
> Patches 2/3 can easily wait for v3.15.x
> 
> Patches 4/5 fix bugs that are in the wild.

I asked you about them, but you didn't reply:

http://marc.info/?l=linux-pm&m=139225158531023&w=4

Again, do patches [4-5/5] depend on [2-3/5]?

If not, I can queue them up for -rc4.

Thanks,
Rafael
