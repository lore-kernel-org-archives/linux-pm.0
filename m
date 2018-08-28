From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Date: Tue, 28 Aug 2018 15:39:47 -0700
Message-ID: <153549598745.129321.12633089552143824401@swboyd.mtv.corp.google.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel-owner@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mark.rutland@arm.com, mturquette@baylibre.com, rjw@rjwysocki.net, robh+dt@kernel.org, viresh.kumar@linaro.org, will.deacon@arm.com, yamada.masahiro@socionext.com
Cc: linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Tang Yuantian <andy.tang@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
List-Id: linux-pm@vger.kernel.org

Quoting Vabhav Sharma (2018-08-19 23:47:14)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> =

> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> As LX2160A is 16 core, so modified value for NUM_CMUX
> =

> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
