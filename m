From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Date: Wed, 9 Jan 2019 10:47:42 -0800
Message-ID: <CALCETrUprUNLci+tQ+P7PV3PvS4ruxz5jrGH3R_FDV4SFp3r9g@mail.gmail.com>
References: <20190103143227.9138-1-jlee@suse.com> <20190106181026.GA15256@amd>
 <20190107173743.GC4210@linux-l9pv.suse> <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
 <20190109163958.GG9503@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109163958.GG9503@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>, Pavel Machek <pavel@ucw.cz>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 9, 2019 at 8:40 AM joeyli <jlee@suse.com> wrote:
>
> Hi Andy,
>
> Thanks for your review!
>
> On Tue, Jan 08, 2019 at 01:41:48PM -0800, Andy Lutomirski wrote:
> > > On Jan 7, 2019, at 9:37 AM, joeyli <jlee@suse.com> wrote:
> > >
> > > Hi Pavel,
> > >
> > > Thanks for your review!
> > >
> > >> On Sun, Jan 06, 2019 at 07:10:27PM +0100, Pavel Machek wrote:
> > >> Hi!
> > >>
> > >>> This patchset is the implementation of encryption and authenticatio=
n
> > >>> for hibernate snapshot image. The image will be encrypted by AES an=
d
> > >>> authenticated by HMAC.
> > >>
> > >> Ok, so you encrypt.
> > >
> > > Yes, encryption and authentication.
> > >
> > >>> The hibernate function can be used to snapshot memory pages to an i=
mage,
> > >>> then kernel restores the image to memory space in a appropriate tim=
e.
> > >>> There have secrets in snapshot image and cracker may modifies it fo=
r
> > >>> hacking system. Encryption and authentication of snapshot image can=
 protect
> > >>> the system.
> > >>>
> > >>> Hibernate function requests the master key through key retention se=
rvice.
> > >>> The snapshot master key can be a trusted key or a user defined key.=
 The
> > >>> name of snapshot master key is fixed to "swsusp-kmk". User should l=
oads
> > >>> swsusp-kmk to kernel by keyctl tool before the hibernation resume.
> > >>> e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume
> > >>
> > >> But if userspace has a key, encryption is useless against root.
> > >
> > > Yes, but this concern is not only for hibernation encryption. This pa=
tch
> > > set does not provide solution against this concern.
> > >
> > > The purpose of this patch set is to encrypt and authenticate hibernat=
e
> > > snapshot image in kernel space. It also requests key through keyring
> > > mechanism. Which means that we can easy to adapt to new key type from
> > > keyring in the future.
> > >
> > > Currently TPM trusted key or user defined key types are not against
> > > root. Even using the TPM trusted key, it still can be unsealed by roo=
t
> > > before the PCRs be capped (unless we capped PCRs in kernel).
> > >
> > > My solution for keeping the secret by kernel is the EFI secure key ty=
pe:
> > >    https://lkml.org/lkml/2018/8/5/31
> > >
> > > But the EFI boot variable doesn't design for keeping secret, so Windo=
ws
> > > and OEM/ODM do not use boot variable to keep secret. So this idea can
> > > not be accepted. We must think other key type against root.
> > >
> > >>> The TPM trusted key type is preferred to be the master key. But use=
r
> > >>> defined key can also be used for testing or when the platform doesn=
't
> > >>> have TPM. User must be aware that the security of user key relies o=
n
> > >>> user space. If the root account be compromised, then the user key w=
ill
> > >>> easy to be grabbed.
> > >>
> > >> In the TPM case, does userland have access to the key?
> > >
> > > In the TPM case, userland can only touch the sealed key blob. So user=
land
> > > doesn't know the real secret. But it has risk that root unseals the k=
ey
> > > before PCRs be capped.
> > >
> > >> Please explain your security goals.
> > >
> > > My security goals:
> > >
> > > - Encrypt and authicate hibernate snapshot image in kernel space. Use=
rspace
> > >  can only touch an encrypted and signed snapshot image.
> >
> > Signed?
> >
> > I=E2=80=99m not entirely convinced that the keyring mechanism is what y=
ou
> > want. ISTM that there are two goals here:
> >
> > a) Encryption: it should be as hard as can reasonably be arranged to
> > extract secrets from a hibernation image.
> >
> > b) Authentication part 1: it should not be possible for someone in
> > possession of a turned-off machine to tamper with the hibernation
> > image such that the image, when booted, will leak its secrets. This
> > should protect against attackers who don=E2=80=99t know the encryption =
key.
> >
> > c) Authentication part 2: it should be to verify, to the extent
> > practical, that the image came from the same machine and was really
> > created using hibernation.  Or maybe by the same user.
> >
> > For (a) and (b), using an AE mode where the key is protected in some
> > reasonable way.  Joey, why are you using HMAC?  Please tell me you=E2=
=80=99re
> > at least doing encrypt-then-MAC.  But why not use a real AE mode like
> > AES-GCM?
>
> The reason for using HMAC is the history for development. My first patch
> set is only for hibernate authentication. Then I added encryption code on
> top of my authentication patches in last version.
>
> I am doing encrypt-then-MAC. My code ecrypts each page by AES then HMAC
> whole snapshot image. I feed encrypted data pages one by one to
> crypto_shash_update() API for calculating the hash for whole image.

...

I think you should write down a clear description of the data format.
A general problem with crypto is that the fact that it appears to work
doesn't mean it's secure at all, and it's very hard to follow the
code.  Especially in Linux using the crypto API -- code using the
crypto API tends to be mostly boilerplate.

>
> >
> >
> > I reviewed the code a bit.  Here are some thoughts:
> >

>
> > You=E2=80=99re explicitly checking that it=E2=80=99s not zero, and I do=
n=E2=80=99t see why.
> >
>
> That's because I use trampoline page to forward the key from boot
> kernel to resume kernel for next hibernation cycle. When resuming,
> the empty key means that the boot kernel didn't forward valid key
> to resume kernel. Then the key initial failed, hibernation can not
> be triggered in next cycle.
>

This seems like a poor design.  If you need some indication of "there
is no key", then implement that.  Don't use a special all-zero value
to mean something special.

>
> > the acceptable usage of trusted keys?
> >
>
> Sorry for I didn't capture the meaning of "acceptable usage". The trusted
> key already be unsealed by TPM when the key be enrolled by keyctl tool.
> So my code just extract the unsealed key data (the random number) for
> encryption.

If someone creates a trusted key that is used for asymmetric crypto or
perhaps a trusted key that is intended to be used for, say, an HMAC
key, you should not also use it to derive hibernation keys.  This is
what I mean by "acceptable usage".

>
> > You are using a non-ephemeral key and generating a fresh IV each time.
> > This is probably okay, but it=E2=80=99s needlessly fragile. Just genera=
te an
> > entirely fresh key each time, please.  You also seem to be doing
> > encrypt-and-MAC, which is not generally considered acceptable. And
>
> I have thought about using one time key before. But that means I need
> attach the key with snapshot image. Keyring API doesn't provide interface
> for other kernel subsystem to feed an encrypted key blob, so I choice
> to use non-ephemeral key that's enrolled by userland through keyctl. I
> can change to one time key if keyring subsystem allows to be modified.

I don't see what this has to do with the keyring API.  If you want a
one time key in the hibernation code, generate a one-time key in the
hibernation code and wrap the key accordingly.


>
> The encrypt-and-MAC is not acceptable? I am OK to change to other way
> just I hope that I can encrypt/decrypt page one by one for the reason
> that I just mentioned.
>
> > you=E2=80=99re not authenticating everything =E2=80=94 just the data. T=
his seems very
> > weak.
> >
>
> Is it too weak? Why?
>
> There have three parts of an snapshot image:
>         image header :: page table pages :: data pages
>
> The real data are in data pages. I thought that encrypt/hmac data pages
> can protect sensitive data in pages and also avoid those pages be arbitra=
ry
> modified. IMHO arbitrary modifing page table pages is easy to cause
> resume kernel crashed.

First you need to define *why* you're authenticating anything.  But I
would guess that under any reasonable security model, a tampered-with
image should not be able to take over the system.  And, if you don't
protect the page tables, then it's probably quite easy to tamper with
an image such that the HMAC is unaffected but the image takes over the
system.

I think that, if this series goes in at all, it should authenticate
the *entire* image.  (But you still have to define what "authentic"
even means.  "It passed an HMAC check" is not a good definition.)

>
> > Can you explain the trampoline?  It looks like you are using it to
> > tell the resumed kernel that it was tampered with. If so, NAK to that.
> > Just abort.
> >
>
> The main job of trampoline page is using by boot kernel to forward
> key to resume kernel for next hibernation cycle. The authorization result
> is just an add on.
>
> In resume process, the key will be loaded in early boot stage. Either in
> EFI stub (EFI secure key type, be rejected by EFI subsystem) or initrd. O=
n
> the other hand, PCRs may capped after TPM trusted key be loaded. So resum=
e
> kernel has no chance to load or unseal key again. The only way to get the
> unsealed/decrypted key is from boot kernel.
>
> The trampoline page is an empty page that it's pre-reserved in snapshot i=
mage
> when hibernation. When resuming, this trampoline page will be written by =
boot
> kernel to fill unsealed key. Then resume kernel will check the trampoline
> page to take the key. If the key is empty(zero), which means that boot
> kernel didn't forward valid key because some reasons. Either the key is
> broken (EFI key be erased) or userspace didn't enroll key to boot kernel.
> That's why I check the zero key in code.

I don't follow this at all.  After reading the code, I couldn't figure
out which stage generates the trampoline, which stage reads the
trampoline, and where there are any keys at all in the trampoline.

There are effectively three kernels:

a) The kernel that gets hibernated and generates the hibernation
image.  This kernel obviously has access to all the keying
information, although some of that information may actually be
resident on the TPM and not in memory.

b) The boot kernel that reads the hibernation image.

c) The resumed kernel.  This kernel has the same code as (a) but
possibly different PCRs.

If the encryption is going to protect anything at all, then kernel (b)
needs to have a way to get the key, which is presumably done using the
TPM, since it's not obvious to me that there's any other credible way
to do it.  (A passphrase could also make sense, but then you'd just
put the hibernation image on a dm-crypt volume and the problem is
solved.)  Kernel (c) shouldn't need to do any crypto, since, by the
time any code in kernel (c) executes at all, you've already decrypted
everything and you've effectively committed to trusting the
hibernation image.

If something goes wrong when you hibernate a second time, this means
that the first hibernation screwed up and corrupted something, e.g.
PCRs.  That should be fixed independently of this series IMO.

So I still don't get what the trampoline is for.
