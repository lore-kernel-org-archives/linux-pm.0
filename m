From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Power management and ACPI updates for v4.3-rc1
Date: Wed, 2 Sep 2015 16:39:14 +1000
Message-ID: <20150902163914.34988848@canb.auug.org.au>
References: <CAJZ5v0j71Zwe8H7Lais82+N97-eF==Yjf4SPnb40kdyBLu2THw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j71Zwe8H7Lais82+N97-eF==Yjf4SPnb40kdyBLu2THw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

On Wed, 2 Sep 2015 01:41:11 +0200 "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> Hi Linus,
> 
> Please pull from
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm+acpi-4.3-rc1
> 
> to receive power management and ACPI material for v4.3-rc1 with
> top-most commit e625ccec1fa6c24620f38fd72d5b2fd62230ad2b
> 
>  Merge branches 'pm-tools' and 'powercap'
> 
> on top of commit 64291f7db5bd8150a74ad2036f1037e6a0428df2
> 
>  Linux 4.2

So there are about 20 commits in here that have not been in linux-next
(unless they have bee rebased) and about 10 of those will be in today's
linux-next.  Not judging, just notiing.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
