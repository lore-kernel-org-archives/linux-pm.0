From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
Date: Tue, 4 Jul 2017 12:51:15 +0300
Message-ID: <CAHp75VdyurjwN+DZQuKnEzNe+XgZwiLLkc0Rg0NvFr=4D2GiQA@mail.gmail.com>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
 <20170703133602.ejcdu35ku3i63cj2@earth> <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com>
 <20170703171427.qtpodt7watymphac@earth> <CAHp75VeLV_ySCRN3B=MSoZdyrbXXqqEXrgC+hJCDoLLCJRComQ@mail.gmail.com>
 <20170703182033.5stv5eq33et63coh@earth> <alpine.DEB.2.20.1707041104390.3346@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1707041104390.3346@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 4, 2017 at 12:11 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> Here is a revised version (not a patch because it doesn't support all of
> the various modes) and the results.  It doesn't return anything beyond
> what was mentioned in previous mails.
>
> For the following code:
>
>         ret = i2c_smbus_read_word_data(chip->client, reg << 1);
>         val[0] = (u16)ret & 0xFF;
>         val[1] = (u16)ret >> 8;
>
> do we want to see:
>
> put_unaligned(val,i2c_smbus_read_word_data(chip->client, reg << 1));

If and only if the type of the pointer is a byte type (u8 *, char *,
or alike) _and_ we try to use it as a provider for 16-bit value (2
bytes).

-- 
With Best Regards,
Andy Shevchenko
