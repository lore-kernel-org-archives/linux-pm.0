From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] Some Thoughts on Device Power Management
Date: Wed, 5 Oct 2005 14:39:23 -0400
Message-ID: <20051005183923.GA5032@neo.rr.com>
References: <20051005075209.GC3306@neo.rr.com>
	<20051005092307.GA22330@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============072934221459834747=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051005092307.GA22330@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============072934221459834747==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 05, 2005 at 11:23:07AM +0200, Pavel Machek wrote:
> On St 05-10-05 03:52:09, Adam Belay wrote:
> > 
> > Hi All,
> > 
> > I've been considering strategies for improving runtime power management,
> > selective suspends, and device power management in general.  Here are some
> > of my ideas.  I would appreciate any comments or suggestions.
> 
> If you want to improve power management, write some code, not "yet
> another useless roadmap". Thanks.
> 								Pavel

Hi Pavel,

This document was more than a roadmap, it makes references to specific
implementation strategies.  Nonetheless, you do bring up a good point.
I actually do have some code for many of the ideas I mentioned.  I'm
hoping to have a functional example soon.

Thanks,
Adam


> 
> PS: Alan wrote some nice pieces for runtime power management, what
> about helping him?

I agree, a notion of power states is a step forward for runtime power
management.  I need to look at Alan's code more carefully, but, as I
understand, it's a little different from my proposal.

My intention was to seperate logical driver states (a given level of
functionality) and physical power states.  Device drivers are
responsible for manipulating physical device states, but the driver
model manages logical states and their dependencies.

I think comparing these strategies would be a useful discussion.


--===============072934221459834747==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============072934221459834747==--
