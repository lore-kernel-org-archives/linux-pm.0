From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.23-rc2 swsusp, suddenly increased uptime
Date: Mon, 13 Aug 2007 23:49:52 +0200
Message-ID: <200708132349.52763.rjw__22511.4721958109$1187041395$gmane$org@sisk.pl>
References: <Pine.LNX.4.63.0708122137130.25343@er-systems.de>
	<200708132306.27587.rjw@sisk.pl>
	<Pine.LNX.4.63.0708132325580.29791@er-systems.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.63.0708132325580.29791@er-systems.de>
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
To: Thomas Voegtle <tv@lio96.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday, 13 August 2007 23:31, Thomas Voegtle wrote:
> On Mon, 13 Aug 2007, Rafael J. Wysocki wrote:
> 
> > On Sunday, 12 August 2007 21:39, Thomas Voegtle wrote:
> > > 
> > > Hi,
> > > 
> > > today I saw this (output from my suspend script):
> > > 
> > > -> woke up at Sun Aug 12 11:39:17 CEST 2007
> > > -> uptime is
> > >  11:39am  up 8 days  0:41,  10 users,  load average: 26.12, 6.35, 2.17
> > > 
> > > 
> > > Then I did a software suspend. After waking up, I saw this:
> > > 
> > > 
> > > -> woke up at Sun Aug 12 14:41:56 CEST 2007
> > > -> uptime is
> > >   2:41pm  up 44 days  9:11,  12 users,  load average: 35.17, 9.17, 3.33
> 
> I just want to add, I built 2.6.23-rc2 on Aug 4th and this happened on Aug 
> 12 and I suspend once a day. And the only thing which was odd was the 
> uptime, nothing else.
> 
> I rebooted with 2.6.23-rc3 today, so the odd uptime is gone.
> Should I try 8 suspend cycles or something to reproduce it again?

Well, if you can, please try to do something like this.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
