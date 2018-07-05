From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Fri, 6 Jul 2018 00:16:37 +0800
Message-ID: <20180705161637.GK3628@linux-l9pv.suse>
References: <cover.1529486870.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1529486870.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Chen Yu, 

On Wed, Jun 20, 2018 at 05:39:37PM +0800, Chen Yu wrote:
> Hi,
> As security becomes more and more important, we add the in-kernel
> encryption support for hibernation.
> 
> This prototype is a trial version to implement the hibernation
> encryption in the kernel, so that the users do not have to rely
> on third-party tools to encrypt the hibernation image. The only
> dependency on user space is that, the user space should provide
> a valid key derived from passphrase to the kernel for image encryption.
> 
> There was a discussion on the mailing list on whether this key should
> be derived in kernel or in user space. And it turns out to be generating
> the key by user space is more acceptable[1]. So this patch set is divided
> into two parts:
> 1. The hibernation snapshot encryption in kernel space,
> 2. the key derivation implementation in user space.
> 
> Please refer to each patch for detail, and feel free to comment on
> this, thanks.
> 
> [1] https://www.spinics.net/lists/linux-crypto/msg33145.html
> 
> Chen Yu (3):
>   PM / Hibernate: Add helper functions for hibernation encryption
>   PM / Hibernate: Encrypt the snapshot pages before submitted to the
>     block device
>   tools: create power/crypto utility
>

I am trying this patch set.

Could you please tell me how to test the user space crypto utility with
systemd's hibernation module? 

I have a question about the salt. If the salt is saved in image header,
does that mean that kernel needs to read the image header before user
space crypto utility be launched? Otherwise user space can not get
the salt to produce key? I a bit confused about the resume process.

Thanks
Joey Lee 
