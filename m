From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Longhaul: Disable driver by default
Date: Tue, 27 Nov 2012 17:41:15 -0500
Message-ID: <20121127224115.GA11301@redhat.com>
References: <1354054435-2459-1-git-send-email-rafalbilski@interia.pl>
 <1997813.IluQxocScm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1997813.IluQxocScm@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Rafal Bilski <rafalbilski@interia.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 27, 2012 at 11:33:10PM +0100, Rafael J. Wysocki wrote:
 > On Tuesday, November 27, 2012 10:13:55 PM Rafal Bilski wrote:
 > > This is only solution I can think of. User decides if he wants this
 > > driver on his machine. I don't have enough knowledge and time to find
 > > the reason why same code works on some machines and doesn't on others
 > > which use same, or very similar,  chipset and processor.
 > 
 > I always have problems with patches like this one, because they are pretty much
 > guaranteed to make someone complain.
 > 
 > Is there any way to blacklist the affected machine you have?

There are a lot of marginal VIA systems out there. Mostly due to really
poor quality motherboards (I had several myself that ended up with leaking
capacitors). They work fine until you put them under load and then start
tweaking the voltage. Rafal spent a long time trying to get them stable
(see the git history for longhaul.c).  

Given those CPUs are pretty underpowered today, and there are many better
alternatives if you care about power saving that much, I'd vote for
not worrying about it too much.  We even stopped building it in Fedora
due to a) the limited userbase and b) when we got bug reports there was
nothing we could really do, so we opted for stability over power saving.

	Dave

