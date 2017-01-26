From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 1/2] power: reset: add linkstation-reset driver
Date: Thu, 26 Jan 2017 16:28:11 +0100
Message-ID: <8760l1zvqs.fsf@free-electrons.com>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
        <20170107150451.17912-1-rogershimizu@gmail.com>
        <20170107150451.17912-2-rogershimizu@gmail.com>
        <CAEQ9gEkoKc0Yv+kLYGWgHZZW92u0tW8E9U0eT7ZhAx79yKxzLQ@mail.gmail.com>
        <20170119044327.j3d2rlpn5va3iw37@earth>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119044327.j3d2rlpn5va3iw37@earth> (Sebastian Reichel's
        message of "Thu, 19 Jan 2017 05:43:28 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Shimizu <rogershimizu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ryan Tandy <ryan-pRYBVO4bdZ33fQ9qLvQP4Q@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Herbert Valerio Riedel <hvr-mXXj517/zsQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sylver Bruneau <sylver.bruneau-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Roger,
 
 On jeu., janv. 19 2017, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> Hi Roger,
>
> On Wed, Jan 18, 2017 at 09:08:13PM +0900, Roger Shimizu wrote:
>> On Sun, Jan 8, 2017 at 12:04 AM, Roger Shimizu <rogershimizu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > Buffalo Linkstation / KuroBox and their variants need magic command
>> > sending to UART1 to power-off.
>> >
>> > Power driver linkstation-reset implements the magic command and I/O
>> > routine, which come from files listed below:
>> >   - arch/arm/mach-orion5x/kurobox_pro-setup.c
>> >   - arch/arm/mach-orion5x/terastation_pro2-setup.c
>> 
>> I think there's not much concern regarding to this series.
>> Could you kindly help to apply this patch?
>
> Well you dropped the DT binding, but still introduce new DT
> properties. Since they are not documented without the binding
> I won't merge this. DT binding documentation is not optional.
> In other words: NAK on the binding effectively means NAK on
> the driver in its current state.
>
> If you want to see this merged rebase it to Rob's generic
> serial bindings [0] and help to support him getting everything
> into mainline ASAP. Currently the feedback seems to be quite
> positive, so I hope to see it merged for 4.11.
>
> [0] https://lwn.net/Articles/711794/ (current proposal from 2 days
> ago)

What is te status for your series?

Do you plan sending a new version soon?

Gregory


>
> -- Sebastian
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
