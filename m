From: Peng Fan <peng.fan@nxp.com>
Subject: tee/optee driver pm question
Date: Wed, 19 Dec 2018 02:12:59 +0000
Message-ID: <AM0PR04MB4481CD18AC19D03D98358DEB88BE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Wiklander <jens.wiklander@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Jens, Ulf

We met an issue is OP-TEE is actively doing some DMA operations, such as CA=
AM DMA, while Linux is doing some ddr freq change and will let ddr into sel=
f-refresh state, this will cause issues.

On ARMv8 i.MX, we have code request_bus_freq/release_bus_freq to ask ATF to=
 make ddr into/out self refresh state. On ARMv7, we use similar code, but t=
he request/release will runs into OP-TEE to make ddr into/out self refresh =
state.

We have a RPC design, that is OP-TEE issue a RPC call to Linux, to ask Linu=
x to not issue release bus freq, but this will introduce complexity and not=
 aligned with other drivers in Linux Kernel. We are thinking to add pm call=
 back to optee/tee drivers, but did not find a good method. Do you have any=
 suggestions?

Thanks,
Peng.
