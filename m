From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Fri, 6 Jul 2018 21:42:27 +0800
Message-ID: <20180706134226.GA9631@sandybridge-desktop>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180705161637.GK3628@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705161637.GK3628@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sorry for late reply.
On Fri, Jul 06, 2018 at 12:16:37AM +0800, joeyli wrote:
> Hi Chen Yu, 
> 
> On Wed, Jun 20, 2018 at 05:39:37PM +0800, Chen Yu wrote:
> > Hi,
> > As security becomes more and more important, we add the in-kernel
> > encryption support for hibernation.
> > 
> > This prototype is a trial version to implement the hibernation
> > encryption in the kernel, so that the users do not have to rely
> > on third-party tools to encrypt the hibernation image. The only
> > dependency on user space is that, the user space should provide
> > a valid key derived from passphrase to the kernel for image encryption.
> > 
> > There was a discussion on the mailing list on whether this key should
> > be derived in kernel or in user space. And it turns out to be generating
> > the key by user space is more acceptable[1]. So this patch set is divided
> > into two parts:
> > 1. The hibernation snapshot encryption in kernel space,
> > 2. the key derivation implementation in user space.
> > 
> > Please refer to each patch for detail, and feel free to comment on
> > this, thanks.
> > 
> > [1] https://www.spinics.net/lists/linux-crypto/msg33145.html
> > 
> > Chen Yu (3):
> >   PM / Hibernate: Add helper functions for hibernation encryption
> >   PM / Hibernate: Encrypt the snapshot pages before submitted to the
> >     block device
> >   tools: create power/crypto utility
> >
> 
> I am trying this patch set.
> 
> Could you please tell me how to test the user space crypto utility with
> systemd's hibernation module? 
> 
Usage:
1. install the kernel module:
   modprobe crypto_hibernation
2. run the tool to generate the key from
   user provided passphrase:
   ./crypto_hibernate
3. launch the hibernation process:
   echo disk > /sys/power/state
4. The initrd launches cryto_hibernate
   to read previous salt from kernel and
   probe the user passphrase and generate the same key:
   ./crypto_hibernate
5. kernel uses this key to decrypt the hibernation
   snapshot.
> I have a question about the salt. If the salt is saved in image header,
> does that mean that kernel needs to read the image header before user
> space crypto utility be launched? Otherwise user space can not get
> the salt to produce key? I a bit confused about the resume process.
> 
The crypto_hibernate will first read the salt from the kernel
via ioctl(the kernel will first expose the salt for the user
in crypto_restore(), then the crypto_hibernate uses ioctl to
read it) and then uses that salt together with user provided
passphrase to generate the key, and pass that key to the kernel
for decryption.
> Thanks
> Joey Lee 
