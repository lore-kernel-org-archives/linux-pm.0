From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
Date: Mon, 3 Jul 2017 19:37:59 +0300
Message-ID: <CAHp75VeJY8Xr2H8XK8A7Piu-38TnAeKu5Gn+edtkZmbw2quW0g@mail.gmail.com>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr> <20170703133602.ejcdu35ku3i63cj2@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170703133602.ejcdu35ku3i63cj2@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 3, 2017 at 4:36 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> On Sat, Jul 01, 2017 at 09:28:10PM +0200, Julia Lawall wrote:

>  * drivers/gpio/gpio-pca953x.c (line 190-192)

It has double conversion there:
1. LE CPU: Read as LE and converted to LE (no-op), so, just u16
2. BE CPU: Read as BE and converted to LE, makes it __le16

Looks like the conversion is not needed, only get_unaligned() is necessary.

P.S. What about lines 244-245 there? I think they are no-op.
Interesting that those two parts were added in quite different
commits.

-- 
With Best Regards,
Andy Shevchenko
