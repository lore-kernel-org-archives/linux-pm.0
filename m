From: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 5/7] pinctrl: qcom: spmi-gpio: fix gpio-hog related
 boot issues
Date: Fri, 9 Nov 2018 05:22:13 -0500
Message-ID: <20181109102213.dijt35etkzwdvu2a@ad8ea8ed68ae>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-6-masneyb@onstation.org>
 <CACRpkdaabE-ekKQp93CiFtN_Qp6OohEUE-qufsX=12u2p_SXtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaabE-ekKQp93CiFtN_Qp6OohEUE-qufsX=12u2p_SXtw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, jonathan@marek.ca
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 09, 2018 at 09:59:08AM +0100, Linus Walleij wrote:
> On Thu, Nov 1, 2018 at 1:12 AM Brian Masney <masneyb@onstation.org> wrote:
> 
> > When attempting to setup up a gpio hog, device probing would repeatedly
> > fail with -EPROBE_DEFERED errors. It was caused by a circular dependency
> > between the gpio and pinctrl frameworks. If the gpio-ranges property is
> > present in device tree, then the gpio framework will handle the gpio pin
> > registration and eliminate the circular dependency.
> >
> > See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
> > gpio-hog related boot issues") for a detailed commit message that
> > explains the issue in much more detail. The code comment in this commit
> > came from Christian's commit.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> 
> No word from Bjorn but I trust my own intuition and applied it.
> 
> Björn: shout if it's wrong.
> 
> Question: should this also be done for pinctrl-ssbi-gpio.c?

Yes, I believe so.

Brian
