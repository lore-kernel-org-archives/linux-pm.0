From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Wed, 11 Apr 2018 17:01:21 -0700
Message-ID: <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
References: <1523436077.16235.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523436077.16235.5.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 11, 2018 at 1:41 AM, Zhang Rui <rui.zhang@intel.com> wrote:
>
> Please pull from
>   git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

Pulled, and then immediately unpulled again.

The code causes new compiler warnings, and the warnings are valid.

If people don't care enough about their code to even check the
warnings, I'm not going to waste one second pulling the resulting
garbage. It's that simple.

                    Linus
