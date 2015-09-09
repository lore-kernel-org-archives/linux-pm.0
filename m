From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261 charger
Date: Wed, 9 Sep 2015 00:01:45 -0300
Message-ID: <CAOMZO5BpPiHv_g=gwvKbSYDoMj0Ks=4-qbe+j9ZXjDGC9VuHQw@mail.gmail.com>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441560187-23611-1-git-send-email-ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ramakrishna Pallala <ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jenny TC <jenny.tc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Sep 6, 2015 at 2:23 PM, Ramakrishna Pallala
<ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> +       chip->psy_usb = power_supply_register(&client->dev,
> +                               &bq24261_charger_desc, &charger_cfg);
> +       if (IS_ERR(chip->psy_usb)) {
> +               dev_err(&client->dev,
> +                       "power supply registration failed(%d)\n", ret);
> +               return ret;

You should not print and return ret here.

You should print and return IS_ERR(chip->psy_usb) instead.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
