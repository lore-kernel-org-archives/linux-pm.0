From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Thu, 12 Apr 2018 09:55:19 -0700
Message-ID: <CA+55aFw0C-S0L-cnk0oROG=Khqy9s36O+g3_BxqPfewKGQ9_EQ@mail.gmail.com>
References: <1523436077.16235.5.camel@intel.com> <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
 <1523509711.16235.25.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523509711.16235.25.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com> wrote:
>
> could you please illustrate me what the kconfig & warning is?

Just "make allmodconfig" and the warning is about a uninitialized variable.

Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell history
is to be believed.

                Linus
