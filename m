From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 3.20-rc0: GUI dies on resume, then systemd gots sigill
Date: Thu, 19 Feb 2015 02:09:27 +0100
Message-ID: <2244262.p04RxBg4Pz@vostro.rjw.lan>
References: <20150218094631.GA3352@amd> <2254794.AHR7M2FYHX@vostro.rjw.lan> <20150218190052.GA25491@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150218190052.GA25491@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 18, 2015 08:00:52 PM Pavel Machek wrote:
> Hi!
> 
> On Wed 2015-02-18 17:39:08, Rafael J. Wysocki wrote:
> > On Wednesday, February 18, 2015 10:46:32 AM Pavel Machek wrote:
> > > Hi!
> > > 
> > > In 3.19, suspend/resume was rock solid.
> > > 
> > > 3.20-rc0, after resume, I could see X windows dying. So I tried to log
> > > in on text console, but at that point got a note about SIGILL from
> > > systemd (and dead system). syslog ilustrates it nicely.
> > > 
> > > Any ideas?
> > 
> > The dying X may be a graphics driver problem.
> > 
> > Have you tried to suspend/resume without X?
> > 
> > The systemd failure after the failing resume indicates that something was
> > stuck somewhere or we corrupted memory.
> 
> It looks like everyone and their dog gets SIGILL, so... yes, I'll try
> without X, no, I don't think it will make difference.
> 
> For the record, 796e1c55717e9a6ff5c81b12289ffa1ffd919b6f is bad.
> 
> Does it work for you? Do you have any Intel graphics machine nearby?

I'm at a conference, so not really.

CCing Daniel though, he may be able to help.

Rafael
