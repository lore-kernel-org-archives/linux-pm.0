From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 3/6] clk: qoriq: increase array size of cmux_to_group
Date: Tue, 16 Oct 2018 15:44:54 -0700
Message-ID: <153972989460.5275.12653601090217013634@swboyd.mtv.corp.google.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
 <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel-owner@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mark.rutland@arm.com, mturquette@baylibre.com, oss@buserror.net, rjw@rjwysocki.net, robh+dt@kernel.org, shawnguo@kernel.org, sudeep.holla@arm.com, viresh.kumar@linaro.org, will.deacon@arm.com, yamada.masahiro@socionext.com
Cc: linux@armlinux.org.uk, adrian.hunter@intel.com, ulf.hansson@linaro.org, V.Sethi@nxp.com, udit.kumar@nxp.com, pankaj.bansal@nxp.com, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
List-Id: linux-pm@vger.kernel.org

Quoting Vabhav Sharma (2018-10-14 10:08:00)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> =

> Increase size of cmux_to_group array, to accomdate entry of
> -1 termination.
> =

> Added -1, terminated, entry for 4080_cmux_grpX.
> =

> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
