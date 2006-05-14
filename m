From: Pavel Machek <pavel@suse.cz>
Subject: Re: suspend and hibernate nomenclature
Date: Sun, 14 May 2006 17:39:30 +0200
Message-ID: <20060514153929.GE2438@elf.ucw.cz>
References: <1147024930.16057.3.camel@localhost.localdomain>
	<20060508200103.GB4312@ucw.cz>
	<1147620745.8072.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============92560832379187752=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1147620745.8072.18.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: richard@hughsie.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============92560832379187752==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Ne 14-05-06 16:32:24, Richard Hughes wrote:
> On Mon, 2006-05-08 at 20:01 +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > First, sorry for the random mail to this mailing list.
> > > 
> > > I'm the developer of gnome-power-manager. The latest mini-project of
> > > mine is to fix the suspend-hibernate nomenclature used by OSS projects.
> > > 
> > > This might not effect the lowest layers of the stack (i.e. I want to
> > > focus on the stuff used by *users*), so this might not be applicable to
> > > you guys. Please keep me cc'd if you discuss, as I'm not subscribed to
> > > this list.
> > > 
> > > Full description of the problem is here:
> > > http://live.gnome.org/GnomePowerManager/SleepNames and I would encourage
> > > you guys to add comments to the end of the wiki if required.
> > 
> > Please do not use word 'thaw'. We already freeze processes during
> > suspend, and we thaw them during resume.
> 
> Got any better ideas? It needs to *just* apply to hibernation, not a
> generic term like wake.

reanimate?  As you said, users are unlikely to see this one.

Alternatives:

dehibarnate (unhibernate?), resume-from-disk :-), ressurect,
resuscitate (particulary useful if s-2-disk is buggy :-), revive, ...


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--===============92560832379187752==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============92560832379187752==--
