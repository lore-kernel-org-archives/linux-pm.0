From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend-Resume support in sparc64 kernel?
Date: Sun, 2 Nov 2008 13:14:28 +0100
Message-ID: <20081102121428.GA1424@ucw.cz>
References: <BAY104-DAV11383E6120F7C604E28C6699260@phx.gbl>
	<200810291325.43694.rjw@sisk.pl> <49085C3D.9050709@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49085C3D.9050709@hotmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, Shaddy Baddah <shaddy_baddah@hotmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-10-29 23:51:09, Shaddy Baddah wrote:
> Rafael J. Wysocki wrote:
> > On Wednesday, 29 of October 2008, Shaddy Baddah wrote:
> >> Hi,
> >>
> >> Is there any Suspend-Resume support in the sparc64 kernel?
> > 
> > Do you mean suspend to RAM or hibernation?
> 
> I mean suspend to RAM, which is what I believe the Suspend-Resume 
> referred to in the document 
> http://docs.sun.com/app/docs/doc/805-4433/6j46udqi7?l=en&a=view&q=power+management 
> also refers to.
> 
> My uninformed research into it gives me an indication that it is not. 
> And I'm curious as to whether there was some history to its possible 
> exclusion, or it is just something that no one has ever attempt to 
> implement.

Noone every tried it, AFAICT. sparcs are big and power-hungry beasts,
so there was not real pressing need to suspend them...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
