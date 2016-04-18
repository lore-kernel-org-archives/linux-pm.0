From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 14:51:35 +0300
Message-ID: <87potnf83c.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <CAMz4kuJwfWPEndmVMoDBQQFZ2X8BAzDgej_9qMKQq0xU3tC=5w@mail.gmail.com> <20160322112940.GB26924@xo-6d-61-c0.localdomain> <87d1pngwjb.fsf@intel.com> <20160418103350.GB27936@amd> <871t63gpqj.fsf@intel.com> <20160418110329.GA29438@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160418110329.GA29438@amd>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:
>> >> manually ??? Hell no! Charger IC should be able to do this no
>> >> problem. I would be surprised if there's any charger IC out there whi=
ch
>> >> blindly connects a 1.8A load from the start. What these ICs do is that
>> >> they slowly increment the load and check voltage level. They'll conti=
nue
>> >> to do that up to the maximum you listed (1.8A, let's say). As soon as
>> >> voltage drops a bit, charger IC knows that it use previous load.
>> >
>> > As I explained, if the note on the wall charger says 1.5A, you want to
>> > do 1.5A, not 1.8A. You can measure voltage on the charger, but you
>> > don't know its temperature.
>>=20
>> phone can't read what it says in the wall charger, nor can it know that
>> it's connected charger ABC and not charger XYZ. Think of the user
>> experience. You can't expect users to tell you "okay phone, the charger
>> reads that maximum is 1.5A, so please don't go over that."
>
> Of course, we may do something sensible by default. But manual
> controls should still be present. You called them "stupid" but they
> are not.
>
> Note that just because you detected wall charger does not even mean
> you are connected to wall charger. See the link below.

that's a horrible product. So what ? If you want to use that, be my
guest. Just, again, don't ask for support when things start falling
apart ;-)

>> >> still unsafe. If you really wanna do that, you're welcome to removing
>> >> safety margins from your own kernel, but we're definitely not going to
>> >> ship this to millions of users.
>> >
>> > Not more unsafe than loading wall chargers with "lets see how much we
>> > can get out of it" algorithm. Plus actually required to charge your
>>=20
>> it actually _is_ more unsafe. You could burn mother boards with that. If
>> host tells you it only has 100mA power budget left, why are you trying
>> to get more ?
>
> No, you can't burn motherboard like that... You can force emergency
> shutdowns, which is also bad, but... There are many devices that break
> this aspect of USB protocol.
>
> https://www.kickstarter.com/projects/1785889318/doubbletime-charging-cabl=
e-full-battery-in-1-2-the

we can't prevent people from coming up with bad devices/cables/whatever,
right ? But we can make sure that overcoming a 500mA power budget on a
USB 2.0 port will not be allowed.

>> > Unfortunately, there's more than one standard for detecting charger,
>> > so manual control will probably be required.
>>=20
>> n900 never had manual control of anything. It was just using information
>> given by the battery IC, charger IC and twl4030 madc.
>
> Manual control of n900 charging is done by:
>
> echo 1800 > /sys/class/power_supply/bq24150a-0/current_limit

yes, that's fine. And if you're connected to a dedicated charger (DCP)
which follows USB Battery Charger specification, we *know* that it
should, per the spec, source up to 2A, so this is fine.

However, if you're connected to SDP (regular PC port), which has a power
budget of 500mA per-port (meaning, that if you're behind a bus powered
hub, you can't even get 500mA), then this write() of yours should be
invalid. It should *not* be a successful write() as that creates an
unsafe and potentially dangerous scenario for the user.

>> >> > (And with USB 5V connected directly to pretty beefy PC power supply=
...
>> >> > it is sometimes safer than it looks).
>> >>=20
>> >> you're not considering the thermal dissipation on the USB connector
>> >> itself. Many of them might not use good metals because they assume the
>> >> maximum power dissipated is 500mA * 5V =3D 2.5W. If you try to draw m=
ore,
>> >> you could, literally, melt the connector.
>> >
>> > If you are dissipating 2.5W at the connector, you are doing something
>> > very wrong. You should not be short-circuiting your USB... even when
>> > the ports are usually designed to survive that.
>>=20
>> yes. You shouldn't. You also shouldn't go over that limit. If you have a
>> 500mA total power budget, we should not let anybody try to draw more
>> because we have no control over what's on the side of the wire.
>
> They already can go over the limit, for example using cable linked
> above. I have several such cables here. I also have various wall

people can use unsupported cable assemblies if they want, but you can't
expect kernel to support you.

> supplies that are not detected as a wall supply by N900. So I either
> have to remember and connect them with the "special" cable, or
> (easier) use the override above to get useful charging.

those supplies are not supported by N900. N900 was designed with USB
Battery Chaging specification in mind and Nokia is not around anymore to
give you SW updates. Sorry, but that's not the kernel's fault.

The point is the following: there are a handful of people who would
*know* how to fiddle with these limits, many would not. The vast
majority would not. And, considering this is something completely out of
spec, and, again, potentially dangerous to the user, we are not going to
support it.

You may use your hacked up cables, not a problem. I did that myself
during N900 development (though I was using a lab power supply with a 2A
current limit sourcing 5V) to test port type detection and charging
algorithm. But that's really not something any company (or this
community) will support.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFMpIAAoJEIaOsuA1yqREfX8QALKY5FEBwBP0/np9xlBZ/ZWa
wirLY9K3Yew48MJBw11ok/vJTPNqAycBRR6a6bFIo5gFrhd3WMvArHjpjEzAQ8NH
2Vq7cIRJ9wGdanxXaTHREGt0vh0q5RV3OvlNCPW05SdyCH1Gu1JNovgLzuKnJC1b
Ek8dkRO+iaHk1yyrY8230OvqJN68OYmv1ttGVn3dPfEcC1G8PJwfZF1li0aIxZzc
u6YX1Kg5Y9B3Ew4HCm1F8UBtwPzWP70TMgN5+kZCXuiHlywA7EKLMQfM1Q76SltN
cdHWL8L9MWBsAh+KFTwBWF5gsWK8w08kxD23mGyhlaZ4EBcfxQpuD9xBdjCnnflz
wW+iDTQxgnbL57ba12yY0xnAbLi8+gWZmdSC53wDk+lXws6FEjaXIMhABEyHMSbp
/ex7qzoYrVYtvf049UJhkbhTRR1yhN0hJZ4RPiNEC1WffifT2WqYIy9TaAKjgx1z
XWeim3oYghqhUDH1535rN8QcqqglfJzSvdIIgQDT+MGKouySOzf39SQBqgsIhqus
DMr3w7DoiI7xaoVga+heWee39QZn6/rGgFLsvWb50aU7MxO/Ot91PQgxixJpryvx
E+U1q7nDJnn38TbUUo4kOxiMCnsRYULAQAxqdwhzAkduSjGmUKWOEtpMPWNZa4/G
DgUtnf5MKpaooRN/x19i
=Pm/M
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
