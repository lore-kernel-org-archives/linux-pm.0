From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Wed, 19 Jul 2017 00:39:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707190038360.2425@nanos>
References: <20170708000303.21863-1-dbasehore@chromium.org> <CAJZ5v0horA+vgR3bAbEu+AiqEFJ7JyZ49nTv6FBPHRvmXOUFpQ@mail.gmail.com> <CAGAzgsoFugSw=UQsJmep0woGg70J3nie0-EtvtQ4Ec1NG1usOg@mail.gmail.com> <7467728.lI8lN4PjS8@aspire.rjw.lan>
 <CAGAzgsq1c3HdMJ9801uqB+7USK9mqt9xtZTbH=EYv0KDLe+8=A@mail.gmail.com> <CAJZ5v0jaHAExRdwwhJU9p+tDB1ESEXqgfU_DLXev0su3qZaNBA@mail.gmail.com> <CAGAzgsqhV=e8ZuwA7NtOX_tg+HfQfYGg6oTTTRa2bp-LBOZ54w@mail.gmail.com> <alpine.DEB.2.20.1707180838570.1945@nanos>
 <CAGAzgsqwOhTYz9D=XYkMYHBZsmajUH8HJoMOJOe3DfG8WVusRA@mail.gmail.com> <alpine.DEB.2.20.1707182352340.2425@nanos> <CAGAzgsoqjwK1HPK7jPKhC+YhH7EbVLjbYm+p-UARGmK_hvB=+A@mail.gmail.com> <alpine.DEB.2.20.1707190019500.2425@nanos>
 <CAGAzgso39-72CfYW475DZpP0kbfXXXDMyABwVg8Gxaq6W_tJ3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAGAzgso39-72CfYW475DZpP0kbfXXXDMyABwVg8Gxaq6W_tJ3w@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Jul 2017, dbasehore . wrote:
> On Tue, Jul 18, 2017 at 3:22 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > The HPET consists of several independent comparator units. The kernel uses
> > only a limited set of them. We can reserve one or more for that purpose, so
> > it does not require any multiplexing or whatever. How many of them do you
> > need?
> >
> 
> I just need one. Is it a different irq than the RTC? It would be nice
> if we could avoid going through the s2idle_loop code.

Yes, it is a different IRQ.

Thanks,

	tglx
