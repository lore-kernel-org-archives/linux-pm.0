From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Date: Mon, 25 Jun 2018 10:06:04 +0200
Message-ID: <CAJZ5v0j9P6dXM+8qBdgGwfd8diQ4F+hh+QZ8h09y769YYFtEkw@mail.gmail.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180611053826.GC16091@dragon> <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 25, 2018 at 10:01 AM, S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> Hi,
>
> On 06/11/2018 07:38 AM, Shawn Guo wrote:
>> On Tue, May 22, 2018 at 08:28:51AM +0200, S=C3=A9bastien Szymanski wrote=
:
>>> Check the max speed supported from the fuses for i.MX6ULL and update th=
e
>>> operating points table accordingly.
>>>
>>> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.c=
om>
>>
>> Acked-by: Shawn Guo <shawnguo@kernel.org>
>>
>
> Thanks, but what about the two others patches ? Now that patch 1 is in
> 4.18-rc1, should I resend the two others patches ?

Please do.

> Should I merge them together ?

If they make related changes, you can do that.
