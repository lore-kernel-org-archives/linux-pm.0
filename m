From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
Date: Thu, 13 Sep 2018 16:31:18 +0200
Message-ID: <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com>
References: <20180912142337.21955-1-jlee@suse.com> <20180912142337.21955-2-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912142337.21955-2-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joeyli.kernel@gmail.com
Cc: rjw@rjwysocki.net, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, joeyli <jlee@suse.com>, rafael.j.wysocki@intel.com, yu.c.chen@intel.com, oneukum@suse.com, yu.chen.surf@gmail.com, David Howells <dhowells@redhat.com>, ggherdovich@suse.cz, keyrings@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

+cc keyrings list

On Thu, Sep 13, 2018 at 4:08 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> This patch adds a snapshot keys handler for using the key retention
> service api to create keys for snapshot image encryption and
> authentication.
>
> This handler uses TPM trusted key as the snapshot master key, and the
> encryption key and authentication key are derived from the snapshot
> key. The user defined key can also be used as the snapshot master key
> , but user must be aware that the security of user key relies on user
> space.
>
> The name of snapshot key is fixed to "swsusp-kmk". User should use
> the keyctl tool to load the key blob to root's user keyring. e.g.
>
>  # /bin/keyctl add trusted swsusp-kmk "load `cat swsusp-kmk.blob`" @u
>
> or create a new user key. e.g.
>
>  # /bin/keyctl add user swsusp-kmk password @u
>
> Then the disk_kmk sysfs file can be used to trigger the initialization
> of snapshot key:
>
>  # echo 1 > /sys/power/disk_kmk
>
> After the initialization be triggered, the secret in the payload of
> swsusp-key will be copied by hibernation and be erased. Then user can
> use keyctl to remove swsusp-kmk key from root's keyring.
>
> If user does not trigger the initialization by disk_kmk file after
> swsusp-kmk be loaded to kernel. Then the snapshot key will be
> initialled when hibernation be triggered.
[...]
> +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> +                             const char *buf, size_t n)
> +{
> +       int error = 0;
> +       char *p;
> +       int len;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;

This is wrong, you can't use capable() in a write handler. You'd have
to use file_ns_capable(), and I think sysfs currently doesn't give you
a pointer to the struct file.
If you want to do this in a write handler, you'll have to either get
rid of this check or plumb through the cred struct pointer.
Alternatively, you could use some interface that doesn't go through a
write handler.

> +       p = memchr(buf, '\n', n);
> +       len = p ? p - buf : n;
> +       if (strncmp(buf, "1", len))
> +               return -EINVAL;
> +
> +       error = snapshot_key_init();
> +
> +       return error ? error : n;
> +}
> +
[...]
> +
> +static int user_key_init(void)
> +{
> +       struct user_key_payload *ukp;
> +       struct key *key;
> +       int err = 0;
> +
> +       pr_debug("%s\n", __func__);
> +
> +       /* find out swsusp-key */
> +       key = request_key(&key_type_user, skey.key_name, NULL);

request_key() looks at current's keyring. That shouldn't happen in a
write handler.

> +       if (IS_ERR(key)) {
> +               pr_err("Request key error: %ld\n", PTR_ERR(key));
> +               err = PTR_ERR(key);
> +               return err;
> +       }
> +
> +       down_write(&key->sem);
> +       ukp = user_key_payload_locked(key);
> +       if (!ukp) {
> +               /* key was revoked before we acquired its semaphore */
> +               err = -EKEYREVOKED;
> +               goto key_invalid;
> +       }
> +       if (invalid_key(ukp->data, ukp->datalen)) {
> +               err = -EINVAL;
> +               goto key_invalid;
> +       }
> +       skey.key_len = ukp->datalen;
> +       memcpy(skey.key, ukp->data, ukp->datalen);
> +       /* burn the original key contents */
> +       memzero_explicit(ukp->data, ukp->datalen);

You just zero out the contents of the supplied key? That seems very
unidiomatic for the keys subsystem, and makes me wonder why you're
using the keys subsystem for this in the first place. It doesn't look
like normal use of the keys subsystem.

> +key_invalid:
> +       up_write(&key->sem);
> +       key_put(key);
> +
> +       return err;
> +}
> +
> +/* this function may sleeps */
> +int snapshot_key_init(void)
> +{
> +       int err;
> +
> +       pr_debug("%s\n", __func__);
> +
> +       if (skey.initialized)
> +               return 0;
> +
> +       hash_tfm = crypto_alloc_shash(hash_alg, 0, CRYPTO_ALG_ASYNC);
> +       if (IS_ERR(hash_tfm)) {
> +               pr_err("Can't allocate %s transform: %ld\n",
> +                       hash_alg, PTR_ERR(hash_tfm));
> +               return PTR_ERR(hash_tfm);
> +       }
> +
> +       err = trusted_key_init();
> +       if (err)
> +               err = user_key_init();
> +       if (err)
> +               goto key_fail;
> +
> +       skey.initialized = true;

Does this need a memory barrier to prevent reordering of the
"skey.initialized = true" assignment before the key is fully
initialized?

> +
> +       pr_info("Snapshot key is initialled.\n");
> +
> +       return 0;
> +
> +key_fail:
> +       crypto_free_shash(hash_tfm);
> +       hash_tfm = NULL;
> +
> +       return err;
> +}
> --
> 2.13.6
>
>
