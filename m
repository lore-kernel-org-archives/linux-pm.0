From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] platform/wmi: Expose the raw WDG data in sysfs
Date: Tue, 01 Aug 2017 23:32:41 +0200
Message-ID: <2674627.ID8AtCtKmZ@aspire.rjw.lan>
References: <cover.1501601667.git.luto@kernel.org> <2014962.u6moyPZATx@aspire.rjw.lan> <20170801213618.GL25574@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170801213618.GL25574@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 01, 2017 11:36:18 PM Pali Rohár wrote:
> On Tuesday 01 August 2017 23:20:10 Rafael J. Wysocki wrote:
> > No evaluation of AML methods from user space, please.
> > 
> > This is plain dangerous, because you never know what those things do and doing
> > that on production systems is just a plain "no".
> > 
> > You can, however, expose the output of AML methods this way or another,
> > for example if they are expected to generate packages of data or similar.
> > 
> > The interface for that cannot be "evaluate this random method right now and
> > give me the result", though.
> 
> It is not a random AML method. It is _WDG buffer which wmi.ko already
> reads + parse (IIRC only once when doing initialization) and purpose is
> to provide copy of this buffer also to userspace. Similarly like
> wmi-bmof.ko provides MOF buffer.

OK, then.
