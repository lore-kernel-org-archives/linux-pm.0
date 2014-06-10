From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3][update] PM / sleep: Introduce command line argument for sleep state enumeration
Date: Tue, 10 Jun 2014 17:23:24 +0200
Message-ID: <1848200.GDD9x0Rptb@vostro.rjw.lan>
References: <1817539.9KW2IGGbDV@vostro.rjw.lan> <1579932.qSkFQPvI6f@vostro.rjw.lan> <20140610131206.GA7626@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140610131206.GA7626@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 10, 2014 03:12:06 PM Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > On some systems the platform doesn't support neither
> > PM_SUSPEND_MEM nor PM_SUSPEND_STANDBY, so PM_SUSPEND_FREEZE is the
> > only available system sleep state.  However, some user space frameworks
> > only use the "mem" and (sometimes) "standby" sleep state labels, so
> > the users of those systems need to modify user space in order to be
> > able to use system suspend at all and that is not always possible.
> 
> I'd say we should fix the frameworks, not add option to change kernel
> interfaces.
> 
> Because, as you mentioned, if we add this, we are probably going to
> get stuck with it forever :-(.

Unfortunately, fixing the frameworks is rather less than realistic in any
reasonable time frame, since  Android. :-)

Rafael
