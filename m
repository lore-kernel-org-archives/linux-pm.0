From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 03/12][RFC v3] x86-32/asm/power: Create stack frames in
 hibernate_asm_32.S
Date: Wed, 19 Sep 2018 16:54:41 +0800
Message-ID: <20180919085441.GA2335@chenyu-desktop>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <19aed6bb376b47f672800b4c59da07efca0f9e5a.1537275915.git.yu.c.chen@intel.com>
 <CAJZ5v0jrodgg_j_dEUDsfPibaSDouXVpt-++UQ3-k_7M41dpTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jrodgg_j_dEUDsfPibaSDouXVpt-++UQ3-k_7M41dpTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, kookoo.gu@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 19, 2018 at 10:41:16AM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 19, 2018 at 9:31 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > From: Zhimin Gu <kookoo.gu@intel.com>
> >
> > Backport
> > Commit ef0f3ed5a4ac (x86/asm/power: Create stack frames
> > in hibernate_asm_64.S)
> > and
> > Commit 4ce827b4cc58 (x86/power/64: Fix hibernation return
> > address corruption)
> >
> > And also prepare for relocated code and jump address
> > mapping.
> 
> I don't like the changelog.
> 
> It should explain the technical reasons for making the changes in the
> first place and then mention that analogous changes were made for
> 64-bit before and by which commits.
>
Ok, will change it in next version.

Thanks,
Yu
> Thanks,
> Rafael
