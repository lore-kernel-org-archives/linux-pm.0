From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Wed, 24 Oct 2007 22:38:02 +0200
Message-ID: <200710242238.02978.rjw__32940.679221838$1193257405$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<200709221240.25614.rjw@sisk.pl> <20071011205445.GA3975@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071011205445.GA3975@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 11 October 2007 22:54, Pavel Machek wrote:
> Hi!
> 
> > > That's certainly possible. We already pass a very small amount of data between 
> > > the boot and resuming kernels at the moment, and it's done quite simply - by 
> > > putting the variables we want to 'transfer' in a nosave page/section.
> > 
> > Well, if the boot and image kernels are different, which is now possible on
> > x86_64 with some recent patches (currently in -mm), the nosave trick won't
> > work.
> 
> I guess we should remove the nosave.... at least from x86-64. If
> someone tries to use it, he'll get a nasty surprise.

Agreed.

I'll try to prepare a patch for that when I have a bit of time.

Greetings,
Rafael
