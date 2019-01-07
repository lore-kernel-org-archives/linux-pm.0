From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Date: Tue, 8 Jan 2019 01:37:43 +0800
Message-ID: <20190107173743.GC4210@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190106181026.GA15256@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190106181026.GA15256@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Pavel, 

Thanks for your review!

On Sun, Jan 06, 2019 at 07:10:27PM +0100, Pavel Machek wrote:
> Hi!
> 
> > This patchset is the implementation of encryption and authentication
> > for hibernate snapshot image. The image will be encrypted by AES and
> > authenticated by HMAC.
> 
> Ok, so you encrypt. 
>

Yes, encryption and authentication. 
 
> > The hibernate function can be used to snapshot memory pages to an image,
> > then kernel restores the image to memory space in a appropriate time.
> > There have secrets in snapshot image and cracker may modifies it for
> > hacking system. Encryption and authentication of snapshot image can protect
> > the system.
> > 
> > Hibernate function requests the master key through key retention service.
> > The snapshot master key can be a trusted key or a user defined key. The
> > name of snapshot master key is fixed to "swsusp-kmk". User should loads
> > swsusp-kmk to kernel by keyctl tool before the hibernation resume.
> > e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume
> 
> But if userspace has a key, encryption is useless against root.
>

Yes, but this concern is not only for hibernation encryption. This patch
set does not provide solution against this concern.

The purpose of this patch set is to encrypt and authenticate hibernate
snapshot image in kernel space. It also requests key through keyring
mechanism. Which means that we can easy to adapt to new key type from
keyring in the future. 

Currently TPM trusted key or user defined key types are not against
root. Even using the TPM trusted key, it still can be unsealed by root
before the PCRs be capped (unless we capped PCRs in kernel). 

My solution for keeping the secret by kernel is the EFI secure key type:
	https://lkml.org/lkml/2018/8/5/31

But the EFI boot variable doesn't design for keeping secret, so Windows
and OEM/ODM do not use boot variable to keep secret. So this idea can
not be accepted. We must think other key type against root. 

> > The TPM trusted key type is preferred to be the master key. But user
> > defined key can also be used for testing or when the platform doesn't
> > have TPM. User must be aware that the security of user key relies on
> > user space. If the root account be compromised, then the user key will
> > easy to be grabbed.
> 
> In the TPM case, does userland have access to the key? 
>

In the TPM case, userland can only touch the sealed key blob. So userland
doesn't know the real secret. But it has risk that root unseals the key
before PCRs be capped.
    
> Please explain your security goals.
> 

My security goals:

- Encrypt and authicate hibernate snapshot image in kernel space. Userspace
  can only touch an encrypted and signed snapshot image.

- The code of encryption are in kernel. They will be signed and verify with
  kernel binary when secure boot enabled. It's better than using
  unauthenticated userspace code at runtime.

- Using TPM trusted key, at least the security of hibernation aligns with
  other subsystem. e.g. EVM. 

- Using keyring as the key source of hibernation. Then we can easy to
  adapt to new key type against root be compromised. 

> 
> > Lee, Chun-Yi (5):
> >   PM / hibernate: Create snapshot keys handler
> >   PM / hibernate: Generate and verify signature for snapshot image
> >   PM / hibernate: Encrypt snapshot image
> >   PM / hibernate: Erase the snapshot master key in snapshot pages
> >   PM / hibernate: An option to request that snapshot image must be
> >     authenticated
> > 

Thanks a lot!
Joey Lee
