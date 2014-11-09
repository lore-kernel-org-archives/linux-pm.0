From: =?windows-1252?Q?Andreas_F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v5 33/48] staging: nvec: Register with kernel power-off
 handler
Date: Mon, 10 Nov 2014 00:06:19 +0100
Message-ID: <545FF36B.6060801@suse.de>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net> <1415292213-28652-34-git-send-email-linux@roeck-us.net> <5008744.rVN94atT9b@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5008744.rVN94atT9b@ax5200p>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Dietrich <Marc.Dietrich-wkdnK3oF/XPYtB+G+YtuwQgYPMzSbZxj@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Am 09.11.2014 um 22:41 schrieb Marc Dietrich:
> Am Donnerstag 06 November 2014, 08:43:17 schrieb Guenter Roeck:
>> Register with kernel power-off handler instead of setting pm_power_o=
ff
>> directly. Register with default priority since we don't know any bet=
ter.
>>
>> Cc: Julian Andres Klode <jak-4HMq4SXA452hPH1hqNUYSQ@public.gmane.org>
>> Cc: Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>
>> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>> Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
>=20
> ok, this version (V5) actually switches the device off in contrast to=
 the=20
> first implementation. Somehow I have to find out why it works at all =
without=20
> irqs.
>=20
> Acked-by: Marc Dietrich <mavin24-Mmb7MZpHnFY@public.gmane.org>

'r' missing in email? :)

Cheers,
Andreas

--=20
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 21284 AG N=FCrn=
berg
