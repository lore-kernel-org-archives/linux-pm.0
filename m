From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Fri, 22 Jun 2018 10:14:10 +0800
Message-ID: <20180622021410.GA30305@sandybridge-desktop>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
 <20180621191443.GB14623@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180621191443.GB14623@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,
On Thu, Jun 21, 2018 at 09:14:43PM +0200, Pavel Machek wrote:
> On Thu 2018-06-21 14:08:40, Rafael J. Wysocki wrote:
> > On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > Hi!
> > >
> > >> As security becomes more and more important, we add the in-kernel
> > >> encryption support for hibernation.
> > > ...
> > >> There was a discussion on the mailing list on whether this key should
> > >> be derived in kernel or in user space. And it turns out to be generating
> > >> the key by user space is more acceptable[1]. So this patch set is divided
> > >> into two parts:
> > >> 1. The hibernation snapshot encryption in kernel space,
> > >> 2. the key derivation implementation in user space.
> > >
> > > uswsusp was created so that this kind of stuff could be kept in
> > > userspace. You get graphical progress bar (etc) too. As you already
> > > have userspace component for key derivation, I see no advantages to
> > > uswsusp.
> > >
> > > If you have some, please explain.
> > 
> > Not having to transfer plain text kernel memory to user space is one
> > IMO.
> 
> Well, AFAICT in this case userland has the key and encrypted data are
> on disk. That does not seem to be improvement.
> 
uswsusp needs to read the snapshot from kernel first, while
do encryption in kernel directly would reduce the IO. Besides,
the kernel memory content is protect from been read from
user space from first place, although finally they are
encrypted on the disk.

Best,
Yu
