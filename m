From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Fri, 2 Dec 2016 11:15:53 +0100
Message-ID: <20161202101553.GA15530@gmail.com>
References: <20161129181300.GA29095@sbauer-Z170X-UD5>
 <20161130183507.syv3cdpp3hzxi77k@treble>
 <20161130190217.GA2756@sbauer-Z170X-UD5>
 <20161130231011.ofmbmevn3hqasetz@treble>
 <CAJZ5v0iW8kNbU6pP96WTc8uLB_0V05vrEyum0d1Q-XKvX0-O-A@mail.gmail.com>
 <20161201165303.rysogoj2uvepw6oe@treble>
 <CAJZ5v0gEXe__KQtfzFS9-MMB0=MgBDpYNFw95P85DNUa7fHT6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gEXe__KQtfzFS9-MMB0=MgBDpYNFw95P85DNUa7fHT6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Scott Bauer <scott.bauer@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> >> Looks OK to me.
> >>
> >> Whom do you expect to apply this?
> >
> > Assuming it gets an ack from Andrey, can you take it?  Or would the tip
> > tree be better?
> 
> I can take it unless anyone else wants to take care of it. :-)

Please pick up the fixes in this thread.

Thanks!

	Ingo
