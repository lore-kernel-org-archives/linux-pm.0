From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/power/64: Remove VLA usage
Date: Wed, 18 Jul 2018 21:39:46 -0700
Message-ID: <CAGXu5jJL8B+eBwm5j7M=p9zd+n559M+yFC9RoDyV8cjmvT6JhQ@mail.gmail.com>
References: <20180716035657.GA32180@beast> <20180716172205.GB77258@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716172205.GB77258@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 16, 2018 at 10:22 AM, Eric Biggers <ebiggers@google.com> wrote:
> On Sun, Jul 15, 2018 at 08:56:57PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
>> shash directly and allocating the descriptor in heap memory (which should
>> be fine: the tfm has already been allocated there too).
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/x86/power/hibernate_64.c | 35 +++++++++++++++++++----------------
>>  1 file changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
>> index 67ccf64c8bd8..0ed01bb935a6 100644
>> --- a/arch/x86/power/hibernate_64.c
>> +++ b/arch/x86/power/hibernate_64.c
>> @@ -233,28 +233,31 @@ struct restore_data_record {
>>   */
>>  static int get_e820_md5(struct e820_table *table, void *buf)
>>  {
>> -     struct scatterlist sg;
>> -     struct crypto_ahash *tfm;
>> +     struct crypto_shash *tfm;
>> +     struct shash_desc *desc;
>>       int size;
>>       int ret = 0;
>>
>> -     tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
>> +     tfm = crypto_alloc_shash("md5", 0, 0);
>>       if (IS_ERR(tfm))
>>               return -ENOMEM;
>>
>> -     {
>> -             AHASH_REQUEST_ON_STACK(req, tfm);
>> -             size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry) * table->nr_entries;
>> -             ahash_request_set_tfm(req, tfm);
>> -             sg_init_one(&sg, (u8 *)table, size);
>> -             ahash_request_set_callback(req, 0, NULL, NULL);
>> -             ahash_request_set_crypt(req, &sg, buf, size);
>> -
>> -             if (crypto_ahash_digest(req))
>> -                     ret = -EINVAL;
>> -             ahash_request_zero(req);
>> -     }
>> -     crypto_free_ahash(tfm);
>> +     desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
>> +                    GFP_KERNEL);
>> +     if (!desc)
>> +             return -ENOMEM;
>
> Need crypto_free_shash(tfm) if the kmalloc() here fails.

Ah thanks! Fixed now for the next version.

-Kees

-- 
Kees Cook
Pixel Security
