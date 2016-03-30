From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 0/2] Add UCS1002 USB Port Power Controller
Date: Wed, 30 Mar 2016 18:51:39 +0200
Message-ID: <CAFqH_53AwUYKZAoUPN0VDiF_zGb=hkzB4k0KV+a9EX06HrdkiA@mail.gmail.com>
References: <1457947485-14140-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457947485-14140-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Martyn Welch <martyn.welch@collabora.com>
List-Id: linux-pm@vger.kernel.org

2016-03-14 10:24 GMT+01:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> Dear all,
>
> This is the fourth version of the UCS1002 driver, a Programmable USB Port
> Power Controller with Charger Emulation.
>
> Any comments are welcome. Thanks in advance.
>
> Enric Balletbo i Serra (2):
>   devicetree: Add UCS1002 USB Port Power Controller binding
>   power: ucs1002: Add support for Programmable USB Port Power Controller
>
>  .../devicetree/bindings/power/ucs1002.txt          |   41 +
>  drivers/power/Kconfig                              |    9 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/ucs1002_power.c                      | 1004 ++++++++++++++++++++
>  4 files changed, 1055 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/ucs1002.txt
>  create mode 100644 drivers/power/ucs1002_power.c
>
> --
> 2.1.0
>

Just a gentle reminder for if anyone can do some review, I would
really like to see these patches ready for next merge window :)

- Enric
