From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Thu, 12 Apr 2018 13:08:31 +0800
Message-ID: <1523509711.16235.25.camel@intel.com>
References: <1523436077.16235.5.camel@intel.com>
         <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Li, Philip" <philip.li@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

On 三, 2018-04-11 at 17:01 -0700, Linus Torvalds wrote:
> On Wed, Apr 11, 2018 at 1:41 AM, Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > 
> > Please pull from
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> > next
> Pulled, and then immediately unpulled again.
> 
> The code causes new compiler warnings, and the warnings are valid.
> 
> If people don't care enough about their code to even check the
> warnings, I'm not going to waste one second pulling the resulting
> garbage. It's that simple.
> 

I'm really sorry for this.
could you please illustrate me what the kconfig & warning is?
I didn't
get such warnings from 0-day.

thanks,
rui
