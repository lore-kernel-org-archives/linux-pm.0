From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/1] x86/platform/iosf_mbi: Remove duplicate definitions
Date: Mon, 07 Dec 2015 23:56:22 +0100
Message-ID: <5624963.0RW57CLWha@vostro.rjw.lan>
References: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com> <1448461984.15393.53.camel@linux.intel.com> <alpine.DEB.2.11.1511251537170.12555@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1511251537170.12555@nanos>
Sender: linux-i2c-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Wolfram Sang <wsa@the-dreams.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hock Leong Kweh <hock.leong.kweh@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 25, 2015 03:37:54 PM Thomas Gleixner wrote:
> On Wed, 25 Nov 2015, Andy Shevchenko wrote:
> > =E2=80=A6we are working on another fix which is based also on this =
patch. Can
> > you provide your ACK if you are okay with the changes to arch/x86 ?
>=20
> I'm fine with the patch. Once I have acks, I'll pick it up.

Well, it turns out that some material to go into my tree depends on thi=
s
one.  Would you mind if I took it?

Thanks,
Rafael
