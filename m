From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Vulnerability in Software Suspend 2 (all versions)
Date: Tue, 29 Jul 2008 00:46:55 +0200
Message-ID: <200807290046.57274.rjw@sisk.pl>
References: <488D821D.5060603@iviztechnosolutions.com>
	<488D89A8.2050101@iviztechnosolutions.com>
	<1217238046.8430.154.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1217238046.8430.154.camel@nigel-laptop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jonathan Brossard <jonathan@iviztechnosolutions.com>
Cc: ncunningham@users.sourceforge.net, Nigel Cunningham <ncunningham@crca.org.au>, mhfl@users.sourceforge.net, bernardb@users.sourceforge.net, seasons@users.sourceforge.net, techteam@ivizindia.com, "cer >> \"CERT(R) Coordination Center\"" <cert@cert.org>, chabaud@users.sourceforge.net, linux-pm@lists.linux-foundation.org, Jonathan Brossard <jonathan@ivizindia.com>
List-Id: linux-pm@vger.kernel.org

On Monday, 28 of July 2008, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2008-07-28 at 14:26 +0530, Jonathan Brossard wrote:
> > Dear Nigel,
> > 
> >  >Why do you think I'm in Switzerland? I'm actually a New Zealander,
> > 
> > >living in Australia.
> > 
> > Nothing against aussies, the project was once uppon a time austed at the federal school
> > of Lausane, which afaik is in Switzerland...
> 
> Ah, okay. Now I'm with you. Yeah, the original author was Gabor Kuti.
> After Gabor, Florent took over and then I took over from Florent. Gabor
> and Florent have contributed for about 5 years, as far as I recall.
> 
> > >Okay. As mentioned in the previous reply, I don't think this is a bug
> > >with TuxOnIce itself. If a BIOS data area needs clearing during resume,
> > >I would suggest that something like the ACPI device driver should be
> > >doing that, because if the memory needs clearing, it should need
> > >clearing irrespective of whether you've hibernated or not.
> > 
> > Ok. I gave you the exploit. I gave you the explaination. I gave you the fix.
> > Now, if you don't want to face the truth that you have a problem (why dont
> > you just test the exploit ?) because you don't know how to use the BIOS API
> > safely, that's fine : don't fix it, I don't really care.
> 
> I understand what you're saying, but I disagree with your diagnosis as
> to where the problem lies. If you're talking about a password for
> encrypted swap not being cleared (you haven't said what password you're
> talking about yet), then the problem is with the program that's asking
> you for the password, or the program that's using it (dmsetup?). The
> TuxOnIce kernel patch doesn't ask for passwords or know anything about
> where in memory passwords might be stored.
> 
> I'm a little confused by the fact that you're mentioning BIOS data and
> TuxOnIce asking for a password. Are you talking about some buffer from
> the BIOS that keypresses are stored in prior to being consumed by the
> kernel's input driver (oh yeah, the kernel _is_ running when TuxOnIce
> starts). If that's the case, your bug should perhaps be filed against
> the input driver.
> 
> > Between : Can I quote you at my Defcon presentation  ?
> 
> Can we leave that question until we've sorted out what we're talking
> about? I'm not at all unwilling to deal with a problem, but right now
> I'm still trying to get clear in my head what the issue is.

Yeah.

Jonathan, could you please describe _exactly_ what the problem is, what
systems are affected (all of them, a subclass and if so, then which one), what
the way to exploit the vulnerability is and why you think that the kernel
should be responsible for preventing the attack from happening?

If you don't want to disclose the details publically, please send them to me
and Nigel in private.

Thanks,
Rafael
