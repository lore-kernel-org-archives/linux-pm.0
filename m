From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
Date: Tue, 2 Oct 2018 21:36:05 +0200
Message-ID: <CAG48ez3=mpJu8gaAZ4-N3pnB-E7d0WkKG8iyD1J=QL4eLwftSQ@mail.gmail.com>
References: <20180912142337.21955-1-jlee@suse.com> <20180912142337.21955-2-jlee@suse.com>
 <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com> <20181002075243.GB6040@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002075243.GB6040@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli <jlee@suse.com>, Andy Lutomirski <luto@kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: joeyli.kernel@gmail.com, rjw@rjwysocki.net, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, yu.c.chen@intel.com, oneukum@suse.com, Yu Chen <yu.chen.surf@gmail.com>, ggherdovich@suse.cz
List-Id: linux-pm@vger.kernel.org

+Andy for opinions on things in write handlers
+Mimi Zohar as EVM maintainer

On Tue, Oct 2, 2018 at 9:55 AM joeyli <jlee@suse.com> wrote:
> On Thu, Sep 13, 2018 at 04:31:18PM +0200, Jann Horn wrote:
> > On Thu, Sep 13, 2018 at 4:08 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > This patch adds a snapshot keys handler for using the key retention
> > > service api to create keys for snapshot image encryption and
> > > authentication.
> [...snip]
> > > +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > +                             const char *buf, size_t n)
> > > +{
> > > +       int error = 0;
> > > +       char *p;
> > > +       int len;
> > > +
> > > +       if (!capable(CAP_SYS_ADMIN))
> > > +               return -EPERM;
> >
> > This is wrong, you can't use capable() in a write handler. You'd have
> > to use file_ns_capable(), and I think sysfs currently doesn't give you
> > a pointer to the struct file.
> > If you want to do this in a write handler, you'll have to either get
> > rid of this check or plumb through the cred struct pointer.
> > Alternatively, you could use some interface that doesn't go through a
> > write handler.
> >
>
> Thank you for point out this problem.
>
> Actually the evm_write_key() is the example for my code. The
> difference is that evm creates interface file on securityfs, but my
> implementation is on sysfs:
>
> security/integrity/evm/evm_secfs.c
>
> static ssize_t evm_write_key(struct file *file, const char __user *buf,
>                              size_t count, loff_t *ppos)
> {
>         int i, ret;
>
>         if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP))
>                 return -EPERM;
> ...
>
> On the other hand, the writing handler of /sys/power/wake_lock also
> uses capable() to check the CAP_BLOCK_SUSPEND capability:
>
> kernel/power/main.c
> static ssize_t wake_lock_store(struct kobject *kobj,
>                                struct kobj_attribute *attr,
>                                const char *buf, size_t n)
> {
>         int error = pm_wake_lock(buf);
>         return error ? error : n;
> }
> power_attr(wake_lock);
>
> kernel/power/wakelock.c
> int pm_wake_lock(const char *buf)
> {
> ...
>         if (!capable(CAP_BLOCK_SUSPEND))
>                 return -EPERM;
> ...
>
>
> So I confused for when can capable() be used in sysfs interface? Is
> capable() only allowed in reading handler? Why the writing handler
> of securityfs can use capable()?

They can't, they're all wrong. :P All of these capable() checks in
write handlers have to be assumed to be ineffective. But it's not a
big deal because you still need UID 0 to access these files.

> > > +static int user_key_init(void)
> > > +{
> > > +       struct user_key_payload *ukp;
> > > +       struct key *key;
> > > +       int err = 0;
> > > +
> > > +       pr_debug("%s\n", __func__);
> > > +
> > > +       /* find out swsusp-key */
> > > +       key = request_key(&key_type_user, skey.key_name, NULL);
> >
> > request_key() looks at current's keyring. That shouldn't happen in a
> > write handler.
> >
>
> The evm_write_key() also uses request_key() but it's on securityfs. Should
> I move my sysfs interface to securityfs?

I don't think you should be doing this in the context of any
filesystem. If EVM does that, EVM is doing it wrong.

> > > +       if (IS_ERR(key)) {
> > > +               pr_err("Request key error: %ld\n", PTR_ERR(key));
> > > +               err = PTR_ERR(key);
> > > +               return err;
> > > +       }
> > > +
> > > +       down_write(&key->sem);
> > > +       ukp = user_key_payload_locked(key);
> > > +       if (!ukp) {
> > > +               /* key was revoked before we acquired its semaphore */
> > > +               err = -EKEYREVOKED;
> > > +               goto key_invalid;
> > > +       }
> > > +       if (invalid_key(ukp->data, ukp->datalen)) {
> > > +               err = -EINVAL;
> > > +               goto key_invalid;
> > > +       }
> > > +       skey.key_len = ukp->datalen;
> > > +       memcpy(skey.key, ukp->data, ukp->datalen);
> > > +       /* burn the original key contents */
> > > +       memzero_explicit(ukp->data, ukp->datalen);
> >
> > You just zero out the contents of the supplied key? That seems very
> > unidiomatic for the keys subsystem, and makes me wonder why you're
> > using the keys subsystem for this in the first place. It doesn't look
> > like normal use of the keys subsystem.
> >
>
> Because I want that only one decrypted key in kernel memory. Then hibernation
> can handle the key more easy. In evm_init_key(), it also burned the key
> contents after evm key be initialled:
>
> security/integrity/evm/evm_crypto.c
> int evm_init_key(void)
> {
> [...snip]
>         /* burn the original key contents */
>         memset(ekp->decrypted_data, 0, ekp->decrypted_datalen);
>         up_read(&evm_key->sem);
>         key_put(evm_key);
>         return rc;
> }
>
> The keys subsystem already handles the interactive with userland and TPM.
> That's the reason for using keys subsystem in hibernation.

How do you guarantee that the user is allowed to overwrite that key? I
don't understand the keys subsystem very well - could this be a key on
the trusted keyring, or something like that?
