From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 5/6] ACPI: Introduce ACPI I2C controller
 enumeration driver
Date: Fri, 28 Sep 2012 13:54:01 +0100
Message-ID: <20120928135401.6781d134@pyramind.ukuu.org.uk>
References: <1348818032.10877.325.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1348818032.10877.325.camel@rui.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 Sep 2012 15:40:32 +0800
Zhang Rui <rui.zhang@intel.com> wrote:

> >From 6077a62f2865201ab6727ca7d628ee5e43aa57e1 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Fri, 24 Aug 2012 15:18:25 +0800
> Subject: [RFC PATCH 5/6] ACPI: Introduce ACPI I2C controller enumeration
>  driver
>=20
> This driver is able to
> 1) enumerate I2C controller via ACPI namespace
>    and register it as a platform device.
> 2) enumerate I2C slave devices via ACPI namespace.

Will this also trigger and work with the ACPI4 based devices that seem to
have I=C2=B2C tables that Linux currently doesn't understand (eq some
GMA600/Oaktrail platforms) ?
