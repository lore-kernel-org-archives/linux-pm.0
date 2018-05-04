From: <ilialin@codeaurora.org>
Subject: RE: [PATCH v4 08/14] dt: qcom: Add opp and thermal to the msm8996
Date: Fri, 4 May 2018 09:48:46 +0300
Message-ID: <003001d3e373$f94db540$ebe91fc0$@codeaurora.org>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org> <1522358807-10413-9-git-send-email-ilialin@codeaurora.org> <20180402091617.GA3572@vireshk-i7> <CAKohpo=cw+2Leuwa6XjEYh4kVYK093A5eckUmPBDutgqeqpvog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=cw+2Leuwa6XjEYh4kVYK093A5eckUmPBDutgqeqpvog@mail.gmail.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: 'Michael Turquette' <mturquette@baylibre.com>, 'Stephen Boyd' <sboyd@kernel.org>, 'Rob Herring' <robh@kernel.org>, 'Mark Rutland' <mark.rutland@arm.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Liam Girdwood' <lgirdwood@gmail.com>, 'Mark Brown' <broonie@kernel.org>, 'Andy Gross' <andy.gross@linaro.org>, 'David Brown' <david.brown@linaro.org>, 'Catalin Marinas' <catalin.marinas@arm.com>, 'Will Deacon' <will.deacon@arm.com>, 'Linux Clock List' <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, "'open list:ARM/QUALCOMM SUPPORT'" <linux-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org'
List-Id: linux-pm@vger.kernel.org

Kryo has single clock per cluster. I define here a shared OPP table per =
cluster.

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Friday, May 4, 2018 09:04
> To: Ilia Lin <ilialin@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Rob Herring <robh@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Liam
> Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Andy Gross <andy.gross@linaro.org>; David Brown
> <david.brown@linaro.org>; Catalin Marinas <catalin.marinas@arm.com>; =
Will
> Deacon <will.deacon@arm.com>; Linux Clock List <linux-
> clk@vger.kernel.org>; devicetree@vger.kernel.org; Linux Kernel Mailing =
List
> <linux-kernel@vger.kernel.org>; linux-pm@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; open list:ARM/QUALCOMM SUPPORT <linux-
> soc@vger.kernel.org>; linux-arm-kernel@lists.infradead.org; Nayak,
> Rajendra <rnayak@codeaurora.org>; Amit Kucheria
> <amit.kucheria@linaro.org>; Nicolas Dechesne
> <nicolas.dechesne@linaro.org>; celster@codeaurora.org;
> tfinkel@codeaurora.org
> Subject: Re: [PATCH v4 08/14] dt: qcom: Add opp and thermal to the
> msm8996
>=20
> On 2 April 2018 at 14:46, Viresh Kumar <viresh.kumar@linaro.org> =
wrote:
>=20
> >> +     cluster0_opp: opp_table0 {
> >> +             compatible =3D "operating-points-v2";
> >> +             opp-shared;
> >
> > Is Kryo like krait where CPUs do DVFS independently ? If yes, then
> > opp-shared thing should be dropped.
>=20
> Have you ever replied to this question ? Sorry, but I am not able to =
find it in
> my inbox :(
