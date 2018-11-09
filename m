From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/7] pinctrl: qcom: spmi-gpio: fix gpio-hog related
 boot issues
Date: Fri, 9 Nov 2018 09:59:08 +0100
Message-ID: <CACRpkdaabE-ekKQp93CiFtN_Qp6OohEUE-qufsX=12u2p_SXtw@mail.gmail.com>
References: <20181101001149.13453-1-masneyb@onstation.org> <20181101001149.13453-6-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101001149.13453-6-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: masneyb@onstation.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, jonathan@marek.ca
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 1, 2018 at 1:12 AM Brian Masney <masneyb@onstation.org> wrote:

> When attempting to setup up a gpio hog, device probing would repeatedly
> fail with -EPROBE_DEFERED errors. It was caused by a circular dependency
> between the gpio and pinctrl frameworks. If the gpio-ranges property is
> present in device tree, then the gpio framework will handle the gpio pin
> registration and eliminate the circular dependency.
>
> See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
> gpio-hog related boot issues") for a detailed commit message that
> explains the issue in much more detail. The code comment in this commit
> came from Christian's commit.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

No word from Bjorn but I trust my own intuition and applied it.

Bj=C3=B6rn: shout if it's wrong.

Question: should this also be done for pinctrl-ssbi-gpio.c?

Yours,
Linus Walleij
