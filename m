From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v8 0/3] Runtime Interpreted Power Sequences
Date: Fri, 16 Nov 2012 09:44:49 +0100
Message-ID: <20121116084449.GA20785@avionic-0098.mockup.avionic-design.de>
References: <1353047903-14363-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353047903-14363-1-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2012 at 03:38:20PM +0900, Alexandre Courbot wrote:
> Hopefully the final series before the feature gets merged. Anton Vorontsov
> kindly accepted to take it into his tree, so this series is mostly a call=
 for
> acks, tests and reviews notices before the merge window for 3.8 opens. If=
 you
> are interested in seeing this feature, please add your name.
>=20
> This series also adds an entry for the subsystem into MAINTAINERS, settin=
g me as
> the person in charge.
>=20
> Changes from v7:
> - fix bug reported by Tony Prisk
> - add MAINTAINERS entry
>=20
> Alexandre Courbot (3):
>   Runtime Interpreted Power Sequences
>   pwm_backlight: use power sequences
>   Take maintainership of power sequences
>=20
>  .../devicetree/bindings/power/power_seq.txt        | 121 +++++++
>  .../bindings/video/backlight/pwm-backlight.txt     |  63 +++-
>  Documentation/power/power_seq.txt                  | 253 ++++++++++++++
>  MAINTAINERS                                        |  10 +
>  drivers/power/Kconfig                              |   1 +
>  drivers/power/Makefile                             |   1 +
>  drivers/power/power_seq/Kconfig                    |   2 +
>  drivers/power/power_seq/Makefile                   |   1 +
>  drivers/power/power_seq/power_seq.c                | 376 +++++++++++++++=
++++++
>  drivers/power/power_seq/power_seq_delay.c          |  65 ++++
>  drivers/power/power_seq/power_seq_gpio.c           |  94 ++++++
>  drivers/power/power_seq/power_seq_pwm.c            |  82 +++++
>  drivers/power/power_seq/power_seq_regulator.c      |  83 +++++
>  drivers/video/backlight/Kconfig                    |   1 +
>  drivers/video/backlight/pwm_bl.c                   | 160 +++++++--
>  include/linux/power_seq.h                          | 203 +++++++++++
>  include/linux/pwm_backlight.h                      |  18 +-
>  17 files changed, 1494 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/power_seq.txt
>  create mode 100644 Documentation/power/power_seq.txt
>  create mode 100644 drivers/power/power_seq/Kconfig
>  create mode 100644 drivers/power/power_seq/Makefile
>  create mode 100644 drivers/power/power_seq/power_seq.c
>  create mode 100644 drivers/power/power_seq/power_seq_delay.c
>  create mode 100644 drivers/power/power_seq/power_seq_gpio.c
>  create mode 100644 drivers/power/power_seq/power_seq_pwm.c
>  create mode 100644 drivers/power/power_seq/power_seq_regulator.c
>  create mode 100644 include/linux/power_seq.h

The series,

Tested-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Acked-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQpf0BAAoJEN0jrNd/PrOhZokQAIsuhlur+Ch6HtW/T51TB19Q
91Jyr22W11fc2p9ECijst9ZY6ebpt4Yy7ZwtqKTGLcQE5oGZZhnHzNRKTipEFGqp
E4iFOrWtq3ulRmhjaOTA1xo1yL6GjuIy07cdxrVMOMy5BVKV1ymOPyVqt1Hazimf
s00QBMvpgyjLSsLatyl6f7QLGCvaEjsJ+l8xeObGATew7FrmYHpeAAYqSecG1SxR
1ypzflnAHYPJ4pqCo2eveguMJeKoxWk8/7jm1/7Sayu9urm27U9H6JLZiKjLZ/Tb
cNZw7n8hul3pTGmEbLDK/Y45LNZ40tisY5dFhM7GS9JF6ca+eRYt2cQ8pDsJ8Fwy
ry0PsCYv/PZLflJazlFt7NyQs91ELjcwAv4ySQogBwGvZ58vDgNSjNxtd+/7Isvr
1mXJoqxV0wNimUb/YhbNBURk4Q3kOKMOrxS/NSJ5/L8UobLGXyGubVEIILqOg6eg
NYuLyzQocaxYRVadzeUBpqp2Qac7dFue2oN7FAlxy04GAR9Zj4ia3YyNHY21Z/PW
D1ryX8EsHMHObIHoup4+7VixRf9ffcL+QAC4XlOtD8m5m6KWZEgO150QiTpFUHAv
ECtBoj96iuO+VKwL/2uAmKw7ZRDSLVB4WPRzdHcZUdZc94kcR3wFNd+VkhzhTjrr
lAAorLy1m4tQZH/nfnQs
=E8ZZ
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
