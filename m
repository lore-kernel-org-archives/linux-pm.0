From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 14:10:44 +0200
Message-ID: <200709211410.45248.rjw__26979.3937019587$1190375893$gmane$org@sisk.pl>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211024.35991.nigel@nigel.suspend2.net>
	<20070921094908.GB20149@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070921094908.GB20149@elf.ucw.cz>
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
To: linux-pm@lists.linux-foundation.org
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, 21 September 2007 11:49, Pavel Machek wrote:
> Hi!
> 
> > > Seems like good enough for -mm to me.
> 
> (For the record, I do not think this is going to be
> hibernation-replacement any time soon. But it is functionality useful
> for other stuff -- dump memory and continue -- and yes it may be able
> to do hibernation in the long term.
> 
> It really comes from the other side of reliability:
> 
> * swsusp is "if your kernel is perfectly healthy, it will work"
> 
> while this, coming from kdump is
> 
> * "if your kernel is not completely trashed, it should work"
> 
> ...which is why can't use swsusp to do dump memory and continue -- you
> want to do dumps on "slightly broken" systems. And yes, as a
> sideeffect it may be able to do hibernation... why not, lets see how
> it works out).

I generally agree. :-)

Greetings,
Rafael
